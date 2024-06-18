
## **Zaman Serisinin İncelenmesi**
Çalışmada kullanılan ve Türkiye’de 2014.01 – 2022.12 dönemi arasındaki aylık istihdam edilen nüfus sayılarını gösteren seri, TÜİK tarafından yayınlanan Temel İşgücü İstatistiklerinden alınmıştır. Kurumsal olmayan çalışma çağındaki tüm nüfus istihdam edilen nüfustur. Burada kurumsal olmayan nüfus üniversite yurtları, yetiştirme yurtları (yetimhane), huzurevi, özel nitelikteki hastane, hapishane, kışla vb. yerlerde ikamet edenler dışında kalan nüfus anlamına gelmektedir. Kurumsal olmayan çalışma çağındaki nüfus ise kurumsal olmayan nüfus içerisindeki 15 ve daha yukarı yaştaki nüfustur.

Öncelikle serinin grafiği çizilerek trend, mevsimsellik gibi bileşenleri belirlenmeye çalışılmıştır.

![](Aspose.Words.61ff1640-db43-4c66-a17f-ac6524cde65f.001.png)

Grafik incelendiğinde, seride yukarı doğru bir trend olduğu görülmektedir. Ayrıca yıllık olarak tekrarlanan bir mevsimsellik olduğu da görülmektedir.

Serinin trend ve mevsimsellik bileşenlerini incelemek için ACF ve PACF grafikleri incelenmiştir. Serideki döngünün tamamının görülebilmesi için grafikler gecikme uzunluğu maksimum olacak şekilde çizilmiştir.

![](Aspose.Words.61ff1640-db43-4c66-a17f-ac6524cde65f.002.png)

ACF grafiği incelendiğinde, serinin 1. gecikmede güçlü bir pozitif otokorelasyona sahip olduğu görülmektedir; yani serinin t zamanındaki (son değer) değerinin bir ay önceki değeri ile arasında pozitif yönde yüksek korelasyon vardır. Gecikme sayısı arttıkça korelasyonun zayıfladığı görülmektedir. Grafikte yüksek gecikmelerde otokorelasyonların tekrar yükselmesi , zaman serisinde mevsimsellik bileşeninin olduğunu göstermektedir. Grafikte 12 aylık periyotlar arasında korelasyonlarda dalgalanmalar görülmesi, yaklaşık 12 aylık periyodu olan bir mevsimsellik bileşenine işaret etmektedir. Sonuç olarak serinin ACF grafiği zaman serisinin pozitif otokorelasyonlu olduğunu, yani zaman serisinin değerlerinin geçmiş değerleriyle ilişkili olduğunu göstermektedir. 

![](Aspose.Words.61ff1640-db43-4c66-a17f-ac6524cde65f.003.png)

Serinin PACF grafiği incelendiğinde, zaman serisi ile birinci gecikmesi arasında yüksek bir pozitif korelasyon olduğu görülmektedir. Yani seri bir gecikme önceki değerleri ile yüksek derecede ilişkilidir. İkinci gecikme ile birlikte korelasyonlar önemsiz bir seviyeye düşmüştür, yani seri yalnızca kendinden bir önceki değerlerden etkilenmektedir. Bu durum seride AR(1) sürecinin olduğuna işaret etmektedir.

Özetleyecek olursak, ACF grafiğinde zamanla azalan korelasyon ve PACF grafiğinde 1. gecikmeden sonra korelasyonların önemsiz seviyeye gelmesi, zaman serisinde AR(1) bileşeni olduğuna işaret etmektedir. ACF grafiğinde yüksek gecikmelerde otokorelasyonların tekrar yükselmesi , zaman serisinde mevsimsellik bileşeninin olduğunu göstermektedir. Seriye ait zaman grafiği ise seride trend olduğunu göstermiştir. 

