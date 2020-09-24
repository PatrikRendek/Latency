defmodule Latency.Repo.Migrations.CreateResponsess do
  use Ecto.Migration

  def change do
    create table(:responsess) do
      add :url, :string
      add :latency, :integer
      add :status, :integer
      add :time, :time

      timestamps()
    end

  end
end
