defmodule SkolaWeb.LiveHelpers do
  use Phoenix.Component
  alias Phoenix.LiveView.JS
    
  def convert_date(date) do
    srb = ['Januar', 'Februar', 'Mart', 'April', 'Maj', 'Jun', 'Jul', 'Avgust', 'Septembar', 'Okobar', 'Novembar', 'Decembar']
    Enum.join([Enum.at(srb, date.month - 1), " ", Integer.to_string(date.day)])
  end

  def md_path_to_html(path) do
    [base_folder, _, file_name] = Path.split(path) |> Enum.take(-3)

    file_name = Path.rootname(file_name) <> ".html"

    Path.join([base_folder, "html", file_name])
  end

  def extract_first_paragraph(path) do
    case Regex.run(~r{<p>(.*?)<\/p>}, File.read!(md_path_to_html(path))) do
      [_, paragraph] -> paragraph
      _ -> ""
    end
  end


  def article_card(assigns) do
    ~H""" 
    <a
      class="bg-white border-[0.5px] border-slate-200 rounded-xl drop-shadow-xl flex flex-col"
      href={@link}
      >

        <div class="h-[84%] px-[2em] pt-[1.5em] pb-[1em] flex flex-col gap-y-[1em] text-slate-800">
            <h1 class="text-4xl font-semibold"><%= @name %></h1>
      <div class="text-xl" style="display: -webkit-box; -webkit-line-clamp: 7; -webkit-box-orient: vertical; overflow: hidden;"><%= @paragraph %></div>
        </div>
        <div id="footer" class="h-[16%] bg-red-500 rounded-b-lg flex px-[2em]">
          <p class="self-center w-full text-3xl text-white font-semibold"><%= @date %></p>
        </div>
    </a>
"""
  end
end
