# Lưu mấy code linh tinh hay hay
## Mục lục

- [Console log ra màu mè](#console-log-ra-màu-mè)
- [Đổi ico tab và Đổi tên](#đổi-ico-tab-và-đổi-tên)
- [Thông báo popup góc (showToast)](#show-toast)
- [Tự lấy accessToken để gửi tin nhắn](#auto-send-mess-by-auto-get-token)
- [Auto copy file](#auto-copy-file)
  
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

### Auto send mess by auto get token

<details>
  <summary>👉 Javascript</summary>
	
```
const vacabResource = `
Chinese language	Zhōngwén	中文
Chinese language	Hànyǔ	汉语
Where	nǎ	哪
Who	shéi	谁
Classmate	tóngxué	同学
Friend	péngyǒu	朋友
(belong to)	de	的
(ask back)	ne	呢
People	rén	人
American	Měiguó rén	美国人
Teacher	lǎoshī	老师
Student	xuéshēng	学生
(is / to be)	shì	是
`;

const groupId = '68d3bf399b7abd768601c1a3';
// Hàm showToast
function showToast(message, duration = 3000) {
	let container = document.getElementById('toast-container');

	if (!container) {
		container = document.createElement('div');
		container.id = 'toast-container';
		document.body.appendChild(container);

		const style = document.createElement('style');
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

	const toast = document.createElement('div');
	toast.className = 'toast';
	toast.innerText =
		typeof message == 'object' ? JSON.stringify(message) : message;
	container.appendChild(toast);

	setTimeout(() => toast.classList.add('show'), 50);

	setTimeout(() => {
		toast.classList.remove('show');
		setTimeout(() => container.removeChild(toast), 300);
	}, duration);
}

// Lấy token
const accessToken = localStorage.getItem('accessToken');
if (!accessToken) {
	showToast('⚠️ Không tìm thấy accessToken trong localStorage!');
	throw new Error('No access token');
}

// Kết nối WebSocket (token truyền qua query string)
const ws = new WebSocket(
	`wss://realtime-chat.fpt.com/realtime?accessToken`,
	accessToken
);

ws.onopen = () => {
	showToast('✅ WebSocket kết nối thành công');

	function pickWords(limit = 5) {
		let _vacabResource = vacabResource
			.replace(/^\n+|\n+$/g, '')
			.split('\n')
			.map((line) => {
				return line.split('\t').join(' - ');
			});

		// Sao chép mảng để tránh làm thay đổi vocabList gốc
		const shuffled = [..._vacabResource].sort(() => Math.random() - 0.5);

		return shuffled.slice(0, limit).join('\n');
	}

	function sendMessage(content) {
		const randomRequestId = Math.random().toString(36).substring(2, 15);
		ws.send(
			JSON.stringify({
				type: 'message',
				data: {
					requestId: randomRequestId,
					content,
					groupId,
					groupType: 'SUPER_PRIVATE',
					type: 'TEXT',
					metadata: {},
					senderId: '6810a5420ae1989bb2a45c70',
				},
			})
		);
	}

	const emojis = [
		'🔥',
		'🚀',
		'💡',
		'📚',
		'✨',
		'💪',
		'🌟',
		'🧠',
		'🎯',
		'🏆',
		'😊',
		'🦾',
	];

	function getRandomEmojis(count = 10) {
		return [...emojis] // copy mảng
			.sort(() => Math.random() - 0.5) // xáo trộn
			.slice(0, count) // lấy count emoji
			.join(' ');
	}

	function buildMessage() {
		const words = pickWords(5);
		const randomEmojis = getRandomEmojis(1);
		return `${randomEmojis} Hôm nay hãy ôn 5 từ sau:\n\n${words}`;
	}

	function checkAndSend() {
		const today = new Date().toISOString().split('T')[0];
		const lastSent = localStorage.getItem('lastSentDate');

		if (lastSent === today) {
			showToast('📌 Hôm nay đã gửi rồi, không gửi lại.');
			return;
		}

		const message = buildMessage();
		sendMessage(message);
		localStorage.setItem('lastSentDate', today);
		showToast('🚀 Tin nhắn đã được gửi!');
	}

	// Thực hiện ngay 1 lần khi mở kết nối
	checkAndSend();
};

ws.onmessage = (event) => {
	console.log('📩 Server trả về:', event.data);
};

ws.onerror = (err) => {
	console.error('❌ WebSocket lỗi:', err);
	showToast('❌ WebSocket lỗi');
};

ws.onclose = () => {
	console.log('🔒 WebSocket đóng');
};
```
</details>

### Auto copy file

<details>
  <summary>👉 copy_image.ps1</summary>

```
param(
    [string]$Source = 'C:\Users\admin\Downloads\AnhServer\test',
    [string]$Target = "$PSScriptRoot\images",
    [switch]$Overwrite  # nếu thêm -Overwrite khi chạy thì sẽ ghi đè thay vì đổi tên
)

# supported extensions (lowercase, includes leading dot)
$exts = '.jpg','.jpeg','.png','.gif','.bmp','.tif','.tiff','.webp','.heic'

if (-not (Test-Path $Source)) {
    Write-Error "Source path does not exist: $Source"
    exit 1
}

if (-not (Test-Path $Target)) {
    New-Item -Path $Target -ItemType Directory -Force | Out-Null
}

Write-Host "==== START COPYING (FLATTEN MODE) ===="
Write-Host "Source : $Source"
Write-Host "Target : $Target"
Write-Host "Overwrite: $($Overwrite.IsPresent)"
Write-Host ""

# Get files
$files = Get-ChildItem -Path $Source -Recurse -File -ErrorAction SilentlyContinue |
         Where-Object { $exts -contains $_.Extension.ToLower() }

Write-Host "Found $($files.Count) image files.`n"

$copied = 0
foreach ($f in $files) {
    try {
        Write-Host "Scanning: $($f.DirectoryName)"
        $dest = Join-Path $Target $f.Name

        if (-not $Overwrite.IsPresent) {
            if (Test-Path $dest) {
                $base = [System.IO.Path]::GetFileNameWithoutExtension($f.Name)
                $ext  = $f.Extension
                $i = 1
                do {
                    $candidate = "{0} ({1}){2}" -f $base, $i, $ext
                    $dest = Join-Path $Target $candidate
                    $i++
                } while (Test-Path $dest)
            }
            Copy-Item -LiteralPath $f.FullName -Destination $dest -ErrorAction Stop
        } else {
            # Overwrite mode
            Copy-Item -LiteralPath $f.FullName -Destination $dest -Force -ErrorAction Stop
        }

        Write-Host "Copied: $($f.FullName) -> $dest"
        $copied++
    } catch {
        Write-Warning "ERROR copying $($f.FullName) : $_"
    }
}

Write-Host "`n==== DONE ===="
Write-Host "Total copied: $copied"
```
</details>
