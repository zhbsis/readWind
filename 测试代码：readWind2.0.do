
	cd "G:\简书材料\JIANSHU\命令开发\readWind2.0\"

	*-读取ROE.xls中的数据，只有ROE一个变量
	readWind ROE, key(ROE) timeType(q) t0(1995q1) tn(2017q4)
	
	/* 读取ROE_ROA.xlsx中的数据，有ROE和ROE两个变量 */
	readWind ROE ROA, key(ROE_ROA) timeType(q) t0(1995q1) tn(2017q4)
	
	/* 读取ROE_ROA.xls中的数据，有ROE和ROE两个变量 */
	readWind ROE ROA, key(ROE_ROA) timeType(q) t0(1995q1) tn(2017q4) type(xls)
	
	/* 读取ROE_ROA.csv中的数据，有ROE和ROE两个变量 */
	readWind ROE ROA, key(ROE_ROA) timeType(q) t0(1995q1) tn(2017q4) type(csv) encoding(GBK) tostring
