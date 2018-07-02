import os
import re
import sys

def look_around(doc, regex, line_number, around = 1):
    def search(reg, ln):
        return(bool(re.search(pattern = reg, string = ln)))
    tr = []
    for k in range(around * 2 + 1):
        try:
            if search(regex, doc[line_number - around + k]):
                tr.append(True)
            else:
                tr.append(False)
        except IndexError: 
            tr.append(False)

    return(tr)


def parse_chunk_line(line, indent_size):
    line = re.sub(r'^' + r' '*indent_size, '', line)
    line = line.replace('\*', '*')
    if len(line.strip()) == 0:
        return None
    return line


def parse_non_chunk_line(line, is_section_heading):
    if line.strip() == '---':
        return None
    elif is_section_heading:
        return '# ' + line
    elif re.match(r'Sample query( run)?:', line):
        return '## Sample query'
    elif re.match(r'(Input|Output.*|Sample.+|):', line):
        return '### ' + line.replace(':', '')
    else:
        return line


def write_md(fl, flnm):
    with(open(flnm, 'w')) as new_fl:
        new_fl.writelines(fl)
    return(True)

def read_md(flpath):
    with(open(flpath, 'r')) as new_fl:
        return(new_fl.readlines())

def sql_chunks(filename):

    the_md = read_md(filename)
    in_chunk = False
    indent_size = 0
    new_md = []

    for i in range(len(the_md)):

        c_lp3, c_lp2, c_lp1, c_l, c_ln1, c_ln2, c_ln3 = look_around(the_md, r'^(\ {4}|\t)', i, 3)
        n_lp2, n_lp1, _, n_ln1, n_ln2 = look_around(the_md, r'\n', i, 2)

        #nextlines_code = (c_ln1 and c_ln2) or (n_ln1 and c_ln2) or (n_ln1 and n_ln2 and c_ln3)
        nextlines_code = c_ln1 or c_ln2 or c_ln3
        prevlines_code = c_lp1 or c_lp2 or c_lp3
        new_codeline = c_l and not prevlines_code
        any_code_nearby = nextlines_code or prevlines_code

        start_chunk = (not in_chunk) and ((c_l and nextlines_code) or new_codeline)
        end_chunk = c_l and in_chunk and not nextlines_code
        one_liner = c_l and not in_chunk and not any_code_nearby

        the_line = the_md[i]
        the_line = the_line.replace('\t', ' '*4)

        is_section_heading = re.match(r'[A-Z]{1,3}\d{2} ?:', the_line)

        if start_chunk or one_liner:
            new_md.append('```sql\n')
            in_chunk = True
            indent_size = len(the_line) - len(the_line.lstrip())

        if in_chunk:
            the_line = parse_chunk_line(the_line, indent_size)
        else:
            the_line = parse_non_chunk_line(the_line, is_section_heading)

        if the_line is not None:
            new_md.append(the_line)

        if end_chunk or one_liner:
            new_md.append('```\n')
            in_chunk = False
        
    return(new_md)

if __name__ == '__main__':
    if len(sys.argv[1:]) != 1:
        raise ValueError('This script accepts one parameter: the path to a folder containing markdown files.')
    md_fldr = sys.argv[1] + '/'
    new_md_fldr = './sql_' + md_fldr

    try:
        os.makedirs(new_md_fldr)
    except:
        print("folder exists")

    filenames = sorted(os.listdir(md_fldr))
    for flnm in filenames:
        write_md(sql_chunks(md_fldr + flnm), new_md_fldr + flnm) 
