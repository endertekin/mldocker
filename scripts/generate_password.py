#!/usr/bin/env python3
import argparse
from notebook.auth import passwd

parser = argparse.ArgumentParser(description="Generate sha-1 hashed password to secure Jupyter notebook")
parser.add_argument('password', type=str, help='plaintext password' )
parser.add_argument('-o', '--out_file', type=str, help='output file', default='pwd.txt')
args = parser.parse_args()
print(args)
hashed_pwd = passwd(args.password)
print(hashed_pwd)
with open(args.out_file, "w") as f:
    f.write(hashed_pwd)
print("Password written to {}.".format(args.out_file))