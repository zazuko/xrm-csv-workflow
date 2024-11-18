# CSV to RDF conversion template project

This repository provides a performant way to convert CSV files to RDF. It contains:

- A sample CSV file
- A sample XRM mapping that generates R2RML mapping files
- A script that converts the input CSV to RDF
- A default GitHub Action configuration that runs the script and creates an artifact for download

This is a GitHub template repository. It will not be declared as "fork" once you click on the `Use this template` button above. Simply do that, start adding your data sources and adjust the XRM mapping accordingly:

1. Create/adjust the XRM files in the `mappings` directory.
2. Copy source CSVs to `input` directory.
3. Edit `load-csv.sql` to define tables for CSV files.
3. Execute the install and convert scripts to convert your data.

Make sure to commit the `input`, `mappings` and `src-gen` directories if you want to build it using GitHub Actions.

See [Further reading](#further-reading) for more information about the XRM mapping language.

## Install

Download DuckDB CLI, DuckDB JDBC Driver, Ontop CLI - and unpack into *bin* folder:

```
$ ./install.sh
```
## Steps

The `./convert.sh` script includes the following steps:

Build DB:
```
$ ./bin/duckdb/duckdb xrm-csv-workflow.duckdb < load-csv.sql
```

Aggregate individual mapping files into a single one - `mappings.nt`:
```
$ docker run --rm -it -v $(pwd):/app zazukoians/node-java-jena:v5 ./aggregate-mapping-files.sh
```

Materialize with ontop:

```
$ ./bin/ontop/ontop materialize -f ntriples -o ./output/mapped.nt -p xrm-csv-workflow.properties -m mappings.nt
```


## Hints

* DuckDB versions 1.1.x did not work. DuckDB version 1.0.0 is working OK. See also https://github.com/ontop/ontop/issues/828
* Table names in DuckDB need to be lowercase, otherwise `ontop materialize` throws exceptions

## Other template repositories

We provide additional template repositories:

* [xrm-csvw-workflow](https://github.com/zazuko/xrm-csvw-workflow):  A template repository for converting CSV to RDF using barnard59 pipelines and the CSVW specification.
* [xrm-r2rml-workflow](https://github.com/zazuko/xrm-r2rml-workflow):  A template repository for converting complete relational databases to RDF using the R2RML specification and Ontop as mapper.
* xrm-xml-workflow: TODO

## Further reading

* [Expressive RDF Mapping Language (XRM)](https://zazuko.com/products/expressive-rdf-mapper/) and the [documentation](https://github.com/zazuko/expressive-rdf-mapper) for details about the domain-specific language (DSL).
