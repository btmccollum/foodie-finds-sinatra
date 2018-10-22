# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app 
- [x] Use ActiveRecord for storing information in a database - ActiveRecord associations were established for each of the 4 models, leveraging has_many, belongs_to, and has_many through: primarily. Test information and states were persisted with seed files. Models make use of ActiveRecord methods for each model.
- [x] Include more than one model class (e.g. User, Post, Category) - Includes 4 models, User, Post (newly created posts on the forum), Category (listed by state name for high level forum categories), and Comment (replies on forum)
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts) - includes 4 has_many relationships and one has_many through:
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User) - includes 5 belongs_to relationships
- [x] Include user accounts with unique login attribute (username or email) - checks are performed to ensure that username and/or email are not blank, and have not already been registered to another user, activerecord validation methods are incorporated on the class, as well as controller methods as an extra layer
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying - All belongs_to resources have full CRUD functionality other than User (at this time)
- [x] Ensure that users can't modify content created by other users - routes are protected to ensure a user cannot edit or delete content created by others
- [x] Include user input validations - routes include logic to ensure that inputs are not duplicates of existing data for accounts, posts have all required information, and post/comment information being edited is only updated for valid inputs. 
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new) - All applicable routes include flash message functionality for error messages, welcome messages, or prompts (where necessary).
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code - README was updated to include description, install and user instructions, contributors guide, and link to license

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
