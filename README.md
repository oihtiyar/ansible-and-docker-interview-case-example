Bizden istenen bu Case de 2 adet tamamlanmayı bekleyen talep var. Bunların yanı sıra Case sunucusuna bağlandığınızda sizi bekleyen bazı sorunlarla işe başlamanız gerekiyor.

Çünkü case sahipleri, bazı temel komutların yetkileri ile oynamış ve çalışamaz hale getirmiş durumdalar, hatırladığım kadarıyla; wget, ping, curl gibi bazı komutlar çalışmıyordu, 
çözüm için ilgili user'a gerekli dosya yetkilerinin verilmesi gerekiyor. Update ve install komutları çalışmıyor bu yüzden repo listesi güncellemenmeli veya rebuild edilmeli.

![image](https://github.com/oihtiyar/case-i-need-to-solve/assets/50960588/b76d5464-0e2c-4ff6-803a-3210a296154e)
Görselde görebileceğiniz üzere Case-A' da bizden bir uygulama seçmemizi ve kurulum adımlarına bağlı kalarak case'i çözmemizi bekliyorlar.

Bu noktan sonra benim tercihim mongoDB cluster ile ilerlemek olacak.
ilk olarak case sunucusuna ansible ve docker kurulumlarını yapmamız gerekiyor. aşağıdaki komut setleri ile kurulumları gerçekleştiriyorum.

yum install ansible
   sudo yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine
   sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
   sudo yum install docker-ce docker-ce-cli containerd.io
   sudo systemctl start docker
   sudo systemctl enable docker
   yum install ansible


bir sonraki önceliğim mongodb cluster kurmak, 3 node'lu 1 tane primary diğerleri de secondary olacak şekilde bir mimarı tasarlamıştım, 
açıkcası bu noktada ilk başlarda çok zorlandım. Çünkü db tarafında replica set tanımlamalarında çok sık fail alıyordum. Yaptığım araştırmalar neticesinde, 
mongo:6 veya 7 ile ve ayrı bir network oluşturarak ilerlersem benim için daha sağlıklı olacağını farkettim ve docker offical-image sitesinden 
mongo:6 kararlı sürümüne ait docker file kullanmaya karar verdim. Değişkenleri tanımlamak için de bir .sh dosyası oluşturdum. 
Bu image build ettikten sonra, docker run ile birlikte port, network, replika set gibi tanımları kullanarak 3 container'ı da ayağa kaldırdım. 
Tüm bunlar bittikten sonra primary makineye erişerek replika set tanımlarını yaptım ve bir db admin user oluşturdum. Daha sonra replika set status kontrol ettim ve her şeyin 
istediğim gibi olduğunu gördüm. Daha sonra tüm bunları ansible ile yapabilmek için; dockerfile dosyamı yeniden düzenledim entrypoint.sh dosyasına olan bağımlılığı da kaldırmanın 
faydalı olacağına karar verdim. mongo-cluster-playbook.yml ismiyle bir playbook oluşturdum ve bununla birlikte 3 adet mongo container'i sırayla ayağa kaldıracak şekilde düzenledim.

replicaset tanımlarını playbook üzerine henüz aktaramadım ama umuyorum ki kısa sürede bunu da başaracağım.


Case-B için python:3.9-sli versiyonunu kullanarak bir image oluşturdum. Dockerfile içerisine container ayağa kalktığında
çalışacak bir komut girdim bu sayede binance_exchange_rates.py dosyasını okuyarak script çalıştıktan sonraki her 5dk'da
bir, binance apisinden gidip aldığı verileri exchange_rates.txt olarak dışarı yazacak şekilde tanımladım.

bunu yaparken özellikle phyton kısmında yapayzeka'dan da destek aldım. Hatırlarsanız ilk tasarladığım haliyle saat 
aralıklarını script çalıştığında değil 12:05, 12:10 gibi düzelterek alıyordu şimdi ise script ne zaman çalıştıysa o zaman
alıp getiriyor.

![image](https://github.com/oihtiyar/case-i-need-to-solve/assets/50960588/2b3d2ebf-5bdc-44e5-ae52-b5b7a68f6247)
