module WelcomeHelper
    def greet
        case Time.now.hour
        when 0..4 then 'Good evening,'
        when 5..11 then 'Good morning,'
        when 12..17 then 'Good afternoon,'
        when 18..24 then 'Good evening,'
        else
          'Hello,'
        end
    end
end