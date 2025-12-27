{
  perSystem =
    {
      self',
      pkgs,
      ...
    }:
    {
      devShells.default = pkgs.mkShell rec {
        name = "dev-shell";
        packages = [
          pkgs.pkg-config
          pkgs.clang
          pkgs.libclang
          pkgs.libvncserver
          pkgs.libvncserver.dev

          # Needed for native-display feature
          pkgs.wayland
          pkgs.libGL
          pkgs.libxkbcommon

          self'.packages.rust
        ];
        LIBCLANG_PATH = "${pkgs.libclang.lib}/lib";
        LIBVNCSERVER_HEADER_FILE = "${pkgs.libvncserver.dev}/include/rfb/rfb.h";

        # Needed for native-display feature
        WINIT_UNIX_BACKEND = "wayland";
        LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath packages}";
        XDG_DATA_DIRS = builtins.getEnv "XDG_DATA_DIRS";
      };
    };
}
