defmodule Skola.Converter do

  def md_to_html(path) do
    path
    |> File.stream!()
    |> Stream.drop_while(fn x -> String.trim(x) != "-----HEADER END-----" end)
    |> Enum.to_list()
    |> Enum.drop(1)
    |> Earmark.as_html!()
  end
end
