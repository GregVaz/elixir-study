defmodule Discuss.Contexts.UserManager do
  @moduledoc """
  The Contexts.UserManager context.
  """

  import Ecto.Query, warn: false

  alias Discuss.Repo
  alias Discuss.Contexts.User

  @doc """
  Returns the list of Users.

  ## Examples

      iex> list()
      [%User{}, ...]

  """
  @spec list() :: [User.t()]
  def list() do
    User
    |> Repo.all()
  end

  @doc """
  Gets a single User.

  Raises if the User does not exist.

  ## Examples

      iex> get!(123)
      %User{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  @spec get!(String.t()) :: User.t()
  def get!(id), do: Repo.get!(User, id)

  @doc """
  Creates a User.

  ## Examples

      iex> create(%{field: value})
      {:ok, %User{}}

      iex> create(%{field: wrong_value})
      {:error, ...}

  """
  @spec create(map()) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  def create(%{} = attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a User.

  ## Examples

      iex> update(User, %{field: new_value})
      {:ok, %User{}}

      iex> update(User, %{field: wrong_value})
      {:error, ...}

  """
  @spec update(User.t(), map()) ::
          {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  def update(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Returns a data structure for tracking User changes.

  ## Examples

      iex> change(User)
      %User{...}

  """
  @spec change(User.t(), map()) :: Ecto.Changeset.t()
  def change(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
