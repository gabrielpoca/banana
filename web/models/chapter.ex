defmodule Banana.Chapter do
  use Banana.Web, :model

  schema "chapters" do
    field :manga, :string
    field :chapter, :integer
    belongs_to :user, Banana.User

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:manga, :chapter, :user_id])
    |> validate_required([:manga, :chapter, :user_id])
    |> unique_constraint(:unique_manga_chapter_for_user, name: :unique_manga_chapter_for_user)
    |> cast_chapter
  end

  defp cast_chapter(changeset) do
    case changeset.params["chapter"] || changeset.params[:chapter] do
      nil -> changeset
      chapter ->
        case String.valid?(chapter) do
          true -> put_change(changeset, :chapter, String.to_integer(chapter))
          false -> changeset
        end
    end
  end
end
