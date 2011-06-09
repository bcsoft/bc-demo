/**
 * 
 */
package cn.bc.example;

import java.io.InputStream;
import java.io.StringBufferInputStream;

import com.opensymphony.xwork2.ActionSupport;

/**
 * @author dragon
 * 
 */
public class ExampleListAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private InputStream inputStream;

	public InputStream getInputStream() {
		return inputStream;
	}

	public String forStream() throws Exception {
		inputStream = new StringBufferInputStream(
				"<b>Hello World!</b> This is a text string response from a Struts 2 Action.<div data=\"{a:123,b:'cc'}\">test</div>");
		return SUCCESS;
	}

	public String execute() throws Exception {
		inputStream = new StringBufferInputStream(
				"<b>Hello World!!</b> This is a text string response from a Struts 2 Action.<div data=\"{a:123,b:'cc'}\">test</div>");
		return SUCCESS;
	}
}
