defmodule SkolaWeb.HomeLive do
  use Phoenix.LiveView
  import SkolaWeb.LiveHelpers

  def mount(_, _, socket) do
    {:ok, assign_new(socket, :four_articles, fn -> Skola.Media.list_latest_articles(4) end)}
  end
end