## **Toplamsal ve Çarpımsal Ayrıştırma Yöntemleri**
Toplamsal ve çarpımsal ayrıştırma yöntemleri, bir zaman serisini bileşenlerine (trend, mevsimsellik ve hata) ayırmaya yönelik iki farklı yaklaşımdır. Toplamsal ayrıştırma yönteminde bu bileşenler toplanarak model kurulur, çarpımsal modelde bileşenler çarpılarak model kurulur. İstihdam serisi hem toplamsal hem de çarpımsal ayrıştırma yöntemleri ile tahmin edilmiştir. Serinin gerçek değerleri ile elde edilen modeller ile tahmin edilmiş olan değerleri aynı zaman grafiğinde çizilerek modellerin performansı incelenmiştir. 

### ***Toplamsal ayrıştırma modeli***
![](Aspose.Words.61ff1640-db43-4c66-a17f-ac6524cde65f.004.png)

Toplamsal ayrıştırma modeli ile elde edilen tahminlerin, serinin gerçek değerlerinden önemli ölçüde sapmış olduğu görülmektedir. Model hataları da elde edilen modelin yetersiz olduğunu gösteriyordu. Ljung-Box Testi sonucunda hata serisinde otokorelasyon olduğu bulundu (χ<sup>2</sup> = 1028.4, sd = 107, p < 0.05).  Hata serisinin ACF ve PACF grafiklerinde serinin ak gürültü olmadığı görülüyordu. 

![](Aspose.Words.61ff1640-db43-4c66-a17f-ac6524cde65f.005.png)


### ***Çarpımsal ayrıştırma modeli***
![](Aspose.Words.61ff1640-db43-4c66-a17f-ac6524cde65f.006.png)

Çarpımsal ayrıştırma yöntemi ile elde edilen modelin de tahminleri gerçek seriden önemli ölçüde uzaktı. Modelin tahmin hataları oldukça yüksekti. Model hataları da elde edilen modelin yetersiz olduğunu gösteriyordu. Ljung-Box Testi sonucunda hata serisinin ak gürültü olmadığı bulundu (χ<sup>2</sup> = 1022.5, sd = 107, p < 0.05).  Hata serisinin ACF ve PACF grafikleri de serinin ak gürültü olmadığını gösteriyordu. 

![](Aspose.Words.61ff1640-db43-4c66-a17f-ac6524cde65f.007.png)


## **Üstel Düzleştirme Yöntemleri**
Üstel düzleştirme yöntemleri, seri trend ve mevsimsellik bileşenlerine sahip olduğunda özellikle etkili tahmin yöntemlerindendir. Üstel düzeltmenin ardındaki temel fikir, güncel gözlemlere daha fazla, eski gözlemlere ise daha az ağırlık vermektir. Üstel düzleştirme yöntemlerinin Çift Üstel Düzleştirme (Holt Yöntemi), Üçlü Üstel Düzleştirme (Holt-Winters Yöntemi), Toplamsal Winters yöntemi ve Çarpımsal Winters yöntemi gibi farklı versiyonları vardır. Holt yöntemi trend içeren ancak mevsimsellik içermeyen seriler için uygun bir yöntemdir. Holt-Winters Yöntemi hem trend hem mevsimsellik içeren serileri tahmin etmek için uygun bir yöntemdir. Toplamsal Winters yöntemi Holt-Winters yöntemi ile benzerdir trend ve mevsimsellik içeren serileri tahmin etmek için uygun bir yöntemdir. Serinin mevsimsellik bileşeni sabitse (zamanla periyodun genişliği değişmiyorsa) iyi sonuçlar verir. Çarpımsal Winters yöntemiyse mevsimsellik bileşeni değişiyorsa (zamanla periyodun genişliği değişiyorsa) iyi sonuçlar verir.

İstihdam serisi Holt-Winters, Toplamsal Winters ve Çarpımsal Winters yöntemleri ile tahmin edilmiştir. Serinin gerçek değerleri ile elde edilen modeller ile tahmin edilmiş olan değerleri aynı zaman grafiğinde çizilerek modellerin performansı incelenmiştir. Gelecek 5 ayın istihdam verisi kurulan modeller ile tahmin edilerek, grafiklere eklenmiştir.

### ***Holt-Winters Modeli***
![](Aspose.Words.61ff1640-db43-4c66-a17f-ac6524cde65f.008.png)

