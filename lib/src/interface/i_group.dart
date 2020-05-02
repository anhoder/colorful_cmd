part of command;

abstract class IGroup<T> {
  String get name;
  List<IGroup<T>> get groups;
  List<ICmd<T>> get commands;

  List<ICmd<T>> getAllCommands() {
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