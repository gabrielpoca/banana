defmodule Banana.TrackChapter do
  alias Banana.{ReadChapter, Repo}

  def call(manga_id, chapter_id, user_id) do
    case Repo.get_by(ReadChapter, %{manga: manga_id, chapter: chapter_id, user_id: user_id}) do
      nil -> create_chapter(manga_id, chapter_id, user_id)
      chapter -> touch_chapter(chapter)
    end
  end

  defp touch_chapter(chapter) do
    changeset = ReadChapter.changeset(chapter, %{})
    case Repo.update(changeset, force: true) do
      {:ok, _} -> {:ok}
      {:error, _} -> {:error}
    end
  end

  defp create_chapter(manga, chapter, user_id) do
    changeset = ReadChapter.changeset(%ReadChapter{}, %{user_id: user_id, manga: manga, chapter: chapter})
    case Repo.insert(changeset) do
      {:ok, _} -> {:ok}
      {:error, _} -> {:error}
    end
  end
end
