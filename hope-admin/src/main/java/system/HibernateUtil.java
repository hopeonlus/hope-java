package system;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.jasypt.hibernate3.encryptor.HibernatePBEEncryptorRegistry;

public class HibernateUtil {

	private static SessionFactory sessionFactory;
	public static final ThreadLocal<Session> session = new ThreadLocal<Session>();

	static {
		try {
			
			Context initCtx = new InitialContext();
			Context envCtx = (Context) initCtx.lookup("java:comp/env");
			String pwd = (String) envCtx.lookup("hope/dbpassword");
			
			StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();
			encryptor.setPassword(pwd);
			
			HibernatePBEEncryptorRegistry registry = HibernatePBEEncryptorRegistry.getInstance();
			registry.registerPBEStringEncryptor("configurationHibernateEncryptor", encryptor);

			Configuration Conf = new Configuration();
			sessionFactory = Conf.configure().buildSessionFactory();
		} catch (Throwable t) {
			t.printStackTrace();
			sessionFactory = null;
		}
	}

	public static Session currentSession() throws HibernateException {
		Session s = (Session) session.get();

		if (s == null) {
			s = sessionFactory.openSession();
			session.set(s);
		}
		return s;
	}

	public static void closeSession() throws HibernateException {
		Session s = (Session) session.get();
		session.set(null);
		if (s != null)
			s.close();
	}
}