Holt-Winter yöntemi ile tahmin edilen veri gerçek veriye oldukça benzer bir görünümdeydi, model hataları küçüktü. Ancak modelin hatalarının analizi modelin yeterli olmadığını gösterdi. Ljung-Box Testi sonucunda hata serisinde otokorelasyon olduğu bulundu (χ<sup>2</sup> = 228.7, sd = 107, p < 0.05).  Hata serisinin ACF ve PACF grafikleri ak gürültüye yakın bir görünümde olsada, bazı korelasyonların anlamlı düzeyde yüksek olduğu ve tekrarlayan örüntüler olduğu görülüyordu. Hataların ak gürültü olmadığına karar verildi. Bu durum modelin yetersiz olduğunu, gelecek üzerine öngörülerinin güvenilmez olabileceğini göstermektedir. 

![](Aspose.Words.61ff1640-db43-4c66-a17f-ac6524cde65f.009.png)

### ***Toplamsal Winters Modeli***
![](Aspose.Words.61ff1640-db43-4c66-a17f-ac6524cde65f.010.png)

Toplamsal Winters yöntemi ile tahmin edilen veri gerçek veriye oldukça benzer bir görünümdeydi, model hataları küçüktü. Modelin hatalarının analizi, modelin yeterli olduğunu gösterdi. Ljung-Box Testi sonucunda hata serisinde otokorelasyon olmadığı bulundu (χ<sup>2</sup> = 112.28, sd = 107, p = 0.344).  Hata serisinin ACF ve PACF grafikleri serinin ak gürültü olduğunu, otokorelasyon bulunmadığını gösteriyordu. Toplamsal Winters modelinin istihdam verilerini tahmin etmek için yeterli bir model olduğuna karar verildi.

![](Aspose.Words.61ff1640-db43-4c66-a17f-ac6524cde65f.011.png)

### ***Çarpımsal Winters Modeli***
![](Aspose.Words.61ff1640-db43-4c66-a17f-ac6524cde65f.012.png)

Modelin gerçek seriden sapmaları incelendiğinde, 2020 – 2023 dönemi arasında tahmin edilen verilerin gerçek veriden sapmalarında bir artış olduğu görülmektedir.  Yine de Çarpımsal Winters yöntemi seriyi tahmin etmede başarılı görünmektedir. Modelin hatalarının analizi, modelin yeterli olduğunu göstermiştir. Ljung-Box Testi sonucunda hata serisinde otokorelasyon olmadığı bulunmuştur (χ<sup>2</sup> = 101.38, sd = 107, p = 0.635).  Hata serisinin ACF ve PACF grafikleri serinin ak gürültü olduğunu, otokorelasyon bulunmadığını gösteriyordu. Çarpımsal Winters modelinin de istihdam verilerini tahmin etmek için yeterli bir model olduğuna karar verilmiştir.

![](Aspose.Words.61ff1640-db43-4c66-a17f-ac6524cde65f.013.png)

Toplamsal ve çarpımsal Winters modellerini karşılaştırmak amacıyla tahmin serileri aşağıdaki grafikte birlikte verilmiştir. İki modelin tahminleri birbirlerine oldukça yakındır. 

![](Aspose.Words.61ff1640-db43-4c66-a17f-ac6524cde65f.014.png)



## **Box-Jenkins Modelleri (ARİMA)**
Box-Jenkins modelleri, aynı zamanda otoregresif entegre hareketli ortalama (ARIMA) modelleri olarak da bilinir. ARIMA’nın üç temel bileşeni vardır: otoregresif (AR), entegre  (l) ve hareketli ortalama (MA). Entegre bileşeni, zaman serisi verilerini durağan hale getirmek için alınan fark sayısını ifade eder. İstihdam serisi düzeyde ve ilk 4 farkta durağan değildir. Daha yüksek farkların durağanlığı test edilmemiştir. 

