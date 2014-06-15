package util.word;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;

import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.model.TextPiece;
import org.apache.poi.hwpf.usermodel.Paragraph;
import org.apache.poi.hwpf.usermodel.Range;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;

public class WordDocumentProcessor {
	private InputStream inputStream = null;
	private OutputStream outputStream = null;

	private HWPFDocument document = null;
	private HashMap<String, String> replacementText = null;
	private Set<String> keys = null;

	public WordDocumentProcessor(InputStream input, OutputStream output, HashMap<String, String> replacementText)
			throws NullPointerException, IllegalArgumentException {
		if (input == null) {
			throw new NullPointerException("Null value passed to the filename parameter of the InsertText class constructor.");
		}
		if (replacementText == null) {
			throw new NullPointerException("Null value passed to the replacementText parameter of the InsertText class constructor.");
		}

		this.replacementText = replacementText;
		this.keys = replacementText.keySet();
		this.inputStream = input;
		this.outputStream = output;
	}

	public void processFile() {
		Range range = null;
		BufferedInputStream buffInputStream = null;
		BufferedOutputStream buffOutputStream = null;
		ParagraphText[] paraText = null;
		try {
			buffInputStream = new BufferedInputStream(this.inputStream);
			this.document = new HWPFDocument(new POIFSFileSystem(buffInputStream));

			range = this.document.getRange();
			paraText = loadParagraphs(range);

			for (int i = 0; i < paraText.length; i++) {
				for (String key : this.keys) {
					if (paraText[i].getUpdatedText().contains(key)) {
						paraText[i].updateText(replacePlaceholders(key, (String) this.replacementText.get(key),
								paraText[i].getUpdatedText()));
					}

				}

				if (paraText[i].isUpdated()) {
					range.getParagraph(paraText[i].getParagraphNumber()).replaceText(paraText[i].getRawText(),
							paraText[i].getUpdatedText(), 0);
				}

			}

			buffOutputStream = new BufferedOutputStream(this.outputStream);
			this.document.write(buffOutputStream);
		} catch (IOException ioEx) {
			System.out.println("Caught an: " + ioEx.getClass().getName());
			System.out.println("Message: " + ioEx.getMessage());
			System.out.println("StackTrace follows:");
			ioEx.printStackTrace(System.out);
		} finally {
			if (buffInputStream != null) {
				try {
					buffInputStream.close();
				} catch (IOException ioEx) {
				}
			}

			if (buffOutputStream != null)
				try {
					buffOutputStream.flush();
					buffOutputStream.close();
				} catch (IOException ioEx) {
				}
		}
	}

	private String replacePlaceholders(String key, String value, String text) {
		int index = 0;

		while ((index = text.indexOf(key)) >= 0) {
			text = text.substring(0, index) + value + text.substring(index + key.length());
		}
		return text;
	}

	private ParagraphText[] loadParagraphs(Range range) {
		ParagraphText[] paraText = new ParagraphText[range.numParagraphs()];
		Paragraph paragraph = null;
		String readText = null;
		try {
			for (int i = 0; i < range.numParagraphs(); i++) {
				paragraph = range.getParagraph(i);
				readText = paragraph.text();
				if (readText.endsWith("\n")) {
					readText = readText + "\n";
				}
				paraText[i] = new ParagraphText(i, readText);
			}
		} catch (Exception ex) {
			paraText[0] = getTextFromPieces();
		}
		return paraText;
	}

	private ParagraphText getTextFromPieces() {
		TextPiece piece = null;
		StringBuffer buffer = new StringBuffer();
		String text = null;
		String encoding = "Cp1252";

		Iterator<TextPiece> textPieces = this.document.getTextTable().getTextPieces().iterator();
		while (textPieces.hasNext()) {
			piece = (TextPiece) textPieces.next();
			if (piece.isUnicode())
				encoding = "UTF-16LE";
			try {
				text = new String(piece.getRawBytes(), encoding);
				buffer.append(text);
			} catch (UnsupportedEncodingException e) {
				throw new InternalError("Standard Encoding " + encoding + " not found, JVM broken");
			}
		}
		text = buffer.toString();

		text = text.replaceAll("\r\r\r", "\r\n\r\n\r\n");
		text = text.replaceAll("\r\r", "\r\n\r\n");
		if (text.endsWith("\r")) {
			text = text + "\n";
		}
		return new ParagraphText(0, text);
	}
}