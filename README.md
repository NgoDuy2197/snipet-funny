# Lưu mấy code linh tinh hay hay

## Mục lục

- [Cài đặt](#cài-đặt)
- [Sử dụng](#sử-dụng)
- [Góp ý](#góp-ý)
- [Đổi ico tab và Đổi tên](#đổi-ico-tab-và-đổi-tên)

x
x
x
x
x
x
x
x
x
x
x
x
x
x
x
x
x
x
x
x
x
x
x
x
x
x
x
x
x
x
x
x
x
x
x


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



# Dự án ABC

## Cài đặt
Nội dung...

## Sử dụng
Nội dung...

## Góp ý
Nội dung...
- [Cài đặt](# Đổi ico tab và Đổi tên)
