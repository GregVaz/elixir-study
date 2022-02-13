defmodule Discuss.Contexts.User do
  use Discuss.Schema

  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :provider, :string
    field :token, :string
    has_many :topics, Discuss.Contexts.Topic
    timestamps()
  end

  @required_fields [
    :email,
    :provider,
    :token
  ]

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end
end
