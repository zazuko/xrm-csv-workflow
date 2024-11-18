#!/bin/sh

# Hint: Materialization not working with DuckDB versions 1.1.x 
# see https://github.com/ontop/ontop/issues/828

DUCKDB_ZIPFILE_URL="https://github.com/duckdb/duckdb/releases/download/v1.0.0/duckdb_cli-linux-amd64.zip"
DUCKDB_JDBC_JARFILE_URL="https://repo1.maven.org/maven2/org/duckdb/duckdb_jdbc/1.0.0/duckdb_jdbc-1.0.0.jar"

ONTOP_ZIPFILE_URL="https://github.com/ontop/ontop/releases/download/ontop-5.2.0/ontop-cli-5.2.0.zip"

mkdir -p bin/duckdb
curl -L $DUCKDB_ZIPFILE_URL -o duckdb_cli.zip
unzip duckdb_cli.zip -d bin/duckdb
rm duckdb_cli.zip

mkdir -p bin/ontop
curl -L $ONTOP_ZIPFILE_URL -o ontop_cli.zip
unzip ontop_cli.zip -d bin/ontop
rm ontop_cli.zip

curl -L $DUCKDB_JDBC_JARFILE_URL -o duckdb_jdbc.jar
mv duckdb_jdbc.jar bin/ontop/jdbc/
