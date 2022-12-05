import gleam/erlang/file
import gleam/option.{Some}
import gleam/string
import gleam/regex
import gleam/list
import gleam/map.{Map}
import gleam/int
import gleam/io

fn crate_offset(id: Int) -> Int {
  { id - 1 } * 4 + 1
}

fn apply_move(
  map: Map(Int, List(String)),
  move: #(Int, Int, Int),
  unlimited unlimited: Bool,
) -> Map(Int, List(String)) {
  let #(count, from, to) = move
  let at_a_time = case unlimited {
    True -> count
    False -> 1
  }

  case count {
    0 -> map
    _ -> {
      assert Ok(stack_from) = map.get(map, from)
      assert Ok(stack_to) = map.get(map, to)
      let #(stack_from, item) =
        list.split(stack_from, at: list.length(stack_from) - at_a_time)
      let stack_to = list.append(stack_to, item)
      let map = map.insert(map, from, stack_from)
      let map = map.insert(map, to, stack_to)
      apply_move(map, #(count - at_a_time, from, to), unlimited)
    }
  }
}

fn solve(
  instructions: List(#(Int, Int, Int)),
  crate_map: Map(Int, List(String)),
  apply: fn(Map(Int, List(String)), #(Int, Int, Int)) -> Map(Int, List(String)),
) -> String {
  instructions
  |> list.fold(crate_map, apply)
  |> map.to_list
  |> list.fold(
    "",
    fn(acc, pair) {
      let #(_, stack) = pair

      assert Ok(top) = list.at(stack, list.length(stack) - 1)

      acc <> top
    },
  )
}

fn part1(
  instructions: List(#(Int, Int, Int)),
  crate_map: Map(Int, List(String)),
) -> String {
  solve(
    instructions,
    crate_map,
    fn(x, y) { apply_move(x, y, unlimited: False) },
  )
}

fn part2(
  instructions: List(#(Int, Int, Int)),
  crate_map: Map(Int, List(String)),
) -> String {
  solve(instructions, crate_map, fn(x, y) { apply_move(x, y, unlimited: True) })
}

fn parse(input: String) -> #(List(#(Int, Int, Int)), Map(Int, List(String))) {
  let [crates, instructions] =
    input
    |> string.trim_right
    |> string.split(on: "\n\n")

  let [crate_idxs, ..crates] =
    crates
    |> string.split(on: "\n")
    |> list.reverse

  let crates = list.map(crates, string.to_graphemes)

  let crate_map =
    crate_idxs
    |> string.trim
    |> string.split(on: "   ")
    |> list.map(fn(idx) {
      assert Ok(idx) = int.parse(idx)

      let stack =
        list.filter_map(
          crates,
          fn(row) {
            case list.at(row, crate_offset(idx)) {
              Ok(" ") | Error(_) -> Error(Nil)
              Ok(crate) -> Ok(crate)
            }
          },
        )

      #(idx, stack)
    })
    |> map.from_list

  assert Ok(instruction_re) =
    regex.from_string("move (\\d+) from (\\d+) to (\\d+)")

  let instructions =
    instructions
    |> string.split(on: "\n")
    |> list.map(fn(instruction) {
      assert [match] = regex.scan(with: instruction_re, content: instruction)
      assert [Some(Ok(count)), Some(Ok(from)), Some(Ok(to))] =
        match.submatches
        |> list.map(option.map(_, int.parse))

      #(count, from, to)
    })

  #(instructions, crate_map)
}

pub fn solution(_) {
  assert Ok(input) = file.read("data/day5/input.txt")

  let #(instructions, crate_map) = parse(input)
  io.debug(part1(instructions, crate_map))
  io.debug(part2(instructions, crate_map))

  Ok(0)
}
