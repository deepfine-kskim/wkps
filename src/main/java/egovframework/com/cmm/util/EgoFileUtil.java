package egovframework.com.cmm.util;

import java.text.DecimalFormat;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class EgoFileUtil {

    private static final Logger LOGGER = LoggerFactory.getLogger(EgoFileUtil.class);

    private static DecimalFormat oneDecimal = new DecimalFormat("0.0");

    public static String getSizeString(Long number) {
        String data = "";
        try {
            if (number != null) {
                long absNumber = Math.abs(number);
                double result = number;
                String suffix;
                if (absNumber < 1024) {
                    suffix = "";
                } else if (absNumber < 1024 * 1024) {
                    result = number / 1024.0;
                    suffix = "K";
                } else if (absNumber < 1024 * 1024 * 1024) {
                    result = number / (1024.0 * 1024);
                    suffix = "M";
                } else {
                    result = number / (1024.0 * 1024 * 1024);
                    suffix = "G";
                }
                data = oneDecimal.format(result) + suffix;
            }

        } catch (NumberFormatException e) {
        	LOGGER.error("[" + e.getClass() +"] :" + e.getMessage());
        }

        return data;
    }
}
