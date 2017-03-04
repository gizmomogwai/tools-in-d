import std.path;
import std.stdio;
import std.algorithm.iteration;
import std.algorithm.searching;
import std.range;
import std.format;
import std.array;

unittest {
  import unit_threaded;
  true.shouldEqual(true);
}

abstract class Executable {
  public string[] names;
  public this(string names) {
    this.names = names.split(",");
  }
  abstract int run(string[] args);
}

Executable[] addExe(string names)(Executable[] executables=[]) {
  mixin(
`
class %2$sExecutable : Executable {
  public this() {
    super("%1$s");
  }
  override int run(string[] args) {
    import %2$s : %2$s;
    return %2$s(args);
  }
}
return executables ~ new %2$sExecutable();
`.format(names, names.split(",")[0]));
}

int toolsInD(string[] args) {
  auto executables =
    addExe!("dime,time").
    addExe!("dir,ls").
    addExe!("zen")
    ;

  auto commandName = args[0].baseName;
  foreach (exe; executables) {
    if (exe.names.canFind(commandName)) {
      return exe.run(args);
    }
  }
  return 1;
}
