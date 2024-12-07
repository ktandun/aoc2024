import gleam/list
import gleam/string
import simplifile

pub fn read_input() {
  let assert Ok(content) = simplifile.read(from: "./input.txt")

  content
  |> string.split("\n")
  |> list.filter(fn(s) { string.length(s) > 0 })
}
