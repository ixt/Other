#!/bin/bash
# mv latest-all.json.gz latest-all_$(date -r latest-all.json.gz +%F).json.gz

# Specify various vars
num_threads=4
database_name='your_database_name'
collection_name='your_collection_name'
gzip_file='latest-all.json.gz'
json_file='latest-all.json'

# Clear the specified collection
mongo $database_name --eval "db.$collection_name.drop()"

# Decompress the gzip file in parallel
pigz -d -p $num_threads $gzip_file | pv -s $(du -sb $gzip_file | awk '{print $1}') > $json_file

# Import the JSON file into a MongoDB database
mongoimport --db $database_name --collection $collection_name --file $json_file --jsonArray

# Remove the json file after import
rm $json_file

