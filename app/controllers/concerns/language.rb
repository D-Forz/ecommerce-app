module Language
  extend ActiveSupport::Concern

  included do
    around_action :switch_locale

    def switch_locale(&)
      locale = params[:locale] || I18n.default_locale
      I18n.with_locale(locale, &)
    end
  end
end
