# Lưu mấy code linh tinh hay hay

## Mục lục

- [Console log ra màu mè](#console-log-ra-màu-mè)
- [Đổi ico tab và Đổi tên](#đổi-ico-tab-và-đổi-tên)
- [Thông báo popup góc (showToast)](#show-toast)

### Console log ra màu mè
![🌴Vice City🌴](https://img.shields.io/badge/🌴%20Vice%20City%20🌴-ff6ec7?style=for-the-badge&labelColor=ff6ec7&color=ff6ec7)

```
console.log(
  "%c 🌴Vice City🌴 ",
  "color: white; background-color: #ff6ec7; font-size:16px; font-weight:bold; padding:4px 12px; border-radius:6px; text-shadow: 0 0 4px #ff99e6;"
);
```

### Đổi ico tab và Đổi tên

```

function changeFaviconWithEmoji(emoji) {
  // Vẽ emoji lên canvas
  const canvas = document.createElement("canvas");
  canvas.width = 64;
  canvas.height = 64;
  const ctx = canvas.getContext("2d");
  ctx.font = "48px serif";
  ctx.textAlign = "center";
  ctx.textBaseline = "middle";
  ctx.fillText(emoji, 32, 32);

  // Xóa favicon cũ
  document.querySelectorAll("link[rel*='icon']").forEach(e => e.remove());

  // Tạo favicon mới từ canvas
  const link = document.createElement("link");
  link.rel = "icon";
  link.href = canvas.toDataURL("image/png");
  document.head.appendChild(link);
}

// Demo: thay favicon emoji mỗi 2 giây
let toggle = false;
setInterval(() => {
	document.title = "PROD";
  if (toggle) {
    changeFaviconWithEmoji("🐳");
  } else {
    changeFaviconWithEmoji("⚓");
  }
  toggle = !toggle;
}, 2000);

```

### Show Toast
