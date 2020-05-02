part of command;

abstract class IGroup<T> {
  String get name;
  String get description;
  List<IGroup<T>> get groups;
  List<Cmd<T>> get commands;

  List<Cmd<T>> getAllCommands() {
    var res = commands ?? [];

    if (groups != null) {
      groups.forEach((group) => res.addAll(group.getAllCommands()));
    }

    if (name == null) {
      throw VariableIsNull('${runtimeType}\'s name');
    }
    
    res.forEach((command){
      if (command.name == null) throw VariableIsNull('Cmd(${command.runtimeType})\'s name');
      command.name = '${name ?? ''}:${command.name ?? ''}';
    });

    return res;
  }
}