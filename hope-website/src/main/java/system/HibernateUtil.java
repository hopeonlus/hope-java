package system;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

/**
 * TODO: A lot of comments here...
 */
public class HibernateUtil {

	private static Log log = LogFactory.getLog(HibernateUtil.class);
	private static SessionFactory sessionFactory;
	public static final ThreadLocal session = new ThreadLocal();

	static {
		try {
			Configuration Conf = new Configuration();
			log.info("ho creato la conf");
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