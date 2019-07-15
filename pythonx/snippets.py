"""
File: snippets.py
Description: Methods for UltiSnips
"""

import re
import vim
from os import path


def first_letter(string):
    """Returns the first letter of a string"""
    if not len(string): return ''  # noqa: E701
    match = re.search(r'\w', string)
    return match.group() if match else ''


def camel_case(string):
    """Converts a string to camel case"""
    return re.sub(r'([\s_\-]+)([^\s_\-])',
                  lambda m: m.group(2).upper(), string)


def capitalise(string):
    """Capitalises the first letter of a string"""
    if not len(string): return ''  # noqa: E701
    return string[0].upper() + string[1:]


def file_name(file_path):
    """Returns the filename from a given path"""
    return path.basename(file_path).split('.')[0]


def titlify(file_path):
    """Converts file path to title"""
    return file_name(file_path).replace('-', '').title()


class Python:
    @staticmethod
    def all(contents):
        """Returns an __all__ list"""
        pattern = r'|'.join([
            r'^{0}\s*=.*',
            r'^class\s*{0}.*',
            r'^def\s*{0}.*'
        ]).format(r'([^_][\w\d_-]+)')
        exports = filter(lambda m: re.match(pattern, m), contents)
        return [re.sub(pattern, r'\1\2\3', e) for e in exports]


class Django:
    @staticmethod
    def forloop(string):
        """Completes forloop variable based on given string"""
        return {
            'f': 'first',
            'l': 'last',
            'c': 'counter',
            'c0': 'counter0',
            'r': 'revcounter',
            'r0': 'revcounter0',
            'p': 'parentloop'
        }.get(string, '')


class Help:
    @staticmethod
    def section(file_path, string):
        """Returns a section string"""
        word = string.strip('1234567890. ')
        sec_name = word.lower().replace(' ', '-')
        basename = file_name(file_path)
        formatted = '*{}-{}*'.format(basename, sec_name)
        return formatted.rjust(78 - len(string))

    @staticmethod
    def modeline(): return 'vim:tw=78:ts=8:ft=help:norl:'


class Java:
    @staticmethod
    def arguments(group):
        """Returns the arguments of a method"""
        word = re.compile(r'[a-zA-Z0-9><.]+ \w+')
        return [w.split(' ') for w in word.findall(group)]

    @staticmethod
    def complete(match, num=1):
        """Completes word based on a given character"""
        return {
            'i': 'int',
            'I': 'Integer',
            'd': 'double',
            'D': 'Double',
            'b': 'boolean',
            'B': 'Boolean',
            't': 'true',
            'f': 'false'
        }.get(match.group(num), '')

    @staticmethod
    def package():
        """Returns the package of the file"""
        file_path = vim.call('expand', '%:p:h')
        strip = path.join(
            '.*', '(src|lib)', '(main',
            '(java|test))?') + path.sep
        new_path = re.sub(strip, '', file_path)
        return new_path.replace(path.sep, '.').strip('.')


class RST:
    @staticmethod
    def admonition(match):
        """Returns an admonition based on a match"""
        return {
            'a': 'attention',
            'c': 'caution',
            'd': 'danger',
            'e': 'error',
            'h': 'hint',
            'i': 'important',
            'n': 'note',
            't': 'tip',
            'w': 'warning'
        }.get(match.group(1), 'admonition')


class JS:
    @staticmethod
    def comma(match, num=1):
        """Returns a comma when there's a match"""
        return ',' if match.group(num) else ''

    @staticmethod
    def varname(string):
        """Returns import/require as variable"""
        return camel_case(file_name(string))

    @staticmethod
    def varmod(char):
        """Returns a variable modifier based on a given character"""
        return {'c': 'const', 'l': 'let', 'v': 'var'}.get(char, '')

    @staticmethod
    def console(match):
        """Returns a console method based on a match"""
        return {
            'l': 'log',
            'd': 'dir',
            'i': 'info',
            'w': 'warn',
            'e': 'error',
            't': 'table',
            'x': 'dirxml',
            'a': 'assert',
            'g': 'debug',
            's': 'trace',
        }.get(match.group(1), '')
