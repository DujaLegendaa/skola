defmodule Skola.MediaTest do
  use Skola.DataCase

  alias Skola.Media

  describe "authors" do
    alias Skola.Media.Author

    import Skola.MediaFixtures

    @invalid_attrs %{name: nil, surname: nil}

    test "list_authors/0 returns all authors" do
      author = author_fixture()
      assert Media.list_authors() == [author]
    end

    test "get_author!/1 returns the author with given id" do
      author = author_fixture()
      assert Media.get_author!(author.id) == author
    end

    test "create_author/1 with valid data creates a author" do
      valid_attrs = %{name: "some name", surname: "some surname"}

      assert {:ok, %Author{} = author} = Media.create_author(valid_attrs)
      assert author.name == "some name"
      assert author.surname == "some surname"
    end

    test "create_author/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Media.create_author(@invalid_attrs)
    end

    test "update_author/2 with valid data updates the author" do
      author = author_fixture()
      update_attrs = %{name: "some updated name", surname: "some updated surname"}

      assert {:ok, %Author{} = author} = Media.update_author(author, update_attrs)
      assert author.name == "some updated name"
      assert author.surname == "some updated surname"
    end

    test "update_author/2 with invalid data returns error changeset" do
      author = author_fixture()
      assert {:error, %Ecto.Changeset{}} = Media.update_author(author, @invalid_attrs)
      assert author == Media.get_author!(author.id)
    end

    test "delete_author/1 deletes the author" do
      author = author_fixture()
      assert {:ok, %Author{}} = Media.delete_author(author)
      assert_raise Ecto.NoResultsError, fn -> Media.get_author!(author.id) end
    end

    test "change_author/1 returns a author changeset" do
      author = author_fixture()
      assert %Ecto.Changeset{} = Media.change_author(author)
    end
  end

  describe "articles" do
    alias Skola.Media.Article

    import Skola.MediaFixtures

    @invalid_attrs %{change_time: nil, hash: nil, words: nil, write_time: nil}

    test "list_articles/0 returns all articles" do
      article = article_fixture()
      assert Media.list_articles() == [article]
    end

    test "get_article!/1 returns the article with given id" do
      article = article_fixture()
      assert Media.get_article!(article.id) == article
    end

    test "create_article/1 with valid data creates a article" do
      valid_attrs = %{change_time: ~N[2023-05-14 09:41:00], hash: "some hash", words: "some words", write_time: ~N[2023-05-14 09:41:00]}

      assert {:ok, %Article{} = article} = Media.create_article(valid_attrs)
      assert article.change_time == ~N[2023-05-14 09:41:00]
      assert article.hash == "some hash"
      assert article.words == "some words"
      assert article.write_time == ~N[2023-05-14 09:41:00]
    end

    test "create_article/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Media.create_article(@invalid_attrs)
    end

    test "update_article/2 with valid data updates the article" do
      article = article_fixture()
      update_attrs = %{change_time: ~N[2023-05-15 09:41:00], hash: "some updated hash", words: "some updated words", write_time: ~N[2023-05-15 09:41:00]}

      assert {:ok, %Article{} = article} = Media.update_article(article, update_attrs)
      assert article.change_time == ~N[2023-05-15 09:41:00]
      assert article.hash == "some updated hash"
      assert article.words == "some updated words"
      assert article.write_time == ~N[2023-05-15 09:41:00]
    end

    test "update_article/2 with invalid data returns error changeset" do
      article = article_fixture()
      assert {:error, %Ecto.Changeset{}} = Media.update_article(article, @invalid_attrs)
      assert article == Media.get_article!(article.id)
    end

    test "delete_article/1 deletes the article" do
      article = article_fixture()
      assert {:ok, %Article{}} = Media.delete_article(article)
      assert_raise Ecto.NoResultsError, fn -> Media.get_article!(article.id) end
    end

    test "change_article/1 returns a article changeset" do
      article = article_fixture()
      assert %Ecto.Changeset{} = Media.change_article(article)
    end
  end
end
