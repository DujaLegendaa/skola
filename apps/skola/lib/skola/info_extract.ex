defmodule Skola.InfoExtract do

  def extract_header(file) do
    file
    |> File.stream!()
    #check if header start
    |> Stream.take_while(&(String.trim(&1) != "-----HEADER END-----"))
    |> Stream.map(&String.trim/1)
    |> Enum.to_list()
    |> Enum.drop(1)
  end

  def parse_header_piece(info) do
    [token | rest] = String.split(info) 
    case token do
      "Naziv:" ->
        {:article_name, Enum.join(rest, " ")}
      "Autor:" ->
        [name, surname] = rest
        {:author, %{name: name, surname: surname}}
      "Vreme:" ->
        {:date_time, Enum.at(rest, 0) |> DateTime.from_iso8601 |> elem(1)}
    end
  end
  def reduce_h(x, acc) do
    {field, val} = parse_header_piece(x)
    Map.put(acc, field, val)
  end

  def extract_from_header(header) do
    Enum.reduce(header, %{}, &reduce_h/2)
  end

  def hash(enumerable) do
    enumerable
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

  def extract_full(file_path) do
    header = extract_header(file_path)

    extract_from_header(header)
    |> Map.put(:words, count_words(file_path))
    |> Map.put(:header_hash, hash(header))
  end

end
