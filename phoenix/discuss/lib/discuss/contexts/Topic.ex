defmodule Discuss.Contexts.Topic do
  use Discuss.Schema

  import Ecto.Changeset

  schema "topics" do
    field(:title, :string)
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end
