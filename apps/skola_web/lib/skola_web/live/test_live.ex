defmodule SkolaWeb.TestLive do
  use Phoenix.LiveView
  import Phoenix.HTML

  def render(assigns) do
    ~H"""
    <%= raw File.read!("vesti/html/prva.html") %>
"""
  end
  def mount(_params, _, socket) do
    {:ok, assign(socket, :text, "") |> assign(:form, %{})}
  end

  def handle_event("save", %{"text" => text}, socket) do
{:noreply, assign(socket, :text, text)}
  end
end
