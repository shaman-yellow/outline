from docx import Document
from docx.oxml import parse_xml

def copy_headers_footers_xml(source_path, target_path):
    # Load the source and target documents
    source_doc = Document(source_path)
    target_doc = Document()

    # Helper function to clear all elements in a part
    def clear_part(part):
        part_element = part._element
        for child in list(part_element):
            part_element.remove(child)

    # Helper function to copy XML elements
    def copy_elements(source_part, target_part):
        clear_part(target_part)
        for element in source_part._element:
            new_element = parse_xml(element.xml)
            target_part._element.append(new_element)

    # Ensure target document has at least as many sections
    while len(target_doc.sections) < len(source_doc.sections):
        target_doc.add_section()

    # Loop through sections of the source document
    for i, source_section in enumerate(source_doc.sections):
        target_section = target_doc.sections[i]

        # Copy header and footer to this section
        copy_elements(source_section.header, target_section.header)
        copy_elements(source_section.footer, target_section.footer)

    # Save the new document with copied headers and footers
    target_doc.save(target_path)

# Example usage
source_doc_path = './blank.docx'
target_doc_path = './content.docx'
copy_headers_footers_xml(source_doc_path, target_doc_path)
