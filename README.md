Banana
======
[![Build Status](https://semaphoreci.com/api/v1/gabrielpoca/banana/branches/master/shields_badge.svg)](https://semaphoreci.com/gabrielpoca/banana)

[Online app](http://decent-manga-reader.herokuapp.com/)

Banana is an application to read manga that matches my expectations of a decent,
online manga reader. Most applications I've been using over the years always
fail to provide a good reading experience.

Banana is build using [Phoenix](http://www.phoenixframework.org/) and the [Manga
Scraper API](https://market.mashape.com/doodle/manga-scraper).

Development
-----------

**Setup:**

To setup this application you need an account in [Mashape marketplace](https://market.mashape.com/). Create your account and create an application inside it. Add the [Manga Scraper api](https://market.mashape.com/doodle/manga-scraper) to your application. Take the application's test key and put it in `config/dev.secret.exs` (there is sample file in the config folder).

In production, the key will be read from the environment variable `MANGA_API_KEY`. See `config/prod.exs` for more details.

**Running:**

* Install dependencies with `mix deps.get`
* Create and migrate your database * with `mix ecto.create && mix ecto.migrate`
* Run the tests with `mix test`
* Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

New Features
------------

This is what I'm planning to do next (in no particular order): 

- [ ] Logo.
- [ ] Favorite mangas.
- [ ] Notification for new chapters.
- [ ] Option to register an email.
- [ ] Add CI.
- [ ] Add button to deploy to Heroku.
- [ ] Landing page.
