def c_preprocess_defs(defs={}):
    defs_values = []
    for k, v in defs.items():
        defs_values.append("-D{}={}".format(k, v))
    return defs_values


def c_preprocess(
    name,
    srcs,
    defs = {},
    hdrs = []):
    """ Only works in the current directory, sadly. """
    defs_values = []
    for k, v in defs.items():
        defs_values.append("-D{}={}".format(k, v))
    native.genrule(
        name = name,
        srcs = srcs,
        outs = [name + ".ld"],
    tools = hdrs + [
        "//build/toolchain/muntjac-baremetal:cpp",
        "//build/toolchain/muntjac-baremetal:wrappers",
        "@muntjac_toolchain//:toolchain",
    ],
    cmd = """
        $(execpath //build/toolchain/muntjac-baremetal:cpp) \
          -nostdinc -P -E """ +
          " ".join(defs_values) +
          """ \
          $(SRCS) \
          $@ \
        """,
    )
