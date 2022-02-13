defmodule Discuss.Repo.Migrations.AddUserIdToTopics do
  use Ecto.Migration

  def change do
    alter table(:topics) do
      add :user_id, references(:users, type: :binary_id), null: false
    end

    create index(:topics, [:user_id])
  end
end
