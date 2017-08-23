#!/usr/bin/env python3

import sys
import os.path

from xdg.BaseDirectory import xdg_cache_home, xdg_config_home

class AliasRC:

    def __init__(self):
        self.cachefile = os.path(xdg_cache_home, 'alias.map')
        self.aliasrc = os.path(xdg_config_home, 'alias.source')

        AliasRC.__filesanity(self.cachefile)
        AliasRC.__filesanity(self.aliasrc)

        self.map = {}

    @staticmethod
    def __filesanity(file):
        if not os.path.exists(file):
            with open(file,'w') as f:
                f.write("\n")
        

    def __readMap(self):
        with open(self.cachefile, 'r') as f:
            for line in f:
                alias, command = line.splitlines().split('\t')
                self.map[alias] = command


    def __writeMap(self):
        with open(self.cachefile, 'w') as f:
            for alias, command in self.map.items():
                f.write("%s\t%s\n" % (alias, command))


    def insertAlias(self, alias, command):
        if alias in self.map:
            print("[Error] ", alias, "already defined. Overwrite? [Y/n]:", file=sys.stderr, end="")

            ans = input().strip()
            if ans[0].lower() == 'y' or len(ans) == 0:
                self.removeAlias(alias)
                self.insertAlias(alias, command)
                return 0

            print("Cancelled.", file=sys.stderr)
            return 1

        self.map[alias] = command
        self.__writeMap()
        print("Inserted.", file=sys.stderr)

    def removeAlias(self, alias, write=False):
        del self.map[alias]
        if write:
            self.__writeMap()
        print("Removed", file=sys.stderr)


    def updateAlias(self):
        with open(self.aliasrc, 'w') as f:
            print("#!/bin/sh", file=f)                                     # probably not neccesary
            for alias, command in self.map.items():
                print("alias %s=\"%s\"" % (alias, command), file=f)


def _help():
    title = sys.argv[0].split(os.path.sep)[-1]
    padd  = "".join([" " for x in title])

    print('''
     %s insert rmf "rm -rf"
 or  %s remove rmf
 or  %s list

An alias management tool that preserves across shells/boots''' % (title, padd, padd),
          file=sys.stderr)
    exit(-1)


if __name__ == "__main__":

    try:
        command = sys.argv[1]         # insert, remove
        alias = sys.argv[2]           # red
        alias_command = sys.argv[3]   # "red -re"

    except IndexError:
        _help()

    al = AliasRC()

    if al == "insert":
        al.insertAlias(alias, alias_command)
    elif al == "remove":
        al.removeAlias(alias)
    else:
        _help()

    

    
