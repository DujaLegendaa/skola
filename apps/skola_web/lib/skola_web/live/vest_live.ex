defmodule SkolaWeb.VestLive do
  use Phoenix.LiveView

  def mount(_params, _, socket) do
    {:ok, assign(socket, :text, "") |> assign(:form, %{})}
  end

end
