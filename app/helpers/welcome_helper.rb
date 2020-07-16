module WelcomeHelper
    def greet
        case Time.now.hour
        when 1..11 then 'Good morning,'
        when 12..17 then 'Good afternoon,'
        when 18..24 then 'Good evening,'
        else
          'Hello,'
        end
    end
end
