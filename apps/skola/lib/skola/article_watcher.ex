defmodule Skola.ArticleWatcher do
  use GenServer 

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end  

  def init(args) do
    {:ok, watcher_pid} = FileSystem.start_link(args)
    FileSystem.subscribe(watcher_pid)
    {:ok, %{watcher_pid: watcher_pid}}
  end

  def handle_info({:file_event, watcher_pid, {path, events}}, %{watcher_pid: watcher_pid} = state) do
    for event <- events do
      IO.inspect(event)
      case event do
        :closed -> 
          persist_article_info(path)
          convert_and_write_html(path)
        _ -> path
      end
    end
    {:noreply, state}
  end

  def persist_article_info(path) do
    %{author: %{name: author_name, surname: surname}, date_time: dt, header_hash: hash, article_name: article_name, words: words} = Skola.InfoExtract.extract_full(path)  
    
    author = Skola.Media.get_or_create_author(author_name, surname)

    case Skola.Media.get_article_by_path!(path) do
      nil -> 
        Skola.Media.create_article(%{name: article_name, header_hash: hash, date_time: dt, words: words, path: path}, author)
      article -> 
        %{header_hash: old_hash} = article
        if old_hash != hash do
          Skola.Media.delete_article(article)
          Skola.Media.create_article(%{name: article_name, header_hash: hash, date_time: dt, words: words, path: path}, author)
        end
    end
  end

  def convert_and_write_html(path) do
    html = Skola.Converter.md_to_html(path)

    [base_folder, _, file_name] = Path.split(path) |> Enum.take(-3)

    file_name = Path.rootname(file_name) <> ".html"

    File.write!(Path.join([base_folder, "html", file_name]), html, [:write])
  end


  def handle_info({:file_event, watcher_pid, :stop}, %{watcher_pid: watcher_pid} = state) do
    IO.inspect("ugasio sam ga")
    {:noreply, state}
  end
end
