defmodule Latency.Response do
  use Ecto.Schema
  import Ecto.Changeset
  @derive {Poison.Encoder, only: [:latency, :status, :url, :time]}
  schema "responses" do
    field :latency, :integer
    field :status, :integer
    field :time, :time
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(response, attrs \\ %{}) do
    response
    |> cast(attrs, [:url, :latency, :status, :time])
    |> validate_required([:url, :latency, :status, :time])
  end
end
