Simplestone
===========

Simplestone was forked from Sandstone, a basic Rails CMS by Viget Labs. (Here's the [original repo] [1] and [Viget Labs blog post] [2] for Sandstone.)

[1]: http://github.com/vigetlabs/sandstone
[2]: http://www.viget.com/extend/sandstone-a-drop-in-cms-for-existing-rails-applications/

Simplestone restructures the original, moving application files into the plugin and greatly reducing the amount of bootstrapping required. Keep your application directories nice and clean!


## Dependencies ##

Requires:

* Rails 2.3 or higher
* `acts_as_versioned`
  *    Note: currently, the gem version of `acts_as_versioned` has bugs on Rails 2.3, so we will be using the trunk version. To install the trunk version:

            ./script/install git://github.com/technoweenie/acts_as_versioned.git

* `acts_as_tree`

        gem install acts_as_tree


## Installation ##

    ./script/plugin install git://github.com/melvinsembrano/simplestone.git

or, if you prefer to use a git submodule:

    git submodule add git://github.com/melvinsembrano/simplestone.git vendor/plugins/simplestone

then execute:

    rake db:migrate


## User Model ##

Sandstone hooks into your application through a user model. If your users are actually represented by a model named User, you're in luck—all you have to do is add the following line to user.rb:

    has_one :editor
  
It's a little trickier if you've named the model something else (like Member). In that case, add this to your existing model:

    has_one :editor, :foreign_key => :user_id
  
And update config/initializers/simplestone.rb with the name of your model:

    SIMPLESTONE = {
      :user_class => 'Member'  # or whatever
    }

Your user model (whatever it's called) must have a `name` attribute. Simplestone reads this attribute to display editors' names in the admin interface. 

Simplestone uses the methods `logged_in?`, `current_user`, and `access_denied` which are supplied by the Restful Authentication plugin. You do *not* need to use Restful Authentication to use Simplestone, but in this case you'll need to define these three methods in `ApplicationController`.

`current_user` must return an object that can match up with Sandstone's `editor` object. `access_denied` should handle redirection and messaging when a non-editor tried to visit an administrative page. `logged_in?` is self-explanatory. :-)


## Gotchas (and solutions) ##

### `undefined local variable or method 'session_url' for #<ActionView::Base>` ###

I happen to use `login_url` and `logout_url` instead of Restful Authentication's `[new_]session_url` helper. You too? Just edit config/initializers/simplestone.rb like so:

    SIMPLESTONE = {
      :user_class => 'User',
      :login_link_proc => Proc.new { link_to 'Login', login_url },
      :logout_link_proc => Proc.new { link_to 'Logout', logout_url }
    }

Restart your server, and just like magic, it works again!
