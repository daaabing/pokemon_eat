# Pokemon Eat - Smoothen your daily food decisions

### Core Package Versions 
  1. ruby --version == 2.6.6
  2. rails --version == 6.0.3.4
  3. node --version == 14.15.4
  4. yarn --version == 1.22.10
  5. Check out https://guides.rubyonrails.org/getting_started.html#creating-the-blog-application for package installation

### Branches Management
  1. master -> The main branch.
  2. layout -> ONLY for editing erb files in /app/views.
  3. test -> ONLY for building up TDD/BDD test cases.
   
### Initialize this project locally
  0. Install Redis on your computer, like: `brew install redis`
  1. Clone this project
  2. Run `rails db:migrate` -> This will init the database
  3. Run `rake db:seed` -> This will insert four user accounts
  4. Run `rails server` to start your rails app
  5. Run `redis-server` to start redis locally




