# **Ini template bloc sederhana cuy**

**Oke perhatian ! Sebelum copas ini coba liat dulu deh version dependencies di pubspec.yaml**

Bentar ada beberapa peraturan di codingan gua ini cuy
1. **bloc disini gak boleh saling berhubungan antara feature**, ini untuk meminimalisir kebingungan kalo udah banyak codingannya (bener dah pusing betulinnya) jadi gua kalo mau kirim data antara halaman, harus lewat constructor.
2. jangan jadiin satu semua di view, coba dipisah di folder core->ui, nah disini harus pahamin dulu konsep **atomic design**
3. nanti kalo ada lagi gua kasih tau....


oke cuy gua jelasin dulu nih, disini gua pisahin bloc berdasarkan featurenya, kaya peraturan pertama yg udah gua jelasin diatas, ini gua lakuin biar lebih mudah dalam maintenisnya, jadi kalo aplikasi lu punya banyak fitur lu gak perlu takut lagi kalo lu edit di satu fitur eh nanti **errornya merembet kemana-mana**. contoh nih gua punya fitur nampilin list product, nah list product ini gua buat disatu feature, fitur yg berhubungan sama list product gua pisah di featur lainya. 

A : Gimana dong cara ambil datanya? 
B : ya lu tinggal kirim aja lewat constructor. 
A : Yah gak cepet dong datanya, gua maunya cepet, ah gak bagus nih
B : ya kalo aplikasinya cuma dikit fiturnya mungkin bisa aja blocnya saling berkaitan, tapi kalo udah banyak fiturnya lu bakal kebingungan cuy. kalo mau cepet bisa lu cache kok, mau tau caranya? bukan disini tapi wkwk

sekarang bahas folder

pertama ada folder **core**

folder core ini fungsinya untuk **method/class yang dipake secara global** cuy,
setiap service bisa lu taro di folder services, ui di folder ui, dll....
(ada beberapa service yg gua buat yg bakal berguna buat nanti tunggu aja yak)
jadi taro sini yak kalo mau bikin method/class global.

lanjut nih di folder features udah ada template tuh 

- **bloc** (ini bisa dibuat pake plugin bloc di vs code)
- **model**
- **views**

itu folder template diatas bisa lu **copy** cuy kalo setiap mau buat feature baru. jangan lupa di **rename** yak,
sisanya yaudah main. liat aja mainnya yak jangan banyak tanya wkwk
kalo mau nanya dan ada masukan langsung aja ke telegram gua cuy [https://t.me/saddamnur](https://t.me/saddamnur)


