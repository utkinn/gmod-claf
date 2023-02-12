#!/bin/sh

set -e

THRESHOLD=100

luacov -c .luacov.default

coverage_percentage=$(awk '/^lua.*%/{coverage+=$4;max_coverage+=100}END{print int(coverage*100/max_coverage)}' luacov.report.out)

if [ "$coverage_percentage" -lt $THRESHOLD ]; then
    echo "Coverage is $coverage_percentage%, which is below the expected $THRESHOLD%"
    exit 1
fi
