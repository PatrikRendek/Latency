defmodule LatencyWeb.PageController do
  use LatencyWeb, :controller
  alias Latency.Response
  alias Latency.Repo

  @doc """
  Method for rendering index.html.
  """

  def index(conn,_params) do
    render(conn, "index.html")
  end

  @doc """
  Method for parsing response code,returns 500 if an error occurs, if does not returns status code.
  """
  def get_response_code(url) do
    case HTTPoison.get(url) do
      {:ok,%HTTPoison.Response{status_code: status_code}} ->
        status_code
      {:error, %HTTPoison.Error{reason: reason}} ->
        500
    end 
  end

  @doc """
  Method for getting latency,status_code and time when a request was sent. Save response object to db,
  returns json representation of response object, if an error occurs it returns json with "Failed".

  """
  def check_response(conn,params) do
    status=0
    url=params["url"]
    time_now=DateTime.utc_now
    start_ms = System.monotonic_time(:milliseconds)
    # do the request and receive response
    status=get_response_code(url)
    end_ms = System.monotonic_time(:milliseconds)
    latency = end_ms - start_ms
    changeset= Response.changeset(%Response{}, %{latency: latency, status: status,url: url, time: time_now,})
    # save response obj
    case Repo.insert(changeset) do
      {:ok, _changeset} ->
        json(conn,%{latency: latency, status: status,url: url, time: time_now,})
      {:error, _changeset} ->
        json(conn,{"Failed"})
      end
  end

end
