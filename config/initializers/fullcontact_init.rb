require 'fullcontact'

FullContact.configure do |config|
    config.api_key = ENV["fullcontact_api_key"]
end

FullContact::Client::Person.module_eval do
      # Returns extended information for a given person (email, phone, twitter or facebook)

      def person(options={}, faraday_options={})
        if options.is_a?(String)
          raise ArgumentError, "Supplying an email address directly is not supported. Please use {email: #{options}} instead."
        end

        if options.has_key?(:facebookUsername) || options.has_key?(:facebookId)
          raise ArgumentError, "Querying by Facebook ID or username is no longer supported. Please contact support@fullcontact.com for more information."
        end

        cached_person = CachedPerson.look_up_email(options[:email])

        if cached_person.nil?
          response = get('person', options, false, faraday_options)
          final_response = (format.to_s.downcase == 'xml') ? response['person'] : response
          CachedPerson.create_new_person(options[:email], final_response)
        else
          cached_person.data
        end

      end
end