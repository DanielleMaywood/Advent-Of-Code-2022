import gleam/erlang/file
import gleam/string
import gleam/list
import gleam/int
import gleam/io

pub fn part1(assignments: List(#(#(Int, Int), #(Int, Int)))) {
  assignments
  |> list.filter(fn(bounds) {
    let #(#(lhs_lower, lhs_upper), #(rhs_lower, rhs_upper)) = bounds

    let overlap = lhs_lower >= rhs_lower && lhs_upper <= rhs_upper
    let overlap = overlap || rhs_lower >= lhs_lower && rhs_upper <= lhs_upper
    overlap
  })
  |> list.length
}

pub fn part2(assignments: List(#(#(Int, Int), #(Int, Int)))) {
  assignments
  |> list.filter(fn(bounds) {
    let #(#(lhs_lower, lhs_upper), #(rhs_lower, rhs_upper)) = bounds

    let min = int.min(lhs_upper, rhs_lower)
    let max = int.max(lhs_lower, rhs_upper)

    min == rhs_lower && max == rhs_upper
  })
  |> list.length
}

pub fn solution(_) {
  assert Ok(input) = file.read("data/day4/input.txt")

  let assignments =
    input
    |> string.trim
    |> string.split(on: "\n")
    |> list.map(fn(pair) {
      assert [[Ok(lhs_lower), Ok(lhs_upper)], [Ok(rhs_lower), Ok(rhs_upper)]] =
        pair
        |> string.split(on: ",")
        |> list.map(fn(bounds) {
          bounds
          |> string.split(on: "-")
          |> list.map(int.parse)
        })

      #(#(lhs_lower, lhs_upper), #(rhs_lower, rhs_upper))
    })

  io.debug(part1(assignments))
  io.debug(part2(assignments))

  Ok(0)
}
