# Seedling

Seedling is a small utility for organizing how your system is seeded.

When using this system, all seedin actions are expected to be idempotent.  That is,
the seed system assumes that the seed function can safely be called multiple times without causing any problems with
the data.


## Installation

Add this line to your application's Gemfile:

    gem 'seedling'

OR

    gem 'seedling', '~> 0.0.1', :git => "git@github.com/RealNobody/seedling.git"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install seedling

## Usage

### Seeding

To seed the database, simply call:

`Seedling::Seeder.seed_all`

This is the master function which will perform all seeding tasks.  Seeding tasks are split into two types of seeding
tasks which are generally performed in this order:

1. Database seeding
2. Generic seeding

#### Database Seeding

There are 2 different ways to seed a database table, which are tried in this order:

1. A special seeding class will be looked for that matches the name of the database table class with "Seeder"
appended.  (i.e. if the database class is `MyTable`, then the seeder class that will be looked for is `MyTableSeeder`.
A class function named `seed` will be called on this class to seed the table.  If the class cannot be found, the
system will look for the appropriately underscore named file in `<Rails.root>/db/seeders/`.  (i.e.
`<Rails.root>/db/seeders/my_table_seeder.rb`
2. A class function named `seed` will be called on the class for the database table.

I don't recommend the second option, but I support it because this was the initial implementation I made.

#### Generic Seeding

All *.rb files under the `<Rails.root>/db/seeders/` folder will be loaded.  The full path under the seeder folder
will be classified to create a class name for the expected class within the file.  That class will be constantized
and if the class exists and has a `seed` class function, that function will be called.

#### Seeding order

Database tables are by default sorted based on the relationships defined in the table classes such that tables which
depend on other tables are seeded after the tables that they depend on.

If there is a cyclic dependency, there is no guarantee in which order the tables will be seeded.

Custom seed classes can define when they are called by overriding the `<=>(right_operator)` method which is called
when sorting the seeding classes.  The right operator will either be another custom sorter class or an instance of
the Seedling::Seeder class which represents the seeder for a table.  This class exposes the `table` that it will seed.

NOTE:  A Seedling:Seeder is created for every table so that you can insert a custom seeder before or after any table
you may need to.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request