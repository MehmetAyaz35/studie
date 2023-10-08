package day10_nestedIfStatement;

public class DaysInWeek {
    public static void main(String[] args) {

        int number = 7;

        if (number>=1 && number<=7){
            if (number==1){
                System.out.println("Monday");
            } else if (number==2) {
                System.out.println("Tuesday");
            } else if (number==3) {
                System.out.println("Wednesday");
            } else if (number==4) {
                System.out.println("Thursday");
            } else if (number==5) {
                System.out.println("Friday");
            } else if (number==6) {
                System.out.println("Saturday");
            }else{
                System.out.println("Sunday");
            }

        }else{
            System.out.println("invalid number");
        }

        System.out.println("----------------------"); //you can do it as a below line

        //int number = 7;   **I didn't write it again because it was written above**
        String result = "";

        if (number>=1 && number<=7){
            if (number==1){
                result = "Monday";
            } else if (number==2) {
                result = "Tuesday";
            } else if (number==3) {
                result ="Wednesday";
            } else if (number==4) {
                result = "Thursday";
            } else if (number==5) {
                result = "Friday";
            } else if (number==6) {
                result = "Saturday";
            }else{
                result = "Sunday";
            }

        }else{
            result = "invalid number";
        }

        System.out.println(result);





    }
}
