import std.stdio;
import std.path;

import dime : dime;
import dir : dir;
import zen : zen;

int main(string[] args) {
  writeln(args);
  auto command = args[0].baseName;
  switch (command) {
  case "dime":
    return dime(args);
  case "dir":
    return dir(args);
  case "zen":
    return zen(args);
  default:
    return 1;
  }
}
