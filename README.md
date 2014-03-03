# SimpleUsertag

Ruby gem for Rails that parses, stores, retrieves and formats usertags in your model. This is under development and may not be perfect. I am working off of Raphael Campardou's excellent Simple Hashtag code. It's going to take a lot of work for me to get this to work correctly. Raphael Campardou did an excellent job with Simple Hashtag, however I needed to create a quick fix to find users in the system as well for my project. I believe others may want to use this as well. I may combine them in the future. I also plan to allow attribute tags in the future

_Simple Usertag_ is a mix between–well–usertags, as we know them, and categories.
It will scan your Active Record attribute for a usertag, store it in an index, and display a page with each object containing the tag.

It's simple, and like all things simple, it can create a nice effect, quickly.

## Installation

Add this line to your application's Gemfile:
```ruby
gem 'simple_usertag'
```

And execute:
```shell
$ bundle
```

Then you have to generate the migration files:
```shell
$ rails g simple_usertag:migration
```

This will create two migration files, one for the `usertags` table and one for the `usertagging` table.
You will need to run `rake db:migrate` to actually create the tables.

__Optionnally__, you can create views,
if only to guide you through your own implementation:
```shell
$ rails g simple_usertag:views
```

This will create a __basic controller__, a __short index view__ and a __small helper__.
It assume your views follow the convention of having a directory named after your model's plural, and a partial named after your model's name.
```
app
|-- views
|    |-- posts
|    |    |-- _post.html.erb
```


## Usage

Just add `include SimpleUsertag::Usertaggable` in your model.

_Simple Hasthag_ will parse the `body` attribute by default:

```ruby
class Post < ActiveRecord::Base
  include SimpleUsertag::Usertaggable
end
```


If you need to parse another attribute instead,
add `usertaggable_attribute` followed by the name of your attribute, i.e.:
```ruby
class Picture < ActiveRecord::Base
  include SimpleUsertag::Usertaggable
  usertaggable_attribute :caption
end
```

From here on, if your text contains a usertag, say _@RubyRocks_,
_Simple Usertag_ will find it, store it in a table and retreive it and its associated object if asked.
Helpers are also available to create a link when displaying the text.

### Controller and Views
If you don't want to bother looking at the genrerated controller and views, here is a quick peek.
In a Controller, display all usertags, or search for a Usertag and its associated records:
```ruby
class UsertagsController < ApplicationController
  def index
    @usertags = SimpleUsertag::Usertag.all
  end

  def show
    @usertag = SimpleUsertag::Usertag.find_by_name(params[:usertag])
    @usertagged = @usertag.usertaggables if @usertag
  end
end
```

The views could resemble something like this:

Index:
```erb
<h1>Usertags</h1>
<ul>
<% @usertags.each do |usertag| %>
  <li><%= link_to usertag.name, usertag_path(usertag.name) %></li>
<% end -%>
</ul>
```

Show:
```erb
<h1><%= params[:usertag] %></h1>
<% if @usertagged %>
  <% @usertagged.each do |usertagged| %>
    <% view    = usertagged.class.to_s.underscore.pluralize %>
    <% partial = usertagged.class.to_s.underscore %>
    <%= render "#{view}/#{partial}", {partial.to_sym => usertagged} %>
  <% end -%>
<% else -%>
  <p>There is no match for the <em><%= params[:usertag] %></em> usertag.</p>
<% end -%>
```
In the gem it is actually extracted in a helper.


### Routes

If you use the provided controller and views, the generator will add two routes to your app:
```ruby
get 'usertags/',         to: 'usertags#index',     as: :usertags
get 'usertags/:usertag', to: 'usertags#show',      as: :usertag
```

The helper generating the link relies on it.



### Spring Cleaning
There is a class method `SimpleUsertag::Usertag#clean_orphans` to remove unused usertags from the DB.
It is currently not hooked, for two reasons:
- It is not optimised at all, DB-wise.
- Destructive method should be called explicitly.

Knowing all this, you can hook it after each change, or automate it with a Cron job, or even spring-clean manually once in a while.

Improvements for this method are listed in the Todo section below.


## Gotchas
### Association Query
The association between a Usertag and your models is a polymorphic many-to-many.

The object returned by the query is an array, not an Arel query, so you can't chain (i.e.: to specify the order), and should do it by hand:

```ruby
usertag = SimpleUsertag.find_by_name("RubyRocks")
posts_and_picts = usertag.hattaggables
posts_and_picts.sort_by! { |p| p.created_at }
```

### find_by

To preserve coherence, Usertags are stored downcased.
To ensure coherence, they are also searched downcased.
Internally, the model overrides `find_by_name` to perform the downcase query.
Should you search Usertags manually you should use the `SimpleUsertag::Usertag#find_by_name` method, instead of `SimpleUsertag::Usertag.find_by(name: 'RubyRocks')`


## ToDo

_Simple Usertag_ is in its very early stage and would need a lot of love to reach 1.0.0.
Among the many improvement areas:

- Code for only allowing a user to be tagged and not create a completely new user.
- Code for replying to a feed using @
- Update clean orphans code to find rogue users

## Contributing

All contributions are welcome.
I might not develop new features (unless a project does require it),
but I will definitely merge any interesting feature or bug fix quickly.

You know the drill:

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Add passing tests
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
