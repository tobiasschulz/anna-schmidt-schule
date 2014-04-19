import javax.swing.SwingUtilities;
import javax.swing.JFrame;
import java.awt.Graphics;
import java.awt.Color;
import java.util.ArrayList;
import java.util.Random;

public class Berge extends JFrame {
    
    public Integer count = 0;
    public ArrayList<Integer> kette = new ArrayList<Integer>();
    
    public void setCount(Integer c) {
        count = c;
    }
    
    public Integer getCount() {
        return count;
    }
    
    public void addBerg(String berg) {
        kette.add(Integer.valueOf(berg));
    }
    
    public void setKette(ArrayList<Integer> k) {
        kette = k;
    }
    
    public ArrayList<Integer> getKette() {
        return kette;
    }
    
    public static void main(final String[] args) {
        Berge berge = new Berge();
        berge.create(args);
    }
    
    /*
        Fenster oeffnen
    */
    private void create(final String[] args) {
        this.setTitle("Berge");
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.setSize(800,600);
        if (args.length > 1 ) {
            for (String height : args) {
                this.addBerg(height);
            }
            this.setCount(args.length);
        }
        else if (args.length == 1) {
            this.setKette(generiereGebirgszug(Integer.valueOf(args[0])));
            this.setCount(Integer.valueOf(args[0]));
        }
        this.setVisible(true);
    }
    
    public ArrayList<Integer> generiereGebirgszug(Integer length) {
        ArrayList<Integer> zug = new ArrayList<Integer>();
        
        Random random = new java.util.Random();
        
        zug.add(0);
        int position = 1;
        int lastHeight = 0;
        while (position < length - 1) {
            if ( (random.nextInt(2) == 0 || length - 1 - position - 1 <= lastHeight) ) {
                if ( lastHeight > 1 ) {
                    lastHeight -= 1;
                }
            }
            else {
                lastHeight += 1;
            }
            zug.add(lastHeight);
            position += 1;
        }
        zug.add(0);
        
        return zug;
    }
    
    /*
        Gebirgszug zeichnen
    */
    public void paint(Graphics g) {
        System.out.println("Zeichne " + getCount() + " Berge...");
        
        g.clearRect(0, 0, getWidth(), getHeight());
        
        int biggest = 0;
        for (Integer height : getKette()) {
            if ( height > biggest ) biggest = height;
        }

        int row = 0;
        int rowstep = getWidth() / (getCount() - 1);
        int lastX = 0;
        int lastY = 0;
        
        for (Integer height : getKette()) {
            height *= getHeight();
            height /= biggest + 2;
            
            g.setColor(Color.BLACK);
            g.drawLine(lastX, getHeight() - lastY, row, getHeight() - height); 
            g.setColor(Color.BLUE);
            g.drawLine(row, 0, row, getHeight()); 
            
            lastX = row;
            lastY = height;
            row += rowstep;
        }
    }
}
