# AuthService API

## POST /auth/signup

Creates a new user account.

### Parameters

- `email` (string, required): The email address of the user.
- `password` (string, required): The password for the user.
- `username` (string, required): The username for the user.

### Returns

If successful, returns a JSON object with the following properties:

- `session` (object): The session information.
- `user` (object): The user information.

If unsuccessful, returns a JSON object with the following property:

- `error` (string): The error message.

## POST /auth/login

Logs in an existing user.

### Parameters

- `email` (string, required): The email address of the user.
- `password` (string, required): The password for the user.

### Returns

If successful, returns a JSON object with the following properties:

- `session` (object): The session information.
- `user` (object): The user information.

If unsuccessful, returns a JSON object with the following property:

- `error` (string): The error message.

## POST /auth/logout

Logs out the current user.

### Returns

No content.