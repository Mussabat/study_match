# SearchService API

## GET /search/users/{query}

Searches for users based on a query string.

### Parameters

- `query` (string, required): The search query string.

### Returns

If successful, returns a JSON array of users. Each user is an object with the following properties:

- `id` (string): The ID of the user.
- `username` (string): The username of the user.

If unsuccessful, returns an empty array.

## GET /search/tags/{query}

Searches for tags based on a query string.

### Parameters

- `query` (string, required): The search query string.

### Returns

If successful, returns a JSON array of tags. Each tag is an object with the following properties:

- `id` (string): The ID of the tag.
- `tag` (string): The tag text.

If unsuccessful, returns an empty array.