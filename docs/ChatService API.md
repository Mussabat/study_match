# ChatService API

## GET /chats/{userId}

Retrieves a list of chats for a specific user.

### Parameters

- `userId` (string, required): The ID of the user to retrieve chats for.

### Returns

If successful, returns a JSON array of chats. Each chat is an object with the following properties:

- `id` (string): The ID of the chat.
- `participants` (array): An array of user IDs participating in the chat.
- `lastMessage` (object): The last message sent in the chat, with `content` (string) and `timestamp` (string) properties.

If unsuccessful, returns an empty array.

## POST /chats

Starts a new chat.

### Parameters

- `participants` (array, required): An array of user IDs to participate in the chat.

### Returns

If successful, returns a JSON object with the following properties:

- `id` (string): The ID of the newly created chat.

If unsuccessful, returns `null`.

## GET /chats/{chatId}/messages

Retrieves a list of messages for a specific chat.

### Parameters

- `chatId` (string, required): The ID of the chat to retrieve messages for.

### Returns

If successful, returns a JSON array of messages. Each message is an object with the following properties:

- `id` (string): The ID of the message.
- `sender` (string): The ID of the user who sent the message.
- `content` (string): The content of the message.
- `timestamp` (string): The timestamp when the message was sent.

If unsuccessful, returns an empty array.

## POST /chats/{chatId}/messages

Sends a new message in a specific chat.

### Parameters

- `chatId` (string, required): The ID of the chat to send the message in.
- `content` (string, required): The content of the message to send.

### Returns

If successful, returns a JSON object with the following properties:

- `id` (string): The ID of the newly sent message.

If unsuccessful, returns `null`.