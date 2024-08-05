load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies", "go_repository")
load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")
load("@rules_foreign_cc//foreign_cc:repositories.bzl", "rules_foreign_cc_dependencies")

def deps_stage_2():
    # These dependencies must have been added before the call to this stage.
    rules_foreign_cc_dependencies()
    go_rules_dependencies()
    go_register_toolchains(version = "1.22.4")
    gazelle_dependencies()
    bazel_skylib_workspace()

    # Declare new repositories.
    maybe(
        go_repository,
        name = "in_gopkg_check_v1",
        importpath = "gopkg.in/check.v1",
        sum = "h1:yhCVgyC4o1eVCa2tZl7eS0r+SDo693bJlVdllGtEeKM=",
        version = "v0.0.0-20161208181325-20d25e280405",
    )

    maybe(
        go_repository,
        name = "in_gopkg_yaml_v3",
        importpath = "gopkg.in/yaml.v3",
        sum = "h1:fxVm/GzAzEWqLHuvctI91KS9hhNmmWOoWu0XTYJS7CA=",
        version = "v3.0.1",
    )

    maybe(
        git_repository,
        name = "rules_foreign_cc",
        commit = "6ecc134b114f6e086537f5f0148d166467042226",
        remote = "https://github.com/bazelbuild/rules_foreign_cc",
        shallow_since = "1686730970 +0000",
    )

    maybe(
        git_repository,
        name = "gotopt2",
        remote = "https://github.com/filmil/gotopt2",
        commit = "d9022a955f016409886e86b55c59df8b26c33a41",
        shallow_since = "1702852114 +0000",
    )

    maybe(
        git_repository,
        name = "rules_hdl",
        commit = "6689294f2d4f45de02a527d947b4703b4c008b53",
        remote = "https://github.com/hdl/bazel_rules_hdl",
        shallow_since = "1676530055 -0800",
    )

    maybe(
        http_archive,
        name = "com_grail_bazel_toolchain",
        sha256 = "ddad1bde0eb9d470ea58500681a7deacdf55c714adf4b89271392c4687acb425",
        strip_prefix = "toolchains_llvm-7e7c7cf1f965f348861085183d79b6a241764390",
        urls = ["https://github.com/grailbio/bazel-toolchain/archive/7e7c7cf1f965f348861085183d79b6a241764390.tar.gz"],
    )

    maybe(
        go_repository,
        name = "in_gopkg_check_v1",
        importpath = "gopkg.in/check.v1",
        sum = "h1:yhCVgyC4o1eVCa2tZl7eS0r+SDo693bJlVdllGtEeKM=",
        version = "v0.0.0-20161208181325-20d25e280405",
    )

    maybe(
        go_repository,
        name = "in_gopkg_yaml_v3",
        importpath = "gopkg.in/yaml.v3",
        sum = "h1:fxVm/GzAzEWqLHuvctI91KS9hhNmmWOoWu0XTYJS7CA=",
        version = "v3.0.1",
    )

    maybe(
        git_repository,
        name = "rules_foreign_cc",
        commit = "6ecc134b114f6e086537f5f0148d166467042226",
        remote = "https://github.com/bazelbuild/rules_foreign_cc",
        shallow_since = "1686730970 +0000",
    )

    maybe(
        git_repository,
        name = "gotopt2",
        remote = "https://github.com/filmil/gotopt2",
        commit = "d9022a955f016409886e86b55c59df8b26c33a41",
        shallow_since = "1702852114 +0000",
    )

    maybe(
        git_repository,
        name = "rules_hdl",
        commit = "6689294f2d4f45de02a527d947b4703b4c008b53",
        remote = "https://github.com/hdl/bazel_rules_hdl",
        shallow_since = "1676530055 -0800",
    )

    maybe(
        http_archive,
        name = "com_grail_bazel_toolchain",
        sha256 = "ddad1bde0eb9d470ea58500681a7deacdf55c714adf4b89271392c4687acb425",
        strip_prefix = "toolchains_llvm-7e7c7cf1f965f348861085183d79b6a241764390",
        urls = [
            "https://github.com/grailbio/bazel-toolchain/archive/7e7c7cf1f965f348861085183d79b6a241764390.tar.gz",
            ],
    )

