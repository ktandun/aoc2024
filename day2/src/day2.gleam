import gleam/int
import gleam/io
import gleam/list
import gleam/string
import utils

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
  |> list.map(is_safe_report)
  |> list.count(fn(line) { line == True })
}

fn part_two(input: List(String)) {
  let lines = input_to_lines(input)

  lines
  |> list.map(fn(line) {
    case is_safe_report(line) {
      True -> True
      False -> {
        list.range(0, list.length(line) - 1)
        |> list.any(fn(idx_to_remove) {
          pop_from_list_by_idx(line, idx_to_remove)
          |> is_safe_report
        })
      }
    }
  })
  |> list.count(fn(line) { line == True })
}

fn input_to_lines(input: List(String)) {
  input
  |> list.map(fn(line) {
    string.split(line, " ")
    |> list.map(fn(s) {
      let assert Ok(number) = int.base_parse(s, 10)
      number
    })
  })
}

fn is_safe_report(line: List(Int)) {
  let assert Ok(first_item) = list.first(line)
  let assert Ok(last_item) = list.last(line)

  let zipped = list.window(line, 2)

  let is_descending = first_item > last_item

  zipped
  |> list.all(fn(items) {
    let assert [left, right] = items

    let diff = case is_descending {
      True -> left - right
      False -> right - left
    }

    diff >= 1 && diff <= 3
  })
}

fn pop_from_list_by_idx(items: List(Int), idx: Int) {
  case idx {
    0 -> {
      let assert Ok(items) = list.rest(items)

      items
    }
    idx -> {
      [list.take(items, idx), list.drop(items, idx + 1)]
      |> list.flatten
    }
  }
}
