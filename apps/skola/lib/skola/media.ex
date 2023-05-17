defmodule Skola.Media do
  alias Skola.Media.Author
  alias Skola.Media.Article
  alias Skola.Repo
  def list_authors do
    Repo.all(Author)
  end
  def get_author!(id), do: Repo.get!(Author, id)

  def get_author_by_name!(name, surname), do: Repo.get_by(Author, name: name, surname: surname)

  def get_or_create_author(name, surname) do
    {:ok, author} = case Skola.Media.get_author_by_name!(name, surname) do
      nil ->
        Skola.Media.create_author(%{name: name, surname: surname})
      author -> {:ok, author}
    end
    author
  end

  def create_author(attrs \\ %{}) do
    %Author{}
    |> Author.changeset(attrs)
    |> Repo.insert()
  end

  def update_author(%Author{} = author, attrs) do
    author
    |> Author.changeset(attrs)
    |> Repo.update()
  end

  def delete_author(%Author{} = author) do
    Repo.delete(author)
  end

  def change_author(%Author{} = author, attrs \\ %{}) do
    Author.changeset(author, attrs)
  end

  alias Skola.Media.Article

  def list_articles do
    Repo.all(Article)
  end

  def get_article!(id), do: Repo.get!(Article, id)

  def get_article_by_path!(path), do: Repo.get_by(Article, path: path)

  def create_article(attrs \\ %{}, author) do
    %Article{}
    |> Article.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:author, author)
    |> Repo.insert()
  end

  def update_article(%Article{} = article, attrs) do
    article
    |> Article.changeset(attrs)
    |> Repo.update()
  end

  def delete_article(%Article{} = article) do
    Repo.delete(article)
  end

  def delete_article_by_path(path) do 
    case Skola.Media.get_article_by_path!(path) do
      nil -> nil
      article ->
        Skola.Media.delete_article(article)
    end
  end

  def change_article(%Article{} = article, attrs \\ %{}) do
    Article.changeset(article, attrs)
  end
end
