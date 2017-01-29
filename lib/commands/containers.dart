import 'dart:convert';
import 'dart:io';
import 'package:dokka/commands/cli_command.dart';

class ContainersCommand extends CliCommand {

  ContainersCommand() {
    addSubcommand(new ContainersListCommand());
    addSubcommand(new ContainersStartCommand());
    addSubcommand(new ContainersStopCommand());
  }

  @override
  String get description => 'access docker container infrastrucutre';

  @override
  String get name => 'containers';
}

class ContainersListCommand extends CliCommand {

  ContainersListCommand() {
    argParser.addFlag('running', abbr: 'r');
    argParser.addFlag('all', abbr: 'a');
  }

  @override
  String get description => 'lists containers';

  @override
  String get name => 'list';

  void run() {
    if (hasFlag("running"))
      Process.start('docker', ['ps', '-s']).then((Process process) {
        process.stdout
            .transform(UTF8.decoder)
            .listen((data) { print(data); });
      });
    else if (hasFlag('all'))
      Process.start('docker', ['ps', '-as']).then((Process process) {
        process.stdout
            .transform(UTF8.decoder)
            .listen((data) { print(data); });
      });
  }
}

class ContainersStopCommand extends CliCommand {

  @override
  String get description => 'stops containers';

  @override
  String get name => 'stop';

  ContainersStopCommand() {
    argParser.addOption('name', abbr: 'n');
    argParser.addFlag('all', abbr: 'a');
  }

  void run() {
    if (hasOption('name'))
      Process.start('docker', ['stop', option('name')]).then((Process process) {
        process.stdout
            .transform(UTF8.decoder)
            .listen((data) { print(data); });
      });
    else if (hasFlag('all'))
      Process.start('bash', ['-c', r'docker stop $(docker ps -a -q)']).then((Process process) {
        process.stdout
            .transform(UTF8.decoder)
            .listen((data) { print(data); });
      });
  }
}

class ContainersStartCommand extends CliCommand {

  @override
  String get description => 'starts containers';

  @override
  String get name => 'start';

  ContainersStartCommand() {
    argParser.addOption('name', abbr: 'n');
    argParser.addFlag('all', abbr: 'a');
  }

  void run() {
    if (hasOption('name'))
      Process.start('docker', ['start', option('name')]).then((Process process) {
        process.stdout
            .transform(UTF8.decoder)
            .listen((data) { print(data); });
      });
    else if (hasFlag('all'))
      Process.start('bash', ['-c', r'docker start $(docker ps -a -q)']).then((Process process) {
        process.stdout
            .transform(UTF8.decoder)
            .listen((data) { print(data); });
      });
  }
}

