# Lưu mấy code linh tinh hay hay
## Mục lục

- [Console log ra màu mè](#console-log-ra-màu-mè)
- [Đổi ico tab và Đổi tên](#đổi-ico-tab-và-đổi-tên)
- [Thông báo popup góc (showToast)](#show-toast)

### Console log ra màu mè
![🌴Vice City🌴](https://img.shields.io/badge/🌴%20Vice%20City%20🌴-ff6ec7?style=for-the-badge&labelColor=ff6ec7&color=ff6ec7)


<details>
  <summary>👉 Javascript</summary>
	
```
console.log(
  "%c 🌴Vice City🌴 ",
  "color: white; background-color: #ff6ec7; font-size:16px; font-weight:bold; padding:4px 12px; border-radius:6px; text-shadow: 0 0 4px #ff99e6;"
);
```
</details>

### Đổi ico tab và Đổi tên

<details>
  <summary>👉 Javascript</summary>
	
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
</details>

### Show Toast
<details>
  <summary>👉 Javascript</summary>
	
```

// Hàm showToast
function showToast(message, duration = 3000) {
  let container = document.getElementById("toast-container");

  if (!container) {
    container = document.createElement("div");
    container.id = "toast-container";
    document.body.appendChild(container);

    const style = document.createElement("style");
    style.innerHTML = `
        #toast-container {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 9999;
        }
        .toast {
            background: #333;
            color: #fff;
            padding: 10px 16px;
            margin-top: 8px;
            border-radius: 6px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.3);
            font-size: 14px;
            opacity: 0;
            transform: translateY(20px);
            transition: all 0.3s ease;
        }
        .toast.show {
            opacity: 1;
            transform: translateY(0);
        }`;
    document.head.appendChild(style);
  }

  const toast = document.createElement("div");
  toast.className = "toast";
  toast.innerText =
    typeof message == "object" ? JSON.stringify(message) : message;
  container.appendChild(toast);

  setTimeout(() => toast.classList.add("show"), 50);

  setTimeout(() => {
    toast.classList.remove("show");
    setTimeout(() => container.removeChild(toast), 300);
  }, duration);
}
```
</details>

<details>
  <summary>👉 CSS</summary>

```
/* Container để chứa tất cả toast */
#toast-container {
  position: fixed;
  top: 20px;
  right: 20px;
  z-index: 9999;
}

/* Style chung cho toast */
.toast {
  background: #333;
  color: #fff;
  padding: 10px 16px;
  margin-top: 8px;
  border-radius: 6px;
  box-shadow: 0 2px 6px rgba(0,0,0,0.3);
  font-size: 14px;
  opacity: 0;
  transform: translateY(20px);
  transition: all 0.3s ease;
}
.toast.show {
  opacity: 1;
  transform: translateY(0);
}
```

</details>
