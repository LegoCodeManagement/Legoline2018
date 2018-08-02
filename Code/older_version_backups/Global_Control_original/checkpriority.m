function result = checkpriority(pallet1,pallet2)
%returns 1 if pallet1 has priority over pallet2,
%returns 0 if pallet2 has priority over pallet1.
priority = memmapfile('priority.txt', 'Writable', true);

result = find((priority.Data == pallet1) == 1) < find((priority.Data == pallet2) == 1);
end