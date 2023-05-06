defmodule Skola.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Skola.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Skola.PubSub},
      # Start Finch
      {Finch, name: Skola.Finch}
      # Start a worker by calling: Skola.Worker.start_link(arg)
      # {Skola.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Skola.Supervisor)
  end
end
