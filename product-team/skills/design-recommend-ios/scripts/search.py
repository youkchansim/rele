#!/usr/bin/env python3
"""
CLI entry point for BM25 design recommendation search.

Usage:
    python3 search.py --query "건강 앱 대시보드" --top 5
    python3 search.py --query "finance dashboard" --categories finance --tables styles colors
    python3 search.py --query "social feed" --categories social --top 3
"""

import argparse
import json
import sys
from pathlib import Path

from core import DesignRecommender


def main():
    parser = argparse.ArgumentParser(description="iOS SwiftUI Design Recommendation Search")
    parser.add_argument("--query", "-q", required=True, help="Search query")
    parser.add_argument(
        "--categories",
        "-c",
        nargs="*",
        default=None,
        help="Filter by categories (e.g., health finance social)",
    )
    parser.add_argument(
        "--tables",
        "-t",
        nargs="*",
        default=None,
        help="Search specific tables (e.g., styles colors components)",
    )
    parser.add_argument("--top", "-k", type=int, default=5, help="Top K results per table")
    parser.add_argument(
        "--override-dir",
        "-o",
        type=str,
        default=None,
        help="Path to project override CSV directory",
    )
    parser.add_argument("--format", "-f", choices=["json", "text"], default="text", help="Output format")
    args = parser.parse_args()

    override_dir = Path(args.override_dir) if args.override_dir else None
    recommender = DesignRecommender(override_dir=override_dir)
    results = recommender.search(
        query=args.query,
        categories=args.categories,
        top_k=args.top,
        tables=args.tables,
    )

    if args.format == "json":
        print(json.dumps(results, ensure_ascii=False, indent=2))
    else:
        for table_name, rows in results.items():
            if not rows:
                continue
            print(f"\n{'='*60}")
            print(f"  {table_name.upper()} (top {len(rows)} results)")
            print(f"{'='*60}")
            for i, row in enumerate(rows, 1):
                score = row.pop("_score", 0)
                print(f"\n  [{i}] score={score}")
                for key, value in row.items():
                    print(f"      {key}: {value}")


if __name__ == "__main__":
    main()
