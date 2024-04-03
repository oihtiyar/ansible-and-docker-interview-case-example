# Case Çözümüne İlişkin Bilgiler

Bu projede, tamamlanmayı bekleyen iki adet talep bulunmaktadır. Ayrıca, Case sunucusuna bağlandığınızda karşılaşacağınız bazı başlangıç sorunları da bulunmaktadır.

Case sahipleri, bazı temel komutların yetkileri ile oynamış ve işlevsiz hale getirmiş durumdadırlar. Hatırladığım kadarıyla; **wget**, **ping**, **curl** gibi bazı komutlar çalışmamaktadır. Bu sorunu çözmek için ilgili kullanıcıya gerekli dosya yetkilerinin verilmesi gerekmektedir. Ayrıca, update ve install komutları da çalışmamaktadır, bu nedenle repo listesinin güncellenmesi veya yeniden oluşturulması gerekmektedir.

![image](https://github.com/oihtiyar/case-i-need-to-solve/assets/50960588/b76d5464-0e2c-4ff6-803a-3210a296154e)
Görselde görebileceğiniz üzere, Case-A'da bize bir uygulama seçmemizi ve kurulum adımlarına bağlı kalarak Case'i çözmeyi beklemektedirler.

Benim tercihim, mongoDB cluster ile ilerlemektir. İlk olarak, Case sunucusuna Ansible ve Docker kurulumlarını yapmamız gerekmektedir. İlgili kurulumları gerçekleştirdikten sonra,
MongoDB cluster kurulumuna başlıyorum. 3 node'lu, 1 tane primary ve diğerlerinin secondary olacak şekilde bir mimari tasarladım. İlk başlarda bu konuda zorluklar yaşadım çünkü replica set tanımlamalarında sık sık hata alıyordum. Yaptığım araştırmalar sonucunda, mongo:6 veya mongo:7 sürümleri ile ve ayrı bir network oluşturmak ve ortak bir data volume ile daha ilerlemenin daha sağlıklı olacağını fark ettim. 

Docker'in resmi sitesinden mongo:6 kararlı sürümüne ait Dockerfile'ı kullanmaya karar verdim. Değişkenleri tanımlamak için bir .sh dosyası oluşturdum. Bu image'i oluşturduktan sonra, Docker'ı kullanarak 3 container'ı da ayağa kaldırdım. Tüm bunlar tamamlandıktan sonra primary makineye erişerek replika set tanımlamalarını yaptım ve bir DB admin kullanıcısı oluşturdum. Daha sonra replika set'in durumunu kontrol ettim ve her şeyin istediğim gibi olduğunu gördüm. Tüm bu adımları Ansible ile otomatikleştirmek için Dockerfile dosyamı yeniden düzenledim ve entrypoint.sh dosyasına olan bağımlılığı kaldırmaya karar verdim. mongo-cluster-playbook.yml isminde bir playbook oluşturdum ve bu, 3 adet mongo container'ını sırayla ayağa kaldıracak şekilde düzenledim.

Replica set tanımlamalarını playbook'a henüz aktaramadım, ancak umuyorum ki kısa sürede bunu da başaracağım.

Case-B için ise, python:3.9-slim versiyonunu kullanarak bir image oluşturdum. Dockerfile içerisine, container ayağa kalktığında çalışacak bir komut ekledim. Böylece, binance_exchange_rates.py dosyasını okuyarak script çalıştıktan sonra her 5 dakikada bir Binance API'sinden aldığı verileri exchange_rates.txt olarak dışarıya yazacak şekilde tanımladım.

Bu süreçte özellikle Python kısmında yapay zeka desteği aldım. İlk tasarladığım versiyon, script'in saat aralıklarını doğru şekilde alamıyordu; örneğin, 12:05 veya 12:10 gibi. Şimdi ise script ne zaman çalışırsa o zaman verileri alıp getiriyor.


![image](https://github.com/oihtiyar/case-i-need-to-solve/assets/50960588/2b3d2ebf-5bdc-44e5-ae52-b5b7a68f6247)
