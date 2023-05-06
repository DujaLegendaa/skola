defmodule Skola.Repo do
  use Ecto.Repo,
    otp_app: :skola,
    adapter: Ecto.Adapters.SQLite3
end
