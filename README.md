# CSV to RDF conversion template project

This repository provides a performant way to convert CSV files to RDF. It contains:

- A sample CSV file
- A corresponding XRM mapping that generates R2RML mapping files
- A script that converts the input CSV to RDF
- A default GitHub Action configuration that runs the script and creates an artifact for download

This is a GitHub template repository. It will not be declared as "fork" once you click on the `Use this template` button above. Simply do that, start adding your data sources and adjust the XRM mapping accordingly.


Make sure to commit the `input`, `mappings` and `src-gen` directories if you want to build it using GitHub Actions.

See [Further reading](#further-reading) for more information about the XRM mapping language.

## Install

Download DuckDB CLI, DuckDB JDBC Driver, Ontop CLI - and unpack into *bin* folder:

```
$ ./install.sh
```

Try converting the example CSV

```
$ ./convert.sh
```


## Customize
1. Replace the example CSV in the `input` directory with your CSV file(s).
2. Edit `load-csv.sql` to define tables for your CSV files.
3. Create the DuckDB database `xrm-csv-workflow.duckdb` from CSV files:
```
$ npm run db:create
```
3. Generate new XRM files in the `mappings` directory:
```
$ npm run xrm:bootstrap
```
4. Create/adjust the XRM files in the `mappings` directory.

5. Materialize `transformed.nt` in the `output` directory:

```
$ npm run rdf:create
```

## Develop
Each time you change the CSV files or the corresponding definitions (in `load-csv.sql`), you need to recreate the DuckDB database (with `npm run db:create`) and refresh the XRM sources (with `npm run xrm:sources`). 
XRM will warn you about any source field used in the mappings that is no more available.


## Hints

* DuckDB versions 1.1.x did not work. DuckDB version 1.0.0 is working OK. See also https://github.com/ontop/ontop/issues/828
* Table names in DuckDB need to be lowercase, otherwise `ontop materialize` throws exceptions

## Other template repositories

We provide additional template repositories:

* [xrm-csvw-workflow](https://github.com/zazuko/xrm-csvw-workflow):  A template repository for converting CSV to RDF using barnard59 pipelines and the CSVW specification.
* [xrm-r2rml-workflow](https://github.com/zazuko/xrm-r2rml-workflow):  A template repository for converting complete relational databases to RDF using the R2RML specification and Ontop as mapper.
* xrm-xml-workflow: TODO

## Further reading

* [DuckDB](https://duckdb.org/) for creating relational databases from CSV files.
* [RDB to RDF Mapping Language (R2RML)](https://www.w3.org/TR/r2rml/) for expressing customized mappings from relational databases to RDF datasets.
* [Expressive RDF Mapping Language (XRM)](https://github.com/zazuko/expressive-rdf-mapper) for creating R2RML mappings with a user-friendly domain-specific language (DSL).


* [Ontop](https://github.com/ontop/ontop) for exposing the content of arbitrary relational databases as knowledge graphs, relying on R2RML mappings.