MA bileşeni serinin değerlerinin hatalar ile ilişkisini temsil eder. Bu bileşen kendini ACF grafiğinde, ilk gecikmelerde yüksek korelasyon, ardından gelen gecikmelerde hızla sıfıra yaklaşan korelasyon değerleri biçiminde gösterir. Örneğin, MA(1) durumunda, ACF grafikte birinci gecikmede otokorelasyon yüksek olacaktır, ikinci ve sonraki gecikmelerde otokorelasyon sıfıra yaklaşacaktır. MA(2) de ise, ilk iki gecikmede otokorelasyon yüksek olacaktır, üçüncü ve sonraki gecikmelerde otokorelasyon sıfıra yaklaşacaktır. MA bileşeni PACF grafiğinde yüksek başlayan ve zamanla azalan bir korelasyon örgüsü şeklinde gösterir. İstihdam serisinin ACF ve PACF grafikleri seride MA bileşeni olmadığına işaret etmektedir.

AR bileşeni mevcut gözlemin geçmiş gözlemlerle olan ilişkisini temsil eder. Bu bileşen ACF grafiğinde yüksek başlayan ve zamanla azalan bir korelasyon örgüsü şeklinde görülür. PACF grafiğinde ise, ilk gecikmelerde yüksek korelasyon, ardından gelen gecikmelerde hızla sıfıra yaklaşan korelasyon değerleri biçiminde gösterir. Örneğin, AR(1) durumunda, PACF grafiğinde birinci gecikmede otokorelasyon yüksek olacaktır, ikinci ve sonraki gecikmelerde otokorelasyon sıfıra yaklaşacaktır. AR(2) de ise, ilk iki gecikmede otokorelasyon yüksek olacaktır, üçüncü ve sonraki gecikmelerde otokorelasyon sıfıra yaklaşacaktır. İstihdam serisinin ACF ve PACF grafikleri seride AR(1) bileşeni olduğuna işaret etmektedir.

SARİMA modellerinde ise ARİMA modelinin bileşenlerine ek olarak mevsimsellik bileşeni vardır. SARİMA modeli mevsimsel döngüye sahip verileri modellemek ve tahmin etmek için kullanılır. İstihdam serisinde mevsimsel bileşen olduğundan, bu seriyi modellemek için ARİMA’ya göre daha etkili bir modeldir.  Yine de ARİMA modellerin yeterliliğini de inceleyebilmek amacıyla, serinin ARİMA modelleri de tahmin edilmiştir. 

Gelecek 5 ayın istihdam verisi kurulan modeller ile tahmin edilerek, grafiklere eklenmiştir.
### ***ARİMA(1,0,0) modeli***
![ref1]

ARİMA(1,0,0) ile tahmin edilen verinin serinin gerçek değerlerinden fazla sapmadığı görülmektedir. Ancak modelin hatalarının analizi, modelin yeterli olmadığını göstermiştir. Ljung-Box Testi sonucunda hata serisinde otokorelasyon olduğu bulundu (χ<sup>2</sup> = 227.49, sd = 107, p < 0.05).  Hata serisinin ACF ve PACF grafikleri serinin ak gürültü olmadığını, hatalar arasında otokorelasyon bulunduğunu gösteriyordu. ARİMA(1,0,0) modelinin istihdam verilerini tahmin etmek için yetersiz bir model olduğuna, gelecek üzerine öngörülerinin güvenilmez olabileceğine karar verildi.

![](Aspose.Words.61ff1640-db43-4c66-a17f-ac6524cde65f.016.png)

### ***ARİMA(1,1,0) modeli***
![ref1]

ARİMA(1,1,0) ile tahmin edilen verinin serinin gerçek değerlerinden fazla sapmadığı görülmektedir. Ancak modelin hatalarının analizi, modelin yeterli olmadığını göstermiştir. Ljung-Box Testi sonucunda hata serisinde otokorelasyon olduğu bulundu (χ<sup>2</sup> = 201.5, sd = 107, p < 0.05).  Hata serisinin ACF ve PACF grafikleri serinin ak gürültü olmadığını gösteriyordu. ARİMA(1,1,0) modelinin yetersiz bir model olduğuna, gelecek üzerine öngörülerinin güvenilmez olabileceğine karar verildi.

![](Aspose.Words.61ff1640-db43-4c66-a17f-ac6524cde65f.017.png)

