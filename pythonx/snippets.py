"""
File: snippets.py
Description: Methods for UltiSnips
"""

import ast
import re
import vim
from os import path


def first_letter(string: str) -> str:
    """Returns the first letter of a string"""
    if not len(string):
        return ''
    match = re.search(r'[a-zA-Z]', string)
    return match.group() if match else ''


def camel_case(string: str) -> str:
    """Converts a string to camel case"""
    return re.sub(
        r'([\s_\-]+)([^\s_\-])',
        lambda m: m.group(2).upper(), string
    )


def capitalise(string: str) -> str:
    """Capitalises the first character of a string"""
    if not len(string):
        return ''
    return string[0].upper() + string[1:]


def file_name(file_path: str) -> str:
    """Returns the filename from a given path"""
    return path.basename(file_path).split('.')[0]


def titlify(file_path: str) -> str:
    """Converts file path to title"""
    return file_name(file_path).replace('-', '').title()


class Python:
    @staticmethod
    def all(contents: str) -> list:
        """Returns an __all__ list"""
        exports = []
        for node in ast.parse(contents).body:
            if hasattr(node, 'name'):
                exports.append(node.name)
            elif isinstance(node, ast.Assign):
                exports.extend(t.id for t in node.targets)
        return exports


class Django:
    @staticmethod
    def forloop(string: str) -> str:
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
    modeline: str = 'vim:tw=78:ts=8:ft=help:norl:'

    @staticmethod
    def section(file_path: str, string: str) -> str:
        """Returns a section string"""
        word = string.strip('1234567890. ')
        sec_name = word.lower().replace(' ', '-')
        basename = file_name(file_path)
        formatted = '*{}-{}*'.format(basename, sec_name)
        return formatted.rjust(78 - len(string))


class Java:
    @staticmethod
    def arguments(group: str) -> list:
        """Returns the arguments of a method"""
        word = re.compile(r'[a-zA-Z0-9><.]+ \w+')
        return [w.split(' ') for w in word.findall(group)]

    @staticmethod
    def complete(match: str, num: int = 1) -> str:
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
    def package() -> str:
        """Returns the package of the file"""
        file_path = vim.call('expand', '%:p:h')
        strip = path.join(
            '.*', '(src|lib)',
            '(main', '(java|test))?'
        ) + path.sep
        new_path = re.sub(strip, '', file_path)
        return new_path.replace(path.sep, '.').strip('.')


class RST:
    @staticmethod
    def admonition(match: re.Match) -> str:
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
    def comma(match: str, num: int = 1) -> str:
        """Returns a comma when there's a match"""
        return ',' if match.group(num) else ''

    @staticmethod
    def varname(string: str) -> str:
        """Returns import/require as variable"""
        return camel_case(file_name(string))

    @staticmethod
    def varmod(char: str) -> str:
        """Returns a variable modifier based on a given character"""
        return {'c': 'const', 'l': 'let', 'v': 'var'}.get(char, '')

    @staticmethod
    def console(match: re.Match) -> str:
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
