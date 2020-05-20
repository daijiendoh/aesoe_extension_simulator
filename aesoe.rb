require 'csv'

ojoin=Hash.new
CSV.foreach("connections.csv") do |row|
	orioligos=row[0,2].map{|x| x.to_i}.sort
	dstdnas=row[2,2].map{|x| x.to_i}.sort
	ojoin[orioligos]=dstdnas
end
# p ojoin

narr=0
no_connset=0
connset=[]
resoligo=[]
unmatchpair=[]
soligos=[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4,4,6,6,6,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8]
orioligos=soligos.flatten
no_final_products=Hash.new
(1..14).to_a.each{|i|
	p "cycle #{i}"
	# p "orioligos #{orioligos}"
	# p "orioligos before wile #{orioligos}"
	connset=Array.new
	oddoligo=orioligos.select{|x| x.odd?}.shuffle
	# p oddoligo
	nodd=oddoligo.length
	evenoligo=orioligos.select{|x| x.even?}.shuffle
	# p evenoligo
	neven=evenoligo.length
	noarr=[nodd,neven].min
	
	preconnset_no=0
	no_connset=1
	# p "connset #{no_connset}  noarr #{noarr}"
	while preconnset_no < no_connset do
		# p "preconnset_no #{preconnset_no}  connset #{no_connset}"
		preconnset_no=no_connset
		
		resoligo=Array.new
		# p "connset  #{connset}"
		# p "orioligos  #{orioligos}"
		oddoligo=orioligos.select{|x| x.odd?}.shuffle
		# p oddoligo
		nodd=oddoligo.length
		evenoligo=orioligos.select{|x| x.even?}.shuffle
		# p evenoligo
		neven=evenoligo.length
		noarr=[nodd,neven].min
		resoligo=Array.new
		if nodd > noarr then
			resoligo =oddoligo[noarr..-1]
		else
			resoligo =evenoligo[noarr..-1]
		end
		mixoligo=oddoligo.shuffle[0,noarr].zip(evenoligo[0,noarr])
		# p "mixoligo  #{mixoligo}"
		mixoligo.each{|pair|
			if ojoin[pair.sort] then
				# p "hit"
				connset << ojoin[pair.sort]
			else
				resoligo << pair
			end
		}
		orioligos=resoligo.flatten
		# p "connset #{connset}"
		no_connset=connset.length
		# p "no_connset  #{no_connset}"
	end
	# p "connset  #{connset}  resoligo #{resoligo}"
	orioligos=(connset+resoligo).flatten
	# p "orioligos after wile #{orioligos}"
	# count end_products no
	endset=connset.select{|set| set == [13,14]}
	p "number of end-products #{endset.length}"
	no_final_products[i]=endset.length
}

CSV.open("final_products.csv","w") do |csv|
	no_final_products.each{|i,nop|
		csv << [i,nop]
	}
end