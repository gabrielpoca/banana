defmodule Banana.Repo.Migrations.CreateChapter do
  use Ecto.Migration

  def change do
    create table(:chapters) do
      add :manga, :string, null: false
      add :chapter, :integer, null: false
      add :user_id, references(:users), null: false

      timestamps()
    end

    create unique_index(:chapters, [:manga, :chapter, :user_id], name: :unique_manga_chapter_for_user)
  end
end
