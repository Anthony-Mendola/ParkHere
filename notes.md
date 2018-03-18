# Notes


 User can sign-up, sign-in, sign-out - Devise
 User can login with Facebook - Omniauth
 User can view all listings without signing in
 User can create a new listing after signing up and signing in
 User data is validated using ActiveRecord ORM and model validations
 User can only CRUD their own listings

# Models

User
has_many :listings

Location
has_many

Listing
