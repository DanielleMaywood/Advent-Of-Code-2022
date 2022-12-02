import gleam/erlang.{start_arguments}
import glint
import challenges/day1
import challenges/day2

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
  |> glint.run(start_arguments())
}
