# Usage of scripts

## Preparation

At first, create a new access token with required scopes.

 1. Go to https://github.com/settings/tokens
 2. Click the button "Generate new token".
 3. Set "webhook" as the token description.
 3. Check only these scopes (and uncheck others):
    * `repo`
    * `user`
    * `write:repo_hook`
 4. Click the button "Generate token".
 5. Copy the generated token string (like `abcd01234...`).


## How to add a new webhook for all repositories under an user account?

Execute the script `remove-webhooks.rb` as:

```
$ export GITHUB_TOKEN=abcd01234...
$ USER=kou
$ WEBHOOK_URL=http://example.com/new-webhook-to-be-added
$ CONTENT_TYPE=json
$ ./add-webhooks.rb $USER_OR_ORGANIZATION $WEBHOOK_URL $CONTENT_TYPE
```

Possible values of the content type are:

 * `json` (means `application/json`)
 * `form` (means `application/x-www-form-urlencoded`)

Repositories which already have the webhook will be ignored.


## How to remove an existing webhook from all repositories under an user account or an organization?

Execute the script `remove-webhooks.rb` as:

```
$ export GITHUB_TOKEN=abcd01234...
$ USER_OR_ORGANIZATION=kou
$ WEBHOOK_URL=http://example.com/old-webhook-to-be-removed
$ ./remove-webhooks.rb $USER_OR_ORGANIZATION $WEBHOOK_URL
```
