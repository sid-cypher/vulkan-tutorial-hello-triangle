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
        with import nixpkgs { inherit system; };
        # gcc8Stdenv.mkDerivation {
        stdenv.mkDerivation {
          inherit name;
          inherit vulkan-validation-layers;
          src = self;
          buildInputs = [
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
          buildPhase = "make helloTriangleNDebug";
          installPhase = "mkdir -p $out; install -t $out helloTriangle";
        };
    };
  };
}
