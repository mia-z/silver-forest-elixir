defmodule SilverForestTest do
  use ExUnit.Case
  doctest SilverForest

  test "greets the world" do
    assert SilverForest.hello() == :world
  end
end
