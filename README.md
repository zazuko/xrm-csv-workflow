# CSV to RDF conversion template project

This repository provides a performant way to convert CSV files to RDF. It contains:

- A sample CSV file
- A corresponding XRM mapping that generates R2RML mapping files
- A script that converts the input CSV to RDF
- A default GitHub Action configuration that runs the script and creates an artifact for download

This is a GitHub template repository. It will not be declared as "fork" once you click on the `Use this template` button above. Simply do that, start adding your data sources and adjust the XRM mapping accordingly.


Make sure to commit the `input`, `mappings` and `src-gen` directories. The GitHub Action regenerates `src-gen` from the XRM files and fails if the committed version is out of date.

See [Further reading](#further-reading) for more information about the XRM mapping language.

## Install

Download DuckDB CLI, DuckDB JDBC Driver, Ontop CLI and the [XRM CLI](https://github.com/zazuko/xrm) - and unpack into *bin* folder (requires Java 11+ and Node.js):

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
4. Generate new XRM files in the `mappings` directory:
```
$ npm run xrm:bootstrap
```
> `xrm:bootstrap` generates a scaffold based on your DB schema. It picks the first column of each table as the subject URI key — review and adjust the generated mappings before using them.
5. Create/adjust the XRM files in the `mappings` directory.
6. Validate the XRM files and generate the R2RML mapping in `src-gen`:
```
$ npm run xrm:generate
```
> Errors are reported as `file:line:column: severity: message`.
7. Materialize `transformed.nt` in the `output` directory:

```
$ npm run rdf:create
```

## Develop
Each time you change the CSV files or the corresponding definitions (in `load-csv.sql`), you need to recreate the DuckDB database (with `npm run db:create`) and refresh the XRM sources (with `npm run xrm:sources`). After changing XRM files, regenerate the R2RML mapping with `npm run xrm:generate`; `./convert.sh` runs all of these steps.
XRM will warn you about any source field used in the mappings that is no more available.


## Hints

* Table names in DuckDB need to be lowercase, otherwise `ontop materialize` throws exceptions
* Override binary paths via env vars: `DUCKDB_BIN`, `ONTOP_BIN` and `XRM_CLI_JAR` (default to `./bin/duckdb/duckdb`, `./bin/ontop/ontop` and `./bin/xrm/xrm-cli.jar`)
* Tool versions are pinned at the top of `install.sh`; the CI cache for `bin/` is invalidated whenever that file or the published XRM CLI jar changes

## Other template repositories

We provide additional template repositories:

* [xrm-csvw-workflow](https://github.com/zazuko/xrm-csvw-workflow):  A template repository for converting CSV to RDF using barnard59 pipelines and the CSVW specification.
* [xrm-r2rml-workflow](https://github.com/zazuko/xrm-r2rml-workflow):  A template repository for converting complete relational databases to RDF using the R2RML specification and Ontop as mapper.

## Further reading

* [DuckDB](https://duckdb.org/) for creating relational databases from CSV files.
* [RDB to RDF Mapping Language (R2RML)](https://www.w3.org/TR/r2rml/) for expressing customized mappings from relational databases to RDF datasets.
* [Expressive RDF Mapping Language (XRM)](https://github.com/zazuko/expressive-rdf-mapper) for creating R2RML mappings with a user-friendly domain-specific language (DSL).


* [Ontop](https://github.com/ontop/ontop) for exposing the content of arbitrary relational databases as knowledge graphs, relying on R2RML mappings.

