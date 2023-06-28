#!/usr/bin/env python
import sys
from pygccxml import utils
from pygccxml import declarations
from pygccxml import parser

# Find out the c++ parser
generator_path, generator_name = utils.find_xml_generator()

# Configure the xml generator
xml_generator_config = parser.xml_generator_configuration_t(
    xml_generator_path=generator_path,
    xml_generator=generator_name)

def main(args):
    # The c++ file we want to parse
    filename = args[0]

    file_config = parser.file_configuration_t(
        data=filename,
        content_type=parser.CONTENT_TYPE.CACHED_SOURCE_FILE)

    project_reader = parser.project_reader_t(xml_generator_config)
    decls = project_reader.read_files(
        [file_config],
        compilation_mode=parser.COMPILATION_MODE.FILE_BY_FILE)

if __name__ == '__main__':
    main(sys.argv[1:])
