defmodule Discuss.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add :email, :string
      add :provider, :string
      add :token, :string

      timestamps()
    end

    create index("users", [:email])
  end
end
