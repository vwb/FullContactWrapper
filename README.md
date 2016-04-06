#FullContactWrapper

A small app demonstrating a wrapper layer for the FullContact gem in order to cache queries to a local database by monkey patching the `FullContact.person` method.

###Implementation Details

* Added a `Cached Person` table to hold the local cache of people who have been previously queried.

* In `fullcontact_init.rb` monkeypatched the `FullContact#person` method to first check if email exists in local database.
	* The email was then sanitized and ensured to be of proper format before continuing

* If email existed the ActiveRecord object with data was passed back, otherwise `nil`.

* In `nil` case, query is performed and then a new entry to the database with the current email is created.

* Utilized `figaro` gem for managing API keys