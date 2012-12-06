# puppet_user.rb

Facter.add("puppet_user") do
  setcode do
    Facter::Util::Resolution.exec('puppet master --configprint user')
  end
end
