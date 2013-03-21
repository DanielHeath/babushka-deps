class ConfigFile
  include Babushka::ShellHelpers
  extend Babushka::ShellHelpers

  def initialize(args={})
    @args = args
  end

  def source
    @source ||= get_source
  end

  def get_source
    @args[:content] || @args[:src].p.read
  end

  def current?
    shell?("diff -qs /dev/stdin #{@args[:dest].p}", :input=>source, :sudo=>@args[:sudo])
  end

  def update
    shell("tee #{@args[:dest].p}", :input=>source, :sudo=>@args[:sudo])
  end

  def mode
    File.stat(@args[:dest].p).mode
  end

  def mode=(mode)
    if @args[:sudo]
      sudo "chmod #{sprintf "%o", mode} #{@args[:dest].p}"
    else
      File.chmod(mode, @args[:dest].p)
    end
  end

end

meta :config_file do
  accepts_value_for :src
  accepts_value_for :dest
  accepts_value_for :sudo, false
  accepts_value_for :content
  accepts_value_for :mode

  template {
    def config
      @config ||= ConfigFile.new(
        :dest => dest,
        :src => src,
        :sudo => sudo,
        :content => content
      )
    end
    met? {
      ret = config.current?
      if mode
        ret &&= (config.mode & 0777)== mode
      end
      ret
    }
    meet {
      config.update
      if mode
        config.mode = mode
      end
    }
  }
end

