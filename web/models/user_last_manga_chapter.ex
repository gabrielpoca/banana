defmodule Banana.MangaLastChapter do
  use Banana.Web, :model

  @primary_key false

  schema "manga_last_chapter" do
    field :manga, :string
    field :chapter, :integer
    belongs_to :user, Banana.User

    timestamps()
  end
end
