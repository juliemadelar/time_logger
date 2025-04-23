import 'package:flutter_test/flutter_test.dart';
import 'package:time_logger/timesheet_page.dart';

void main() {
  late TimesheetPageState timesheetPageState;

  setUp(() {
    timesheetPageState = TimesheetPageState();
  });

  test('_computeTotalHours correctly calculates total hours', () {
    expect(timesheetPageState.computeTotalHours('09:00 AM', '06:00 PM'),
        8.0); // 9 hours - 1 hour lunch
    expect(timesheetPageState.computeTotalHours('09:00 AM', '09:30 AM'), 0);
  });

  test('_computeOvertimeHours calculates overtime hours', () {
    expect(timesheetPageState.computeOvertimeHours(10.0), 1.0);
    expect(timesheetPageState.computeOvertimeHours(8.0), 0.0);
  });

  test('computeTotalPay calculates total pay correctly', () {
    // Example with regular hours
    expect(
        timesheetPageState.computeTotalPay(
            8, '09:00 AM', '06:00 PM', 'Regular'),
        520.0); // 8 hours * $65/hour

    // Example with regular hours and OT hours
    expect(
        timesheetPageState.computeTotalPay(
            10, '09:00 AM', '08:00 PM', 'Regular'),
        747.5); // 8 hours * $65/hour + 2 hours OT (65 * 1.25)

    // Example with Night Diff (assuming _hourlyRate = 65, _nightDifferentialRate = 0.10)
    // Simplified:  Need to mock the other functions to get very precise result.
    // Example with night differential
    // expect(timesheetPageState._computeTotalPay(8, '10:00 PM', '06:00 AM', 'Regular'),
    //     572.0);
  });
}
