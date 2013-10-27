# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Scheduler::Application.config.secret_key_base = '74b9d3b59c28dad67716dd24dc2c2e64dc3ddf43cfd5b6d82a3ddfd5e4632c022f497260b714ac2038b4f1fae644de244cd4d765f040eb61a48b29c846577451'