### <a name="_hlk153554343"></a>***SARIMA (1,0,0)(2,1,0)[12] modeli***
Bu model “auto.arima” fonksiyonu ile oluşturulmuştur. Elde edilen modelde serinin mevsimsellik döngü uzunluğu 12 olarak belirlenmiştir. Seride iki adet mevsimsel otoregresyon terimi vardır, seri mevsimsel döneme göre 1. fark durağandır ve mevsimsel hareketli ortalama terimi bulunmamaktadır (2,1,0). 

![](Aspose.Words.61ff1640-db43-4c66-a17f-ac6524cde65f.018.png)

Tahmin edilen verinin serinin gerçek değerlerinden fazla sapmadığı görülmektedir. Modelin hatalarının analizi, modelin yeterli olduğunu göstermiştir. Ljung-Box Testi sonucunda hata serisinde otokorelasyon olmadığı bulunmuştur (χ<sup>2</sup> = 75.84, sd = 107, p = 0.990).  Hata serisinin ACF ve PACF grafikleri serinin ak gürültü olduğunu, otokorelasyon bulunmadığını göstermiştir. SARIMA (1,0,0)(2,1,0)[12] modelinin istihdam verilerini tahmin etmek için yeterli bir model olduğuna karar verilmiştir.

![](Aspose.Words.61ff1640-db43-4c66-a17f-ac6524cde65f.019.png)


## **Regresyon Modelleri**
### ***Toplamsal regresyon modeli***
Serinin trend ve mevsimsellik bileşenlerinin bağımsız değişken olduğu toplamsal regresyon modeli tahmin edilmiştir. Gerçek seri, tahmin edilmiş seri ve gelecek 5 gözlem için öngörü birlikte çizilerek modelin tahmin başarısı incelenmiştir.

![](Aspose.Words.61ff1640-db43-4c66-a17f-ac6524cde65f.020.png)

Hem trendin hem de mevsimsellik bileşenine ait iki bağımsız değişkenin regresyon modelinde istatistiksel olarak anlamlı olduğu bulunmuştur. Toplamsal regresyon modeli ile tahmin edilen verinin serinin gerçek değerlerinden önemli ölçüde saptığı görülmektedir. Model hatalarının analizi de elde edilen modelin yetersiz olduğunu göstermiştir. Ljung-Box Testi sonucunda hata serisinde otokorelasyon olduğu bulunmuştur (χ<sup>2</sup> = 970.91, sd = 107, p < 0.05).  Durbin-Watson testi de hata terimlerinde otokorelasyon olduğunu göstermiştir (DW = 0.210, p < 0.05). Hata serisinin ACF ve PACF grafikleri de serinin ak gürültü olmadığını göstermiştir.

![](Aspose.Words.61ff1640-db43-4c66-a17f-ac6524cde65f.021.png)

### ***Çarpımsal regresyon modeli***
Serinin trend ve mevsimsellik bileşenlerinin bağımsız değişken olduğu çarpımsal regresyon modeli tahmin edilmiştir. Gerçek seri, tahmin edilmiş seri ve gelecek 5 gözlem için öngörü birlikte çizilerek modelin tahmin başarısı incelenmiştir.

![](Aspose.Words.61ff1640-db43-4c66-a17f-ac6524cde65f.022.png)

Serinin trendinin ve mevsimsellik bileşenine ait bağımsız değişkenlerden sinüsün regresyon modelinde istatistiksel olarak anlamlı olduğu bulunmuştur. Mevsimsellik bileşenine ait diğer bağımsız değişken olan cosinüs modelde istatistiksel olarak anlamlı değildi.  Çarpımsal regresyon modeli ile tahmin edilen verinin serinin gerçek değerlerinden önemli ölçüde saptığı görülmektedir. Model hatalarının analizi de elde edilen modelin yetersiz olduğunu göstermiştir. Ljung-Box Testi sonucunda hata serisinde otokorelasyon olduğu bulunmuştur (χ<sup>2</sup> = 874.32, sd = 107, p < 0.05).  Durbin-Watson testi de hata terimlerinde otokorelasyon olduğunu göstermiştir (DW = 0.216, p < 0.05). Hata serisinin ACF ve PACF grafikleri de serinin ak gürültü olmadığını göstermiştir.

