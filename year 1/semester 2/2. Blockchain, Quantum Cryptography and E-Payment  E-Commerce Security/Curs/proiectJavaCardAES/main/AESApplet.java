package main;

import javacard.framework.*;
import javacard.security.*;
import javacardx.crypto.*;

public class AESApplet extends Applet {

    // applet class byte
    private static final byte CLA_AES = (byte) 0xB0;

    // commands for encrypt and decrypt
    private static final byte INS_ENCRYPT = 0x10;
    private static final byte INS_DECRYPT = 0x20;

    // default aes key, 16 bytes
    private static final byte[] DEFAULT_KEY = {
        0x00, 0x01, 0x02, 0x03,  
        0x04, 0x05, 0x06, 0x07,
        0x08, 0x09, 0x0A, 0x0B,  
        0x0C, 0x0D, 0x0E, 0x0F
    };

    private final AESKey aesKey;
    private final Cipher cipher;

    private AESApplet() {
        // create aes key 128 bits
        aesKey = (AESKey) KeyBuilder.buildKey(KeyBuilder.TYPE_AES, KeyBuilder.LENGTH_AES_128, false);
        aesKey.setKey(DEFAULT_KEY, (short) 0);

        // setup cipher ecb no padding
        cipher = Cipher.getInstance(Cipher.ALG_AES_BLOCK_128_ECB_NOPAD, false);

        // register this applet
        register();
    }

    public static void install(byte[] bArray, short bOffset, byte bLength) {
        new AESApplet();
    }

    public void process(APDU apdu) {
        if (selectingApplet()) return;

        byte[] buf = apdu.getBuffer();

        if (buf[ISO7816.OFFSET_CLA] != CLA_AES) {
            ISOException.throwIt(ISO7816.SW_CLA_NOT_SUPPORTED);
        }

        short inLen = apdu.setIncomingAndReceive();

        switch (buf[ISO7816.OFFSET_INS]) {
            case INS_ENCRYPT:
                doCrypt(apdu, inLen, Cipher.MODE_ENCRYPT);
                break;
            case INS_DECRYPT:
                doCrypt(apdu, inLen, Cipher.MODE_DECRYPT);
                break;
            default:
                ISOException.throwIt(ISO7816.SW_INS_NOT_SUPPORTED);
        }
    }

    private void doCrypt(APDU apdu, short dataLen, byte mode) {
        byte[] buf = apdu.getBuffer();
        cipher.init(aesKey, mode);

        short procLen = dataLen;

        if (mode == Cipher.MODE_ENCRYPT) {
            // pad to 16 bytes if needed
            short rem = (short) (dataLen % 16);
            if (rem != 0) procLen += (16 - rem);

            // temp buffer cleared on reset
            byte[] tmp = JCSystem.makeTransientByteArray(procLen, JCSystem.CLEAR_ON_RESET);
            Util.arrayFillNonAtomic(tmp, (short) 0, procLen, (byte) 0);

            // copy input to temp buffer
            Util.arrayCopyNonAtomic(buf, ISO7816.OFFSET_CDATA, tmp, (short) 0, dataLen);

            // encrypt and write back to buffer
            short out = cipher.doFinal(tmp, (short) 0, procLen, buf, (short) 0);

            apdu.setOutgoingAndSend((short) 0, out);
        } else {
            // decrypt: length must be multiple of 16
            if ((dataLen % 16) != 0) {
                ISOException.throwIt(ISO7816.SW_WRONG_LENGTH);
            }

            // decrypt and send back
            short out = cipher.doFinal(buf, ISO7816.OFFSET_CDATA, dataLen, buf, (short) 0);
            apdu.setOutgoingAndSend((short) 0, out);
        }
    }
}
