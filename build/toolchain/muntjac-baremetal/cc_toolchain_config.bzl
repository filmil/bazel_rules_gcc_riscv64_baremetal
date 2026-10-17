load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "feature",
    "flag_group",
    "flag_set",
    "tool_path",
)
load("@rules_cc//cc:defs.bzl", "CcToolchainConfigInfo", "cc_common")

all_link_actions = [
    ACTION_NAMES.cpp_link_executable,
    ACTION_NAMES.cpp_link_dynamic_library,
    ACTION_NAMES.cpp_link_nodeps_dynamic_library,
]

all_compile_actions = [
    ACTION_NAMES.assemble,
    ACTION_NAMES.c_compile,
    ACTION_NAMES.clif_match,
    ACTION_NAMES.cpp_compile,
    ACTION_NAMES.cpp_header_parsing,
    ACTION_NAMES.cpp_module_codegen,
    ACTION_NAMES.cpp_module_compile,
    ACTION_NAMES.linkstamp_compile,
    ACTION_NAMES.lto_backend,
    ACTION_NAMES.preprocess_assemble,
]

def _impl(ctx):
    specs_file = ctx.file._specs_file
    specs_path = specs_file.path
    sysroot_path = specs_path.replace("/lib/baremetal.specs", "")

    tool_paths = [
        tool_path(
            name = "ar",
            path = "wrappers/ar",
        ),
        tool_path(
            name = "cpp",
            path = "wrappers/cpp",
        ),
        tool_path(
            name = "gcc",
            path = "wrappers/gcc",
        ),
        tool_path(
            name = "gcov",
            path = "wrappers/gcov",
        ),
        tool_path(
            name = "ld",
            path = "wrappers/ld",
        ),
        tool_path(
            name = "nm",
            path = "wrappers/nm",
        ),
        tool_path(
            name = "objdump",
            path = "wrappers/objdump",
        ),
        tool_path(
            name = "objcopy",
            path = "wrappers/objcopy",
        ),
        tool_path(
            name = "strip",
            path = "wrappers/strip",
        ),
    ]

    default_compiler_flags = feature(
        name = "default_compiler_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = all_compile_actions,
                flag_groups = [
                    flag_group(
                        flags = [
                            "-specs", specs_path,
                            "--sysroot=" + sysroot_path,
                            "-no-canonical-prefixes",
                            "-fno-canonical-system-headers",
                            "-Wno-builtin-macro-redefined",
                            "-D__DATE__=\"redacted\"",
                            "-D__TIMESTAMP__=\"redacted\"",
                            "-D__TIME__=\"redacted\"",
                        ],
                    ),
                ],
            ),
        ],
    )

    default_linker_flags = feature(
        name = "default_linker_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = all_link_actions,
                flag_groups = ([
                    flag_group(
                        flags = [
                            "-specs", specs_path,
                            "--sysroot=" + sysroot_path,
                        ],
                    ),
                ]),
            ),
        ],
    )

    features = [
        default_compiler_flags,
        default_linker_flags,
    ]

    return [cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        features = features,
        toolchain_identifier = "muntjac-toolchain",
        host_system_name = "local",
        target_system_name = "none",
        target_cpu = "riscv64",
        target_libc = "unknown",
        compiler = "unknown",
        abi_version = "unknown",
        abi_libc_version = "unknown",
        tool_paths = tool_paths,
    ), 
        platform_common.TemplateVariableInfo({
            "OBJCOPY": "YADDA",
            "OBJDUMP": "YADDA",
        }),
    ]

cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {
        "_specs_file": attr.label(
            default = "@muntjac_toolchain//:riscv64-unknown-elf/lib/baremetal.specs",
            allow_single_file = True,
        ),
    },
    provides = [CcToolchainConfigInfo, platform_common.TemplateVariableInfo],
)
