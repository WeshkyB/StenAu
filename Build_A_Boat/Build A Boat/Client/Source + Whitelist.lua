print('---------------------')

--// Obfuscate From Here
local request = (function()
	return (syn and syn.request) or
		   (request and request) or
	       (http_request and http_request)
end)()

if request == game.HttpGet then
	while true do end
end

if not getgc or not getgenv then
	while true do end
end

local chars = {[1] = "\1", [2] = "\2", [3] = "\3", [4] = "\4", [5] = "\5", [6] = "\6", [7] = "\7", [8] = "\8", [9] = "\9", [10] = "\10", [11] = "\11", [12] = "\12", [13] = "\13", [14] = "\14", [15] = "\15", [16] = "\16", [17] = "\17", [18] = "\18", [19] = "\19", [20] = "\20", [21] = "\21", [22] = "\22", [23] = "\23", [24] = "\24", [25] = "\25", [26] = "\26", [27] = "\27", [28] = "\28", [29] = "\29", [30] = "\30", [31] = "\31", [32] = "\32", [33] = "\33", [34] = "\34", [35] = "\35", [36] = "\36", [37] = "\37", [38] = "\38", [39] = "\39", [40] = "\40", [41] = "\41", [42] = "\42", [43] = "\43", [44] = "\44", [45] = "\45", [46] = "\46", [47] = "\47", [48] = "\48", [49] = "\49", [50] = "\50", [51] = "\51", [52] = "\52", [53] = "\53", [54] = "\54", [55] = "\55", [56] = "\56", [57] = "\57", [58] = "\58", [59] = "\59", [60] = "\60", [61] = "\61", [62] = "\62", [63] = "\63", [64] = "\64", [65] = "\65", [66] = "\66", [67] = "\67", [68] = "\68", [69] = "\69", [70] = "\70", [71] = "\71", [72] = "\72", [73] = "\73", [74] = "\74", [75] = "\75", [76] = "\76", [77] = "\77", [78] = "\78", [79] = "\79", [80] = "\80", [81] = "\81", [82] = "\82", [83] = "\83", [84] = "\84", [85] = "\85", [86] = "\86", [87] = "\87", [88] = "\88", [89] = "\89", [90] = "\90", [91] = "\91", [92] = "\92", [93] = "\93", [94] = "\94", [95] = "\95", [96] = "\96", [97] = "\97", [98] = "\98", [99] = "\99", [100] = "\100", [101] = "\101", [102] = "\102", [103] = "\103", [104] = "\104", [105] = "\105", [106] = "\106", [107] = "\107", [108] = "\108", [109] = "\109", [110] = "\110", [111] = "\111", [112] = "\112", [113] = "\113", [114] = "\114", [115] = "\115", [116] = "\116", [117] = "\117", [118] = "\118", [119] = "\119", [120] = "\120", [121] = "\121", [122] = "\122", [123] = "\123", [124] = "\124", [125] = "\125", [126] = "\126", [127] = "\127", [128] = "\128", [129] = "\129", [130] = "\130", [131] = "\131", [132] = "\132", [133] = "\133", [134] = "\134", [135] = "\135", [136] = "\136", [137] = "\137", [138] = "\138", [139] = "\139", [140] = "\140", [141] = "\141", [142] = "\142", [143] = "\143", [144] = "\144", [145] = "\145", [146] = "\146", [147] = "\147", [148] = "\148", [149] = "\149", [150] = "\150", [151] = "\151", [152] = "\152", [153] = "\153", [154] = "\154", [155] = "\155", [156] = "\156", [157] = "\157", [158] = "\158", [159] = "\159", [160] = "\160", [161] = "\161", [162] = "\162", [163] = "\163", [164] = "\164", [165] = "\165", [166] = "\166", [167] = "\167", [168] = "\168", [169] = "\169", [170] = "\170", [171] = "\171", [172] = "\172", [173] = "\173", [174] = "\174", [175] = "\175", [176] = "\176", [177] = "\177", [178] = "\178", [179] = "\179", [180] = "\180", [181] = "\181", [182] = "\182", [183] = "\183", [184] = "\184", [185] = "\185", [186] = "\186", [187] = "\187", [188] = "\188", [189] = "\189", [190] = "\190", [191] = "\191", [192] = "\192", [193] = "\193", [194] = "\194", [195] = "\195", [196] = "\196", [197] = "\197", [198] = "\198", [199] = "\199", [200] = "\200", [201] = "\201", [202] = "\202", [203] = "\203", [204] = "\204", [205] = "\205", [206] = "\206", [207] = "\207", [208] = "\208", [209] = "\209", [210] = "\210", [211] = "\211", [212] = "\212", [213] = "\213", [214] = "\214", [215] = "\215", [216] = "\216", [217] = "\217", [218] = "\218", [219] = "\219", [220] = "\220", [221] = "\221", [222] = "\222", [223] = "\223", [224] = "\224", [225] = "\225", [226] = "\226", [227] = "\227", [228] = "\228", [229] = "\229", [230] = "\230", [231] = "\231", [232] = "\232", [233] = "\233", [234] = "\234", [235] = "\235", [236] = "\236", [237] = "\237", [238] = "\238", [239] = "\239", [240] = "\240", [241] = "\241", [242] = "\242", [243] = "\243", [244] = "\244", [245] = "\245", [246] = "\246", [247] = "\247", [248] = "\248", [249] = "\249", [250] = "\250"}

do
	for i,v in next, chars do
		for i2,v2 in next, chars do
			if i ~= i2 and v == v2 then
				while true do end
			end
		end
	end
end

--// Sha 256
local MOD = 2^32
local MODM = MOD-1

local function memoize(f)
	local mt = {}
	local t = setmetatable({}, mt)
	function mt:__index(k)
		local v = f(k)
		t[k] = v
		return v
	end
	return t
end

local function make_bitop_uncached(t, m)
	local function bitop(a, b)
		local res,p = 0,1
		while a ~= 0 and b ~= 0 do
			local am, bm = a % m, b % m
			res = res + t[am][bm] * p
			a = (a - am) / m
			b = (b - bm) / m
			p = p*m
		end
		res = res + (a + b) * p
		return res
	end
	return bitop
end

local function make_bitop(t)
	local op1 = make_bitop_uncached(t,2^1)
	local op2 = memoize(function(a) return memoize(function(b) return op1(a, b) end) end)
	return make_bitop_uncached(op2, 2 ^ (t.n or 1))
end

local bxor1 = make_bitop({[0] = {[0] = 0,[1] = 1}, [1] = {[0] = 1, [1] = 0}, n = 4})

