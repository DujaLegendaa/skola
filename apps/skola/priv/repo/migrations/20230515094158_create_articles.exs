defmodule Skola.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :name, :string
      add :header_hash, :string
      add :date_time, :naive_datetime
      add :words, :integer
      add :path, :string
      add :author_id, references(:authors, on_delete: :nothing)

      timestamps()
    end

    create index(:articles, [:author_id])
  end
end
