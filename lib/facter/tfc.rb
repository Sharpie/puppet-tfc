Facter.add(:tfc) do
  setcode do
    result = {}

    if (path = Facter::Core::Execution.which('terraform'))
      tf_version = Facter::Core::Execution.execute("#{path} version").match(/(\d+\.\d+\.\d+)/)

      if tf_version
        result[:path] = path
        result[:version] = tf_version.captures.first
      end
    end

    result
  end
end
