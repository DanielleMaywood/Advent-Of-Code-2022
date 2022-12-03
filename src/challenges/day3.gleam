import gleam/erlang/file
import gleam/bit_string
import gleam/string
import gleam/list
import gleam/int
import gleam/set
import gleam/io

fn priority(item) {
  case bit_string.from_string(item) {
    <<v>> if v >= 97 && v <= 122 -> v - 97 + 1
    <<v>> if v >= 65 && v <= 90 -> v - 65 + 27
  }
}

pub fn solution(_) {
  assert Ok(input) = file.read("data/day3/input.txt")

  let rucksacks =
    input
    |> string.trim
    |> string.split(on: "\n")

  let priority_sum =
    rucksacks
    |> list.map(fn(rucksack) {
      let graphemes =
        rucksack
        |> string.to_graphemes

      let #(compartment_a, compartment_b) =
        graphemes
        |> list.split(at: list.length(graphemes) / 2)

      let [duplicate] =
        set.intersection(
          set.from_list(compartment_a),
          set.from_list(compartment_b),
        )
        |> set.to_list

      priority(duplicate)
    })
    |> int.sum

  io.debug(priority_sum)

  let group_id_sum =
    rucksacks
    |> list.sized_chunk(3)
    |> list.map(fn(group) {
      let [a, b, c] =
        group
        |> list.map(string.to_graphemes)
        |> list.map(set.from_list)

      let [group_id] =
        a
        |> set.intersection(b)
        |> set.intersection(c)
        |> set.to_list

      priority(group_id)
    })
    |> int.sum

  io.debug(group_id_sum)

  Ok(0)
}
