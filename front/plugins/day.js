import dayjs from 'dayjs';
import ja from 'dayjs/locale/ja';
dayjs.extend(require('dayjs/plugin/timezone'));
dayjs.extend(require('dayjs/plugin/utc'));
dayjs.tz.setDefault('Asia/Tokyo');

dayjs.locale(ja);

export default ({ app }, inject) => {
  inject('dayjs', ((string) => dayjs(string)))
}
