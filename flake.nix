{
  description = "Vulkan Tutorial HelloTriangle test program";
  inputs = {
    nixpkgs.url = "flake:current";
  };
  outputs = { self, nixpkgs }: let
      system = "x86_64-linux";
      name = "vulkan-tutorial-hello-triangle";
    in
  {
    packages."${system}" = {
      default = self.packages."${system}"."${name}";
      "${name}" =
        let pkgs = import nixpkgs { inherit system; }; in
        # gcc8Stdenv.mkDerivation {
        pkgs.stdenv.mkDerivation {
          inherit name;
          src = self;
          buildInputs = with pkgs; [
            glfw3
            glm
            glslang
            pkg-config
            spirv-tools
            vulkan-headers
            vulkan-loader
            vulkan-tools
            vulkan-validation-layers
            xorg.libX11
            xorg.libXi
            xorg.libXrandr
            xorg.libXxf86vm
          ];
          shellHook = ''
            export PS1="\n(hello) \033[1;32m[\w]\$\033[0m "
            export VK_LAYER_PATH="${pkgs.vulkan-validation-layers}/share/vulkan/explicit_layer.d";
          '';
        };
    };
  };
}
