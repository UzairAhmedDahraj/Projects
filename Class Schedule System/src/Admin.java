import java.util.Scanner;

public class Admin {
    Scanner sc = new Scanner(System.in);
    RoomNew[] NewRooms = new RoomNew[5];
    int Count = 0;
    int RoomCount = 0;
    int RoomLowerBound = 0;
    String[] Rooms = new String[10];
    static String[] availableSubjects = {"FOP", "OOP", "ICT", "PHYSICS", "BUSINESS", "ACCOUNTS", "MARKETING"};
    public static String[] Name = new String[11];
    public int[] ID = new int[11];
    String[] TeacherSubjects = new String[11];
    String[] Timings = new String[11];
    static int Teachers = 0;
    int IDAssign = 1;

    public void BinarySearch() {
        System.out.print("Enter ID To Search For A Record: ");
        int Key = sc.nextInt();
        int UpperBound = Teachers;
        int LowerBound = 0;
        int Flag = -1;
        int Location = 0;
        while (LowerBound <= UpperBound) { //Keep repeating until LowerBound == UpperBound.
            int MidPoint = LowerBound + (UpperBound - LowerBound) / 2; //Get MidPoint Index.
            if (ID[MidPoint] == Key) { //If Key to be searched is the MidPoint Element.
                Flag = ID[MidPoint];
                Location = MidPoint;
            }
            if (ID[MidPoint] < Key) { //If Element is less than MidPoint Element,

                LowerBound = MidPoint + 1; //Search the left side of MidPoint.
            } else {
                UpperBound = MidPoint - 1; //If Element is greater than MidPoint Element,
                //Search the right side of MidPoint.
            }
        }
        if (Flag > -1) {
            System.out.println("Teacher's Name: " + Name[Location]);
            System.out.println("Teacher's Subject: " + TeacherSubjects[Location]);
            System.out.println("Teacher's Room: " + Rooms[Location]);
            System.out.println("Teacher's Timing: " + Timings[Location]);
        } else {
            System.out.println("No Record Found.");
        }
    }

    public void chooseSubject() {
        System.out.println("--CHOOSE TEACHER'S SUBJECT--");
        int SNO = 1;
        for (int i = 0; i < availableSubjects.length; i++) {
            System.out.println(SNO + ")" + availableSubjects[i]);
            SNO++;
        }
        System.out.print("Enter Subject: ");
        int choose = sc.nextInt();
        choose = choose - 1;
        TeacherSubjects[Count] = availableSubjects[choose];
    }

    public void DisplayDetails() {
        System.out.println("----TEACHER'S ID--------NAME--------SUBJECT---------TIMINGS---------------ROOM#------------------------");
        for (int i = 0; i < Count; i++) {
            System.out.println("        " + ID[i] + "            " + Name[i] + "         " + TeacherSubjects[i] + "           " + Timings[i] + "              " + Rooms[i]);
            System.out.println("-------------------------------------------------------------------------------------------------------");
        }
    }

    public void Schedule_Class() {
        char Choice = 'Y';
        do {
            if (Teachers == 9) {
                System.out.println("Cannot Add More Teachers.");
            } else {
                System.out.print("ENTER NAME OF TEACHER: ");
                Name[Teachers] = sc.next();
                ID[Teachers] = IDAssign;
                System.out.println("Teacher's Identification Number is: " + ID[Teachers]);
                chooseSubject();
                ChooseRoom();
                Teachers++;
                IDAssign++;
                Count++;
                System.out.print("Do You Want Add Another Teacher (Y/N)?: ");
                Choice = sc.next().charAt(0);
            }
        } while (Choice == 'Y' || Choice == 'y');
    }

