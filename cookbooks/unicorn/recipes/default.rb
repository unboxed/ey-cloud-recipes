if ['app_master', 'app', 'solo'].include?(node[:instance_role])

  # we only want one.. so just overwrite it
  node[:applications].each do |app, data|
    template "/data/custom_unicorn.rb"do
      source 'custom_unicorn.rb.erb'
      owner node[:owner_name]
      group node[:owner_name]
      mode 0655
      backup 0
      variables({
        :app => app
      })
    end
  end

end
