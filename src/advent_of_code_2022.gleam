import gleam/erlang.{start_arguments}
import glint
import challenges/day1
import challenges/day2
import challenges/day3
import challenges/day4
import challenges/day5
import challenges/day6

pub fn main() {
  glint.new()
  |> glint.with_pretty_help(glint.default_pretty_help)
  |> glint.add_command(
    at: ["day1"],
    do: day1.solution,
    with: [],
    described: "Day 1 Challenge",
  )
  |> glint.add_command(
    at: ["day2"],
    do: day2.solution,
    with: [],
    described: "Day 2 Challenge",
  )
  |> glint.add_command(
    at: ["day3"],
    do: day3.solution,
    with: [],
    described: "Day 3 Challenge",
  )
  |> glint.add_command(
    at: ["day4"],
    do: day4.solution,
    with: [],
    described: "Day 4 Challenge",
  )
  |> glint.add_command(
    at: ["day5"],
    do: day5.solution,
    with: [],
    described: "Day 5 Challenge",
  )
  |> glint.add_command(
    at: ["day6"],
    do: day6.solution,
    with: [],
    described: "Day 6 Challenge",
  )
  |> glint.run(start_arguments())
}
