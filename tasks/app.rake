namespace :app do
  desc 'Run the dependency update cycle.'
  task :update_dependencies do
    # update every version
    BoxesMonitor.dependencies.each do |k, v|
      v.each do |ea|
        versions = BoxesMonitor::VersionScraper.run(k.to_sym, ea)

        # build up the tool name, with a special case for GitHub repos
        if k == 'github'
          tool_name = "#{ea}"
        else
          tool_name = "#{k.capitalize} #{ea.capitalize}"
        end

        tool = Tool.find_or_initialize_by name: tool_name
        puts "Added new tool: #{tool_name}" if tool.new_record?
        tool.save!

        versions.each do |version|
          existing = tool.versions.find_by_version version[:version]
          unless existing
            Version.create Hash[tool: tool].merge version

            puts "Added new version: #{tool.name} #{version[:version]}"
          end
        end
      end
    end

    # run the notifications
  end
end
