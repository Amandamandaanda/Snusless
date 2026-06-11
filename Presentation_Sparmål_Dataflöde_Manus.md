# Talmanus – Dataflöde för sparmål i Snusless

**Presentationsform:** Individuell skärminspelning i Xcode + appen
**Längd:** ca 5 minuter (lite över är okej)
**Publik:** Lärare/examinator · **Betygsnivå jag siktar på:** VG
**Min kod i det här flödet:** `User`-modellen + extensions, samt `HomeView`, `HomeViewModel` och `SavingsCard`
**Fokus:** Hur sparmålet och det sparade beloppet rör sig in i min `User`-modell och vidare ut i sparkortet på startsidan

> Sektionsrubrikerna är hållpunkter åt dig – du läser texten löpande. Allt i jag-form gäller kod jag själv byggt. Onboarding-vyerna nämner jag kort som mina lagkamraters delar, eftersom datan kommer därifrån.
>
> **OBS:** Anpassa sektion 7 (processreflektion) så den stämmer med hur ni faktiskt jobbat med PR:ar i teamet.

---

## 1. Introduktion (ca 0:00–0:30)

Hej. Jag ska visa hur datan för användarens sparmål rör sig genom vår app Snusless, med fokus på den kod jag själv har byggt. Jag har ansvarat för `User`-modellen och dess beräkningar, samt startsidan – `HomeView`, `HomeViewModel` och sparkortet `SavingsCard`. Jag följer alltså sparmålet och det sparade beloppet från att de landar i min datamodell tills att de visas och uppdateras live på startsidan. Vi jobbar med MVVM och SwiftData, och jag kommer också att resonera kring varför jag lagt logiken där jag gjort.

---

## 2. Var datan kommer ifrån (ca 0:30–1:05)

Själva sparmålet matas in tidigare i onboardingen, i en vy som en lagkamrat byggt. Där binds textfältet till en egenskap `savingGoal` i `OnboardingViewModel`, som håller värdet tillfälligt i minnet. När användaren skapas anropas `saveUser`, och där är min kod inblandad: det är min `User`-modell som tar emot värdet. Så datan flyttas från ett tillfälligt tillstånd i en view model till en permanent modell – och det är den modellen jag ska visa nu.

---

## 3. Min datamodell och beräkningar (ca 1:05–2:05)

Här är `User`-modellen som jag byggt. Den är markerad med `@Model`, vilket är SwiftDatas sätt att göra en klass sparbar i databasen. Egenskapen `savingsGoal` håller sparmålet, och `totalSaved` håller hur mycket användaren faktiskt har sparat hittills.

Den intressanta logiken ligger i min extension till `User`. Här har jag en beräknad egenskap `dailySavings`, som är antal dosor gånger priset per dosa – alltså vad användaren sparar per dag på att inte snusa. Jag valde att lägga den som en `computed property` direkt på modellen, eftersom det är ren domänlogik som hör ihop med användarens data. Då kan vem som helst i appen läsa `user.dailySavings` utan att räkna om det själv, och jag undviker att samma formel sprids ut i flera vyer.

Jag har även `calculateSavings`, som räknar besparingen över ett antal dagar genom att jämföra startdatum med dagens datum. Poängen med att samla de här beräkningarna på modellen är att de blir lätta att återanvända och testa, och att vyerna slipper känna till formlerna.

---

## 4. Startsidan: View och ViewModel enligt MVVM (ca 2:05–3:25)

Nu går vi till `HomeView`. Det här är min vy, och jag vill lyfta hur den kommunicerar med sin view model enligt MVVM.

Högst upp hämtar jag användaren med `@Query private var users: [User]`. `@Query` läser direkt ur SwiftData-databasen, så startsidan är helt frikopplad från onboardingen – den går rakt till källan. Vyn håller också en `HomeViewModel` som `@State`. Det viktiga är att `HomeView` inte innehåller någon affärslogik själv. När användaren trycker på "Jag klarade dagen!" anropar vyn bara `viewModel.checkToday` och skickar med användaren och `modelContext`. Vyn säger alltså *vad* som ska hända, men *hur* det görs ligger i view modellen.

Låt oss titta på `checkToday` i `HomeViewModel`. Funktionen börjar med att kontrollera om användaren redan checkat in idag – jag letar i `checkedinDays` efter ett datum som matchar dagens dag. Om det redan finns gör jag ingenting, vilket skyddar mot att man råkar dubbelregistrera samma dag. Annars lägger jag till dagens datum, uppdaterar den längsta streaken, och – det centrala för vårt flöde – ökar `totalSaved` med `dailySavings`. Sist anropar jag `context.save()` så att ändringen sparas permanent.

Att jag lagt den här logiken i view modellen och inte i vyn är ett medvetet MVVM-val: vyn ska vara enkel och bara visa data och fånga knapptryck, medan view modellen sköter logik och prat med databasen. Det gör koden lättare att läsa, testa och underhålla.

---

## 5. Sparkortet beräknar framsteget (ca 3:25–4:10)

`HomeView` skickar in värdena till mitt sparkort, `SavingsCard` – bland annat `user.savingsGoal` och `user.totalSaved`. `SavingsCard` är en ren presentationsvy: den tar emot färdiga värden och äger ingen egen affärslogik.

Det enda kortet räknar ut är hur långt användaren kommit. Det sker i den beräknade egenskapen `progressFraction`: jag tar sparat belopp delat med sparmålet. Jag har en `guard` som returnerar noll om sparmålet är noll, för att undvika division med noll, och jag använder `min` för att kapa värdet vid hundra procent, så att stapeln aldrig kan överfyllas. Det värdet driver tre saker i gränssnittet samtidigt: procentsiffran, måltexten och själva `ProgressView`-stapeln. Eftersom kortet bara tar emot värden blir det enkelt och återanvändbart – det vet ingenting om databasen.

---

## 6. Live-uppdatering (ca 4:10–4:40)

Nu visar jag att flödet lever. Jag trycker på "Jag klarade dagen!" igen. Som ni ser ökar det sparade beloppet, procenten stiger och stapeln fylls på – automatiskt. Det fungerar för att `User` är en `@Model` och `HomeView` observerar databasen reaktivt via `@Query`. Jag uppdaterar bara datan i view modellen, och SwiftUI ritar om kortet av sig självt. Jag behöver alltså aldrig manuellt putta in nya värden i vyn.

---

## 7. Process: Pull Requests och kodgranskning (ca 4:40–5:05)

Kort om hur vi säkrat kvaliteten på den här koden. Jag jobbade i en egen feature-branch och öppnade en Pull Request när delen var klar. Innan den mergades till huvudbranchen granskade minst en lagkamrat koden, gav kommentarer, och jag justerade utifrån feedbacken. Det hjälpte oss att fånga buggar tidigt och hålla en gemensam standard – till exempel att beräkningarna hamnade på modellen och inte i vyerna, precis som jag visat. *(Anpassa detaljerna efter er faktiska process.)*

---

## 8. Avslutning (ca 5:05–5:20)

Sammanfattningsvis: sparmålet matas in i onboardingen, sparas in i min `User`-modell med SwiftData, och hämtas tillbaka på startsidan med `@Query`. `HomeViewModel` uppdaterar det sparade beloppet i `checkToday`, och `SavingsCard` räknar ut och visar framstegen – allt reaktivt. Det visar hur jag följt MVVM: modellen äger sin data och sina beräkningar, view modellen sköter logik och persistens, och vyerna håller sig enkla och reaktiva. Tack för att ni lyssnade.
