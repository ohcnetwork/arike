# Arike

## Local Development

```
bundle
yarn
rake db:setup
rails server
```

## Notes

* We use UUIDs instead of integer ids. This helps us create IDs from the client-side, so records can be saved on a mobile device without internet, and can be synced to the server once it is online. Further reading: https://pawelurbanek.com/uuid-order-rails


