defmodule LatencyWeb.PageController do
  use LatencyWeb, :controller
  alias Latency.Response
  alias Latency.Repo
  import Plug.Conn



  def index(conn,params) do
    render(conn, "index.html",url: params["url"])
  end

  def check_response(conn,params) do
    url=params["url"]
    time_now=DateTime.utc_now
    start_ms = System.monotonic_time(:milliseconds)
     # do the request and receive response
    response_json = HTTPoison.get!(url)
    end_ms = System.monotonic_time(:milliseconds)
    status = response_json.status_code
    latency = end_ms - start_ms
    changeset= Response.changeset(%Response{}, %{latency: latency, status: status,url: url, time: time_now,})
    IO.inspect changeset.changes.latency
    case Repo.insert(changeset) do
      {:ok, changeset} ->
        json(conn,%{latency: latency, status: status,url: url, time: time_now,})
      {:error, changeset} ->
        json(conn,{"Failed"})
      end
  end

end
