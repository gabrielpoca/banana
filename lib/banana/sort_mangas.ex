defmodule Banana.SortMangas do

  alias Banana.{Repo, Chapter}
  import Ecto.Query

  def call(mangas, user_id) do
    sort_by_chapters([], mangas, favorite_chapters(user_id)) |> Enum.reverse
  end

  defp sort_by_chapters(sorted, [], _chapters), do: sorted

  defp sort_by_chapters(sorted, [manga | mangas] = all, chapters) do
    if Enum.member?(chapters, manga["mangaId"]) do
      sort_by_chapters(sorted ++ [manga], mangas, chapters)
    else
      sort_by_chapters([manga | sorted], mangas, chapters)
    end
  end

  defp favorite_chapters(user_id) do
    from(c in Chapter,
      select: c.manga,
      where: c.user_id == ^user_id,
      order_by: [desc: c.updated_at],
      limit: 4)
    |> Repo.all
  end
end
