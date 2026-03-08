"""
BM25 Design Recommendation Engine for iOS SwiftUI.
Pure Python — no external dependencies.
"""

import csv
import math
import os
import re
from collections import defaultdict
from pathlib import Path
from typing import Dict, List, Optional

DATA_DIR = Path(__file__).parent.parent / "data"

TABLES = {
    "styles": "styles.csv",
    "colors": "colors.csv",
    "typography": "typography.csv",
    "components": "components.csv",
    "layouts": "layouts.csv",
    "effects": "effects.csv",
}


def tokenize(text: str) -> list[str]:
    """Tokenize text into lowercase alphanumeric + Korean tokens."""
    return re.findall(r"[a-z0-9가-힣]+", text.lower())


class BM25:
    """BM25 ranking algorithm (k1=1.5, b=0.75)."""

    def __init__(self, k1: float = 1.5, b: float = 0.75):
        self.k1 = k1
        self.b = b
        self.corpus_size = 0
        self.avg_dl = 0.0
        self.doc_freqs: Dict[str, int] = defaultdict(int)
        self.doc_lens: List[int] = []
        self.term_freqs: List[Dict[str, int]] = []

    def fit(self, documents: List[List[str]]) -> None:
        self.corpus_size = len(documents)
        total_len = 0
        for doc in documents:
            doc_len = len(doc)
            self.doc_lens.append(doc_len)
            total_len += doc_len
            tf: Dict[str, int] = defaultdict(int)
            for token in doc:
                tf[token] += 1
            self.term_freqs.append(dict(tf))
            for token in set(doc):
                self.doc_freqs[token] += 1
        self.avg_dl = total_len / self.corpus_size if self.corpus_size else 0.0

    def score(self, query_tokens: List[str]) -> List[float]:
        scores = [0.0] * self.corpus_size
        for token in query_tokens:
            if token not in self.doc_freqs:
                continue
            df = self.doc_freqs[token]
            idf = math.log((self.corpus_size - df + 0.5) / (df + 0.5) + 1.0)
            for i in range(self.corpus_size):
                tf = self.term_freqs[i].get(token, 0)
                if tf == 0:
                    continue
                dl = self.doc_lens[i]
                numerator = tf * (self.k1 + 1)
                denominator = tf + self.k1 * (1 - self.b + self.b * dl / self.avg_dl)
                scores[i] += idf * numerator / denominator
        return scores


class DesignRecommender:
    """Load CSV tables and search with BM25."""

    def __init__(self, data_dir: Optional[Path] = None, override_dir: Optional[Path] = None):
        self.data_dir = data_dir or DATA_DIR
        self.tables: Dict[str, List[Dict[str, str]]] = {}
        self.bm25_indices: Dict[str, BM25] = {}
        self._load_all(override_dir)

    def _load_csv(self, filepath: Path) -> List[Dict[str, str]]:
        rows = []
        with open(filepath, newline="", encoding="utf-8") as f:
            reader = csv.DictReader(f)
            for row in reader:
                rows.append(dict(row))
        return rows

    def _merge_overrides(
        self, base: List[Dict[str, str]], overrides: List[Dict[str, str]], key_col: str
    ) -> List[Dict[str, str]]:
        """Merge override rows into base by key column."""
        base_map = {row[key_col]: row for row in base}
        for row in overrides:
            base_map[row[key_col]] = row
        return list(base_map.values())

    def _load_all(self, override_dir: Optional[Path]) -> None:
        key_columns = {
            "styles": "style_name",
            "colors": "semantic_name",
            "typography": "text_style",
            "components": "component_name",
            "layouts": "layout_name",
            "effects": "effect_name",
        }
        for table_name, filename in TABLES.items():
            filepath = self.data_dir / filename
            if not filepath.exists():
                continue
            rows = self._load_csv(filepath)

            # Merge project overrides if available
            if override_dir:
                override_path = override_dir / filename
                if override_path.exists():
                    override_rows = self._load_csv(override_path)
                    rows = self._merge_overrides(
                        rows, override_rows, key_columns.get(table_name, "")
                    )

            self.tables[table_name] = rows

            # Build BM25 index from keywords + all text fields
            documents = []
            for row in rows:
                text_parts = []
                for value in row.values():
                    text_parts.append(value)
                tokens = tokenize(" ".join(text_parts))
                documents.append(tokens)

            bm25 = BM25()
            bm25.fit(documents)
            self.bm25_indices[table_name] = bm25

    def search(
        self,
        query: str,
        categories: Optional[List[str]] = None,
        top_k: int = 5,
        tables: Optional[List[str]] = None,
    ) -> Dict[str, List[dict]]:
        """Search across tables. Returns top_k results per table."""
        query_tokens = tokenize(query)
        target_tables = tables or list(self.tables.keys())
        results: Dict[str, List[dict]] = {}

        for table_name in target_tables:
            if table_name not in self.tables:
                continue
            rows = self.tables[table_name]
            bm25 = self.bm25_indices[table_name]
            scores = bm25.score(query_tokens)

            scored_rows = list(zip(scores, rows))

            # Filter by category if specified
            if categories:
                cat_set = {c.lower() for c in categories}
                scored_rows = [
                    (s, r)
                    for s, r in scored_rows
                    if r.get("category", "all").lower() in cat_set
                    or r.get("category", "").lower() == "all"
                    or r.get("category", "") == ""
                ]

            # Sort by score descending, take top_k
            scored_rows.sort(key=lambda x: x[0], reverse=True)
            results[table_name] = [
                {**row, "_score": round(score, 4)}
                for score, row in scored_rows[:top_k]
                if score > 0
            ]

        return results

    def recommend(
        self, query: str, categories: Optional[List[str]] = None
    ) -> Dict[str, List[dict]]:
        """Full recommendation: search all tables, return top results."""
        return self.search(query, categories=categories, top_k=5)
