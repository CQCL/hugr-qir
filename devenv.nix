{ pkgs, lib, config, inputs, ... }:

{
  packages = [ ];
  # enterShell = ''
  # '';

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  languages = {
    rust = {
      enable = true;
      channel = "stable";
    };

    python = {
      enable = true;
      venv.enable = true;
      uv = {
        enable = true;
      };
    };
  };
}
