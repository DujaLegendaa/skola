defmodule SkolaWeb.TestLive do
  use Phoenix.LiveView
  import Phoenix.HTML

  def render(assigns) do
    ~H"""
    <%= raw Earmark.as_html!(@text) %>
    <.form for={@form} phx-submit="save">
      <input type="text" name="text" />
    </.form>
"""
  end
  def mount(_params, _, socket) do
    {:ok, assign(socket, :text, "") |> assign(:form, %{})}
  end

  def handle_event("save", %{"text" => text}, socket) do
{:noreply, assign(socket, :text, text)}
  end
end
