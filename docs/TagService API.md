# TagService API

## GET /tags/{userId}

Retrieves a list of tags for a specific user.

### Parameters

- `userId` (string, required): The ID of the user to retrieve tags for.

### Returns

If successful, returns a JSON array of tags. Each tag is an object with the following properties:

- `id` (string): The ID of the tag.
- `tag` (string): The tag text.
- `isConnected` (boolean): Whether the current user is connected to this tag.

If unsuccessful, returns `null`.

## GET /tags/currentUser

Retrieves a list of tags for the current user.

### Returns

If successful, returns a JSON array of tags. Each tag is an object with the following properties:

- `id` (string): The ID of the tag.
- `tag` (string): The tag text.
- `isConnected` (boolean): Always `true` for this endpoint.

If unsuccessful, returns `null`.

## DELETE /tags/{tagId}

Deletes a tag for the current user.

### Parameters

- `tagId` (string, required): The ID of the tag to delete.

### Returns

No content.

## POST /tags

Adds a new tag for the current user.

### Parameters

- `tag` (string, required): The tag text to add.

### Returns

No content.