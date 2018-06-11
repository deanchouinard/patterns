# From a gist by Connor Rigby
defmodule MyApp.ConfigStorage do
  @moduledoc """
  Pretty standard KV Bucket.
  """

  ## API
  @doc "Put a value in the Config Storage."
  def put(cs, key, val) do
    GenServer.call(cs, {:put, key, val})
  end

  @doc "Get a value from the Config Storage."
  def get(cs, key, default \\ nil) do
    GenServer.call(cs, {:get, key, default})
  end

  use GenServer

  defmodule KV do
    @moduledoc """
    Wrapper structure to hide the contents of the config bucket.
    """

    defstruct [data: %{}, ref: nil, backing_file: nil]

    @doc "New KV Bucket."
    def new(backing_file) do
      struct(KV, [ref: make_ref(), backing_file: backing_file])
    end

    @doc false
    def put(kv, key, val), do: %{kv | data: Map.put(kv.data, key, val)}

    @doc false
    def get(kv, key, default), do: Map.get(kv.data, key, default)

    defimpl Inspect, for: MyApp.ConfigStorage.KV do
      def inspect(kv, _), do: "#KV<#{kv.backing_file}>"
    end

  end

  @doc false
  def start_link(backup_file, opts) do
    GenServer.start_link(__MODULE__, [backup_file], opts)
  end

  def stop(kv) do
    GenServer.stop(kv, :normal)
  end

  @doc false
  def init([backup_file]), do: load(backup_file)

  def terminate(_, kv) do
    flush(kv)
    :ok
  end

  def handle_call({:put, key, value}, _from, kv) do
    case save(kv, key, value) do
      {:ok, new_kv} -> {:reply, :ok, new_kv}
      {:error, reason} -> {:reply, {:error, reason}, kv}
    end
  end

  def handle_call({:get, key, default}, _from, kv) do
    {:reply, KV.get(kv, key, default), kv}
  end

  defp load(file) do
    case File.read(file) do
      {:ok, data} -> {:ok, :erlang.binary_to_term(data)}
      _ -> {:ok, KV.new(file)}
    end
  end

  defp save(kv, key, value) do
    new = KV.put(kv, key, value)
    flush(new)
  end

  defp flush(kv) do
    case File.write(kv.backing_file, :erlang.term_to_binary(kv)) do
      :ok -> {:ok, kv}
      {:error, reason} -> {:error, reason}
    end
  end
end

File.rm_rf("/tmp/data.term")
{:ok, kv} = MyApp.ConfigStorage.start_link("/tmp/data.term", [])
MyApp.ConfigStorage.put(kv, "hey", "world")
IO.inspect MyApp.ConfigStorage.get(kv, "hey"), label: "hey"
IO.inspect MyApp.ConfigStorage.get(kv, "whoops", :default), label: "whoops"
MyApp.ConfigStorage.put(kv, "dc", "Hello Dean")
MyApp.ConfigStorage.stop(kv)

{:ok, kv} = MyApp.ConfigStorage.start_link("/tmp/data.term", [])
IO.inspect MyApp.ConfigStorage.get(kv, "hey"), label: "hey"
IO.inspect MyApp.ConfigStorage.get(kv, "dc"), label: "dc"
MyApp.ConfigStorage.stop(kv)
