# Specifications for the Rails Assessment

Specs:
- [X] Using Ruby on Rails for the project
- [X] Include at least one has_many relationship (x has_many y e.g. Recipe has_many Ingredients, Recipe model line 3)
User has_many :listings
User has_many :reviews

- [X] Include at least one belongs_to relationship (x belongs_to y e.g. Ingredient belongs_to Recipe, Ingredient model line 2)
Listing belongs_to :user
ListingType belongs to :listing

- [X] Include at least one has_many through relationship (x has_many y through z e.g. Recipe has_many :categories, through: :recipe_categories, Recipe model line 9)
Listing has_many :types, through: :listing_types

- [X] The "through" part of the has_many through includes at least one user submittable attribute (attribute_name e.g. comment.message)
type.length
- [X] Include reasonable validations for simple model objects (list of model objects with validations e.g. Recipe, Ingredient, Comment)
Listing validates :title, :description, :cost, :contact, :image

- [ ] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g.Recipe.most_recently_updated URL: /)
Listing.recent
orders listings in descending order of most recently updated
/listing

- [X] Include a nested form writing to an associated model using a custom attribute writer (URL /recipes/:id, model name: Comment)
When a user creates a new listing, the form has nested fields within Type which is associated with a custom attribute writer in the Listing model.

- [X] Include signup (how e.g. Devise)
Devise
- [X] Include login (how e.g. Devise)
Devise
- [X] Include logout (how e.g. Devise)
Devise
- [X] Include third party signup/login (how e.g. Devise/OmniAuth)
Devise and Omniauth using Facebook
- [X] Include nested resource show or index (URL e.g. recipes/19/comments)
listings/3/reviews
- [ ] Include nested resource "new" form (Comments: my 'new' form for a nested resource is inside the Recipe show page as i liked the user experience better that way. So in URL /recipes/19 you can find the 'Create Comment' form)
- [ ] Include form display of validation errors (form URL e.g. /recipes/new)

Confirm:
- [ ] The application is pretty DRY
- [ ] Limited logic in controllers
- [ ] Views use helper methods if appropriate
- [ ] Views use partials if appropriate
