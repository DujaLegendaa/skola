defmodule Skola.MediaFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Skola.Media` context.
  """

  @doc """
  Generate a author.
  """
  def author_fixture(attrs \\ %{}) do
    {:ok, author} =
      attrs
      |> Enum.into(%{
        name: "some name",
        surname: "some surname"
      })
      |> Skola.Media.create_author()

    author
  end

  @doc """
  Generate a article.
  """
  def article_fixture(attrs \\ %{}) do
    {:ok, article} =
      attrs
      |> Enum.into(%{
        change_time: ~N[2023-05-14 09:41:00],
        hash: "some hash",
        words: "some words",
        write_time: ~N[2023-05-14 09:41:00]
      })
      |> Skola.Media.create_article()

    article
  end
end
