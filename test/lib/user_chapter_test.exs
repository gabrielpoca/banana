defmodule Banana.UserChapterTest do
  use Banana.ConnCase
  use ExUnit.Case, async: true

  import Banana.Factory

  alias Banana.{UserChapter, Chapter}

  describe "last_for_manga" do
    test "return the last chapter a user read" do
      user = insert(:user)
      chapter = insert(:chapter, user: user, manga: "naruto", chapter: 2)
      insert(:chapter, user: user, manga: "naruto", chapter: 1)
      insert(:chapter, user: user, manga: "naruto", chapter: 3)

      touch_chapter(chapter)

      assert UserChapter.last_for_manga(user, "naruto").chapter == chapter.chapter
    end
  end

  describe "all_for_manga" do
    test "returns all the chapters a user read for a manga" do
      user = insert(:user)
      insert_list(4, :chapter, user: user)
      insert(:chapter, user: user, manga: "naruto", chapter: 1)
      insert(:chapter, user: user, manga: "naruto", chapter: 2)

      assert UserChapter.all_for_manga(user, "naruto") |> length == 2
    end
  end

  describe "last_by_manga" do
    test "returns the last read chapter for each manga" do
      user = insert(:user)
      Enum.each([1, 2], fn (chapter) ->
        insert(:chapter, user: user, manga: "naruto", chapter: chapter)
        insert(:chapter, user: user, manga: "fairy_tail", chapter: chapter)
      end)

      chapters = UserChapter.last_by_manga(user)

      assert chapters |> length == 2
      for chapter <- chapters do
        assert chapter.chapter == 2
      end
    end
  end

  defp touch_chapter(chapter) do
    changeset = Chapter.changeset(chapter, %{})
    Repo.update!(changeset, force: true)
  end
end
