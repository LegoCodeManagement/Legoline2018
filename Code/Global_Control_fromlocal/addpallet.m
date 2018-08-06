function addpallet(pallet,filename)
m1 = memmapfile(filename, 'Writable', true);

for i = 5:-1:1
    
    if i == 1
         m1.Data(i) = pallet;
         return
    end
    
    if m1.Data(i-1) ~= 48
        m1.Data(i) = pallet;
        return
    end
end

end