#!/bin/sh

rm -f xrm-csv-workflow.duckdb
./bin/duckdb/duckdb xrm-csv-workflow.duckdb < load-csv.sql

docker run --rm -it -v $(pwd):/app zazukoians/node-java-jena:v5 ./aggregate-mapping-files.sh

mkdir -p output
./bin/ontop/ontop materialize -f ntriples -o ./output/transformed.nt -p xrm-csv-workflow.properties -m mappings.nt
