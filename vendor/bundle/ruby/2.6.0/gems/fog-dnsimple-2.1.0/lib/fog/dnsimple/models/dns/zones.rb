require 'fog/core/collection'
require 'fog/dnsimple/models/dns/zone'

module Fog
  module DNS
    class Dnsimple
      class Zones < Fog::Collection
        model Fog::DNS::Dnsimple::Zone

        def all
          clear
          data = service.list_domains.body["data"]
          load(data)
        end

        def get(zone_id)
          data = service.get_domain(zone_id).body["data"]
          new(data)
        rescue Excon::Errors::NotFound
          nil
        end
      end
    end
  end
end
