{ pkgs, lib, config, inputs, ... }: let
  cfg = config.hugr-qir;
  libllvm = pkgs."llvmPackages_${cfg.llvmVersion}".libllvm;
in {
  options.hugr-qir = {
    llvmVersion = lib.mkOption {
      type = lib.types.str;
      default = "14";
    };
  };
  config = {
    packages = [
      # These are required for hugr-llvm to be able to link to llvm.
      pkgs.libffi
      pkgs.libxml2
      pkgs.libz
      pkgs.ncurses
      libllvm
    ];

    # enterShell = ''
    # '';

    # https://devenv.sh/tasks/
    # tasks = {
    #   "myproj:setup".exec = "mytool build";
    #   "devenv:enterShell".after = [ "myproj:setup" ];
    # };

    env = {
      "LLVM_SYS_${cfg.llvmVersion}0_PREFIX" = "${libllvm.dev}";
    };

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
          sync.enable = true;
        };
      };
    };
  };
}
