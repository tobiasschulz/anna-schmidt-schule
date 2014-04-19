import javax.swing.*;
import java.awt.*;
import java.util.ArrayList;
import java.util.Random;
import java.awt.event.*;

class Zutat implements ItemListener {
    String name;
    Image img;
    boolean aufPizza;
    JCheckBox box;
    Pizza pizza;
    
    public Zutat(String name, Image img, boolean aufPizza) {
        this.name = name;
        this.img  = img;
        this.aufPizza = aufPizza;
    }
    
    public void itemStateChanged(ItemEvent e) {
        aufPizza = !aufPizza;
        pizza.repaint();
    }
}

class Bestellung extends JFrame {
    public ArrayList<Zutat> zutaten = new ArrayList<Zutat>();
    
    public void neuePizza(Pizza pizza) {
        JPanel group = new JPanel(new GridLayout(0, 1));
        
        for (Zutat zutat : zutaten) {
            zutat.box = new JCheckBox(zutat.name);
            zutat.box.setSelected(zutat.aufPizza);
            zutat.box.addItemListener(zutat);
            zutat.pizza = pizza;
            group.add(zutat.box);
        }
        setContentPane(group);
        
        this.setTitle("Bestellung");
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.setSize(200,200);
        this.setVisible(true);
    }
}

public class Pizza extends JFrame {
    
    public ArrayList<Zutat> zutaten = new ArrayList<Zutat>();
    Bestellung bestellung = new Bestellung();
    
    public static void main(final String[] args) {
        Pizza pizza = new Pizza();
        pizza.create(args);
    }
    
    /*
        Fenster oeffnen
    */
    private void create(final String[] args) {
        this.setTitle("Pizza");
        this.setSize(400,420);
        this.setVisible(true);
        
        this.zutaten.add(new Zutat("Teig", Toolkit.getDefaultToolkit().getImage("teig.png"), true));
        this.zutaten.add(new Zutat("Tomaten", Toolkit.getDefaultToolkit().getImage("tomaten.png"), true));
        this.zutaten.add(new Zutat("Spinat", Toolkit.getDefaultToolkit().getImage("spinat.png"), false));
        this.zutaten.add(new Zutat("Kaese", Toolkit.getDefaultToolkit().getImage("kaese.png"), true));
        this.zutaten.add(new Zutat("Paprika", Toolkit.getDefaultToolkit().getImage("paprika.png"), false));
        this.zutaten.add(new Zutat("Knoblauch", Toolkit.getDefaultToolkit().getImage("knoblauch.png"), false));
        this.zutaten.add(new Zutat("Pilze", Toolkit.getDefaultToolkit().getImage("pilze.png"), false));
        this.zutaten.add(new Zutat("Salami", Toolkit.getDefaultToolkit().getImage("salami.png"), false));
        this.zutaten.add(new Zutat("Ananas", Toolkit.getDefaultToolkit().getImage("ananas.png"), false));
        this.zutaten.add(new Zutat("Salat", Toolkit.getDefaultToolkit().getImage("salat.png"), false));
        this.zutaten.add(new Zutat("Oliven", Toolkit.getDefaultToolkit().getImage("oliven.png"), false));
        this.zutaten.add(new Zutat("Kapern", Toolkit.getDefaultToolkit().getImage("kapern.png"), false));
        
        bestellung.zutaten = this.zutaten;
        bestellung.neuePizza(this);
    }
    
    
    /*
        Pizza Zeichnen
    */
    public void paint(Graphics g) {
        System.out.println("Zeichne Pizza...");
        
        g.clearRect(0, 0, getWidth(), getHeight());
        
        for (Zutat zutat : zutaten) {
            if (zutat.aufPizza) {
                g.drawImage(zutat.img, 0, 10, getWidth(), getHeight(), this);
            }
        }
    }
}
