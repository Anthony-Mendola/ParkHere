# Notes

Wouldn't it be great to secure a parking spot before going out to dinner tonight or an event? Let's say you're going to the city or another neighborhood with scarce parking. Prior, you can go on ParkHere and reserve a spot from a listing.
Parking garages can be expensive, they also pack in cars and who knows what damage will occur. How about that scene from Ferris Bueller when the parking garage guy takes his car for a spin.
Own a garage or parking space that you rarely use and want to make some extra side money? List it!

 User can sign-up, sign-in, sign-out - Devise
 User can login with Facebook - Omniauth
 User can view all listings without signing in
 User can create a new listing after signing up and signing in
 User data is validated using ActiveRecord ORM and model validations
 User can only CRUD their own listings

------------------------------
Be clear on the difference between build and create when instantiating objects
Review the specs for the project and make sure to pinpoint where in the code you're meeting each requirement
If you have a small feature you want to add, think about how you'd build it out before the assessment. 
Controllers:
Using instance variables in controllers grants view access.

Views:
.erb stands for embedded ruby
putting an equal sign like <%= tells rails whatever the code within the tags returns
we want to print out to our html.
Every other view page uses application.html.erb by default and loads where <%= yield %>
Link creation <%= link_to text_to_show, model_instance %>

Listings index page:
loop through each listing in the array every time, setting the current listing to the listing local variable in this code block
<% Listing.all.each do |listing|  %>
<%= listing.title %>
Create links within code block <%= link_to listing.title, listing %>
When calling Listing anywhere in this app it will reference a class which is my model.
Listing.all returns an array of listings