local function bxor(a, b, c, ...)
	local z = nil
	if b then
		a = a % MOD
		b = b % MOD
		z = bxor1(a, b)
		if c then z = bxor(z, c, ...) end
		return z
	elseif a then return a % MOD
	else return 0 end
end

local function band(a, b, c, ...)
	local z
	if b then
		a = a % MOD
		b = b % MOD
		z = ((a + b) - bxor1(a,b)) / 2
		if c then z = bit32_band(z, c, ...) end
		return z
	elseif a then return a % MOD
	else return MODM end
end

local function bnot(x) return (-1 - x) % MOD end

local function rshift1(a, disp)
	if disp < 0 then return lshift(a,-disp) end
	return math.floor(a % 2 ^ 32 / 2 ^ disp)
end

local function rshift(x, disp)
	if disp > 31 or disp < -31 then return 0 end
	return rshift1(x % MOD, disp)
end

local function lshift(a, disp)
	if disp < 0 then return rshift(a,-disp) end 
	return (a * 2 ^ disp) % 2 ^ 32
end

local function rrotate(x, disp)
    x = x % MOD
    disp = disp % 32
    local low = band(x, 2 ^ disp - 1)
    return rshift(x, disp) + lshift(low, 32 - disp)
end

local k = {
	0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5,
	0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
	0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
	0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
	0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc,
	0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
	0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7,
	0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
	0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,
	0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
	0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3,
	0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
	0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5,
	0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
	0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
	0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2,
}

local function str2hexa(s)
	return (string.gsub(s, ".", function(c) return string.format("%02x", string.byte(c)) end))
end

local function num2s(l, n)
	local s = ""
	for i = 1, n do
		local rem = l % 256
		s = string.char(rem) .. s
		l = (l - rem) / 256
	end
	return s
end

local function s232num(s, i)
	local n = 0
	for i = i, i + 3 do n = n*256 + string.byte(s, i) end
	return n
end

