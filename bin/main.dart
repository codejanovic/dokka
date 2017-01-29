// Copyright (c) 2017, codejanovic. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:args/command_runner.dart';
import 'package:dokka/commands/containers.dart';

main(List<String> arguments) {
  var cli = new CommandRunner("dokka", "convenient wrapper for docker and docker-compose cli");
  cli.addCommand(new ContainersCommand());
  cli.run(arguments).catchError((error) {
    if (error is! UsageException) throw error;
    print(error);
  });

  print(cli.usage);
}
