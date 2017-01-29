// Copyright (c) 2017, codejanovic. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:dokka/commands/containers.dart';
import 'dart:convert';

main(List<String> arguments) {
  var cli = new CommandRunner("dokka", "convenient wrapper for docker and docker-compose cli");
  cli.addCommand(new ContainersCommand());
  cli.run(arguments).catchError((error) {
    if (arguments.first == 'compose')
      forwardToDockerCompose(arguments);
    else
      forwardToDocker(arguments);
  });
}

void forwardToDocker(List<String> arguments) {
  Process.start('bash', ['-c', arguments
      .fold('docker', (previous, next) => previous + ' ' + next)])
      .then((process) {
    process.stdout
        .transform(UTF8.decoder)
        .listen((data) { print(data); });
    process.stderr
      .transform(UTF8.decoder)
      .listen((data) { print(data); });
  });
}

void forwardToDockerCompose(List<String> arguments) {
  Process.start('bash', ['-c', arguments
      .fold('docker-compose', (previous, next) => previous + ' ' + next)])
      .then((process) {
    process.stdout
        .transform(UTF8.decoder)
        .listen((data) { print(data); });
    process.stderr
        .transform(UTF8.decoder)
        .listen((data) { print(data); });
  });
}
