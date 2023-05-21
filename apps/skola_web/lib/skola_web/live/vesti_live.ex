defmodule SkolaWeb.VestiLive do
  import SkolaWeb.LiveHelpers
  use Phoenix.LiveView

  def mount(_params, _, socket) do
    {:ok, assign_new(socket, :articles, fn -> Skola.Media.list_articles() end)}
  end

end
