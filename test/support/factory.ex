defmodule Banana.Factory do
  use ExMachina.Ecto, repo: Banana.Repo

  alias Banana.{User, Chapter}

  def user_factory do
    %User{
      username: sequence("username"),
      encrypted_password: "some password"
    }
  end

  def chapter_factory do
    %Chapter{
      manga: sequence("manga"),
      chapter: 1,
      user: build(:user)
    }
  end
end
