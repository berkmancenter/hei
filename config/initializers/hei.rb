Hei::Application.config.hei = YAML.load_file( Rails.root.join( 'config', 'hei.yml' ) )[Rails.env]

