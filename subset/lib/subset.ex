defmodule Subset do
  @doc """
  Compares lists.
  subset/2 is from the Plug.Static source code copied here
  so I could see what it does.

  Compares two lists and outputs the difference from the second one.

  The key to its operation is the h variable in the first function
  signature. Notice that the same variable is used to match the
  head of each list.

    ## Examples

        iex> Subset.test_subset(["a", "b", "c"], ["a", "b", "c", "g", "i"])
        ["g", "i"]

        iex> Subset.test_subset(["a", "b", "c", "d", "e"], ["c", "d", "f"])
        []

  """
  def test_subset(expected, actual), do: subset(expected, actual)

  defp subset([h | expected], [h | actual]) do
   IO.puts "expected"
   subset(expected, actual)
  end

  defp subset([], actual) do
    IO.puts "actual"
    actual
  end

  defp subset(_, _) do
   IO.puts "empty"
   []
  end

end


