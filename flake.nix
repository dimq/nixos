{
  # Description, write anything or even nothing
  description = "b0dian NixOS Flake";

  # Input config, or package repos
  inputs = {
    # Nixpkgs, NixOS's official repo
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    home-manager.url = "github:nix-community/home-manager/release-22.05";
  };

  # Output config, or config for NixOS system
  outputs = { self, nixpkgs, ... }@inputs: {
    # Define a system called "nixos"
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
      ];
    };

    home-manager.users.b0dian = {
      programs.home-manager.enable = true;
      programs.zsh.oh-my-zsh = {
        enable = true;
        plugins = [
          "git" "ssh-agent" "colored-man-pages" "colorize"
          "command-not-found" "compleat" "cp" "encode64" "extract" "rsync"
          "web-search" "emoji-clock" "rand-quote"
        ];
        theme = "robbyrussell";
      };
      programs.alacritty = {
        enable = true;
        settings = {
          font.size = 11;
          scrolling = {
            history = 10000;
            multiplier = 3;
          };
          colors = {
            primary = {
              background = "#282828";
              foreground = "#ebdbb2";
            };
            normal = {
              black   = "#282828";
              red     = "#cc241d";
              green   = "#98971a";
              yellow  = "#d79921";
              blue    = "#458588";
              magenta = "#b16286";
              cyan    = "#689d6a";
              white   = "#a89984";
            };
            bright = {
              black   = "#928374";
              red     = "#fb4934";
              green   = "#b8bb26";
              yellow  = "#fabd2f";
              blue    = "#83a598";
              magenta = "#d3869b";
              cyan    = "#8ec07c";
              white   = "#ebdbb2";
            };
          };
        };
      };
    };

    # You can define many systems in one Flake file.
    # NixOS will choose one based on your hostname.
    #
    # nixosConfigurations."nixos2" = nixpkgs.lib.nixosSystem {
    #   system = "x86_64-linux";
    #   modules = [
    #     ./configuration2.nix
    #   ];
    # };
  };
}

