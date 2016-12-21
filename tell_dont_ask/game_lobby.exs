# Example of Tell, Don't Ask for Josh Clayton of Thoughtbot
#
defmodule Game.Lobby do
  def add_player(%{game: game} = lobby, player) do
    %{lobby |
      game: %{game | players: game.players ++ [Game.Player.new(player)]}}
  end
end

defmodule Game.Player do
  defstruct id: 0, name: "New Player", active: true

  def new(name) when is_binary(name), do: new(%{name: name, id: generate_id})
  def new(a)    when is_map(a), do: %__MODULE__{} |> Map.merge(a)
  def new(_),                    do: %__MODULE__{}

  defp generate_id, do: :rand.uniform()
end

IO.inspect lobby = %{game: %{players: []}}
lobby = Game.Lobby.add_player(lobby, "Bob")
IO.inspect lobby
IO.inspect Game.Lobby.add_player(lobby, "Sam")



