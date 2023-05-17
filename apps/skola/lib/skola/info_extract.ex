defmodule Skola.InfoExtract do

  def get_metadata(file) do
    %{size: size, mtime: mtime, ctime: ctime} = File.stat!(file)
    %{size: size, write_time: mtime, change_time: ctime}
  end

  def hash(file) do
    file
    |> File.stream!([], 2048)
    |> Enum.reduce(:crypto.hash_init(:sha256), &(:crypto.hash_update(&2, &1)))
    |> :crypto.hash_final()
    |> Base.encode16()
    |> String.downcase()
  end

  def count_words(file) do
    file
    |> File.read!()
    |> String.split()
    |> Enum.count()
  end

  def extract(string, token, transform_fn, default) do
    [n_token | rest] = String.trim(string) |> String.split(" ")
    if token == n_token do
      transform_fn.(rest)
    else
      default
    end
  end

  # PROMENITI

  def get_name(file) do
    file
    |> File.stream!()
    |> Enum.at(0)
    |> extract("Naziv:", &Enum.join(&1, " "), "Nova vest")
  end

  def get_author(file) do
    file
    |> File.stream!()
    |> Enum.at(1)
    |> extract("Autor:", fn x -> %{name: Enum.at(x, 0), surname: Enum.at(x, 1)} end, %{name: "N", surname: "N"})
  end

  def get_time(file) do
    file 
    |> File.stream!()
    |> Enum.at(2)
    |> extract("Vreme:", fn x -> x |> Enum.at(0) |> DateTime.from_iso8601 |> elem(1) end, DateTime.now!("Etc/UTC"))
  end


  def extract_full(file_path) do
    name = get_name(file_path)
    time = get_time(file_path)
    hash = hash(file_path)
    author = get_author(file_path)
    words = count_words(file_path)
    %{name: name, date_time: time, hash: hash, author: author, words: words}
  end

end