    public void DeleteRecord() { //Deleting A Record & Then Adjusting Total Indexes Of Array.
        if (Teachers > 0) {
            System.out.println("Please Enter The ID For The Record You Want To Delete: ");
            int input = sc.nextInt();

            for (int i = 0; i < Teachers; i++) {
                if (input == ID[i]) {
                    System.out.println("Teacher's Record Found, Proceeding To Delete.");
                    for (int j = i; j < Teachers; j++) { //Iterate Next Records Backwards
                        ID[j] = ID[j + 1];
                        Name[j] = Name[j + 1];
                        TeacherSubjects[j] = TeacherSubjects[j + 1];
                        Rooms[j] = Rooms[j + 1];
                        Timings[j] = Timings[j + 1];
                    }
                    Teachers--; //So that next record should be added on the index deleted.
                    Count--;

                    System.out.println("Record Deleted For The Following ID: (" + input + ")");
                }
            }
        } else {
            System.out.println("No Records Available To Delete.");
        }
    }

    public void InitialiseRooms() {
        if (RoomCount < 1) {
            NewRooms[0] = new RoomNew();
            NewRooms[1] = new RoomNew();
            NewRooms[2] = new RoomNew();
            NewRooms[3] = new RoomNew();
            NewRooms[4] = new RoomNew();
            NewRooms[0].RoomNo = "ROOM 1";
            NewRooms[1].RoomNo = "ROOM 2";
            NewRooms[2].RoomNo = "ROOM 3";
            NewRooms[3].RoomNo = "ROOM 4";
            NewRooms[4].RoomNo = "ROOM 5";
            RoomCount = 5;
        }
    }

    public void ChooseRoom() {
        InitialiseRooms();
        if (RoomCount > 1) {
            int SNO = 1;
            System.out.println("--------Rooms---------");
            for (int i = RoomLowerBound; i < RoomCount; i++) {
                System.out.println(SNO + ")" + NewRooms[i].RoomNo);
                SNO++;
            }
            System.out.print("Enter Room No: ");
            int input1 = sc.nextInt();
            input1 = input1 - 1;
            if (!isRoomFull(input1)) {
                Rooms[Count] = NewRooms[input1].RoomNo;
                System.out.println("Room Success.");
                System.out.println("--------Timings---------");
                SNO = 1;
                for (int i = 0; i < 4; i++) {
                    System.out.println(SNO + ")" + NewRooms[input1].RoomTimings[i]);
                    SNO++;
                }
                System.out.print("Enter Timing For " + NewRooms[input1].RoomNo + " :");
                int input2 = sc.nextInt();
                input2 = input2 - 1;
                while (NewRooms[input1].RoomTimings[input2].equals("RESERVED")) {
                    System.out.println("This Timing Is Already Reserved.");
                    System.out.print("Enter Timing Again: ");
                    input2 = sc.nextInt();
                    input2 = input2 - 1; // since index start from 0 but Serial # is 1,2,3,4 so input - 1 to match index element.
                }
                Timings[Count] = NewRooms[input1].RoomTimings[input2];
                NewRooms[input1].RoomTimings[input2] = "RESERVED";
                System.out.println("Timing Success");
            }
        }
    }

    public boolean isRoomFull(int RoomNo) {
        int Count = 0;
        for (int i = 0; i < 4; i++) {
            if (NewRooms[RoomNo].RoomTimings[i].equals("RESERVED")) {
                Count++;
            }
        }
        if (Count == 4) {
            System.out.println("THIS ROOM IS FULLY RESERVED!");
            int ROOM = RoomNo;
            ROOM += 1;
            NewRooms[RoomNo].RoomNo = "ROOM " + ROOM + " (FULL)";
            if (NewRooms[RoomNo].RoomNo.equals("ROOM " + RoomNo + " (FULL)")) {
                RoomLowerBound++;
            }
            ChooseRoom();
            return true;
        }
        return false;
    }

    public void AvailableRooms() {
        int SNO = 1;
        System.out.println("--------Rooms---------");
        for (int i = RoomLowerBound; i < RoomCount; i++) {
            System.out.println(SNO + ")" + NewRooms[i].RoomNo);
            SNO++;
        }
    }

}