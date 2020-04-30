part of command;

abstract class IGroup {
  String name;
  String description;
  List<IGroup> sonGroups;
  List<Command> commands;
}