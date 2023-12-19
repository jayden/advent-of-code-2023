defmodule DayOne do
  defmodule PartOne do
    def execute(inputs) when is_list(inputs) do
      Enum.reduce(inputs, 0, fn input, sum ->
        sum + parse(input)
      end)
    end

    def execute(file_path) do
      {:ok, content} = File.read(file_path)

      content
      |> String.split("\n")
      |> execute()
    end

    defp parse(input) do
      parsed_input = String.replace(input, ~r/[^\d]/, "")

      first_number = String.at(parsed_input, 0)
      last_number = parsed_input |> String.length() |> then(&String.at(parsed_input, &1 - 1))

      {result, _rem} = Integer.parse(first_number <> last_number)
      result
    end
  end

  defmodule PartTwo do
    @numerical_lookup [
      {"one", "1"},
      {"two", "2"},
      {"three", "3"},
      {"four", "4"},
      {"five", "5"},
      {"six", "6"},
      {"seven", "7"},
      {"eight", "8"},
      {"nine", "9"}
    ]

    def execute(inputs) when is_list(inputs) do
      numerical_lookup = initialize_lookup()

      Enum.reduce(inputs, 0, fn input, sum ->
        sum + parse(input, numerical_lookup)
      end)
    end

    def execute(file_path) do
      {:ok, content} = File.read(file_path)

      content
      |> String.split("\n")
      |> execute()
    end

    defp parse(input, numerical_lookup) do
      codepoints = String.codepoints(input)

      forward = find_first_number(codepoints, numerical_lookup)
      backward = codepoints |> Enum.reverse() |> find_first_number(numerical_lookup, true)

      Integer.undigits([forward, backward])
    end

    defp find_first_number(codepoints, numerical_lookup, reverse? \\ false)

    defp find_first_number(codepoints, numerical_lookup, reverse?) do
      codepoints
      |> Enum.with_index()
      |> Enum.reduce(nil, fn char_with_index, match ->
        with true <- is_nil(match),
             {_word, num, _len} <-
               find_number(codepoints, numerical_lookup, char_with_index, reverse?),
             {parsed_num, _rem} <- Integer.parse(num) do
          parsed_num
        else
          _ -> match
        end
      end)
    end

    defp find_number(codepoints, numerical_lookup, {char, index}, reverse?) do
      Enum.find(numerical_lookup, fn {word, num, word_length} ->
        cond do
          char == num ->
            true

          string_comparison_function(reverse?).(word, char) ->
            word == codepoints |> Enum.slice(index, word_length) |> get_potential_match(reverse?)

          true ->
            false
        end
      end)
    end

    defp string_comparison_function(false), do: &String.starts_with?/2
    defp string_comparison_function(true), do: &String.ends_with?/2

    defp get_potential_match(parts, false), do: Enum.join(parts)
    defp get_potential_match(parts, true), do: parts |> Enum.reverse() |> Enum.join()

    defp initialize_lookup do
      Enum.map(@numerical_lookup, fn {word, num} ->
        {word, num, String.length(word)}
      end)
    end
  end
end
