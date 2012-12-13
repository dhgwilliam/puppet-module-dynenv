Facter.add("puppet_sync_pubkey") do
  confine :kernel => "Linux"
  setcode do
    Facter::Util::Resolution.exec(
      '
      if [ -e "/var/lib/puppet-sync/.ssh/id_rsa.pub" ]
      then
        cat /var/lib/puppet-sync/.ssh/id_rsa.pub | grep -o AAAA.*=
      fi
      '
    )
  end
end

