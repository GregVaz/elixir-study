defmodule Discuss.Contexts.Topic do
  @moduledoc """
  The Contexts.Topic Schema.
  """

  use Discuss.Schema

  import Ecto.Changeset

  schema "topics" do
    field(:title, :string)
    belongs_to(:user, Discuss.Contexts.User)
    has_many :comments, Discuss.Contexts.Comment
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end
