// 菜集鲜：到付新订单轮询提醒（仅轮询；Telegram/Zalo 推送留作后续，扩展点见后端 NoticeListener）
import { codNew } from '@/api/cod';
import store from '@/store';

const SINCE_KEY = 'cod_since_id';
const SOUND_KEY = 'cod_sound_on';
let timer = null;
let vmRef = null;
let audio = null;
let unlocked = false;

function getSince() {
  try {
    return parseInt(localStorage.getItem(SINCE_KEY) || '0', 10) || 0;
  } catch (e) {
    return 0;
  }
}

function setSince(id) {
  try {
    localStorage.setItem(SINCE_KEY, String(id));
  } catch (e) {}
}

export function isSoundOn() {
  try {
    return localStorage.getItem(SOUND_KEY) !== '0';
  } catch (e) {
    return true;
  }
}

export function setSoundOn(on) {
  try {
    localStorage.setItem(SOUND_KEY, on ? '1' : '0');
  } catch (e) {}
  if (on) unlockAudio();
}

// 浏览器自动播放限制：需用户有过一次交互后才可播放；首次点击时预热
export function unlockAudio() {
  if (unlocked) return;
  try {
    audio = audio || new Audio('/admin/static/new_order.wav');
    audio.muted = true;
    const p = audio.play();
    const done = () => {
      audio.pause();
      audio.currentTime = 0;
      audio.muted = false;
      unlocked = true;
    };
    if (p && p.then) p.then(done).catch(() => {});
    else done();
  } catch (e) {}
}

function beep() {
  if (!isSoundOn() || !audio) return;
  try {
    audio.currentTime = 0;
    const p = audio.play();
    if (p && p.catch) p.catch(() => {});
  } catch (e) {}
}

function schedule(sec) {
  clearTimeout(timer);
  timer = setTimeout(tick, Math.max(5, sec || 20) * 1000);
}

function tick() {
  codNew({ since_id: getSince() })
    .then((res) => {
      const d = res.data || {};
      store.commit('cod/setPending', d.pending || 0);
      const list = d.list || [];
      if (list.length && vmRef) {
        const first = list[0];
        vmRef.$notify({
          title: '新的到付订单',
          message: list.length > 1 ? `收到 ${list.length} 个新订单，点击查看` : `${first.order_id} ${first.region_name || ''} ${first.pay_price}`,
          type: 'success',
          duration: 8000,
          onClick: () => {
            vmRef.$router.push({ name: 'order_cod' }).catch(() => {});
          },
        });
        beep();
      }
      if (d.latest_id !== undefined) setSince(d.latest_id);
      schedule(d.poll_seconds);
    })
    .catch(() => schedule(30));
}

export function startCodNotifier(vm) {
  vmRef = vm;
  if (timer) return;
  document.addEventListener('click', unlockAudio, { once: true });
  tick();
}

export function stopCodNotifier() {
  clearTimeout(timer);
  timer = null;
  vmRef = null;
}
