defmodule Discuss.Contexts.CommentManager do
  @moduledoc """
  The Contexts.CommentManager context.
  """

  import Ecto.Query, warn: false

  alias Discuss.Repo
  alias Discuss.Contexts.Comment

  @doc """
  Returns the list of comments.

  ## Examples

      iex> list()
      [%Comment{}, ...]

  """
  @spec list() :: [Comment.t()]
  def list() do
    Comment
    |> Repo.all()
  end

  @doc """
  Gets a single Comment.

  Raises if the Comment does not exist.

  ## Examples

      iex> get!(123)
      %Comment{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  @spec get!(String.t()) :: Comment.t()
  def get!(id), do: Repo.get!(Comment, id)

  @doc """
  Creates a Comment.

  ## Examples

      iex> create(%{field: value})
      {:ok, %Comment{}}

      iex> create(%{field: wrong_value})
      {:error, ...}

  """
  @spec create(map()) :: {:ok, Comment.t()} | {:error, Ecto.Changeset.t()}
  def create(%{} = attrs) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a Comment.

  ## Examples

      iex> update(Comment, %{field: new_value})
      {:ok, %Comment{}}

      iex> update(Comment, %{field: wrong_value})
      {:error, ...}

  """
  @spec update(Comment.t(), map()) ::
          {:ok, Comment.t()} | {:error, Ecto.Changeset.t()}
  def update(%Comment{} = comment, attrs) do
    comment
    |> Comment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Returns a data structure for tracking Comment changes.

  ## Examples

      iex> change(Comment)
      %Comment{...}

  """
  @spec change(Comment.t(), map()) :: Ecto.Changeset.t()
  def change(%Comment{} = comment, attrs \\ %{}) do
    Comment.changeset(comment, attrs)
  end
end
