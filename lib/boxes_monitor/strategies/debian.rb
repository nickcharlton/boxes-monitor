module BoxesMonitor
  module Strategies
    class Debian < Base
      def run(distro)
        host = 'http://cdimage.debian.org/cdimage'
        if distro == 'current'
          url = "#{host}/release/current/amd64/iso-cd"
        elsif distro == 'oldstable'
          url = "#{host}/archive/latest-oldstable/amd64/iso-cd"
        else
          url = "#{host}/archive/#{distro}/amd64/iso-cd"
        end

        response = @client.get "#{url}/SHA256SUMS"
        doc = response.body

        # pull out the versions relevant to us
        lines = doc.split(/\n/).map do |m|
          m if m.match(/amd64-netinst\.iso/)
        end.compact

        # assemble the versions into a structure
        versions = lines.map do |m|
          checksum, file = m.split(' ')
          # file ~= 'debian-7.8.0-amd64-netinst.iso'
          version = file.scan(/[0-9.]*(?=-)/)[1]

          { checksum: checksum, iso_url: "#{url}/#{file}", version: version }
        end

        versions
      end
    end
  end
end
