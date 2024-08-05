load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@com_grail_bazel_toolchain//toolchain:rules.bzl", "llvm_toolchain")
load("@gotopt2//build:deps.bzl", "gotopt2_dependencies")

def deps_stage_3():
    gotopt2_dependencies()

    maybe(
        llvm_toolchain,
        name = "llvm_toolchain",
        llvm_version = "10.0.1",
        sha256 = {
            "linux": "02a73cfa031dfe073ba8d6c608baf795aa2ddc78eed1b3e08f3739b803545046",
        },
        strip_prefix = {
            "linux": "clang+llvm-10.0.1-x86_64-pc-linux-gnu",
        },
        urls = {
            "linux": [
                # Use a custom built Clang+LLVM binary distribution that is more portable than
                # the official builds because it's built against an older glibc and does not have
                # dynamic library dependencies to tinfo, gcc_s or stdlibc++.
                #
                # For more details, see the files under toolchains/clang.
                "https://github.com/retone/deps/releases/download/na5/clang+llvm-10.0.1-x86_64-pc-linux-gnu.tar.xz",
            ],
        },
        # Disabled for now waiting on https://github.com/pybind/pybind11_bazel/pull/29
        # sysroot = {
        #     "linux": "@org_chromium_sysroot_linux_x64//:sysroot",
        # },
    )

    maybe(
        http_archive,
        name = "muntjac_toolchain",
        build_file = Label("//build/toolchain/muntjac-baremetal:BUILD.muntjac_toolchain.bazel"),
        patch_args = ["-p1"],
        patches = [ Label("//third_party/muntjac_toolchain:0001-Change-the-memory-map.patch") ],
        sha256 = "0ce482d45783e0ea9aa986cafd5961de5f490068fd6c7d737b78b4366a3ff579",
        strip_prefix = "lowrisc-toolchain-rv64imac-20230228-1-muntjac",
        urls = [
            "https://storage.googleapis.com/filmil-storage/lowrisc-toolchain-rv64imac-20230228-1-muntjac.tar.gz",
        ],
    )


