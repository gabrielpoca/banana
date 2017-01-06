defmodule Banana.User do
  use Banana.Web, :model

  import Comeonin.Bcrypt, only: [hashpwsalt: 1, checkpw: 2]

  schema "users" do
    field :username, :string
    field :password, :string, virtual: true
    field :encrypted_password, :string

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :encrypted_password])
    |> validate_required([:username, :encrypted_password])

    struct
    |> cast(params, [
      :username,
      :password
    ])
    |> unique_constraint(:username)
    |> validate_required([:username, :password])
    |> encrypt_password
  end

  def check_password(password, %{encrypted_password: encrypted_password}) do
    checkpw(password, encrypted_password)
  end

  def check_password(_password, _), do: false

  defp encrypt_password(changeset) do
    case changeset.params["password"] || changeset.params[:password] do
      nil -> changeset
      password -> put_change(changeset, :encrypted_password, hashpwsalt(password))
    end
  end
end
