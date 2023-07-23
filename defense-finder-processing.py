#!/usr/bin/env python
# coding: utf-8
import pandas as pd

#get header name into list 
hd = pd.read_csv('python-header.tsv', sep=".", low_memory=False)
s=list(hd)
#process defense finder output
file_name = "defense_finder_systems.tsv"
df = pd.read_csv(file_name, sep="\t", low_memory=False)
df2 = df[["subtype",'protein_in_syst']]
i = df2.columns.get_loc('protein_in_syst')
df3 =df2.protein_in_syst.str.split(",", expand = True)     
df4=pd.concat([df2.iloc[:, :i], df3, df2.iloc[:, i+1:]], axis=1)
df4.to_csv('defense_finder-proc.tsv', '\t', header=True)
df4.to_csv(s[0]+"_"+'defense_finder.csv', '\t', header=True)
