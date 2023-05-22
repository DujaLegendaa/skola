defmodule SkolaWeb.VestLive do
  use Phoenix.LiveView
  import SkolaWeb.LiveHelpers
  import Phoenix.HTML

  def mount(%{"id" => id}, _, socket) do
    {:ok, assign_new(socket, :article, fn -> Skola.Media.get_article!(id) end)}
  end

end
