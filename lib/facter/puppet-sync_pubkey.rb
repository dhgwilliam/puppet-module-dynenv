Facter.add("puppet_sync_pubkey") do
  confine :kernel => "Linux"
  setcode do
    Facter::Util::Resolution.exec('cat /var/lib/puppet-sync/.ssh/id_rsa.pub | grep -o AAAA.*=')
  end
end

