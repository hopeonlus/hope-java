package util.word;

public class ParagraphText {
	private String rawText = null;
	private String updatedText = null;
	private boolean updated = false;
	private int paragraphNumber = 0;

	public ParagraphText(int paragraphNumber, String text) {
		this.rawText = text;
		this.updatedText = new String(text);
		this.paragraphNumber = paragraphNumber;
		this.updated = false;
	}

	public String getRawText() {
		return this.rawText;
	}

	public String getUpdatedText() {
		return this.updatedText;
	}

	public int getParagraphNumber() {
		return this.paragraphNumber;
	}

	public void updateText(String text) {
		this.updatedText = text;
		setUpdated(true);
	}

	public boolean isUpdated() {
		return this.updated;
	}

	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("ParagraphText: ");
		buffer.append("Paragraph Number: ");
		buffer.append(this.paragraphNumber);
		buffer.append(" Raw Text: ");
		buffer.append(this.rawText);
		buffer.append(" Updated Text: ");
		buffer.append(this.updatedText);
		buffer.append(" Updated: ");
		buffer.append(this.updated);
		return buffer.toString().trim();
	}

	private void setUpdated(boolean updated) {
		this.updated = updated;
	}
}