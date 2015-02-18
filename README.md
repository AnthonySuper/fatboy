# Fatboy
##### See views, right here, right now
Fatboy is a gem which manages view counts on ActiveRecord objects (or things that quack like them).
It's great for seeing the most (and least) viewed models on your website.
To make things even better, Fatboy will store view counts by day, month, year,
and all-time.

It doesn't touch your SQL database. 
Fatboy stays slim in Redis.

NOTE: This is currenlty not production-ready. 
It will be soon, though.
## Installation

Add this line to your application's Gemfile:

    gem 'fatboy'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fatboy

## Usage

Fatboy is easy to set up. First, initialize it:

```ruby
  # if you don't provide your own redis, fatoby will create one 
  # with Redis.new
  fatboy = Fatboy.new(redis: redis)
```

Then, just tell it what your users look at.

```ruby
  # As long as the variable you're passing in responds to
  # .id, this will work
  fatboy.view(image)
  # You can also use the shorthand method:
  # fatboy[image]
```

Now, managing views is pretty useless if you can't retrieve them later.
Thankfully, fatboy makes this easy as well:

```ruby
  fatboy.views_for(image) # => 1
```

Don't worry if that's a brand-new Fatboy instance---as long as the Redis is the same, Fatboy's view count will be the same.

#### Getting Top Viewed

Fatboy makes it easy to retrieve a list of the most-popular records in your database.
Check it now now:
```ruby
  fatboy.popular(Image).today # => Top 10 most viewed images today
  fatboy.popular("Image").all_time # => Top viewed images all time
```

Don't want just the most popular?
Maybe you'd like the least popular?

```ruby
  fatboy.popular(Image).today(:least)
  fatboy.popular(Image).this_month(:least)
```

Or perhaps a range?

```ruby
  fatboy.popular(Image).this_month(30..40)
```

Fatboy makes it easier. 
## Contributing

1. Fork it ( https://github.com/[my-github-username]/fatboy/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Write functionality and tests
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request