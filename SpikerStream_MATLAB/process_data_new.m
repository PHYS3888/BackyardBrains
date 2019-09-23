function out = process_data_new(in)

flag_in = find(in>127);
out = (uint16(bitand(uint8(in(flag_in)),127)).*128);
out = out + uint16((in(flag_in+1)));
