defmodule Discuss.Repo.Migrations.CreateTopics do
  use Ecto.Migration

  def change do
    create table(:topics, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:title, :string)
    end
  end
end
