import gleam/erlang/file
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string

pub fn solution(_) {
  assert Ok(calories) = file.read("data/day1/calories.txt")

  assert Ok(calories_per_elf) =
    calories
    |> string.split(on: "\n\n")
    |> list.try_map(fn(elf) {
      elf
      |> string.split(on: "\n")
      |> list.try_map(int.parse)
      |> result.map(list.reduce(_, int.add))
      |> result.flatten()
    })

  let sorted_calories =
    calories_per_elf
    |> list.sort(int.compare)
    |> list.reverse()

  // Top elf
  assert Ok(top) = list.at(sorted_calories, 0)

  io.debug(top)

  // Top three
  assert Ok(top3) =
    sorted_calories
    |> list.take(3)
    |> list.reduce(int.add)

  io.debug(top3)

  Ok(0)
}
