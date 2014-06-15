package util.cms;

import java.io.InputStream;

public class CMSUtilCustom extends CMSUtil {
	public InputStream getWelcomeLetterTemplate(int year) {
		String word_template_name = "lettere_soci/lettera_nuovo_socio_" + year + ".doc";
		return getClass().getClassLoader().getResourceAsStream(word_template_name);
	}

	public boolean isWelcomeLetterTemplateAvailable(int year) {
		return getWelcomeLetterTemplate(year) != null;
	}
}