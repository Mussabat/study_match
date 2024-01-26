# ProfileService API

## GET /profiles/{id}

Retrieves a profile by ID.

### Parameters

- `id` (string, required): The ID of the profile to retrieve.

### Returns

If successful, returns a JSON object with the following properties:

- `id` (string): The ID of the profile.
- `username` (string): The username of the profile.
- `tags` (array): An array of tags associated with the profile.
- `isFollowing` (boolean): Whether the current user is following this profile.

If unsuccessful, returns `null`.

## GET /profiles/recommended

Retrieves a list of recommended profile IDs for the current user.

### Returns

If successful, returns a JSON array of strings, where each string is a profile ID.

If unsuccessful, returns an empty array.