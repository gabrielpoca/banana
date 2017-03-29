defmodule Banana.Repo.Migrations.RenameViewToMangaLastChapter do
  use Ecto.Migration

  def up do
    execute """
    ALTER VIEW user_last_manga_chapters RENAME TO manga_last_chapter
    """
  end

  def down do
    execute """
    ALTER VIEW manga_last_chapter RENAME TO user_last_manga_chapters
    """
  end
end
