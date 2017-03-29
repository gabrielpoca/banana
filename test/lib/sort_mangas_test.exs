defmodule Banana.SortMangasTest do
  use Banana.ConnCase
  use ExUnit.Case, async: true

  alias Banana.{SortMangas, TrackChapter}

  import Banana.Factory

  test "it sorts by the user's favorite mangas" do
    {:ok, mangas} = MangaClient.Client.all()
    user = insert(:user)
    read_mangas = mangas |> Enum.shuffle |> Enum.take(4) |> Enum.map(&(Map.get(&1, "mangaId")))
    Enum.map(read_mangas, fn (manga) ->
      TrackChapter.call(manga, 1, user.id)
    end)

    sorted_mangas = SortMangas.call(mangas, user.id)
    |> Enum.take(4)
    |> Enum.map(&(Map.get(&1, "mangaId")))

    assert Enum.all?(read_mangas, &(Enum.member?(sorted_mangas, &1)))
  end
end
