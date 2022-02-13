import java.io.IOException;

/**
 * @author minasora
 * @date 2019/10/7 16: 16
 * @description
 */
public class Main {

    public static void main(String[] args) throws IOException
    {
        Conf.readInstance();
        System.out.println("运行中");
        GA_Strategy.genetic_algoritm().toSolution().print();
    }
}
