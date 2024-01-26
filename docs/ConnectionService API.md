# ConnectionsService API

## GET /connections

Retrieves a list of connections for the current user.

### Returns

If successful, returns a JSON array of connections. Each connection is an object with the following properties:

- `(id, username)` (object): The profile information of the connected user.

If unsuccessful, returns an empty array.

## DELETE /connections/{id}

Deletes a connection for the current user.

### Parameters

- `id` (string, required): The ID of the connection to delete.

### Returns

No content.

## POST /connections

Adds a new connection for the current user.

### Parameters

- `id` (string, required): The ID of the user to connect with.

### Returns

No content.