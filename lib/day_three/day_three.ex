defmodule DayThree do
  defmodule PartOne do
    def execute(lines) when is_list(lines) do
      {symbol_lookup, number_lookup} = DayThree.build_lookups(lines, ~r/[^\d. ]/)

      symbol_lookup
      |> Enum.with_index()
      |> Enum.reduce([], fn {symbol_indices, index}, acc ->
        line_results =
          symbol_indices
          |> Enum.map(&DayThree.get_adjacent_numbers(number_lookup, index, &1, lines))
          |> List.flatten()

        case acc do
          [previous | _rest] = acc ->
            [Enum.reject(line_results, &(&1 in previous)) | acc]

          _ ->
            [line_results | acc]
        end
      end)
      |> List.flatten()
      |> Enum.reduce(0, fn {_, _, num}, sum ->
        {parsed, _rem} = Integer.parse(num)
        sum + parsed
      end)
    end

    def execute(file_path) do
      file_path
      |> DayThree.parse_file()
      |> execute()
    end
  end

  defmodule PartTwo do
    def execute(lines) when is_list(lines) do
      {symbol_lookup, number_lookup} = DayThree.build_lookups(lines, ~r/[*]/)

      symbol_lookup
      |> Enum.with_index()
      |> Enum.reduce(0, fn {symbol_indices, index}, sum ->
        products =
          symbol_indices
          |> Enum.map(fn symbol_index ->
            number_lookup
            |> DayThree.get_adjacent_numbers(index, symbol_index, lines)
            |> get_product()
          end)
          |> Enum.reduce(0, &(&1 + &2))

        sum + products
      end)
    end

    def execute(file_path) do
      file_path
      |> DayThree.parse_file()
      |> execute()
    end

    defp get_product(matches) when length(matches) == 2 do
      Enum.reduce(matches, 1, fn {_, _, num}, product ->
        {parsed, _} = Integer.parse(num)
        parsed * product
      end)
    end

    defp get_product(_matches), do: 0
  end

  def parse_file(file_path) do
    {:ok, content} = File.read(file_path)

    String.split(content, "\n")
  end

  def build_lookups(lines, symbol_pattern) do
    Enum.reduce(lines, {[], []}, fn line, {symbol_lookup, number_lookup} ->
      codepoints = line |> String.codepoints() |> Enum.with_index()

      {
        [build_symbol_indices(codepoints, symbol_pattern) | symbol_lookup],
        [build_number_indices(codepoints) | number_lookup]
      }
    end)
  end

  def get_adjacent_numbers(number_lookup, index, symbol_index, lines) do
    matches = get_matches(number_lookup, index, symbol_index)
    previous_matches = get_previous_matches(number_lookup, index, symbol_index)
    next_matches = get_next_matches(number_lookup, index, symbol_index, lines)

    List.flatten(matches ++ previous_matches ++ next_matches)
  end

  defp get_matches(number_lookup, index, symbol_index) do
    number_lookup
    |> Enum.at(index)
    |> find_matches(symbol_index)
  end

  defp get_previous_matches(number_lookup, index, symbol_index) do
    if index == 0 do
      []
    else
      number_lookup
      |> Enum.at(index - 1)
      |> find_matches(symbol_index)
    end
  end

  defp get_next_matches(number_lookup, index, symbol_index, lines) do
    if index == length(lines) - 1 do
      []
    else
      number_lookup
      |> Enum.at(index + 1)
      |> find_matches(symbol_index)
    end
  end

  defp find_matches(line_number_indices, symbol_index) do
    Enum.filter(line_number_indices, fn {starting_index, ending_index, _num} ->
      symbol_index in Enum.to_list((starting_index - 1)..(ending_index + 1))
    end)
  end

  defp build_symbol_indices(codepoints, symbol_pattern) do
    codepoints
    |> Enum.filter(fn {char, _char_index} -> Regex.match?(symbol_pattern, char) end)
    |> Enum.map(fn {_char, char_index} -> char_index end)
  end

  defp build_number_indices(codepoints) do
    codepoints
    |> Enum.filter(fn {char, _char_index} -> Regex.match?(~r/[\d]/, char) end)
    |> Enum.with_index()
    |> Enum.reduce([], fn {{char, char_index}, index}, acc ->
      with false <- index == 0,
           [{starting_index, previous_index, previous_val} | rest] <- acc,
           ^char_index <- previous_index + 1 do
        [{starting_index, char_index, previous_val <> char} | rest]
      else
        _ -> [{char_index, char_index, char} | acc]
      end
    end)
  end
end
