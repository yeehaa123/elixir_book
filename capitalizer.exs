defmodule Capitalizer do
  def capitalize_sentence(str) do
    str 
    |> String.split(". ") 
    |> Enum.map(String.capitalize(&1))
    |> Enum.join ". "
  end
end
