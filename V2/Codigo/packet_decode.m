function [buffer_out,packets,crc_errors] = packet_decode(buffer_in)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
HEADER_SIZE = 10;
decode_iterator = 1;
crc_errors = 0;
min_packet_size = HEADER_SIZE + 2*1600;
max_packets = floor(length(buffer_in)/min_packet_size);
packets = struct('sequence_num', cell(1, max_packets), 'header', cell(1, max_packets),...
                    'length', cell(1, max_packets),'data_i', cell(1, max_packets),'data_q', cell(1, max_packets));
buffer_out = [];
packets_rcv = 0;
while decode_iterator + HEADER_SIZE <= length(buffer_in)
    header = buffer_in(decode_iterator)*256; decode_iterator = decode_iterator + 1;
    header = header + buffer_in(decode_iterator); decode_iterator = decode_iterator + 1;
    if header == 65530
        seq_num = buffer_in(decode_iterator); decode_iterator = decode_iterator + 1;
        seq_num = seq_num + buffer_in(decode_iterator)*256; decode_iterator = decode_iterator + 1;
        len = buffer_in(decode_iterator); decode_iterator = decode_iterator + 1;
        len = len + buffer_in(decode_iterator)*256; decode_iterator = decode_iterator + 1;
        
        crc = buffer_in(decode_iterator); decode_iterator = decode_iterator + 1;
        crc = crc + buffer_in(decode_iterator)*256; decode_iterator = decode_iterator + 1;
        crc = crc + buffer_in(decode_iterator)*65536; decode_iterator = decode_iterator + 1;
        crc = crc + buffer_in(decode_iterator)*16777216; decode_iterator = decode_iterator + 1;
%         crc
        if decode_iterator + len > length(buffer_in)
            decode_iterator = decode_iterator - HEADER_SIZE;
            break;
        end
        data = buffer_in(decode_iterator:decode_iterator+len-1);
        if crc == crc_mex32(uint8(data)') %row vector of uint8 expected
            new_packet.sequence_num = seq_num;
            new_packet.header = buffer_in(decode_iterator - HEADER_SIZE:decode_iterator-1);
            new_packet.length = len;
            data_iq = data(2:2:end)*256 + data(1:2:end);
            new_packet.data_i = data_iq(1:2:end);
            new_packet.data_q = data_iq(2:2:end);
            packets_rcv = packets_rcv + 1;
            packets(packets_rcv) = new_packet;
            decode_iterator = decode_iterator + len;
            continue;
        else
            decode_iterator = decode_iterator - (HEADER_SIZE - 1);
            crc_errors = crc_errors + 1;
%             fprintf("ERROR: %d\n", crc_errors);
%             fprintf("%s != %s\n", dec2hex(crc), dec2hex(crc_mex32(uint8(data)')));
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
packets = packets(1:packets_rcv);
buffer_out = buffer_in;
end


