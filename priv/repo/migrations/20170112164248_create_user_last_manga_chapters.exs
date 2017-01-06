defmodule Banana.Repo.Migrations.CreateUserLastMangaChapters do
  use Ecto.Migration

  def up do
    execute """
    CREATE VIEW user_last_manga_chapters AS
    SELECT c0.*
    FROM chapters AS c0
    WHERE c0.updated_at in
      (SELECT max(c1.updated_at) FROM chapters AS c1 WHERE c1.user_id = c0.user_id AND c1.manga = c0.manga GROUP BY c1.manga)
    """
  end

  def down do
    execute "DROP VIEW user_last_manga_chapters;"
  end
end
