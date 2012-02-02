require 'foreman/export'
require 'foreman/cli'

class Foreman::Export::God < Foreman::Export::Base
  def export
    error("Must specify a location") unless location
    FileUtils.mkdir_p location

    app = self.app || File.basename(engine.directory)

    base_config   = ERB.new(base_template).result(binding)

    write_file(File.join(location, "#{app}.god"), base_config)
  end

  def extension(process_name)
    if extensions.has_key?(process_name)
      ERB.new(extension_template(process_name)).result(binding)
    else
      ""
    end
  end

  private
  def template_path
    Pathname.new(File.dirname(__FILE__)).join('..', '..', '..', 'data', 'templates')
  end

  def base_template
    IO.read(base_template_path)
  end

  def base_template_path
    base_template = File.join(template_path, "base.god.erb")
  end

  def extension_template(name)
    IO.read(extensions[name])
  end

  def extensions
    @extensions = load_extensions
  end

  def load_extensions
    h = {}
    Dir.glob(template_path.join('extensions') + "*.erb").each do |extension_path|
      extension_name = extension_path.split("/").last.match(/(.*?).god.erb$/)[1]
      h[extension_name] = extension_path
    end
    h
  end
end
