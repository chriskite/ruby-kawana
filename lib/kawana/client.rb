require 'socket'
require 'ipaddr'

module Kawana
  class Client

    #
    # +addr+ is a string remote address, e.g. <tt>'localhost'</tt> or <tt>'127.0.0.1'</tt>
    #
    def initialize(addr, port = 9291)
      @addr = addr
      @port = port
    end

    #
    # Whitelist +ip+ in the Kawana server.
    # +ip+ must be of type *IPAddr*, e.g. <tt>IPAddr.new('127.0.0.1')</tt>
    # Raises an exception if an error occurs, otherwise returns nil if successful.
    #
    def whitelist(ip)
      black_white_cmd(ip, 1)
    end

    #
    # Un-whitelist +ip+ in the Kawana server.
    # +ip+ must be of type *IPAddr*, e.g. <tt>IPAddr.new('127.0.0.1')</tt>
    # Raises an exception if an error occurs, otherwise returns nil if successful.
    #
    def unwhitelist(ip)
      black_white_cmd(ip, 2)
    end

    #
    # Blacklist +ip+ in the Kawana server.
    # +ip+ must be of type *IPAddr*, e.g. <tt>IPAddr.new('127.0.0.1')</tt>
    # Raises an exception if an error occurs, otherwise returns nil if successful.
    #
    def blacklist(ip)
      black_white_cmd(ip, 3)
    end

    #
    # Un-blacklist +ip+ in the Kawana server.
    # +ip+ must be of type *IPAddr*, e.g. <tt>IPAddr.new('127.0.0.1')</tt>
    # Raises an exception if an error occurs, otherwise returns nil if successful.
    #
    def unblacklist(ip)
      black_white_cmd(ip, 4)
    end

    private

    def black_white_cmd(ip, modifier)
      if !ip.is_a?(IPAddr)
        raise ArgumentError.new("ip must be of type IPAddr")
      end

      bytes = [
        0x03, # BlackWhite command byte
        ip.to_i,
        modifier # BlackWhite modifier byte
      ].pack("CVC")
      
      send_and_recv bytes
      nil
    end

    def send_and_recv(bytes)
      s = TCPSocket.new @addr, @port
      s.send bytes, 0
      resp = s.recv 15 # kawana response is 15 bytes
      puts resp.unpack("V3SC").inspect
      s.close
    end

  end
end
