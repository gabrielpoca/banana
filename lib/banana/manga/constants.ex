defmodule Manga.Constants do
  def all_url do
    "https://doodle-manga-scraper.p.mashape.com/mangareader.net?cover=1"
  end

  def manga_url(manga_id) do
    "https://doodle-manga-scraper.p.mashape.com/mangareader.net/manga/#{manga_id}/"
  end

  def manga_chapter_url(manga_id, chapter_id) do
    "https://doodle-manga-scraper.p.mashape.com/mangareader.net/manga/#{manga_id}/#{chapter_id}"
  end

  def search_url(query) do
    "https://doodle-manga-scraper.p.mashape.com/mangareader.net/search?cover=1&info=0&l=10&q=#{query}"
  end
end
