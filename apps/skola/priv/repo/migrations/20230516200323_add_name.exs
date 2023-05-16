defmodule Skola.Repo.Migrations.AddName do
  use Ecto.Migration

  def change do
    alter table(:articles) do
      add :name, :string
    end
  end
end
