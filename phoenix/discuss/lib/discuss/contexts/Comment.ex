defmodule Discuss.Contexts.Comment do
  use Discuss.Schema

  import Ecto.Changeset

  schema "comments" do
    field :content, :string
    belongs_to :user, Discuss.Contexts.User
    belongs_to :topic, Discuss.Contexts.Topic

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content])
    |> validate_required([:content])
  end
end
