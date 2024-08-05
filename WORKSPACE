workspace(name = "bazel_rules_riscv64_baremetal")

# 1:
load("//:deps1.bzl", "deps_stage_1")
deps_stage_1()

# 2:
load("//:deps2.bzl", "deps_stage_2")
deps_stage_2()

# This must stay in WORKSPACE.
load("@com_grail_bazel_toolchain//toolchain:deps.bzl", "bazel_toolchain_dependencies")
bazel_toolchain_dependencies()

load("//:deps3.bzl", "deps_stage_3")
deps_stage_3()

# This is the "new" toolchain registration approach.
register_toolchains("//build/toolchain/muntjac-baremetal:muntjac_baremetal")

