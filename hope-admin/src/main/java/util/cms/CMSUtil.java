package util.cms;

import java.io.InputStream;

public abstract class CMSUtil {
	public static final CMSUtil getInstance() {
		return new CMSUtilCustom();
	}

	public abstract InputStream getWelcomeLetterTemplate(int paramInt);

	public abstract boolean isWelcomeLetterTemplateAvailable(int paramInt);
}