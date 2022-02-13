import java.util.ArrayList;
import java.util.Random;
import java.util.zip.CheckedOutputStream;


/**
 * @author minasora
 * @date 2019/10/7 16:16
 * @description 提供了crossover，mutation，selection等遗传算法使用的函数
 */
public class GA_Strategy {
    public static double p_rate = 0.1;
    public static int pop_number = 100;// 种群的数量

    static Chromosome[] initialize()//
    {
        Chromosome[] chromosomes = new Chromosome[pop_number];
        for (int i = 0; i < pop_number; i++) {
            chromosomes[i] = new Chromosome();
            chromosomes[i].setFitness();
        }
        return chromosomes;
    }



    static Chromosome crossover(Chromosome p_one,Chromosome p_two)//OX交叉方式，返回一个新的Chromosome，交换亲代即可获得两个子代
    {
        Chromosome children = new Chromosome();
        children.cur_list.clear();
        children.cur_list.add(0);
        Random r = new Random();
        int i = r.nextInt(Conf.N)+1;
        int j= r.nextInt(Conf.N)+1;
        if(j < i)
        {
            int mid = i;
            i = j;
            j = mid;
        }
        // 获得 0<= i<= j <= n的随机数
        for(int tmp = i;tmp <= j;tmp++)
            children.cur_list.add(p_one.cur_list.get(tmp));//把i-j中的点先转移到mid中
        ArrayList<Integer> parent  = new ArrayList<>();
        for(int tmp = j;tmp<=Conf.N;tmp++)
            parent.add(p_two.cur_list.get(tmp));
        for(int tmp = 1;tmp<=j;tmp++)
            parent.add(p_two.cur_list.get(tmp));
        int tmp = j;
        Boolean if_fir = false;//标记是否到头
        for(int t : parent)
        {
            if(tmp == Conf.N)//假如到了末尾
            {
                tmp = 1;//从头开始
                if_fir = true;
            }
            if(if_fir)
            {
                if (!children.cur_list.contains(t)) {
                    children.cur_list.add(1, t);
                    tmp++;
                }
            }
            else {
                if (!children.cur_list.contains(t))//不包含的话就加入
                {
                    children.cur_list.add(t);
                    tmp++;
                }
            }

        }
        children.setFitness();
        return children;
    }
    static Chromosome mutation(Chromosome chromosome)// 突变，也是Ls,提高才能停止迭代
    {
        Chromosome new_chromosome = chromosome.copy();
        int iteratiion = 1;
        while(iteratiion<10000) {
            if(chromosome.fitness>neighborhood_move(new_chromosome).fitness)
            {
                return new_chromosome;
            }
            else
                new_chromosome = chromosome.copy();
        }
        return  new_chromosome;
    }
    static Chromosome neighborhood_move(Chromosome chromosome)
    {
        Random r = new Random();
        int i = r.nextInt(Conf.N) + 1;
        int j = r.nextInt(Conf.N) + 1;
        int mid = chromosome.cur_list.get(i);
        chromosome.cur_list.set(i,chromosome.cur_list.get(j));
        chromosome.cur_list.set(j,mid);
        chromosome.setFitness();
        return chromosome;
    }
    static Chromosome[] selection(Chromosome[] chromosomes)//选择，保留优秀个体，二进制锦标赛选择
    {
        Chromosome [] childrens = new Chromosome[pop_number];
        for(int t = 0;t<pop_number;t++) {
            Random r = new Random();
            int i = r.nextInt(pop_number);
            int j = r.nextInt(pop_number);
            if (chromosomes[i].fitness < chromosomes[j].fitness)
                childrens[t] = chromosomes[i];
            else
                childrens[t] = chromosomes[j];
        }
        return  childrens;
    }
    static Chromosome getbest(Chromosome[] chromosomes)
    {
        Chromosome chromosome = null;
        double min = 99999;
        for(int i=0;i<pop_number;i++)
        {
            if(min>chromosomes[i].fitness)
            {
                min = chromosomes[i].fitness;
                chromosome = chromosomes[i];

            }
        }
        return chromosome;
    }
    static double get_mean(Chromosome[] chromosomes)
    {
        double ans = 0;
        for(Chromosome chromosome:chromosomes)
        {
            ans += chromosome.fitness;
        }
        return ans/pop_number;
    }
    static Chromosome genetic_algoritm()//遗传算法主流程
    {
        Chromosome best = new Chromosome();
        double min = 999999;
        Chromosome[] parents = GA_Strategy.initialize();//初始化
        for(int i=1;i<= 1000;i++)
        {
            Chromosome[] mid = GA_Strategy.selection(parents);//选择
            Chromosome[] childrens = new Chromosome[pop_number];//子代数组
            for(int j=0;j<pop_number;j++)
            {
                Random r = new Random();
                int fir = r.nextInt(pop_number);
                int sec = r.nextInt(pop_number);
                childrens[j] = crossover(mid[fir],mid[sec]);
            }
           for(int p=0;p<pop_number;p++)
            {
                childrens[p] = mutation(childrens[p]);
            }
            for(int q = 0;q<pop_number;q++)
            {
                parents[q] = childrens[q];
            }
            if(min>GA_Strategy.getbest(parents).fitness)
            {
                best = GA_Strategy.getbest(parents);
                min = best.fitness;
            }
            //System.out.println(get_mean(parents));

        }
        return best;
    }

}
