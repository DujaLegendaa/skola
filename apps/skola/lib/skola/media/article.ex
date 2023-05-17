defmodule Skola.Media.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field :name, :string
    field :header_hash, :string
    field :words, :integer
    field :date_time, :naive_datetime
    field :path, :string
    belongs_to :author, Skola.Media.Author

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:name, :header_hash, :date_time, :words, :path])
    |> validate_required([:name, :header_hash, :date_time, :words, :path])
  end
end
