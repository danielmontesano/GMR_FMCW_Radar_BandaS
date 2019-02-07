function [buffer_out,packets, crc_errors] = packet_decode(buffer_in)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
HEADER_SIZE = 8;
decode_iterator = 1;
crc_errors = 0;
packets = [];
buffer_out = [];
while decode_iterator + HEADER_SIZE <= length(buffer_in)
    header = buffer_in(decode_iterator)*256; decode_iterator = decode_iterator + 1;
    header = header + buffer_in(decode_iterator); decode_iterator = decode_iterator + 1;
    if header == 65530
        seq_num = buffer_in(decode_iterator); decode_iterator = decode_iterator + 1;
        seq_num = bitor(seq_num, bitshift(buffer_in(decode_iterator), 8)); decode_iterator = decode_iterator + 1;
        len = buffer_in(decode_iterator); decode_iterator = decode_iterator + 1;
        len = bitor(len, bitshift(buffer_in(decode_iterator), 8)); decode_iterator = decode_iterator + 1;
        crc = buffer_in(decode_iterator); decode_iterator = decode_iterator + 1;
        crc = bitor(crc, bitshift(buffer_in(decode_iterator), 8)); decode_iterator = decode_iterator + 1;
        
        if decode_iterator + len > length(buffer_in)
            decode_iterator = decode_iterator - HEADER_SIZE;
            break;
        end
        data = buffer_in(decode_iterator:decode_iterator+len-1);
        if crc == crc_mex(uint8(data)') %row vector of uint8 expected
            new_packet.sequence_num = seq_num;
            new_packet.header = buffer_in(decode_iterator - HEADER_SIZE:decode_iterator);
            new_packet.length = len;
            new_packet.data = data(2:2:end)*256 + data(1:2:end);
            packets = [packets, new_packet];
            decode_iterator = decode_iterator + len;
            continue;
        else
            decode_iterator = decode_iterator - (HEADER_SIZE - 1);
            crc_errors = crc_errors + 1;
            fprintf("ERROR: %d\n", crc_errors);
%             fprintf("%s != %s\n", dec2hex(crc), dec2hex(calculate_crc(buffer_in(decode_iterator:decode_iterator+len-1))));
        end
    else
        decode_iterator = decode_iterator - 1;
    end
end

if decode_iterator < length(buffer_in)
    if decode_iterator > 1
        buffer_in = buffer_in(decode_iterator:end);
    end
end
buffer_out = buffer_in;
end


