# IPPTT By Haocomm
![image](https://i.imgur.com/fU1z9wS.png)

  Web Management Dashboard สำหรับทำหน้าที่จัดการ Dashboard ของ mumble / Traccar 
ซึ่งก็จะนำบาง function ของ mumble และ Traccar มาใช้งาน เพื่อให้ง่ายกับผู้ดูแลระบบ  ตอนนี้กำลังอยู่ในช่วงพัฒนาอยู่ครับ
มารู้จักกับ คำศัพท์ mumble / Traccar / Talkkonnect
- mumble คือ voice communication server ซึ่งเป็น open source สามารถใช้งานได้ฟรี ใช้สำหรับติดต่อสื่อสารกันระหว่างกัน โดย mumble มี client application สามารถติดตั้งบนมือถือ android/ ios / PC และที่สำคัญ talkkonnect สามารถใช้งานร่วมกับ mumble
- Traccar คือ  GPS Tracking Platform ซึ่งเป็น open source สามารถใช้งานได้ฟรี ใช้สำหรับเป็น GPS tracking สามารถใช้ตรวจสอบสถานะตำแหน่งของอุปกรณ์ได้
- Talkkonnect คือ A Headless Mumble Client/Transceiver/Walkie Talkie/Intercom/Gateway ซึ่งเป็น open source สามารถใช้งานได้ฟรี
     เราสามารถนำ talkkonnect มาทำเป็น walkie talkie หรือเป็น ROIP Gateway เชื่อมต่อกับ Radio และใช้งานร่วมกับ voip ได้ครับ
ทีนี้มาถึงตัว Web Management Dashboard ที่แอดมิน กำลังพัฒนาจะมี Feature หลัก ๆ ดังนี้ครับ
- Show Server Status => สำหรับแสดงภาพรวม ของระบบ เช่น User online, uptime, จำนวน server  ที่ online
- Create Channel => สำหรับจัดการ Channel ในการสื่อสารให้กับผู้ใช้งานในระบบ (แก้ไขชื่อ Channel, เพิ่ม, ลบ)
- Server Configuration => ตั้งค่าจำนวน user max limit บน mumble server
- Managers (Create Manager) => จัดการ Admin Role/ User Role ต่าง ๆ ในระบบ 
- Users (Create New User) => จัดการ User List (edit, save, delete) รายชื่อผู้ใช้งานในระบบทั้งหมด
- Users Location (Maps) => แสดง Maps ตำแหน่งของผู้ใช้งานในระบบที่อุปกรณ์มี GPS จะแสดงข้อมูลชื่อ สถานะ online ของผู้ใช้งาน
- Devices Status (show device raspberry pi) => แสดง devices อุปกรณ์สื่อสารในระบบทั้งหมด สามารถสั่ง mute, unmute เสียงของอุปกรณ์ได้
- Auto provision (configuration xml) for device raspberry pi => สามารถตั้งค่า configuration file ของอุปกรณ์สื่อสาร raspberry pi จากส่วนกลางทั้งหมด
- Logging report => แสดงรายงาน event ต่าง ๆ ของผู้ใช้งานในระบบ เช่น join เข้าใช้งานระบบ, disconnect เป็นต้น
- Login for Admin (support Oauth 2.0 SSO)=> สำหรับให้ผู้ใช้งาน System Admin ล็อกอินเข้าสู่ระบบเพื่อจัดการ Web Management Dashboard
- Talk online  เป็น mumble web client ซึ่งสามารถ ใช้งาน mumble client ผ่าน Web browser

URL DEMO: https://demo-tk.haocomm.com



# cloudflared-tunnel-webfront
```
git clone https://github.com/haocomm/ipptt-demo-site.git

cd cloudflare

docker run -v ${PWD}/config:/root/.cloudflared msnelling/cloudflared cloudflared tunnel login

docker run -v ${PWD}/config:/etc/cloudflared msnelling/cloudflared cloudflared tunnel create <name tunnel>
```

```
echo 'tunnel: uuid tunnel' > config/config.yaml
```
## Cloudflared
```
docker-compose up -d
docker-compose logs -f
```

## Check your tunnel is visible on the Cloudflare Zero Trust Dashboard ->(https://dash.teams.cloudflare.com/)
Access > Tunnels

## Cloudflared
```
nano cloudflare-tunnel-wordpress/config/config.yml
ingress:
        - hostname: <site url>
          service: http://nginx-webfront:80
        - service: http_status:404
```
```
docker-compose restart cloudflared
```
## Change the DNS settings of your domain
```
Add  CNAME record to <UUID of your tunnel>.cfargotunnel.com
```

## Deploy Webfront site
```
cd cloudflare/demo-tk.haocomm.com

docker-compose up -d
```

## Deploy IPPTT STACK
```
docker-compose up -d
```