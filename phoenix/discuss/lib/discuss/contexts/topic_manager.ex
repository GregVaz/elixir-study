defmodule Discuss.Contexts.TopicManager do
  @moduledoc """
  The Contexts.TopicManager context.
  """

  import Ecto.Query, warn: false

  alias Discuss.Repo
  alias Discuss.Contexts.Topic

  @doc """
  Returns the list of topics.

  ## Examples

      iex> list()
      [%Topic{}, ...]

  """
  @spec list() :: [Topic.t()]
  def list() do
    Topic
    |> Repo.all()
  end

  @doc """
  Gets a single topic.

  Raises if the Topic does not exist.

  ## Examples

      iex> get!(123)
      %Topic{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  @spec get!(String.t()) :: Topic.t()
  def get!(id), do: Repo.get!(Topic, id)

  @doc """
  Creates a Topic.

  ## Examples

      iex> create(%{field: value})
      {:ok, %Topic{}}

      iex> create(%{field: wrong_value})
      {:error, ...}

  """
  @spec create(map()) :: {:ok, Topic.t()} | {:error, Ecto.Changeset.t()}
  def create(%{} = attrs) do
    %Topic{}
    |> Topic.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a Topic.

  ## Examples

      iex> update(topic, %{field: new_value})
      {:ok, %Topic{}}

      iex> update(topic, %{field: wrong_value})
      {:error, ...}

  """
  @spec update(Topic.t(), map()) ::
          {:ok, Topic.t()} | {:error, Ecto.Changeset.t()}
  def update(%Topic{} = topic, attrs) do
    topic
    |> Topic.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Topic.

  ## Examples

      iex> delete(topic)
      {:ok, %Topic{}}

      iex> update(topic)
      {:error, ...}

  """
  @spec delete!(Topic.t()) ::
          {:ok, Topic.t()} | {:error, Ecto.Changeset.t()}
  def delete!(%Topic{} = topic), do: Repo.delete!(topic)

  @doc """
  Returns a data structure for tracking topic changes.

  ## Examples

      iex> change(topic)
      %Topic{...}

  """
  @spec change(Topic.t(), map()) :: Ecto.Changeset.t()
  def change(%Topic{} = topic, attrs \\ %{}) do
    Topic.changeset(topic, attrs)
  end
end
