def include_from_binary(name, src):
    """Produces a sequence of byte definitions for including into an
    assembly source.

    Args:
      name: the name of this bazel target.
      src: a source to be disasembled, usually a single file, or a filegroup
           with a single file in it.
    """
    _out = "{name}.h".format(name=name)
    native.genrule(
        name = name,
        outs = [ _out ],
        srcs = [ src ],
        cmd_bash = """
        $(location //build/bin/bintoinc) < $(location {inf}) > $(location {out})
        """.format(inf=src, out=_out),
        tags = [ "manual", "no-sandbox" ],
        tools = [
            "//build/bin/bintoinc",
        ]
    )

def disasm(name, src):
    """Produces an objdump disassembly of an ELF file.

    Args:
      name: the name of this bazel target.
      src: a source to be disasembled, usually a single file, or a filegroup
           with a single file in it.
    """
    _out = "{}.S".format(name)
    _objdump = Label("//build/toolchain/muntjac-baremetal:wrappers/objdump")
    native.genrule(
        name = name,
        outs = [ "{}.S".format(name) ],
        tools = [ _objdump ],
        srcs = [
            # The target containing the disasm tool
            Label("//build/toolchain/muntjac-baremetal:all_files"),
        ] + [ src ] ,
        cmd_bash = """
        $(location {}) \
          -D $(location {}) \
          > $(location {})
        """.format(_objdump, src, _out),
    )


def extract_binary_content(name, src):
    """Extracts obj content as a binary."""
    _intermediate = "{name}.bin".format(name=name)
    _name = "{name}_bin".format(name=name)
    native.genrule(
        name = _name,
        outs = [ _intermediate ],
        srcs = [ src ],
        cmd_bash = """
        $(OBJCOPY) -S -O binary $(location {inf}) $(@)
        """.format(inf=src),
        tags = [ "manual", "no-sandbox" ],
        toolchains = [ Label("//build/toolchain/muntjac-baremetal:muntjac_baremetal_toolchain"),],
    )
    include_from_binary(
        name = name,
        src = _intermediate
    )

