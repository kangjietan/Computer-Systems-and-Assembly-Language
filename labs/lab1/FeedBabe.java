public class FeedBabe {
    public static void main(String args[]) {
        for (int i = 1; i <= 500; i++) {
            if (i % 3 == 0 && i % 4 != 0) {
                System.out.println("FEED");
            } 
            else if (i % 4 == 0 && i % 3 != 0) {
                System.out.println("BABE");
            } 
            else if (i % 3 == 0 && i % 4 == 0) {
                System.out.println("FEEDBABE");
            } 
            else {
                System.out.println(i);
            }
        }
    }
}