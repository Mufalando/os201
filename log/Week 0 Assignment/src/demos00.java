import java.io.*;

public class demos00 {
    static BufferedReader br;
    static BufferedWriter bw;

    public static void readInput() throws FileNotFoundException {
        File input =   new File("INPUT.txt");
        br = new BufferedReader(new FileReader(input));
    }

    public static String ambilNama() throws IOException{
        String test;
        while ((test = br.readLine()).equals("")){
            continue;
        }
        String[] line1 = test.split(" ");
        return  line1[0] +  line1[1] + line1[2] + ".txt";
    }

    public static void writeInput(String namaFile) throws IOException{
        String st; String term = ""; String tahun = "";
        int urutan = 0;
        int jumlahSks = 0;
        bw = new BufferedWriter(new FileWriter(namaFile,true));
        while ((st = br.readLine()) != null) {
            if (st.contains("Tahun")) {
                String[] temp = st.split(" ");
                if (tahun.equals("") || !tahun.equals(temp[2])) {
                    tahun = temp[2];
                    urutan++;
                }
                term = temp[4];
            } else if (st.contains("Disetujui")) {
                String[] temp = st.split(" ");
                jumlahSks += Integer.parseInt(temp[temp.length - 5].replaceAll("\\s+",""));
                System.out.println(urutan + term + " " + temp[1] + " " + temp[temp.length - 5] + " " + temp[temp.length - 2] + " " + jumlahSks);
                bw.write(urutan + term + " " + temp[1].replaceAll("\\s+","") + " " + temp[temp.length - 5].replaceAll("\\s+","") + " " + temp[temp.length - 2].replaceAll("\\s+","") + " " + jumlahSks + "\n");
            }
        }
        bw.close();
    }

    public static void main(String[] args) throws IOException {
        readInput();
        String namaOut = ambilNama();
        writeInput(namaOut);
        br.close();
    }
}
