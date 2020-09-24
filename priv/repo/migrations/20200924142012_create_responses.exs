defmodule Latency.Repo.Migrations.CreateResponses do
  use Ecto.Migration

  def change do
    create table(:responses) do
      add :url, :string
      add :latency, :integer
      add :status, :integer
      add :time, :time

      timestamps()
    end

  end
end
