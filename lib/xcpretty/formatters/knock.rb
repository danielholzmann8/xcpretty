module XCPretty

  class Knock < Formatter

    FAIL = 'not ok'
    PASS = 'ok'

    def format_passing_test(suite, test_case, device, time)
      "#{PASS} - #{format_test_description(test_case, device)}"
    end

    def format_failing_test(test_suite, test_case, device, reason, file)
      knock_result =
      "#{FAIL} - #{format_test_description(test_case, device)}: FAILED"
      if reason.nil? || reason.empty? || file.nil? || file.empty?
        return knock_result
      end
      knock_result +
      format_failure_diagnostics(test_suite, test_case, reason, file)
    end

    def format_test_summary(executed_message, failures_per_suite)
      ''
    end

    def format_failure_diagnostics(test_suite, test_case, reason, file)
      format_diagnostics(reason) +
      format_diagnostics("  #{file}: #{test_suite} - #{test_case}")
    end

    private

    def format_diagnostics(text)
      "\n# #{text}"
    end

    def format_test_description(test_case, device)
      if device.nil? || device.empty?
        test_case
      else
        "#{test_case} on #{device}"
      end
    end

  end

end

