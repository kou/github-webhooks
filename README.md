# How to run `remove-webhook.rb`

First, create a new access token with required scopes.

 1. Go to https://github.com/settings/tokens
 2. Click the button "Generate new token".
 3. Set "webhook" as the token description.
 3. Check only these scopes (and uncheck others):
    * `repo`
    * `user`
    * `write:repo_hook`
 4. Click the button "Generate token".
 5. Copy the generated token string (like `abcd01234...`).

Then, execute the script as:

```
$ export GITHUB_TOKEN=abcd01234...
$ USER_OR_ORGANIZATION=kou
$ WEBHOOK_URL=http://example.com/old-webhook-to-be-removed
$ ./remove-webhooks.rb $USER_OR_ORGANIZATION $WEBHOOK_URL
```
