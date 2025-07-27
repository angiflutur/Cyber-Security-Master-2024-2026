package main;

import com.licel.jcardsim.smartcardio.CardSimulator;
import javacard.framework.AID;

import java.io.ByteArrayOutputStream;
import java.nio.file.*;
import java.util.Arrays;

public class HostAppEmulator {

    private static final byte CLA_AES = (byte) 0xB0;
    private static final byte INS_ENCRYPT = 0x10;
    private static final byte INS_DECRYPT = 0x20;

    // send data in 16 byte blocks to card for encrypt/decrypt
    private static byte[] process(CardSimulator sim, byte[] data, byte ins) throws Exception {
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        for (int i = 0; i < data.length; i += 16) {
            byte[] block = Arrays.copyOfRange(data, i, i + 16);
            byte[] apduRes = sendApdu(sim, CLA_AES, ins, block);
            out.write(apduRes);
        }
        return out.toByteArray();
    }

    // build and send apdu command to card
    private static byte[] sendApdu(CardSimulator sim, byte cla, byte ins, byte[] payload) throws Exception {
        byte[] cmd = new byte[5 + payload.length];
        cmd[0] = cla;
        cmd[1] = ins;
        cmd[2] = 0x00; // p1
        cmd[3] = 0x00; // p2
        cmd[4] = (byte) payload.length; // lc
        System.arraycopy(payload, 0, cmd, 5, payload.length);

        var resp = sim.transmitCommand(new javax.smartcardio.CommandAPDU(cmd));
        if (resp.getSW() != 0x9000)
            throw new Exception(String.format("sw error: 0x%04X", resp.getSW()));

        return resp.getData();
    }

    // add pkcs7 padding to data
    private static byte[] pad(byte[] data) {
        int padLen = 16 - (data.length % 16);
        byte[] out = Arrays.copyOf(data, data.length + padLen);
        Arrays.fill(out, data.length, out.length, (byte) padLen);
        return out;
    }

    // remove and check pkcs7 padding
    private static byte[] unpad(byte[] data) throws Exception {
        int padLen = data[data.length - 1] & 0xFF;
        if (padLen < 1 || padLen > 16) throw new Exception("invalid padding");
        for (int i = data.length - padLen; i < data.length; i++)
            if (data[i] != (byte) padLen) throw new Exception("corrupt padding");
        return Arrays.copyOf(data, data.length - padLen);
    }

    public static void main(String[] args) throws Exception {
        // setup simulator and install applet
        CardSimulator sim = new CardSimulator();
        AID aid = new AID(new byte[]{ (byte) 0xA0,0x00,0x00,0x00,0x62,0x12,0x34 }, (short) 0, (byte) 7);

        sim.installApplet(aid, AESApplet.class);
        sim.selectApplet(aid);

        Path inDir = Paths.get("files");
        Path encDir = Paths.get("encrypted");
        Path decDir = Paths.get("decrypted");
        Files.createDirectories(encDir);
        Files.createDirectories(decDir);

        // loop over all files in 'files' folder
        Files.list(inDir)
             .filter(Files::isRegularFile)
             .forEach(f -> {
                 try {
                     String name = f.getFileName().toString();
                     System.out.println("\nprocessing file: " + name);

                     byte[] raw = Files.readAllBytes(f);
                     byte[] padded = pad(raw);

                     // encrypt padded data
                     byte[] enc = process(sim, padded, INS_ENCRYPT);
                     // decrypt it back
                     byte[] decPadd = process(sim, enc, INS_DECRYPT);
                     byte[] dec = unpad(decPadd);

                     Files.write(encDir.resolve("enc_" + name + ".enc"), enc);
                     Files.write(decDir.resolve("dec_" + name), dec);

                     System.out.println("saved encrypted to: " + encDir.resolve("enc_" + name + ".enc"));
                     System.out.println("saved decrypted to: " + decDir.resolve("dec_" + name));
                 } catch (Exception ex) {
                     System.err.println("error with file: " + ex.getMessage());
                 }
             });
    }
}
