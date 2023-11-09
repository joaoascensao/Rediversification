import numpy as np 
import scipy as sp
import pandas as pd
import statsmodels.api as sm


df=pd.read_csv('overnight_timecourses.csv')


def get_growths(dff,name):
	res=sm.OLS(np.log(np.array(dff[name])),sm.add_constant(np.array(dff['Time']))).fit()
	return res.params[1],res.bse[1]

diff=list(zip(range(8),range(1,9)))
gens=[]
minmaj=[]
competition=[]
s_growth=[]
l_growth=[]
s_growth_se=[]
l_growth_se=[]
ts=[]
for i,group in df.groupby(by=['gen','S minmaj','competition']):
	for t0,t1 in diff:
		group1 = group[(group['timepoint']==t0) | (group['timepoint']==t1)]
		try:
			r,std=get_growths(group1,'S counts')
		except:
			continue
		s_growth.append(r)
		s_growth_se.append(std)

		r,std=get_growths(group1,'LSl counts')
		l_growth.append(r)
		l_growth_se.append(std)

		ts.append(np.float(group[group['timepoint']==t1]['Time'].mean()))
		gens.append(i[0])
		minmaj.append(i[1])
		competition.append(i[2])

pd.DataFrame({
	'S minmaj':minmaj,
	'gen':gens,
	'competition':competition,
	'Time':ts,
	'S growth':s_growth,
	'S growth std':s_growth_se,
	'L growth':l_growth,
	'L growth std':l_growth_se,
	}).to_csv('growthrates.csv')
		
