# Arike

## For Local Development

### 1. Install Packages

```
bundle
yarn
```

### 2. Configure application environment variables

1. Copy `example.env` to `.env`.

   ```
   cp example.env .env
   ```

2. Update the values of `DB_USERNAME` and `DB_PASSWORD` in the new `.env` file.

   Use the same values from the previous step. The username should be `postgres`, and the password will be whatever value you've set.

The `.env` file contains environment variables that are used to configure the application. The file contains documentation explaining where you should source its values from. If you're just starting out, you shouldn't have to change any variables other than the ones listed above.

### 3. Setup and Run Server

```bash
rake db:setup
# run the following scripts concurrently
# in 2 terminals
bin/webpack-dev-server
rails server

#to run the tests
bundle exec rspec

#to run a specific test file
bundle exec rspec path/to/spec/file.rb #(eg: bundle exec rspec spec/system/home/index_spec.rb)
```

## General Notes

- We use UUIDs instead of integer ids. This helps us create IDs from the client-side, so records can be saved on a mobile device without internet, and can be synced to the server once it is online. Further reading: https://pawelurbanek.com/uuid-order-rails

## Gems Used

- Authentication - Devise (https://github.com/heartcombo/devise)
- Authorization - Pundit (https://github.com/varvet/pundit)
- Pagination - Kaminari (https://github.com/kaminari/kaminari)

## Changelog

Using the following command to log a new change

```
$ bundle exec logchange new
title: A cool new feature has been added.

github_issue_link: Add link to related Github issue.
https://github.com/harigopal/logchange/issues/1

private: Hide this change from the public? Set to true or false.
false

Created [..]/changelog/unreleased/20170521-a-cool-new-feature-has-been-added.yml
```
## More
Check out the wiki for more information!
