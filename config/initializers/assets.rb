# frozen_string_literal: true

Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.paths << Rails.root.join('node_modules')
Rails.application.config.assets.precompile += %w[edit_user.js]
Rails.application.config.assets.precompile += %w[edit_product.js]