![](Aspose.Words.61ff1640-db43-4c66-a17f-ac6524cde65f.023.png)

### ***Karesel regresyon modeli***
Serinin trend bileşenlerinin ve trend bileşeninin karesinin bağımsız değişken olduğu karesel regresyon modeli tahmin edilmiştir. Gerçek seri, tahmin edilmiş seri ve gelecek 5 gözlem için öngörü birlikte çizilerek modelin tahmin başarısı incelenmiştir.

![](Aspose.Words.61ff1640-db43-4c66-a17f-ac6524cde65f.024.png)

Hem trend ve trendin karesinin regresyon modelinde istatistiksel olarak anlamlı olmadığı bulunmuştur. Karesel regresyon modeli ile tahmin edilen verinin serinin gerçek değerlerinden önemli ölçüde saptığı görülmektedir. Model hatalarının analizi de elde edilen modelin yetersiz olduğunu göstermiştir. Ljung-Box Testi sonucunda hata serisinde otokorelasyon olduğu bulunmuştur (χ<sup>2</sup> = 866.03, sd = 107, p < 0.05).  Durbin-Watson testi de hata terimlerinde otokorelasyon olduğunu göstermiştir (DW = 0.213, p < 0.05). Hata serisinin ACF ve PACF grafikleri de serinin ak gürültü olmadığını göstermiştir.

![](Aspose.Words.61ff1640-db43-4c66-a17f-ac6524cde65f.025.png)

### ***Kübik regresyon modeli***
Serinin trend bileşenlerinin ve trend bileşeninin karesinin ve küpünün bağımsız değişkenler olduğu kübik regresyon modeli tahmin edilmiştir. Gerçek seri, tahmin edilmiş seri ve gelecek 5 gözlem için öngörü birlikte çizilerek modelin tahmin başarısı incelenmiştir.

![](Aspose.Words.61ff1640-db43-4c66-a17f-ac6524cde65f.026.png)

Üç bağımsız değişken regresyon modelinde istatistiksel olarak anlamlıdır. Kübik regresyon modeli ile tahmin edilen verinin serinin gerçek değerlerinden önemli ölçüde saptığı görülmektedir. Model hatalarının analizi de elde edilen modelin yetersiz olduğunu göstermiştir. Ljung-Box Testi sonucunda hata serisinde otokorelasyon olduğu bulunmuştur (χ<sup>2</sup> = 739.82, sd = 107, p < 0.05).  Durbin-Watson testi de hata terimlerinde otokorelasyon olduğunu göstermiştir (DW = 0.334, p < 0.05). Hata serisinin ACF ve PACF grafikleri de serinin ak gürültü olmadığını göstermiştir.

![](Aspose.Words.61ff1640-db43-4c66-a17f-ac6524cde65f.027.png)

### ***Üstel regresyon modeli***
Serinin trendinin bağımsız değişken olduğu üstel regresyon modeli tahmin edilmiştir. Gerçek seri, tahmin edilmiş seri ve gelecek 5 gözlem için öngörü birlikte çizilerek modelin tahmin başarısı incelenmiştir. 

![](Aspose.Words.61ff1640-db43-4c66-a17f-ac6524cde65f.028.png)

Trend değişkeni regresyon modelinde istatistiksel olarak anlamlıdır. Kübik regresyon modeli ile tahmin edilen verinin serinin gerçek değerlerinden önemli ölçüde saptığı görülmektedir. Model hatalarının analizi de elde edilen modelin yetersiz olduğunu göstermiştir. Ljung-Box Testi sonucunda hata serisinde otokorelasyon olduğu bulunmuştur (χ<sup>2</sup> = 813.97, sd = 107, p < 0.05).  Durbin-Watson testi de hata terimlerinde otokorelasyon olduğunu göstermiştir (DW = 0.221, p < 0.05). Hata serisinin ACF ve PACF grafikleri de serinin ak gürültü olmadığını göstermiştir.

![](Aspose.Words.61ff1640-db43-4c66-a17f-ac6524cde65f.029.png)



[ref1]: Aspose.Words.61ff1640-db43-4c66-a17f-ac6524cde65f.015.png
