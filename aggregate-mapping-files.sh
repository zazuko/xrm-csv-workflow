#!/bin/bash

# Usage:
#   docker run --rm -it -v $(pwd):/app zazukoians/node-java-jena:v5 ./aggregate-mapping-files.sh
#   The output is the aggregated mapping file `mappings.nt`.

# Define the output file
output_file="mappings.nt"

# Clear the output file initially
> "$output_file"

# Iterate over all mapping files and concat their ntriples serialization into the output file
for file in src-gen/*.r2rml.ttl; do
    # Check if it is a file
    if [ -f "$file" ]; then
        # Convert to ntriples and concatenate
        # cat "$file" >> "$output_file"
        riot --out=ntriples "$file" >> "$output_file"
    fi
done

# Run validation
echo "Validating data..."
riot --validate $output_file

# Check the return code
if [ $? -eq 0 ]; then
    # No errors found
    echo "No errors found"
    echo "Consolidated mapping file: $output_file"
else
    # Errors found, exit with non-zero status
    echo "Validation failed with errors"
    exit 1
fi