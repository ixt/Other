#include <mongoc/mongoc.h>
#include <bson/bson.h>
#include <stdlib.h>

int main (int argc, char *argv[]) {
    mongoc_client_t *client;
    mongoc_collection_t *collection;
    mongoc_cursor_t *cursor;
    bson_t *query;
    const bson_t *doc;
    char *str;
    char *uri_str, *database, *collection;

    // get the MongoDB connection string, database, and collection from environment variables
    uri_str = getenv("MONGODB_CONNECTION");
    database = getenv("MONGODB_DATABASE");
    collection = getenv("MONGODB_COLLECTION");

    // initialize libmongoc
    mongoc_init ();

    // create a new client instance
    client = mongoc_client_new (uri_str);

    // get a handle to the collection
    collection = mongoc_client_get_collection (client, database, collection);

    // create the query
    query = bson_new ();
    bson_append_int32 (query, "age", -1, 27);

    // execute the query
    cursor = mongoc_collection_find (collection, MONGOC_QUERY_NONE, 0, 0, 0, query, NULL, NULL);

    // iterate over the results
    while (mongoc_cursor_next (cursor, &doc)) {
        str = bson_as_json (doc, NULL);
        printf ("%s\n", str);
        bson_free (str);
    }

    // cleanup
    bson_destroy (query);
    mongoc_cursor_destroy (cursor);
    mongoc_collection_destroy (collection);
    mongoc_client_destroy (client);

    mongoc_cleanup ();

    return 0;
}
