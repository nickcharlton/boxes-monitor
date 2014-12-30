module BoxesMonitor
  module Strategies
    class Ubuntu < Base
      def run(distro)
        url = "http://releases.ubuntu.com/#{distro}"
        response = @client.get "#{url}/SHA256SUMS"
        doc = response.body

        # pull out the versions relevant to us
        lines = doc.split(/\n/).map do |m|
          m if m.match(/server-amd64\.iso/)
        end.compact

        # assemble the versions into a structure
        versions = lines.map do |m|
          checksum, file_string = m.split(' ')
          # file_string ~= '*ubuntu-14.04.1-server-amd64.iso'
          version = file_string.scan(/[0-9.]*(?=-)/)[1]
          iso = file_string.gsub('*', '')

          { checksum: checksum, iso_url: "#{url}/#{iso}", version: version }
        end

        # the last one is the most recent
        versions.last
      end
    end
  end
end
