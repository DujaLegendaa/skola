defmodule Skola.Media.Author do
  use Ecto.Schema
  import Ecto.Changeset

  schema "authors" do
    field :name, :string
    field :surname, :string
    has_many :articles, Skola.Media.Article

    timestamps()
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:name, :surname])
    |> validate_required([:name, :surname])
  end
end
