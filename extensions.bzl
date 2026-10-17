load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def _baremetal_toolchain_impl(mctx):
    http_archive(
        name = "muntjac_toolchain",
        build_file = Label("//build/toolchain/muntjac-baremetal:BUILD.muntjac_toolchain.bazel"),
        patch_args = ["-p1"],
        patches = [Label("//third_party/muntjac_toolchain:0001-Change-the-memory-map.patch")],
        sha256 = "0ce482d45783e0ea9aa986cafd5961de5f490068fd6c7d737b78b4366a3ff579",
        strip_prefix = "lowrisc-toolchain-rv64imac-20230228-1-muntjac",
        urls = [
            "https://storage.googleapis.com/filmil-storage/lowrisc-toolchain-rv64imac-20230228-1-muntjac.tar.gz",
        ],
    )

baremetal_toolchains = module_extension(
    implementation = _baremetal_toolchain_impl,
)
