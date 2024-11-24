#!/usr/bin/env python3

import os, sys

script_dir = os.path.dirname(__file__)

def main(argv: list):
    target_path = ""
    if len(argv) < 2:
        print("Usage: symlinker.py <package> [<target>]")
        exit(1)
    elif len(argv) < 3:
        target_path = os.path.expanduser("~")
    else:
        target_path = os.path.realpath(argv[2])
    package_path = os.path.realpath(argv[1])
    
    for path, directories, files in os.walk(package_path):
        package_folder = path[len(package_path) + 1:]
        package_folder_parts = package_folder.split(os.path.sep)
        def replace_dot(name: str):
            if name.startswith("dot-"):
                return "." + name[len("dot-"):]
            else:
                return name

        link_target_folder = os.path.join(target_path, *map(replace_dot, package_folder_parts))
        if not os.path.exists(link_target_folder):
            os.makedirs(link_target_folder)
        
        for file in files:
            link_source_file = os.path.join(package_path, package_folder, file)
            file = replace_dot(file)
            link_target_file = os.path.join(target_path, link_target_folder, file)
            
            if os.path.exists(link_target_file) and not os.path.islink(link_target_file):
                overwrite = input(f"File or directory '{link_target_file}' already exists. Should I create a backup and overwrite it or (a)dopt it? [Y/n/a] ")
                if overwrite.lower() == "y":
                    os.rename(link_target_file, link_target_file + ".bak")
                elif overwrite.lower() == "a":
                    os.rename(link_target_file, link_source_file)
                else:
                    os.remove(link_target_file)
            elif os.path.exists(link_target_file) or os.path.islink(link_target_file):
                os.remove(link_target_file)
            
            print("add", link_target_file, "=>", link_source_file)
            os.symlink(link_source_file, link_target_file)


if __name__ == "__main__":
    main(sys.argv)
