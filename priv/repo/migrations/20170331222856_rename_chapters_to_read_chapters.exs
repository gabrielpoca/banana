defmodule Banana.Repo.Migrations.RenameChaptersToReadChapters do
  use Ecto.Migration

  def change do
    rename table(:chapters), to: table(:read_chapters)
  end
end
