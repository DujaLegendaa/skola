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
      case event do
        :closed -> 
          on_close(path)
        _ -> path
      end
    end
    {:noreply, state}
  end

  def on_close(path) do
    %{name: name, hash: hash, date_time: date_time, author: %{name: name, surname: surname}, words: words} = Skola.InfoExtract.extract_full(path)  

    author = Skola.Media.get_or_create_author(name, surname)

    Skola.Media.delete_article_by_path(path)
    
    Skola.Media.create_article(%{name: name, hash: hash, date_time: date_time, words: words, path: path}, author)
  end


  def handle_info({:file_event, watcher_pid, :stop}, %{watcher_pid: watcher_pid} = state) do
    IO.inspect("ugasio sam ga")
    {:noreply, state}
  end
end
