require 'foreman/export'
require 'foreman/cli'

class Foreman::Export::God < Foreman::Export::Base
  def export
    error("Must specify a location") unless location
    FileUtils.mkdir_p location

    app = self.app || File.basename(engine.directory)

    base_template = export_template(self.options[:template] ? self.options[:template] : File.join(template_root, 'base.god.erb'))
    base_config   = ERB.new(base_template).result(binding)

    write_file(File.join(location, "#{app}.god"), base_config)
  end

  def extension(process_name)
    if extensions.has_key?(process_name)
      ERB.new(extension_template(process_name)).result(binding)
    else
      ''
    end
  end

  private
  def template_root
    root = nil
    if self.options[:template]
      root = self.options[:template].split('/')
      root.delete_at(root.count-1)
      root = root.join '/'
    else
      root = File.expand_path('../../../../data/templates', __FILE__)
    end
    root
  end

  def extension_template(name)
    IO.read(extensions[name])
  end

  def extensions
    @extensions = load_extensions
  end

  def load_extensions
    h = {}
    Dir.glob(File.join(template_root, 'extensions',"*.erb")).each do |extension_path|
      extension_name = extension_path.split("/").last.match(/(.*?).god.erb$/)[1]
      h[extension_name] = extension_path
    end
    h
  end
end
