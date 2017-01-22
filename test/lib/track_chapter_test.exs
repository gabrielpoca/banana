defmodule Banana.TrackChapterTest do
  use Banana.ConnCase
  use ExUnit.Case, async: true

  alias Banana.{TrackChapter, Chapter}

  import Banana.Factory

  test "creates a chapter" do
    user = insert(:user)

    TrackChapter.call("naruto", 1, user.id)

    chapter = Repo.get_by(Chapter, %{user_id: user.id, manga: "naruto", chapter: 1})
    assert chapter != nil
  end

  test "it touches a chapter" do
    %{
      manga: manga_id,
      chapter: chapter_id,
      updated_at: updated_at,
      user_id: user_id
    } = insert(:chapter)

    TrackChapter.call(manga_id, chapter_id, user_id)

    chapter = Repo.get_by(Chapter, %{user_id: user_id, manga: manga_id, chapter: chapter_id})
    assert updated_at != chapter.updated_at
  end
end
