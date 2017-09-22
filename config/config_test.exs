Code.load_file("config.ex")

ExUnit.start

defmodule ConfigTest do
  use ExUnit.Case, async: false

  test "read config at test values" do
    config = Config.read_config()
    assert config == [%{prop: "DataDir", val: "../data"}]
    assert Config.get(config, "DataDir", "/home/test") == "../data"
    assert Config.get(config, "Port", 8000) == 8000
  end
end

