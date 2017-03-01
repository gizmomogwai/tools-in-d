import std.path;
import std.stdio;
import std.algorithm.iteration;
import std.range;
import std.format;

unittest {
  import unit_threaded;
  true.shouldEqual(true);
}

abstract class Executable {
  public string name;
  public this(string name) {
    this.name = name;
  }
  abstract int run(string[] args);
}

Executable[] addExe(string name)(Executable[] executables=[]) {
  mixin(
`
class %1$sExecutable : Executable {
  public this() {
    super("%1$s");
  }
  override int run(string[] args) {
    import %1$s : %1$s;
    return %1$s(args);
  }
}
return executables ~ new %1$sExecutable();
`.format(name));
}

int toolsInD(string[] args) {
  auto executables =
    addExe!("dime").
    addExe!("dir").
    addExe!("zen")
    ;

  auto command = args[0].baseName;
  foreach (exe; executables) {
    if (exe.name == command) {
      return exe.run(args);
    }
  }
  return 1;
}
