import 'package:args/command_runner.dart';

abstract class CliCommand extends Command {

  bool hasFlag(String name) {
    return argResults.wasParsed(name);
  }

  bool hasOption(String name) {
    return argResults.wasParsed(name);
  }

  String option(String name) {
    return argResults[name];
  }
}