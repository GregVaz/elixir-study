defmodule Discuss.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add :content, :string
      add :user_id, references(:users, type: :binary_id), null: false
      add :topic_id, references(:topics, type: :binary_id), null: false
      timestamps()
    end
  end
end
