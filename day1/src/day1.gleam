import gleam/dict
import gleam/int
import gleam/io
import gleam/list
import gleam/string
import utils

pub type Line {
  Line(left: Int, right: Int)
}

pub fn main() {
  let day_input = utils.read_input()

  part_one(day_input)
  |> io.debug

  part_two(day_input)
  |> io.debug
}

fn part_one(input: List(String)) {
  let lines = input_to_lines(input)

  lines
  |> list.map(fn(line) {
    let #(left, right) = line

    int.absolute_value(left - right)
  })
  |> int.sum
}

fn part_two(input: List(String)) {
  let lines = input_to_lines(input)

  let right_frequencies =
    lines
    |> list.map(fn(line) {
      let #(_, right) = line
      right
    })
    |> list.group(by: fn(number) { number })
    |> dict.map_values(fn(_, value) { list.length(value) })

  lines
  |> list.map(fn(line) {
    let #(left, _) = line
    case dict.get(right_frequencies, left) {
      Ok(value) -> left * value
      _ -> 0
    }
  })
  |> int.sum
}

fn input_to_lines(input: List(String)) {
  let lines =
    input
    |> list.map(split_left_right)

  let lefts =
    lines
    |> list.map(fn(line) { line.left })
    |> list.sort(by: int.compare)

  let rights =
    lines
    |> list.map(fn(line) { line.right })
    |> list.sort(by: int.compare)

  let assert Ok(zipped) = list.strict_zip(lefts, rights)

  zipped
}

fn split_left_right(line: String) {
  let assert [left, right] = line |> string.split("   ")

  let assert Ok(left) = int.base_parse(left, 10)
  let assert Ok(right) = int.base_parse(right, 10)

  Line(left:, right:)
}