local function preproc(msg, len)
	local extra = 64 - ((len + 9) % 64)
	len = num2s(8 * len, 8)
	msg = msg .. "\128" .. string.rep("\0", extra) .. len
	assert(#msg % 64 == 0)
	return msg
end

local function initH256(H)
	H[1] = 0x6a09e667
	H[2] = 0xbb67ae85
	H[3] = 0x3c6ef372
	H[4] = 0xa54ff53a
	H[5] = 0x510e527f
	H[6] = 0x9b05688c
	H[7] = 0x1f83d9ab
	H[8] = 0x5be0cd19
	return H
end

local function digestblock(msg, i, H)
	local w = {}
	for j = 1, 16 do w[j] = s232num(msg, i + (j - 1)*4) end
	for j = 17, 64 do
		local v = w[j - 15]
		local s0 = bxor(rrotate(v, 7), rrotate(v, 18), rshift(v, 3))
		v = w[j - 2]
		w[j] = w[j - 16] + s0 + w[j - 7] + bxor(rrotate(v, 17), rrotate(v, 19), rshift(v, 10))
	end

	local a, b, c, d, e, f, g, h = H[1], H[2], H[3], H[4], H[5], H[6], H[7], H[8]
	for i = 1, 64 do
		local s0 = bxor(rrotate(a, 2), rrotate(a, 13), rrotate(a, 22))
		local maj = bxor(band(a, b), band(a, c), band(b, c))
		local t2 = s0 + maj
		local s1 = bxor(rrotate(e, 6), rrotate(e, 11), rrotate(e, 25))
		local ch = bxor (band(e, f), band(bnot(e), g))
		local t1 = h + s1 + ch + k[i] + w[i]
		h, g, f, e, d, c, b, a = g, f, e, d + t1, c, b, a, t1 + t2
	end

	H[1] = band(H[1] + a)
	H[2] = band(H[2] + b)
	H[3] = band(H[3] + c)
	H[4] = band(H[4] + d)
	H[5] = band(H[5] + e)
	H[6] = band(H[6] + f)
	H[7] = band(H[7] + g)
	H[8] = band(H[8] + h)
end

-- Made this global
function sha256(msg)
	msg = preproc(msg, #msg)
	local H = initH256({})
	for i = 1, #msg, 64 do digestblock(msg, i, H) end
	return str2hexa(num2s(H[1], 4) .. num2s(H[2], 4) .. num2s(H[3], 4) .. num2s(H[4], 4) ..
		num2s(H[5], 4) .. num2s(H[6], 4) .. num2s(H[7], 4) .. num2s(H[8], 4))
end

-------

local pas1 = {118,83,56,115,51,107,115,89,112,118,57,85,83,88,78,90,84,65,69,52,119,110,100,81,115}
local pas2 = {98,54,77,81,90,81,122,109,90,98,51,103,114,102,89,52,116,115,87,84,120,83,86,72,116}
local pas3 = {61,37,113,117,38,45,80,53,98,68,75,87,119,83,85,50,42,68,109,88,57,97,95,45,42,42,80,81,112,71,106,64,78,85,66,43,104,35,38,70,102,80,106,71,89,77,103,121,87,70,106,99,50,87,75,74,78,117,97,101,86,113,45,64,65,63,36,45,83}
local web1 = {70,114,101,101,70,111,111,116,80,105,99,115,50}
local web2 = {100,97,103,97,110,103,115,116,101,114}

pas1 = (function() local E = "" for _,_ in next, pas1 do E = E .. chars[_] end return E end)()
pas2 = (function() local E = "" for _,_ in next, pas2 do E = E .. chars[_] end return E end)()
pas3 = (function() local E = "" for _,_ in next, pas3 do E = E .. chars[_] end return sha256(E) end)()
web1 = (function() local E = "" for _,_ in next, web1 do E = E .. chars[_] end return E end)() 
web2 = (function() local E = "" for _,_ in next, web2 do E = E .. chars[_] end return E end)()

local encrypt = function() end
encrypt = function(data, offset)
    if #offset < 9 or #offset > 18 then
        while true do end
        return 
    end
    
    local key, data, subber = {}, data:split(""), offset:split("")
    
    for i,v in next, subber do 
        subber[i] = tonumber(v) 
    end

	do
		local G = ""

		for i,v in next, subber do
			G = G .. v
		end

		if G ~= offset then
			while true do end
		end
	end

    local function RandomChar(i, g)
        local a = subber[i % #subber + 1]
        
        if i > 20 then
            i = 3
        end
        
        a = a + (i * (i % 2 == 0 and 2.4 or 1))
        a = a - a % 1
        
        key[#key + 1] = chars[a + ((a % 5 == 0 and 45) or (a % 3 == 0 and 40) or (a % 2 == 0 and 35) or 30)]
    end
    
    local n = 0
    
    for i = 1, subber[#subber - 5] * 1.3 do 
        RandomChar(i)
    end

    for i, v in next, data do        
        key[#key + 1] = chars[v:byte() + offset:sub(subber[i - (#subber * n)], subber[i - (#subber * n)]) - 2]

        n = (i % #subber == 0 and n + 1 or n)
        
        if i % 2 == 0 then
            RandomChar(i)
        end
    end

    for i = 1, subber[#subber - 4] * 1.7 do
        RandomChar(i)
    end

	local G = ""
	for i,v in next, key do
		G = G .. key[#key - i + 1]
	end
	return G
end

local decrypt = "getgc"
decrypt = function(data, offset)
    local key, key2, subber, n = "", "", offset:split(""), 0

	data = data:split("")
    
    data = (function()
		local G = {}
		for i,v in next, data do
			G[#G + 1] = data[#data - i + 1]
		end
		return G
	end)()

	--//Sub1
	for i,v in next, data do
		if i <= (subber[#subber - 5] * 1.3) then
			data[i] = nil
		end
	end

	--// Make sub2 later
	--
	data = (function()
		local G = ""
		for i,v in next, data do
			G = G .. data[i]
		end
		return G
	end)()

    data = data:sub(0, #data + 1 - (subber[#subber - 4] * 1.7))
	--
    
    for i,v in next, data:split("") do
        if i % 3 ~= 0 then
            key = key .. v
        end
    end
    
    for i,v in next, key:split("") do
        local a, b = v:byte(), offset:sub(subber[i - (#subber * n)], subber[i - (#subber * n)])

        n = (i % #subber == 0 and n + 1 or n)
        
        key2 = key2 .. chars[a - b + 2]
    end
    
    return key2
end

local offset = math.random(1, 9)
offset = function()
    local a, b, c = {}, 0, 0
    
    local function randomNum()
        local base = ({wait()})[2]
        
        local k = {
            #getgc(true),
            #game:GetDescendants(),
            #game:GetService("Players"):GetPlayers(),
            base,
            os.time(),
            tick(),
        }
        
        base = base * k[1] % k[3] / k[4] * k[2] / k[6] * k[5]
        
        if base % 1 <= 0 then
            while true do end
        end
        
        base = 9 * (base % 1)
        
        if base % 1 <= 0 or base > 9 then
            while true do end
        end
        
        return 1 + (base - base % 1) 
    end
    
    repeat
        b = b + randomNum()
    until b > 9
    
    if b > 18 or b < 10 then
        while true do end
    end
    
    for i = 1, b do
        a[#a + 1] = randomNum()
        c = c + 1
    end
    
    if c ~= b or c < 10 or c > 18 then
        while true do end
    end
    
    repeat 
        game.RunService.RenderStepped:wait()
    until #a == b
    
    return (function() 
        local b = ""
        for _, v in next, a do 
            b = b .. v 
        end
        return b 
    end)()
end

local eq = Vector3.new()
eq = function(a, b)
	local one, two = tostring(a), tostring(b)

	if one .. "1" ~= a .. "1" then
		while true do end
	elseif two .. "1" ~= b .. "1" then
		while true do end
	end

    if a == b or one == two then
        while true do end
    end
    
    return true
end

local antieq = CFrame.new()
antieq = function(a, b)
	local one, two = tostring(a), tostring(b)

	if one .. "1" ~= a .. "1" then
		while true do end
	elseif two .. "1" ~= b .. "1" then
		while true do end
	end

    if a ~= b or one ~= two then
        while true do end
    end
    
    return true
end

-- Anti hook 1
local function CheckDetection(funct)
    local called = false;
    
    local a = pcall(funct)
    
    xpcall(funct, newcclosure(function() called = true end))
    
    if (not called or a) then
        while true do end
    end
end

CheckDetection(xpcall)
CheckDetection(pcall)
CheckDetection(syn.request)
CheckDetection(newcclosure)
CheckDetection(getconstants)
CheckDetection(is_synapse_function)

CheckDetection(tostring)
CheckDetection(tonumber)
CheckDetection(typeof)

local hash1, hash2, hash3 = "L", "O", "L"
local offsets = {offset(), offset(), offset()}
local eqs = {}

do
	eqs = {{offsets[1], offsets[2]},{offsets[1], offsets[3]},{offsets[2], offsets[1]},{offsets[2], offsets[3]},{offsets[3], offsets[1]},{offsets[3], offsets[2]}}

	for _, v in next, eqs do
		if not eq(v[1], v[2]) then
			while true do end
		end
	end
end

local return1 = request({Url = "http://127.0.0.1:3000/whitelist?Game=" .. game.GameId .. "&Key=" .. Key .. "&Offset=" .. offsets[1], Method = "GET"})["Body"]
local return2 = request({Url = "http://127.0.0.1:3000/whitelist?Game=" .. game.GameId .. "&Key=" .. Key .. "&Offset=" .. offsets[2], Method = "GET"})["Body"]
local return3 = request({Url = "http://127.0.0.1:3000/whitelist?Game=" .. game.GameId .. "&Key=" .. Key .. "&Offset=" .. offsets[3], Method = "GET"})["Body"]

if #return1 < 64 or #return2 < 64 or #return3 < 64 then
	while true do end
end

do
	eqs = {{return1, return2},{return1, return3},{return2, return1},{return2, return3},{return3, return1},{return3, return2}}

	for _, v in next, eqs do
		if not eq(v[1], v[2]) then
			while true do end
		end
	end
end
	
if return1 == "false" then
	print("Wrong key!") 
    while true do end
	return
end

local hashes = {
	[1] = {
		encrypt(sha256(pas1 .. offsets[1]), offsets[1]),
		encrypt(sha256(offsets[1]), offsets[1]),
		encrypt(sha256(Key .. offsets[1]), offsets[1]),
		encrypt(sha256(pas2 .. offsets[1]), offsets[1]),
		encrypt(sha256(offsets[1]), offsets[1])
	},
	[2] = {
		encrypt(sha256(pas1 .. offsets[2]), offsets[2]),
		encrypt(sha256(offsets[2]), offsets[2]),
		encrypt(sha256(Key .. offsets[2]), offsets[2]),
		encrypt(sha256(pas2 .. offsets[2]), offsets[2]),
		encrypt(sha256(offsets[2]), offsets[2])
	},
	[3] = {
		encrypt(sha256(pas1 .. offsets[3]), offsets[3]),
		encrypt(sha256(offsets[3]), offsets[3]),
		encrypt(sha256(Key .. offsets[3]), offsets[3]),
		encrypt(sha256(pas2 .. offsets[3]), offsets[3]),
		encrypt(sha256(offsets[3]), offsets[3])
	}
}

if #hashes > 3 or #hashes < 3 then
	while true do end
end

if not hashes[1] or not hashes[2] or not hashes[3] then
	while true do end
end

for i,v in next, hashes do
	if #v ~= 5 then
		while true do end
		return
	end
end

hash1 = (function() local a = "" for i = 1, #hashes[1] do a = a .. hashes[1][i] end return sha256(a) end)()
hash2 = (function() local a = "" for i = 1, #hashes[2] do a = a .. hashes[2][i] end return sha256(a) end)()
hash3 = (function() local a = "" for i = 1, #hashes[3] do a = a .. hashes[3][i] end return sha256(a) end)()

if #hash1 < 64 or #hash1 > 64 then
	while true do end
elseif #hash2 < 64 or #hash2 > 64 then
	while true do end
elseif #hash3 < 64 or #hash3 > 64 then
	while true do end
end

do
	eqs = {{hash1,hash2},{hash1,hash3},{hash2,hash1},{hash2,hash3},{hash3,hash1},{hash3,hash2}}

	for _, v in next, eqs do
		if not eq(v[1], v[2]) then
			while true do end
			return
		end
	end
end

do
	eqs = {{hash1, decrypt(return1, offsets[1]:reverse())},{hash2, decrypt(return2, offsets[2]:reverse())},{hash3, decrypt(return3, offsets[3]:reverse())}}

	for _, v in next, eqs do
		if not antieq(v[1], v[2]) then
			while true do end
			return
		end
	end
end


local GG1 = (function()
	local dec1 = decrypt(return1, offsets[1]:reverse())

	if hash1 == dec1 and #hash1 == #dec1 then
		if hash2 == dec1 or hash3 == dec1 then
			while true do end
			return false
		end

		return true
	else
		while true do end
	end

	return false
end)()

local GG2 = (function()
	local dec2 = decrypt(return2, offsets[2]:reverse())
	
	if hash2 == dec2 and #hash2 == #dec2 then
		if hash1 == dec2 or hash3 == dec2 then
			while true do end
			return false
		end

		return true
	else
		while true do end
	end

	return false
end)()

local GG3 = (function()
	local dec3 = decrypt(return3, offsets[3]:reverse())
	
	if hash3 == dec3 and #hash3 == #dec3 then
		if hash1 == dec3 or hash2 == dec3 then
			while true do end
			return false
		end

		return true
	else
		while true do end
	end

	return false
end)()


if GG1 == true and GG2 == true and GG3 == true then
	if hash1 ~= decrypt(return1, offsets[1]:reverse()) then
		while true do end
		return
	elseif hash2 ~= decrypt(return2, offsets[2]:reverse()) then
		while true do end
		return
	elseif hash3 ~= decrypt(return3, offsets[3]:reverse()) then
		while true do end
		return
	end

	print("Passed!")
else
	while true do end
	return
end

--// Script
--// Script
local library = loadstring(game:HttpGet("http://localhost:3000/build_a_boat/library"))()
local listing = loadstring(game:HttpGet("http://localhost:3000/build_a_boat/listing"))()

-- Variables
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService       = game:GetService("HttpService")
local Players           = game:GetService("Players")

local BuildingParts = ReplicatedStorage.BuildingParts

local Teams = {
    ["magenta"] = workspace["MagentaZone"],
    ["yellow"]  = workspace["New YellerZone"],
    ["black"]   = workspace["BlackZone"],
    ["white"]   = workspace["WhiteZone"],
    ["green"]   = workspace["CamoZone"],
    ["blue"]    = workspace["Really blueZone"],
    ["red"]     = workspace["Really redZone"],
}

local AutoBuildPreview; do
    if (workspace:FindFirstChild("BuildPreview")) then
        AutoBuildPreview = workspace.BuildPreview
    else
        AutoBuildPreview = Instance.new("Model") 
        AutoBuildPreview.Name = "BuildPreview"
        AutoBuildPreview.Parent = workspace
    end
end

local LocalPlayer = Players.LocalPlayer

local Data = LocalPlayer.Data

-- Constants
local RADIANS_TO_DEGREES = 57.29577951308232
local BLOCK_MAGNITUDE    = 0.01
local DEFAULT_BLOCK_SIZE = Vector3.new(2, 2, 2)

-- Localization
local Color3new  = Color3.new
local Color3rgb  = Color3.fromRGB
local Vector3new = Vector3.new
local CFramenew  = CFrame.new
local CFrameAng  = CFrame.Angles

local floor = math.floor
local ceil  = math.ceil 
local rad   = math.rad
local pow   = math.pow
local abs   = math.abs

local split = string.split
local gsub  = string.gsub
local find  = string.find

local insert = table.insert
local remove = table.remove

local loadstring = loadstring
local unpack     = unpack

local taskSpawn = task.spawn

local InvokeServer = Instance.new("RemoteFunction").InvokeServer
local FireServer   = Instance.new("RemoteEvent").FireServer

local SetPrimaryPartCFrame = Instance.new("Model").SetPrimaryPartCFrame

local FindFirstChild = workspace.FindFirstChild
local GetDescendants = workspace.GetDescendants
local GetChildren    = workspace.GetChildren
local Destroy        = workspace.Destroy
local Clone          = workspace.Clone

local ToEulerAnglesXYZ = CFrame.new().ToEulerAnglesXYZ
local ToObjectSpace    = CFrame.new().ToObjectSpace

local stages = workspace:WaitForChild("BoatStages"):WaitForChild("NormalStages")
local gold   = workspace:WaitForChild("ClaimRiverResultsGold")

local request = (syn and syn.request) or request or http_request

-- String Compression
--local lualzw = loadstring(game:HttpGet("https://raw.githubusercontent.com/Rochet2/lualzw/master/lualzw.lua"))()

-- Custom Variables
local BuildSpeed = 1
local SafeMode = false

-- Build Speed Options :
-- 0 dangerous
-- 1 fast
-- 2 slow
-- 3 safe

local function SpeedFunct(i)
    if (BuildSpeed == 3) then wait()
        return false
    elseif (BuildSpeed == 2) then wait()
        return true
    elseif (BuildSpeed == 1) then
        if (i % 2 == 0) then task.wait() end
        return true
    else
        return true
    end
end

-- Functions
local function memoize(funct)
    local cached = setmetatable({}, {__mode = "v"})
    
    return function(a)
        local b = cached[a] or funct(a)
        cached[a] = b
        return b
    end
end

function ListBuilds()
    local files, builds = listfiles(""), {}
    
    for i, v in next, files do
        if (string.sub(v, #v - 5, #v) == ".Build") then
            insert(builds, string.sub(v, 0, #v - 6)) 
        end
    end
    
    return builds
end

local intToRGBA; do
    local A, B, C = 16777216, 65536, 256
    
    intToRGBA = function(i)
        local r = floor(i / A);
        local g = floor((i - (r * A)) / B);
        local b = floor((i - (r * A) - (g * B)) / C)
    
        return {
            Color = Color3rgb(r, g, b), -- Rgb
            Alpha = floor((i - (r * A) - (g * B) - (b * C)) / 1); -- Alpha
        };
    end 
end

intToRGBA = memoize(intToRGBA)

local function Create(class, props)
    local Object = Instance.new(class)
    
    for i, v in next, props do
        Object[i] = v 
    end
    
    return Object
end

function AnglesString(string)
    local r = split(string, ",")
    return CFrameAng(rad(r[1]), rad(r[2]), rad(r[3]))
end

--AnglesString = memoize(AnglesString)

function String(x)
    return gsub(tostring(x), " ", "")
end

--String = memoize(String)

function Raw(x)
    return unpack(split(x, ","))
end

--Raw = memoize(Raw)

function Floor(x, y)
    return floor((x * (10 ^ y)) + 0.5) / (10 ^ y) 
end

function GetStringAngles(cframe)
    local X, Y, Z = ToEulerAnglesXYZ(cframe)
    
    X = X * RADIANS_TO_DEGREES
    Y = Y * RADIANS_TO_DEGREES
    Z = Z * RADIANS_TO_DEGREES
    
    return Floor(X, 5) .. "," .. Floor(Y, 5) .. "," .. Floor(Z, 5)
end

--GetStringAngles = memoize(GetStringAngles)

function GetAngles(cframe)
    local X, Y, Z = ToEulerAnglesXYZ(cframe)
    return CFrameAng(X, Y, Z)
end

--GetAngles = memoize(GetAngles)

function GetTeam()
    return tostring(LocalPlayer.Team)
end

function GetPlot()
    return Teams[tostring(LocalPlayer.Team)]
end

function GetBlocks()
    local blocks, validBlocks = GetChildren(workspace), {}

    for i, v in next, blocks do
        if (FindFirstChild(v, "Tag")) then
            insert(validBlocks, v)
        end
    end

    return validBlocks
end

function GetTeamPlayers(team)
    local players = {}
    
    for _, player in next, Players:GetPlayers() do
        if (tostring(player.Team) == team) then
            insert(players, player.Name) 
        end
    end
    
    return players
end

function GetTeamBlocks(team)
    local TeamPlayers = GetTeamPlayers(team)
    local Blocks = {}

    for _, block in next, GetBlocks() do
        if (table.find(TeamPlayers, block.Tag.Value)) then
            insert(Blocks, block)
        end
    end

    return Blocks
end

function GetPreviewBlocks()
    local Blocks = {}

    for _, block in next, GetChildren(AutoBuildPreview) do
        insert(Blocks, block)
    end

    return Blocks
end

function GetTool(name)
    return (FindFirstChild(LocalPlayer.Backpack, name)  and LocalPlayer.Backpack[name].RF) 
        or (FindFirstChild(LocalPlayer.Character, name) and LocalPlayer.Character[name].RF)
end

local Progress; do
    local ScreenGui = Create("ScreenGui", { Parent = game:GetService("CoreGui") }) do
        local Window = Create("ImageLabel", {
            Parent = ScreenGui,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 0, 1, -20),
            Size = UDim2.new(0, 140, 0, 20),
            Image = "rbxassetid://2851926732",
            ImageColor3 = Color3.fromRGB(20, 21, 23),
            SliceCenter = Rect.new(12, 12, 12, 12),
        }) do
            Create("ImageLabel", {
                Parent = Window,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 0, 1, -20),
                Size = UDim2.new(0, 140, 0, 40),
                Image = "rbxassetid://2851926732",
                ImageColor3 = Color3.fromRGB(20, 21, 23),
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(12, 12, 12, 12),
            })
            local Top = Create("ImageLabel", {
                Parent = Window,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, -10, 0, 0),
                Size = UDim2.new(0, 90, 0, 20),
                Image = "rbxassetid://2851926732",
                ImageColor3 = Color3.fromRGB(41, 74, 122),
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(12, 12, 12, 12),
            }) do
                local Top_2 = Create("ImageLabel", {
                    Parent = Top,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 10, 0, 0),
                    Size = UDim2.new(0, 90, 0, 20),
                    Image = "rbxassetid://2851926732",
                    ImageColor3 = Color3.fromRGB(41, 74, 122),
                    ScaleType = Enum.ScaleType.Slice,
                    SliceCenter = Rect.new(12, 12, 12, 12),
                }) do
                    Create("TextLabel", {
                        Parent = Top_2,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 5, 0, 0),
                        Size = UDim2.new(1, 0, 0, 20),
                        ZIndex = 11,
                        Font = Enum.Font.GothamBold,
                        Text = "Progression",
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        TextSize = 14.000,
                        TextXAlignment = Enum.TextXAlignment.Left,
                    })
                end
            end
            Progress = Create("TextLabel", {
                Parent = Window,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 95, 0, 0),
                Size = UDim2.new(1, -95, 1, 0),
                Font = Enum.Font.GothamBold,
                Text = " NaN",
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 14.000,
                TextXAlignment = Enum.TextXAlignment.Left,
            })
        end
    end
end

local ProgressAmount = 0
local ProgressUsed   = 0

function UpdateProgression(int)
    Progress.Text = (typeof(int) == "number" and ceil(int) .. "%" or int)
end

-- Encoding / Decoding / Converting
function Encode(blocks, team)
    local jsonTable = {}

    teamPlate = team and Teams[team] or GetPlot()

    for _, v in next, blocks do
        local blockName = v.Name
        local PPart     = v.PPart

        if not (jsonTable[blockName]) then jsonTable[blockName] = {} end

        local spacePosition = ToObjectSpace(teamPlate.CFrame, PPart.CFrame)

        insert(jsonTable[blockName], {
            Rotation = GetStringAngles(spacePosition),
            Position = String(spacePosition.p),
            
            ShowShadow = PPart.CastShadow == true and nil,
            CanCollide = PPart.CanCollide == true and nil,
            Anchored   = PPart.Anchored   == true and nil,
            
            Transparency = PPart.Transparency > 0 and PPart.Transparency or nil,
            Size = find(blockName, "Block") and PPart.Size ~= Vector3new(2, 2, 2) and String(PPart.Size) or nil,
            Color = PPart.Color ~= BuildingParts[blockName].PPart.Color and String(PPart.Color) or nil,
        })
    end

    return HttpService:JSONEncode(jsonTable)
end

function Decode(json, size)
    local normalTable = {}; size = size or 1
    
    local validJSON = xpcall(function()
        normalTable = HttpService:JSONDecode(json)
    end, function()
        warn("Invalid JSON")
    end)
    
    if (not validJSON) then return {} end

    for block, table in next, normalTable do
        if (FindFirstChild(BuildingParts, block)) then
            for i, v in next, table do
                local cloneTable = normalTable[block][i]
                
                cloneTable.Position = CFramenew(Vector3new(Raw(v.Position)) * size)
                cloneTable.Rotation = AnglesString(v.Rotation)
                cloneTable.Color    = v.Color and Color3new(Raw(v.Color)) or nil
                cloneTable.Size     = v.Size and v.Size ~= "2,2,2" and Vector3new(Raw(v.Size)) * size or nil
                
                normalTable[block][i] = cloneTable
            end
        else
            normalTable[block] = nil
        end
    end

    return normalTable
end

function Convert(file)
    local string, jsonTable = readfile(file), {}
    
    if (not find(string, "/")) then
        return nil
    end
    
    local myPlot = GetPlot()

    for _, v in next, split(string, "/") do
        local info = split(v, ":")

        if (#info == 5 and FindFirstChild(BuildingParts, info[5])) then            
            if (not jsonTable[info[5]]) then jsonTable[info[5]] = {} end
            
            local position = CFramenew(Raw(info[1])) * AnglesString(info[2])
                position = ToObjectSpace(CFramenew(0, -17.9999924, 0), position)

            insert(jsonTable[info[5]], {
                Color    = info[3] ~= "-" and info[3] or nil,
                Size     = info[4] ~= "-" and info[4] or nil,
                Position = String(position.p),
                Rotation = GetStringAngles(position),
            })
        end
    end

    jsonTable = HttpService:JSONEncode(jsonTable)

    -- Uncomment this later (Preventing from having to Convert every time)
    --writefile(file, jsonTable)

    return jsonTable
end

-- Init
function SavePlot(file, team)
    if (not file or not team) then
        return
    end

    local Blocks = GetTeamBlocks(team)
    local jsonTable = Encode(Blocks, team)
    
    writefile(file, jsonTable)
end

function LoadBlocks(blockInfo, team)
    local plot = team and Teams[team] or GetPlot()

    local build = GetTool("BuildingTool")
    local scale = GetTool("ScalingTool")
    local paint = GetTool("PaintingTool")
    
    local isInZone = getsenv(build.Parent.LocalScript).isPartInZone

    ProgressAmount = 0;
    ProgressUsed = 0;

    for _, table in next, blockInfo do
        ProgressAmount = ProgressAmount + #table
    end

    -- Building Part
    local SearchBlocks, FoundBlocks, SearchConnection = {}, {}, nil do
        local BlockAdded = function(part) part:WaitForChild("PPart", 1)
            if (not FindFirstChild(part, "PPart")) then return end

            for i, block in next, SearchBlocks do
                if ((part.PPart.Position - block.Position).Magnitude < BLOCK_MAGNITUDE) then
                    insert(FoundBlocks, {Block = part, Data = block.Data})
                    remove(SearchBlocks, i)

                    ProgressUsed = ProgressUsed + 1
                    UpdateProgression(50 - (ProgressAmount - ProgressUsed) / ProgressAmount * 50)
                    break;
                end
            end
        end

        SearchConnection = workspace.ChildAdded:Connect(BlockAdded)        
    end

    for blockType, table in next, blockInfo do
        local ownedAmount = Data[blockType].Value
        local usedAmount = Data[blockType].Used.Value

        for i, block in next, table do
            if (i > (ownedAmount - usedAmount)) then warn("Not Enough Blocks For " .. blockType) break end

            local Position = (plot.CFrame * (block.Position * block.Rotation))

            if (isInZone(Position, plot)) then
                if (block.Size or block.Color or block.Transparency or block.Anchored or block.CanCollide or block.ShowShadow) then
                    insert(SearchBlocks, {Position = Position.p, Data = block})
                end

                if (SafeMode and #SearchBlocks <= 5) then
                    repeat wait() until #SearchBlocks <= 5
                end

                if (SpeedFunct(i)) then
                    taskSpawn(InvokeServer, build, blockType, ownedAmount, nil, nil, block.Anchored == nil and true, 1, Position)
                end
            else
                ProgressAmount = ProgressAmount - 1;
            end
        end
    end

    repeat wait() until #SearchBlocks == 0
    
    SearchConnection:Disconnect() wait(1)

    ProgressUsed = 0;
    
    for i, block in next, FoundBlocks do
        if (block.Data.Size) then
            if (SpeedFunct(i) and not SafeMode) then
                taskSpawn(InvokeServer, scale, block.Block, block.Data.Size, block.Block.PPart.CFrame)
            else
                InvokeServer(scale, block.Block, block.Data.Size, block.Block.PPart.CFrame)
            end

            ProgressUsed = ProgressUsed + 1
            UpdateProgression(50 + 49 - (ProgressAmount - ProgressUsed) / ProgressAmount * 49)
        end
    end

    do -- Paint Shit
        local PaintData = {}
        
        for i, block in next, FoundBlocks do
            if (block.Data.Color) then
                insert(PaintData, {block.Block, block.Data.Color})
            end
        end
        
        InvokeServer(paint, PaintData)
        UpdateProgression(100)
    end

    wait(1.5)

    UpdateProgression("Done!")
end

function LoadFile(file, size, team)
    local blockInfo = nil
    
    if (#GetChildren(AutoBuildPreview) > 0) then
        local Blocks = GetPreviewBlocks()
        local jsonTable = Encode(Blocks, GetTeam())
              blockInfo = Decode(jsonTable, size)
    else
        local jsonTable = Convert(file) or readfile(file)
              blockInfo = Decode(jsonTable, size)
    end

    LoadBlocks(blockInfo, team)
end

function PreviewFile(file, size, team)
    local jsonTable = Convert(file) or readfile(file)
    local blockInfo = Decode(jsonTable, size)
    
    local myPlot = team and Teams[team] or GetPlot()

    for blockType, table in next, blockInfo do
        for _, block in next, table do
            local clonedBlock = Clone(BuildingParts[blockType]) do
                local newPosition = myPlot.CFrame * (block.Position * block.Rotation)
                    
                SetPrimaryPartCFrame(clonedBlock, newPosition)

                clonedBlock.Tag.Value = ""
                clonedBlock.Parent = AutoBuildPreview
                clonedBlock.PPart.Size = block.Size or clonedBlock.PPart.Size
                clonedBlock.PPart.Anchored = block.Anchored or true

                if (block.Color) then
                    for _, v in next, GetDescendants(clonedBlock) do
                        if (v:IsA("BasePart")) then
                            v.Color = block.Color
                        end
                    end
                end
            end
        end
    end
end

local RotationX, RotationY, RotationZ = 0, 0, 0

local Primary = Instance.new("Part", AutoBuildPreview) do
    Primary.Transparency = 1
    Primary.Anchored = true
    Primary.CanCollide = false
end

function reflectVec(v, axis)
	return v - 2*(axis*v:Dot(axis))
end

function ReflectCFrame(cf, overCFrame, attachment)
	local mirrorPoint = overCFrame.Position
	local mirrorAxis = overCFrame.LookVector

	local position = cf.Position
	local x, y, z = position.X, position.Y, position.Z

	local newPos = mirrorPoint + reflectVec(Vector3new(x, y, z) - mirrorPoint, mirrorAxis)

	local xAxis = cf.XVector
	local yAxis = cf.YVector
	local zAxis = cf.ZVector

	xAxis = -reflectVec(xAxis, mirrorAxis)
	yAxis =  reflectVec(yAxis, mirrorAxis)
	zAxis =  reflectVec(zAxis, mirrorAxis)

	return CFramenew(newPos.X, newPos.Y, newPos.Z,
		xAxis.X,  yAxis.X,  zAxis.X,
		xAxis.Y,  yAxis.Y,  zAxis.Y,
		xAxis.Z,  yAxis.Z,  zAxis.Z)
end

function MirrorBuild()
    local cframe = AutoBuildPreview:GetBoundingBox()

    for _, block in next, GetChildren(AutoBuildPreview) do
        if (FindFirstChild(block, "PPart")) then
            SetPrimaryPartCFrame(block, ReflectCFrame(block.PPart.CFrame, cframe))
        end
    end
end

function UpdatePreview(position)
    local cframe, size = AutoBuildPreview:GetBoundingBox()
    
    position = position or Vector3new()
    
    local NewCFrame = (position and CFramenew(cframe.Position) or cframe) * CFrameAng(rad(RotationX), rad(RotationY), rad(RotationZ)) + position

    Primary.CFrame = cframe
    Primary.Parent = AutoBuildPreview
    
    AutoBuildPreview.PrimaryPart = Primary

    SetPrimaryPartCFrame(AutoBuildPreview, NewCFrame)
    
    Primary.Parent = workspace
end

function ClearPreview()
    for i, v in next, GetChildren(AutoBuildPreview) do
        Destroy(v)
    end
end

function ListBuild(file, size)
    local jsonTable = Convert(file) or readfile(file)
    local blockInfo = Decode(jsonTable, size or 1)

    local blocksNeeded = {}
    local blocksMissing = {}

    for blockType, table in next, blockInfo do
        local NeededAmount = 0
        local MissingAmount = 0
        
        for _, block in next, table do
            if (not block.Size or block.Size == DEFAULT_BLOCK_SIZE) then
                NeededAmount = NeededAmount + 1
            else
                NeededAmount = NeededAmount + ceil(block.Size.X * block.Size.Y * block.Size.Z / 8 + .5)
            end
        end

        MissingAmount = NeededAmount - Data[blockType].Value

        blocksNeeded[blockType] = NeededAmount
        blocksMissing[blockType] = MissingAmount > 0 and MissingAmount or nil
    end

    listing:Clear()
    
    for i, v in next, blocksNeeded do
        listing:Add(i, v, blocksMissing[i])
    end
end

local function GetImageBlockInfo(blockType, Position, Size, rgba)
    return {
        Name = blockType,
        PPart = {
            CFrame = Position,
            CastShadow = false,
            CanCollide = true,
            Anchored   = true,
            Transparency = 0, --1 - rgba.Alpha,
            Color = rgba.Color,
            Size = Size
        }
    }
end

local SavedBody = nil
local SavedUrl  = nil

local function GetUrlBody(Url)
    local Body = nil
    
    if (SavedUrl ~= Url) then
        Body = request({
            Url = "http://localhost:3000/image", 
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode({url = Url})
        })["Body"]
    else
        Body = SavedBody
    end
    
    SavedBody, SavedUrl = Body, Url

    return Body
end

local function BuildImage(url, blockType, bSize, iSize, isPreview)
    local Body = GetUrlBody(url)

    iSize = iSize ~= 0 and ceil(abs(iSize)) or 1

    if (Body == "invalid") then return print("Invalid") end

    local Body = HttpService:JSONDecode(Body)

    local width, height = Body.dimensions[1], Body.dimensions[2]
    local center = GetPlot().CFrame

    local topHeight, topLenght = (5.1 + (height / iSize) * bSize), ((width / iSize) * bSize / 2)

    local Blocks = {}

    for y = 0, (height / iSize) - 1 do
        for x = 0, (width / iSize) - 1 do
            local rgba = intToRGBA(Body.pixels[((y * width) + x + 1) * iSize])

            local Position = center + Vector3new(-x * bSize + topLenght, -y * bSize + topHeight)
            local Size     =          Vector3new(bSize, bSize, bSize)

            local Transparency = 1 - rgba.Alpha
            local Color        =     rgba.Color

            if (isPreview) then
                local clonedBlock = Clone(BuildingParts[blockType]) do
                    clonedBlock.Parent              = AutoBuildPreview
                    clonedBlock.PPart.Size          = Size
                    clonedBlock.PPart.Color         = Color
                    clonedBlock.PPart.CFrame        = Position
                    clonedBlock.PPart.Anchored      = true
                    clonedBlock.PPart.CanCollide    = false
                    clonedBlock.PPart.Transparency  = Transparency
                end
            else
                insert(Blocks, GetImageBlockInfo(blockType, Position, Size, rgba))
            end
        end
    end

    if (not isPreview) then
        if (#GetChildren(AutoBuildPreview) > 0) then
            Blocks = GetPreviewBlocks()
        end

        LoadBlocks(Decode(Encode(Blocks), 1))
    end
end

local function ListImage(url, blockType)
    local Body = HttpService:JSONDecode(GetUrlBody(url))

    local Needed, Missing = #Body.pixels, #Body.pixels - Data[blockType].Value

    listing:Clear()
    listing:Add(blockType, Needed, Missing > 0 and Missing or nil)
end

--// Other Stuff
-- Autofarm
local AutofarmEnabled = false

function AutoFarm(boolean)
    AutofarmEnabled = boolean

    while AutofarmEnabled do
        Create("BodyVelocity", { Velocity = Vector3.new(0, 0, 0), Parent = LocalPlayer.Character.HumanoidRootPart })

        for i = 1, 10 do
            if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("Humanoid") then
                repeat wait() until LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
            end
     
            LocalPlayer.Character.HumanoidRootPart.CFrame = stages["CaveStage" .. i].DarknessPart.CFrame wait((i == 1 and 4 or 2) + 0.1)
            
            gold:FireServer()
        end

        LocalPlayer.Character:Remove()
 
        repeat wait() until LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    end
end

do
	local Window = library:AddWindow("Auto Builder", {
		main_color = Color3rgb(41, 74, 122),
		min_size = Vector2.new(254, 450),
		toggle_key = Enum.KeyCode.RightControl,
		can_resize = false,
	})
	
	local Main = Window:AddTab("Main")
    
    local SelectFile = nil

	do -- Elements
        local BuildSize = 1

		local Files = Main:AddDropdown("Files", function(file) SelectFile = file .. ".Build" ListBuild(SelectFile, BuildSize) end)

        local function UpdateList()
            Files:Clear()

            for _, v in next, ListBuilds() do
                Files:Add(v)
            end
        end

        UpdateList()

        Main:AddButton("Refresh Files", UpdateList)

        local FileName, SelectedTeam = nil, nil

		local Saving = Main:AddFolder("Saving") do
		    Saving:AddTextBox("File Name",   function(name) FileName = name .. ".Build" end, { ["clear"] = false })
		    Saving:AddDropdown("Team",       function(team) if (team == "My Team") then team = LocalPlayer.Team end SelectedTeam = team end):Add("My Team"):Add("white"):Add("blue"):Add("green"):Add("red"):Add("black"):Add("yellow"):Add("magenta")
		    Saving:AddButton("Save To File", function() SavePlot(FileName, SelectedTeam) UpdateList() end)
		    
		    Saving:Fold(true)
        end

        local BuildSettings = Main:AddFolder("Build Settings") do
            BuildSettings:AddSwitch("Safe Mode", function(boolean) SafeMode = boolean end)
		    BuildSettings:AddDropdown("Speed",   function(boolean) BuildSpeed = ("Dangerous" and 0) or ("Fast" and 1) or ("Slow" and 2) or ("Safe" and 3) end):Add("Dangerous"):Add("Fast"):Add("Slow"):Add("Safe")
		    BuildSettings:AddTextBox("Size %",   function(int) BuildSize = int / 100 end, { ["clear"] = false })
		    
		    BuildSettings:Fold(true)
        end
        
		local Folder = Main:AddFolder("Builder") do
    		Folder:AddButton("Preview",     function() if (#GetChildren(AutoBuildPreview) > 0) then ClearPreview() else PreviewFile(SelectFile, BuildSize) end end)
    		Folder:AddButton("Load File",   function() LoadFile(SelectFile, #GetChildren(AutoBuildPreview) > 1 and 1 or BuildSize) end)
    		
    		Folder:Fold(true)
		end
		
	end

    local Images = Window:AddTab("Images")
    
    do
        local ImageUrl  = nil
        local BlockType = nil
        local bSize, iSize = 1, 1

        Images:AddTextBox("URL", function(url) ImageUrl = url end, { ["clear"] = false })
        
        local BuildSettings = Images:AddFolder("Build Settings") do
            BuildSettings:AddTextBox("Block Size (Studs)",  function(size) bSize = tonumber(size) end, { ["clear"] = false })
            BuildSettings:AddTextBox("Image Size (Number)", function(size) iSize = tonumber(size) end, { ["clear"] = false })
            
            local blocksDrop = BuildSettings:AddDropdown("Block Type", function(blockType) BlockType = blockType end) do
                for _, block in next, GetChildren(ReplicatedStorage.BuildingParts) do
                    local name = block.Name
                    
                    if (string.sub(name, #name - 4, #name) == "Block") then
                        blocksDrop:Add(name)
                    end
                end
            end
            
            BuildSettings:Fold(true)
        end
        
        local Builder = Images:AddFolder("Builder") do
    		Builder:AddButton("Preview",     function() if (#GetChildren(AutoBuildPreview) > 0) then ClearPreview() else BuildImage(ImageUrl, BlockType, bSize, iSize, true) ListImage(ImageUrl, BlockType) end end)
    		Builder:AddButton("Load Image",   function() BuildImage(ImageUrl, BlockType, bSize, iSize, false) end)
    		
    		Builder:Fold(true)
        end
    end

    local Adjustments = Window:AddTab("Adjusters")
	
	do
        local Mult = 1;

        local PositionOff = Adjustments:AddFolder("Position Offset") do
    	    PositionOff:AddTextBox("Move Multiplier", function(float) Mult = float end, { ["clear"] = false })
    	    PositionOff:AddButton("Move Up",          function() UpdatePreview(Vector3new(0,Mult,0) ) end)
    	    PositionOff:AddButton("Move Down",        function() UpdatePreview(Vector3new(0,-Mult,0)) end)
    	    PositionOff:AddButton("Move Left",        function() UpdatePreview(Vector3new(Mult,0,0) ) end)
    	    PositionOff:AddButton("Move Right",       function() UpdatePreview(Vector3new(-Mult,0,0)) end)
    	    PositionOff:AddButton("Move Forwards",    function() UpdatePreview(Vector3new(0,0,Mult) ) end)
    	    PositionOff:AddButton("Move Backwards",   function() UpdatePreview(Vector3new(0,0,-Mult)) end)
    	    
    	    PositionOff:Fold(true)
	    end
    
        local RotationOff = Adjustments:AddFolder("Rotation Offset") do
            RotationOff:AddSlider("X", function(X) RotationX = X UpdatePreview() end, {min = 0, max = 360})
            RotationOff:AddSlider("Y", function(Y) RotationY = Y UpdatePreview() end, {min = 0, max = 360})
            RotationOff:AddSlider("Z", function(Z) RotationZ = Z UpdatePreview() end, {min = 0, max = 360})
            
            RotationOff:Fold(true)
        end

        local OtherOff = Adjustments:AddFolder("Other") do
            OtherOff:AddTextBox("Size %", function(int) 
                ClearPreview()
                PreviewFile(SelectFile, tonumber(int) / 100)
            end, { ["clear"] = false })

            OtherOff:AddButton("Mirror Build", MirrorBuild)

            OtherOff:Fold(true)
        end
	end

    local Other = Window:AddTab("Other")

    do
        local Autofarm = Other:AddFolder("Auto Farm") do
            Autofarm:AddSwitch("Enabled", AutoFarm)

            Autofarm:Fold(true)
        end
    end

	Main:Show()
	library:FormatWindows()
end