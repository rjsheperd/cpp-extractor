#!/usr/bin/env python
import sys
from pygccxml import utils
from pygccxml import declarations
from pygccxml import parser

# Find the location of the xml generator (castxml or gccxml)
generator_path, generator_name = utils.find_xml_generator()

# Configure the xml generator
xml_generator_config = parser.xml_generator_configuration_t(
    xml_generator_path=generator_path,
    xml_generator=generator_name)

the_ns = {}
the_class = {}
the_fn = {}

def print_enum(enum):
    print(enum.name)
    if "values" in dir(enum):
        for v in enum.values:
            print(v)

def print_fn(f):
    global the_fn

    if isinstance(f, declarations.member_function_t):
        print(f.name, [[a.name, a.decl_type] for a in f.arguments])

    elif isinstance(f, declarations.member_function_t):
        print(f.return_type, f.name, [[a.name, a.decl_type] for a in f.arguments])

def print_class(c):
    print(c.name)
    [print_fn(f) for f in c.declarations]

def print_ns(c):
    print(c.name)

def printer(decl):
    global the_class, the_ns
    if isinstance(decl, declarations.namespace_t):
        print_ns(decl)
        the_ns = decl
        try:
            [printer(c) for c in decl.classes()]
        except Exception:
            pass
            
        try:
            [printer(e) for e in decl.enumerations()]
        except Exception:
            pass

    elif isinstance(decl, declarations.enumeration_t):
        print_enum(decl)

    elif isinstance(decl, declarations.class_t):
        print_class(decl)

        try:
            [printer(c) for c in decl.classes()]
        except Exception:
            pass
            
        try:
            [printer(e) for e in decl.enumerations()]
        except Exception:
            pass

def main(args):
    filename = args[0]
    decls = parser.parse([filename], xml_generator_config)

    # Get access to the global namespace
    global_namespace = declarations.get_global_namespace(decls)

    for decl in global_namespace.declarations:
        printer(decl)

if __name__ == '__main__':
    main(sys.argv[1:])
