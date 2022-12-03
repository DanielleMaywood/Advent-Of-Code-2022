import gleam/erlang/file
import gleam/bit_string
import gleam/string
import gleam/list
import gleam/set
import gleam/io

fn priority(item) {
  case bit_string.from_string(item) {
    <<v>> if v >= 97 && v <= 122 -> v - 97 + 1
    <<v>> if v >= 65 && v <= 90 -> v - 65 + 27
  }
}

pub fn part1(rucksacks: List(String)) {
  use total, rucksack <- list.fold(rucksacks, 0)

  let items = string.to_graphemes(rucksack)

  let #(compartment_a, compartment_b) =
    list.split(items, at: list.length(items) / 2)

  let [duplicate] =
    set.from_list(compartment_a)
    |> set.intersection(set.from_list(compartment_b))
    |> set.to_list

  total + priority(duplicate)
}

pub fn part2(rucksacks: List(String)) {
  let groups = list.sized_chunk(rucksacks, 3)
  use total, group <- list.fold(groups, 0)

  let [a, b, c] =
    group
    |> list.map(string.to_graphemes)
    |> list.map(set.from_list)

  let [group_id] =
    a
    |> set.intersection(b)
    |> set.intersection(c)
    |> set.to_list

  total + priority(group_id)
}

pub fn solution(_) {
  assert Ok(input) = file.read("data/day3/input.txt")

  let rucksacks =
    input
    |> string.trim
    |> string.split(on: "\n")

  io.debug(part1(rucksacks))
  io.debug(part2(rucksacks))

  Ok(0)
}
