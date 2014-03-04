# Supertag


This gem is for tagging users using the "@", tagging things using the "#", tagging whatever else with "$" and in the future allowing extentions of the tags with "%". It will search your code and create a page with those attributes.

Thank you Raphael Campardou for use of your gem(simple_hashtag)
This is a work in progress, right now. It allows for the use of "$", "#", "@", and "%". The "%" is a future work in progress for allowing an attribute. For example: @somealias%private would create a private message. For now use it if you wish, but that one is not complete as of now. If you would like to contribute, by all means fork and let me know! Or collaborate with me as well so we can improve this. Any questions/comments/additions you would like to see/subtractions you think I should do/or just to tell me that you think this is awesome(or sucks) can be done through github/scy0846 or the email address in the gemfile.

It's simple, and like all things simple, it can create a nice effect, quickly.

## Installation

Add this line to your application's Gemfile:
```ruby
gem 'supertag'
```

And execute:
```shell
$ bundle
```

Then you have to generate the migration files:
```shell
$ rails g supertag:migration
```

This will create two migration files, one for the `tags` table and one for the `tagging` table.
You will need to run `rake db:migrate` to actually create the tables.

__Optionnally__, you can create views,
if only to guide you through your own implementation:
```shell
$ rails g supertag:views
```

**you may need a partial file in your fiew of _posts(or whatever content your using)**

This will create a __basic controller__, a __short index view__ and a __small helper__.
It assume your views follow the convention of having a directory named after your model's plural, and a partial named after your model's name.
```
app
|-- views
|    |-- posts
|    |    |-- _post.html.erb
```


## Usage

Just add `include Supertag::Taggable` in your model.

_Simple Hasthag_ will parse the `body` attribute by default:

```ruby
class Post < ActiveRecord::Base
  include Supertag::Taggable
end
```


If you need to parse another attribute instead,
add `taggable_attribute` followed by the name of your attribute, i.e.:
```ruby
class Picture < ActiveRecord::Base
  include Supertag::Taggable
  taggable_attribute :caption
end
```

From here on, if your text contains a tag, say _@RubyRocks_,
_Supertag_ will find it, store it in a table and retreive it and its associated object if asked.
---------------------------------------------------------------------------------------
Helpers are also available to create a link when displaying the text.
To use the helper, if you are new to rails you would place in your view page

<%= linkify_tags(taggable_content) %>

when you use this helper it will read the content find the hashtags and spew all of your content back on the page with links on the taggables. If you have your content tag above it and the helper tag below that realize you will repeat your content. Hopefully this will save you some time.
----------------------------------------------------------------------------------------
### Controller and Views
If you don't want to bother looking at the generated controller and views, here is a quick peek.
In a Controller, display all tags, or search for a Tag and its associated records:
```ruby
class TagsController < ApplicationController
  def index
    @tags = Supertag::Tag.all
  end

  def show
    @tag = Supertag::Tag.find_by_name(params[:tag])
    @tagged = @tag.taggables if @tag
  end
end
```

The views could resemble something like this:

Index:
```erb
<h1>Tags</h1>
<ul>
<% @tags.each do |tag| %>
  <li><%= link_to tag.name, tag_path(tag.name) %></li>
<% end -%>
</ul>
```

Show:
```erb
<h1><%= params[:tag] %></h1>
<% if @tagged %>
  <% @tagged.each do |tagged| %>
    <% view    = tagged.class.to_s.underscore.pluralize %>
    <% partial = tagged.class.to_s.underscore %>
    <%= render "#{view}/#{partial}", {partial.to_sym => tagged} %>
  <% end -%>
<% else -%>
  <p>There is no match for the <em><%= params[:tag] %></em> tag.</p>
<% end -%>
```
In the gem it is actually extracted in a helper.


### Routes

If you use the provided controller and views, the generator will add two routes to your app:
```ruby
get 'tags/',         to: 'tags#index',     as: :tags
get 'tags/:tag', to: 'tags#show',      as: :tag
```

The helper generating the link relies on it.



### Spring Cleaning
There is a class method `Supertag::Tag#clean_orphans` to remove unused tags from the DB.
It is currently not hooked, for two reasons:
- It is not optimised at all, DB-wise.
- Destructive method should be called explicitly.

Knowing all this, you can hook it after each change, or automate it with a Cron job, or even spring-clean manually once in a while.

Improvements for this method are listed in the Todo section below.


## Gotchas
### Association Query
The association between a Tag and your models is a polymorphic many-to-many.

The object returned by the query is an array, not an Arel query, so you can't chain (i.e.: to specify the order), and should do it by hand:

```ruby
tag = Supertag.find_by_name("RubyRocks")
posts_and_picts = tag.taggables
posts_and_picts.sort_by! { |p| p.created_at }
```

### find_by

To preserve coherence, Tags are stored downcased.
To ensure coherence, they are also searched downcased.
Internally, the model overrides `find_by_name` to perform the downcase query.
Should you search Tags manually you should use the `Supertag::Tag#find_by_name` method, instead of `Supertag::Tag.find_by(name: 'RubyRocks')`


## ToDo

_Supertag_ is in its very early stage and would need a lot of love to reach 1.0.0.
Among the many improvement areas:

- Code for only allowing a user to be tagged and not create a completely new user.
- Code for replying to a feed using @
- Update clean orphans code to find rogue users
- Code for attributes and only allowing certain attributes

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
