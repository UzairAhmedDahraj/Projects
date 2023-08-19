import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Admin admin = new Admin();


        while (true) {
            String CYAN_BRIGHT = "\033[0;96m";
            System.out.println(CYAN_BRIGHT);
            System.out.println("-------------------------------------");
            System.out.println("|WELCOME TO CLASS SCHEDULE SYSTEM   |");
            System.out.println("|----------------MENU---------------|");
            System.out.println("Enter 1 To Login: ");
            System.out.println("Enter 2 To Exit: ");
            Scanner sc = new Scanner(System.in);
            char option = sc.next().charAt(0);
            if (option == '1' || option == '2' || option == '3' || option == '4') {
                switch (option) {
                    case '1': {
                        System.out.println("PRESS-'A' TO SCHEDULE A NEW CLASS:");
                        System.out.println("PRESS-'B' TO REMOVE A TEACHER RECORD:");
                        System.out.println("PRESS 'C' TO DISPLAY TOTAL RECORD:");
                        System.out.println("PRESS-'D' TO SEARCH A RECORD:");
                        System.out.println("PRESS-'E' TO DISPLAY ALL ROOMS: ");

                        char adminLogin = sc.next().charAt(0);
                        if (adminLogin == 'a' || adminLogin == 'b' || adminLogin == 'c' || adminLogin == 'd' || adminLogin == 'e' || adminLogin == 'f' || adminLogin == 'g' || adminLogin == 'h' || adminLogin == 'i' || adminLogin == 'j')

                            switch (adminLogin) {
                                case 'a': {
                                    admin.Schedule_Class();
                                }
                                break;
                                case 'b': {
                                    admin.DeleteRecord();
                                }
                                break;
                                case 'c': {
                                    admin.DisplayDetails();
                                }
                                break;
                                case 'd': {
                                    admin.BinarySearch();
                                }
                                break;
                                case 'e': {
                                    admin.InitialiseRooms();
                                    admin.AvailableRooms();
                                }
                                break;
                                case 'f': {
                                    System.out.println("TOTAL TEACHERS ARE " + admin.Count);
                                }
                                break;

                            }
                        break;

                    }
                    case '2':
                        System.out.println("Closing Program.");
                }
            }
        }
    }
}