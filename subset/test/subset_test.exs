defmodule SubsetTest do
  use ExUnit.Case
  doctest Subset

  @tag :skip
  test "greets the world" do
    assert Subset.hello() == :world
  end
end
