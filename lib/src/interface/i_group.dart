part of command;

abstract class IGroup {
  String get name;
  String get description;
  List<IGroup> get sonGroups;
  List<Command> get commands;
}