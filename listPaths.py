from lxml import etree
from collections import defaultdict
import argparse
import re

def get_unique_xpaths_with_count(root, xpath_count=None, current_path=None):
    if xpath_count is None:
        xpath_count = defaultdict(int)
    if current_path is None:
        current_path = "/"

    current_path += root.tag
    xpath_count[current_path] += 1

    for child in root:
        get_unique_xpaths_with_count(child, xpath_count, current_path + "/")

    return xpath_count

def main():
    parser = argparse.ArgumentParser(description="List unique XPaths and their counts in an XML document.")
    parser.add_argument("xml_file", help="Path to the XML file")
    args = parser.parse_args()

    xml_file = args.xml_file
    tree = etree.parse(xml_file)
    root = tree.getroot()

    xpath_count = get_unique_xpaths_with_count(root)

    # Print the XPaths with frequency count
    for xpath, count in xpath_count.items():
        xpath2 = re.sub(r'\{[^\}]*\}', '', xpath)
        print(f"{xpath2}\t{count}")


if __name__ == "__main__":
    main()
