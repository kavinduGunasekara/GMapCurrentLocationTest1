import java.util.Scanner;

public class BusPunctuality {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String[] busRoutes = {"A", "B", "C", "D", "E", "F"};
        int[][][] punctualityData = new int[6][4][5];  // [Route][Week][Day]

        for (int route = 0; route < busRoutes.length; route++) {
            System.out.println("Enter punctuality data for Route " + busRoutes[route] + ":");
            for (int week = 0; week < 4; week++) {
                for (int day = 0; day < 5; day++) {
                    while (true) {
                        try {
                            System.out.print("Enter punctuality for Week " + (week + 1) + ", Day " + (day + 1) + ": ");
                            punctualityData[route][week][day] = scanner.nextInt();
                            break;
                        } catch (Exception e) {
                            System.out.println("Invalid input. Please enter a valid number of minutes.");
                            scanner.nextLine();  // Clear the input buffer
                        }
                    }
                }
            }
        }

        // Printing the entered punctuality data
        for (int route = 0; route < busRoutes.length; route++) {
            System.out.println("Punctuality data for Route " + busRoutes[route] + ":");
            for (int week = 0; week < 4; week++) {
                System.out.print("Week " + (week + 1) + ": ");
                for (int day = 0; day < 5; day++) {
                    System.out.print(punctualityData[route][week][day] + " ");
                }
                System.out.println();
            }
        }
    }
}
