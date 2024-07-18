{
  self,
  pkgs,
  ...
}: {
  packages = [ pkgs.git pkgs.hello pkgs.coreutils ];
  processes.run.exec = ''
    hello
    sleep 10
    echo tchau
  '';
  enterShell = ''
    hello
  '';
  languages.python.enable = true;
  languages.python.version = "3.11";
  cachix.pull = [ "pre-commit-hooks" ];
  cachix.push = "tarc";
}
