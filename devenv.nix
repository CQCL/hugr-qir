{ pkgs, lib, config, inputs, ... }: let
  cfg = config.hugr-qir;
  libllvm = pkgs."llvmPackages_${cfg.llvmVersion}".libllvm;
in {
  # set these options in devenv.local.nix
  options.hugr-qir = {
    llvmVersion = lib.mkOption {
      type = lib.types.str;
      default = "14";
    };
    patch-ruff = lib.mkEnableOption "patch-ruff";
  };
  config = lib.mkMerge [{
    packages = [
      pkgs.pre-commit
      # These are required for hugr-llvm to be able to link to llvm.
      pkgs.libffi
      pkgs.libxml2
      pkgs.libz
      pkgs.ncurses
    ];

    # enterShell = ''
    # '';

    # https://devenv.sh/tasks/
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
  } (lib.mkIf cfg.patch-ruff {
    tasks = {
      # Patch ruff to make it runnable
      "venv:patchelf" = {
        exec = "${lib.getExe pkgs.patchelf} --set-interpreter ${pkgs.stdenv.cc.bintools.dynamicLinker} $VIRTUAL_ENV/bin/ruff";
        after = [ "devenv:python:uv" ]; # Runs after this
        before = [ "devenv:enterShell" ]; # Runs before this
      };
    };
  })];
}
