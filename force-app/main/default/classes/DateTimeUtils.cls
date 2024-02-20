public class DateTimeUtils {
	public virtual Datetime now() {
        return DateTime.newInstance(Date.today(), Time.newInstance(0, 0, 0, 0));
    }
}