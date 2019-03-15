def readint(_file)
	return _file.read(4).unpack("V").to_s.gsub("[","").gsub("]","").to_i
end
def readstr(_file,_size)
	
	return _file.read(_size).force_encoding("Shift_JIS").to_s
end
def readfloat(_file)
	return _file.read(4).unpack("F*").to_s.gsub("[","").gsub("]","").to_f
end
def readbyte(_file)
	return _file.read(1).unpack("C").to_s.gsub("[","").gsub("]","").to_i
end
vmd_file=File.open(ARGV[0],"rb")
v_jis=2#版本
magic = vmd_file.read(25)
if magic != "Vocaloid Motion Data 0002"
	v_jis-=1#版本
	if magic != "Vocaloid Motion Data file"
		throw 'wrong magic'
	end
end
vmd_file.read(5)
if v_jis==2
	puts "VMD V2DATA"
	puts vmd_file.read(20).force_encoding("Shift_JIS")#非永久转换编码
elsif v_jis==1
	puts "VMD V1DATA"
	puts vmd_file.read(10).force_encoding("Shift_JIS")#非永久转换编码
end

i=0
numOfBoneRecord=readint(vmd_file)
if numOfBoneRecord != 0
	bonefile=File.open(("bone."+ARGV[0])+".csv","wb+")
	bonefile.puts "name,key,tx,ty,tz,ry,rz,rw,txc1,txc2,txc3,txc4,tyc1,tyc2,tyc3,tyc4,tzc1,tzc2,tzc3,tzc4,rc1,rc2,rc3,rc4"
	while i < numOfBoneRecord
		bonename=readstr(vmd_file,15)
		bonefile.print bonename,","
		frametime=readint(vmd_file)
		bonefile.print frametime,","
		tx=readfloat(vmd_file)
		ty=readfloat(vmd_file)
		tz=readfloat(vmd_file)
		rx=readfloat(vmd_file)
		ry=readfloat(vmd_file)
		rz=readfloat(vmd_file)
		rw=readfloat(vmd_file)
		bonefile.print tx,",",ty,",",tz,",",rx,",",ry,",",rz,",",rw,","
		txc1=readbyte(vmd_file)
		vmd_file.read(3)
		txc2=readbyte(vmd_file)
		vmd_file.read(3)
		txc3=readbyte(vmd_file)
		vmd_file.read(3)
		txc4=readbyte(vmd_file)
		vmd_file.read(3)
		tyc1=readbyte(vmd_file)
		vmd_file.read(3)
		tyc2=readbyte(vmd_file)
		vmd_file.read(3)
		tyc3=readbyte(vmd_file)
		vmd_file.read(3)
		tyc4=readbyte(vmd_file)
		vmd_file.read(3)
		tzc1=readbyte(vmd_file)
		vmd_file.read(3)
		tzc2=readbyte(vmd_file)
		vmd_file.read(3)
		tzc3=readbyte(vmd_file)
		vmd_file.read(3)
		tzc4=readbyte(vmd_file)
		vmd_file.read(3)
		rc1=readbyte(vmd_file)
		vmd_file.read(3)
		rc2=readbyte(vmd_file)
		vmd_file.read(3)
		rc3=readbyte(vmd_file)
		vmd_file.read(3)
		rc4=readbyte(vmd_file)
		vmd_file.read(3)
		bonefile.print txc1,",",txc2,",",txc3,",",txc4,","
		bonefile.print tyc1,",",tyc2,",",tyc3,",",tyc4,","
		bonefile.print tzc1,",",tzc2,",",tzc3,",",tzc4,","
		bonefile.print rc1,",",rc2,",",rc3,",",rc4,"\n"
		i+=1
		puts "#{i}/#{numOfBoneRecord}"
		system "cls"
	end
	puts "bone key done!"
	bonefile.close
end
i=0
numOfMorphRecord=readint(vmd_file)
if numOfMorphRecord != 0
	morphfile=File.open(("morph."+ARGV[0])+".csv","wb+")
	morphfile.puts "name,key,weight"
	while i < numOfMorphRecord
		morphname=readstr(vmd_file,15)
		frameTime=readint(vmd_file)
		weight=readfloat(vmd_file)
		morphfile.print morphname,",",frameTime,",",weight,"\n"
		i+=1
		puts "#{i}/#{numOfMorphRecord}"
		system "cls"
	end
	puts "morph key done!"
	morphfile.close
end
i=0
numOfCameraRecord=readint(vmd_file)
if numOfCameraRecord != 0
	camfile=File.open(("cam."+ARGV[0])+".csv","wb+")
	camfile.puts "key,distance,px,py,pz,rx,ry,rz,txc1,txc2,txc3,txc4,tyc1,tyc2,tyc3,tyc4,tzc1,tzc2,tzc3,tzc4,qc1,qc2,qc3,qc4,dc1,dc2,dc3,dc4,vc1,vc2,vc3,vc4,viewAngle,orthographic"
	while i < numOfCameraRecord
		frameTime=readint(vmd_file)
		distance=readfloat(vmd_file)
		camfile.print frameTime,",",distance,","#out
		px=readfloat(vmd_file)
		py=readfloat(vmd_file)
		pz=readfloat(vmd_file)
		camfile.print px,",",py,",",pz,","
		rx=readfloat(vmd_file)
		ry=readfloat(vmd_file)
		rz=readfloat(vmd_file)
		camfile.print rx,",",ry,",",rz,","
		txc1=readbyte(vmd_file)
		txc2=readbyte(vmd_file)
		txc3=readbyte(vmd_file)
		txc4=readbyte(vmd_file)
		camfile.print txc1,",",txc2,",",txc3,",",txc4,","
		tyc1=readbyte(vmd_file)
		tyc2=readbyte(vmd_file)
		tyc3=readbyte(vmd_file)
		tyc4=readbyte(vmd_file)
		camfile.print tyc1,",",tyc2,",",tyc3,",",tyc4,","
		tzc1=readbyte(vmd_file)
		tzc2=readbyte(vmd_file)
		tzc3=readbyte(vmd_file)
		tzc4=readbyte(vmd_file)
		camfile.print tzc1,",",tzc2,",",tzc3,",",tzc4,","
		qc1=readbyte(vmd_file)
		qc2=readbyte(vmd_file)
		qc3=readbyte(vmd_file)
		qc4=readbyte(vmd_file)
		camfile.print qc1,",",qc2,",",qc3,",",qc4,","
		dc1=readbyte(vmd_file)
		dc2=readbyte(vmd_file)
		dc3=readbyte(vmd_file)
		dc4=readbyte(vmd_file)
		camfile.print dc1,",",dc2,",",dc3,",",dc4,","
		vc1=readbyte(vmd_file)
		vc2=readbyte(vmd_file)
		vc3=readbyte(vmd_file)
		vc4=readbyte(vmd_file)
		camfile.print vc1,",",vc2,",",vc3,",",vc4,","
		viewAngle=readfloat(vmd_file)
		orthographic=readbyte(vmd_file)
		camfile.print viewAngle,",",orthographic,"\n"
		i+=1
		puts "#{i}/#{numOfCameraRecord}"
		system "cls"
	end
	puts "cam key done!"
	camfile.close
end
#-----------------------
puts vmd_file.pos.to_s(16)