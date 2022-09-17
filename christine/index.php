<?php
$imgFormat = 'webp';
$user_agent = $_SERVER['HTTP_USER_AGENT'];
if (stripos( $user_agent, 'Chrome') !== false) {
    // echo "Google Chrome";
} elseif (stripos( $user_agent, 'Safari') !== false) {
   // echo "Safari";
	$imgFormat = 'jpg';
}
echo '<!DOCTYPE html>
<html lang="de">
<head>
	<meta charset="utf-8">
	<title>Haarentfernung Wörgl - Haut & Haar</title>
	<link rel="preload" as="image" href="images/hero-img-640.'.$imgFormat.'">
	<link rel="icon" type="image/x-icon" href="images/favicon.png">
	<meta name="description" content="Sie suchen nach Haarentfernung Wörgl ? Bei uns sind Sie richtig ! Lassen Sie sich ganz unverbindlich beraten.">
	<meta name="keywords" content="Haarentfernung Wörgl">
	<meta name="generator" content="Contao Open Source CMS">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body><header class="header">
		<div class="container">
			<div class="logo">
				<div class="logo-img">
					<img src="images/logo.png" alt="Haarentfernung Wörgl - Haut & Haar" width="61" height="50">
				</div>
				<div class="logo-text">
					Haut & Haar
				</div>
			</div>
			<div class="header-btn" data-mdl_link="menu">
				<div></div>
				<div></div>
				<div></div>
			</div>
			<nav class="header-nav">
				 <ul>
				 	<li><a href="#services" class="link-js" onclick="return false">Behandlungen</a></li>
				 	<li><a href="#about-us" class="link-js" onclick="return false">Über uns</a></li>
				 	<li><a href="#contact" class="link-js" onclick="return false">Kontakt</a></li>
				 </ul>
			</nav>
		</div>
	</header>
	<section class="section-hero">
		<div class="container">
			<div class="row section-hero-top align-items-end">
				<div class="col-md-8">
					<h1>Haut <span>&</span> Haar</h1>
					<p><b>Professionelle Haarentfernung</b><br>
					Nie wieder rasieren oder epilieren</p>
				</div>
				<div class="col-md-4">
					<p>Eine haarfreie Zukunft?<br>Wir machen es möglich</p>
					<div class="btn-wrap"><a href="#form" class="link-js btn" onclick="return false"><span class="btn-text">Terminanfrage</span><span class="btn-line"></span></a></div>
				</div>
			</div>
		</div>
	</section>
	<div class="hero-img-wrap">
		<div class="container">
			<div class="hero-img"> 
				<picture>
  					<source media="(min-width:768px)" srcset="images/hero-img.'.$imgFormat.'">
  					<img src="images/hero-img-640.'.$imgFormat.'" alt="Haut & Haar" width="640" height="480">
				</picture>
			</div>
		</div>
	</div>
	<div class="section-additional-information">
		<div class="container">
			<div class="row align-items-md-center">
				<div class="col-lg-4 offset-lg-2 col-md-5 offset-md-1 col-12 col-sm-6">
					<div class="image-sm-line image-mb">
						<img loading="lazy" src="images/additional-information.'.$imgFormat.'" alt="Haarentfernung Wörgl - Haut & Haar" width="359" height="260">
					</div>
				</div>
				<div class="col-lg-4 col-md-5 col-12 col-sm-5">
					<p>Sanft + schonend + dauerhaft<br>keine Nebenwirkungen<br> für alle Körperregionen</p>
					<p><b>IPL - dauerhafte Haarentfernung</b></p>
				</div>
			</div>
		</div>
	</div>
	<section class="section-style bg-dark-gray z-index-3">
		<div class="container">
			<div class="row">
				<div class="col-md-4">
					<h3>Willkommen in der Welt perfekt glatter Haut</h3>
				</div>
				<div class="col-md-4 col-sm-6">
					<div class="images">
						<div>
							<img loading="lazy" src="images/content1.'.$imgFormat.'" alt="Willkommen in der Welt perfekt glatter Haut" width="164" height="254">
						</div>
						<div>
							<img loading="lazy" src="images/content2.'.$imgFormat.'" alt="Willkommen in der Welt perfekt glatter Haut" width="164" height="254">
						</div>
					</div>
					<p>Ab der ersten Behandlung sichtbare und dauerhafte Erfolge. Müde von Schnittwunden, Irritationen und Rötungen nach häufigem rasieren oder epilieren</p>
					<p><b>Perfekt glatte Haut für&nbsp;Sie&nbsp;und&nbsp;Ihn</b></p>
				</div>
				<div class="col-md-4 col-sm-6">
					<div class="image-right">
						<img loading="lazy" src="images/content3.'.$imgFormat.'" alt="Willkommen in der Welt perfekt glatter Haut" width="459" height="550">
					</div>
				</div>
			</div>
		</div>
	</section>
	<section class="section-style bg-gray z-index-3" id="services">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 offset-lg-4">
					<h2>Behandlungen</h2>
				</div>
			</div>
			<div class="row mb">
				<div class="col-md-4 col-12">
					<h3>Dauerhafte Haarentfernung</h3>
				</div>
				<div class="col-md-4 col-sm-6 col-12 order-sm-last">
					<p>Mithilfe von Lichtimpulsen werden die Haarwurzeln dauerhaft verödet.</p>
					<p>Erfahren Sie mehr über diese Art der Haarentfernung. Was ist zu beachten...</p>
					<p class="link"><a href="#" data-mdl_link="dauerhafte_haarentfernung" onclick="return false">Weiterlesen</a></p>
				</div>
				<div class="col-md-4 col-sm-6 col-12">
					<div class="image image-sm-line">
						<img loading="lazy" src="images/content4.'.$imgFormat.'" alt="Dauerhafte Haarentfernung" width="359" height="400">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4 col-12 mb-md">
					<h3>Temporäre Haarentfernung</h3>
					<p>Befreien Sie sich von unerwünschten Haaren, komfortabel ohne Kratzer und Schnitte mit Heiß- und Filmwachs. </p>
					<p>Für empfindliche Bereiche, wie Brazilian waxing verwende ich ausschließlich Filmwachs, weil es sehr gut verträglich ist.</p>
					<p>Nach einer Behandlung haben Sie mindestens 3 Wochen Ruhe vor lästiger Behaarung.</p>
					<p class="link"><a href="#" data-mdl_link="temporare_haarentfernung" onclick="return false">Weiterlesen</a></p>
				</div>
				<div class="col-md-4 col-6">
					<div class="image">
						<img loading="lazy" src="images/content5.'.$imgFormat.'" alt="Temporäre Haarentfernung" width="359" height="550">
					</div>
				</div>
				<div class="col-md-4 col-6">
					<div class="image">
						<img loading="lazy" src="images/content6.'.$imgFormat.'" alt="Temporäre Haarentfernung" width="359" height="550">
					</div>
				</div>
			</div>
		</div>
	</section>
	<section class="section-style bg-white z-index-3">
		<div class="container">
			<div class="row">
				<div class="col-md-4">
					<h3>Für fast alle Körperbereiche</h3>
					<ul class="list">
						<li>nie mehr rasieren oder zupfen</li>
						<li>keine Hautirritationen oder Schnitte</li>
						<li>keine schmerzhafte waxing Behandlung mehr</li>
						<li>höhere Attraktivität und Selbstbewusstsein</li>
					</ul>
					<div class="btn-content d-md-none"><a href="#form" class="link-js btn" onclick="return false"><span class="btn-text">Terminanfrage</span><span class="btn-line"></span></a></div>
				</div>
				<div class="col-3 col-sm-2">
					<div class="image">
						<img loading="lazy" src="images/content8.'.$imgFormat.'" alt="Für fast alle Körperbereiche" width="149" height="570">
					</div>
				</div>
				<div class="col-3 col-sm-2">
					<div class="image">
						<img loading="lazy" src="images/content9.'.$imgFormat.'" alt="Für fast alle Körperbereiche" width="150" height="570">
					</div>
				</div>
				<div class="col-3 col-sm-2">
					<div class="image">
						<img loading="lazy" src="images/content10.'.$imgFormat.'" alt="Für fast alle Körperbereiche" width="150" height="570">
					</div>
				</div>
				<div class="col-3 col-sm-2">
					<div class="image">
						<img loading="lazy" src="images/content11.'.$imgFormat.'" alt="Für fast alle Körperbereiche" width="150" height="570">
					</div>
				</div>
				<div class="col-12 d-md-block">
					<div class="btn-content"><a href="#form" class="link-js btn" onclick="return false"><span class="btn-text">Einen Termin machen</span><span class="btn-line"></span></a></div>
				</div>
			</div>
		</div>
	</section>
	<section class="section-style pb-0 bg-gray z-index-3" id="about-us">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 offset-lg-4">
					<h2>Über unseren Salon</h2>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-8 mb-sm">
					<div class="row">
						<div class="col content-img">
							<div class="image">
								<img src="images/content12.'.$imgFormat.'" alt="Über unseren Salon" width="510" height="600">
							</div>
						</div>
						<div class="col">
							<div class="image">
								<img src="images/content13.'.$imgFormat.'" alt="Über unseren Salon" width="210" height="275">
							</div>
						</div>
					</div>
				</div>
				<div class="col-sm-4">
					<h3>Lernen wir uns kennen</h3>
					<p>Alle Fragen rund um die Behandlungen beantworte ich gerne bei einem kostenlosen Beratungs gesprach.</p>
					<p>
						<img loading="lazy" src="images/cosmetic-solution.png" width="150" height="87" alt="cosmetic solution">
					</p>
				</div>
			</div>
			<div class="numbers row">
				<div class="col-4">
					<div class="numbers-title">15+</div>
					<div class="numbers-text">Erfahrung</div>
				</div>
				<div class="col-4">
					<div class="numbers-title">500+</div>
					<div class="numbers-text">Zufriedene Kunden</div>
				</div>
				<div class="col-4">
					<div class="numbers-title">10M+</div>
					<div class="numbers-text">Entfernte Haare</div>
				</div>
			</div>
		</div>
	</section>
	<div class="section-quote bg-gray z-index-3">
		<div class="container">
			<div class="row align-items-md-center">
				<div class="col-8">
					<div class="quote">
						<p>Seit über 15 jahren arbeite ich in der Haarentfernung. Es ist mein ehrgeiziges Ziel für jeden meiner Kunden das optimalste Ergebnis zu erreichen.</p>
						<div class="quote-name">Mag. Christine Egger</div>
						<div class="quote-info">Inhaber</div>
					</div>
				</div>
				<div class="col-4">
					<div class="image">
						<img loading="lazy" src="images/owner.'.$imgFormat.'" alt="Mag. Christine Egger" width="359" height="500">
					</div>
				</div>
			</div>
		</div>
	</div>
	<section class="section-style bg-white z-index-3">
		<div class="container">
			<div class="row">
				<div class="col-md-4 order-md-last">
					<h3>Geschenk für einen wunderbaren Freund</h3>
					<p>Bereiten Sie ihrerm Lieblingsmenschen eine Freude.</p>
					<div class="btn-content d-md-none"><a href="mailto:rolltreff@haut-haar.eu?subject=Geschenk%20f%C3%BCr%20einen%20wunderbaren%20Freund&body=Hallo%2C%20ich%20m%C3%B6chte%20einen%20Gutschein%20f%C3%BCr%20einen%20wunderbaren%20Freund%20kaufen" class="btn"><span class="btn-text">Einen Gutschein kaufen</span><span class="btn-line"></span></a></div>
				</div>
				<div class="col-sm-4 col-6">
					<div class="image">
						<img loading="lazy" src="images/content14.'.$imgFormat.'" alt="Geschenk für einen wunderbaren Freund" width="359" height="530">
					</div>
				</div>
				<div class="col-sm-4 col-6">
					<div class="image">
						<img loading="lazy" src="images/content15.'.$imgFormat.'" alt="Geschenk für einen wunderbaren Freund" width="359" height="530">
					</div>
				</div>
				<div class="col-12 d-md-block">
					<div class="btn-content"><a href="mailto:rolltreff@haut-haar.eu?subject=Geschenk%20f%C3%BCr%20einen%20wunderbaren%20Freund&body=Hallo%2C%20ich%20m%C3%B6chte%20einen%20Gutschein%20f%C3%BCr%20einen%20wunderbaren%20Freund%20kaufen" class="btn"><span class="btn-text">En Zertifikat kaufen</span><span class="btn-line"></span></a></div>
				</div>
			</div>
		</div>
	</section>
	<section class="section-style section-form bg-light-gray z-index-3" id="form">
		<div class="container">
			<div class="row">
				<div class="col-sm-6">
					<h2>Holen Sie<br> sich einen Termin</h2>
					<p>Bitte füllen Sie die folgenden Felder aus</p>
					<form class="form-style" method="POST" id="feedback" action="form.php">
						<div class="form-floating">
							<input type="text" name="name" class="form-control" required id="name" placeholder="Name">
							<label for="name">Name</label>
						</div>
						<div class="form-floating">
							<input type="text" name="email" class="form-control" required id="email" placeholder="Email">
							<label for="email">Email</label>
						</div> 
						<div class="form-floating">
							<input type="tel" name="phone" class="form-control" required id="phone" placeholder="Telefonnumer">
							<label for="phone">Telefonnumer</label>
						</div>
						<div class="form-floating">
							<textarea class="form-control" name="message" required id="message" placeholder="Nachricht"></textarea>
							<label for="message">Nachricht</label>
						</div>
						<div class="form-check-wrap">
							<div class="form-check">
								<input class="form-check-input" name="response_to_email" value="response_to_email" type="checkbox" id="antwort-per-email">
								<label class="form-check-label" for="antwort-per-email">
									Antwort per Email
								</label>
							</div>
							<div class="form-check">
								<input class="form-check-input" name="response_to_phone" value="response_to_phone" type="checkbox" id="bitte-um-ruckruf">
								<label class="form-check-label" for="bitte-um-ruckruf">
									Bitte um Ruckruf
								</label>
							</div>
						</div>
						<div class="form-btn">
							<button type="submit" class="btn"><span class="btn-text">Senden</span><span class="btn-line"></span></button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div class="img-form">
			<div>
				<img loading="lazy" src="images/img-form.'.$imgFormat.'" alt="Holen Sie sich einen Termin" width="537" height="1100">
			</div>
		</div>
	</section>
	<section class="section-style section-contact bg-white z-index-3" id="contact">
		<div class="container">
			<div class="row align-items-md-center">
				<div class="col-md-6 order-md-last">
					<h2>Kontakt</h2>
					<div class="row">
						<div class="col-md-6 mb-md">
							<p>Mag. Christine Egger</p>
							<p>Kaiserweg 1<br>
							A-6342 Niederndorf</p>
							<p>Telefon: <a href="tel:+43537361477">+43 5373 61477</a> <br>
							eMail: <a href="mailto:rolltreff@haut-haar.eu">rolltreff@haut-haar.eu</a></p>
						</div>
						<div class="col-md-6 mb-md">
							<p><b>Unsere Öffnungszeiten:</b></p>
							<p>Dienstag und Mittwoch<br>
							8:00&#8209;12:00 und 17:15&#8209;21:00&nbsp;Uhr</p>
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2687.92057781033!2d12.212405415821923!3d47.64711019317151!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x4776393e237da6c9%3A0x8b6db4572458ae08!2sKaiserweg%201%2C%206342%20Niederndorf%20bei%20Kufstein%2C%20%C3%96sterreich!5e0!3m2!1sde!2sua!4v1663150574402!5m2!1sde!2sua" loading="lazy" title="Kaiserweg 1, A-6342 Niederndorf" width="570" height="400" style="border:0" allowfullscreen></iframe>
				</div>
			</div>
		</div>
	</section>
	<footer class="footer">
		<div class="footer-top">
			<div class="container">
				<div class="footer-logo">
					<div class="footer-logo-img">
						<img src="images/logo.png" loading="lazy" alt="Haarentfernung Wörgl - Haut & Haar" width="61" height="50">
					</div>
					<div class="footer-logo-text">
						Haut & Haar
					</div>
				</div>
				<div class="footer-links">
					<a href="#" data-mdl_link="impressum" onclick="return false">Impressum</a>
					<a href="#" data-mdl_link="datenschutz" onclick="return false">Datenschutz</a>
				</div>
			</div>
		</div>
		<div class="footer-bottom">
			<div class="container">
				<div class="footer-copy">© Haut & Haar, 2022</div>
				<div class="company"><span>Made by</span> <a href="https://it-b.at">it-b.at</a></div>
			</div>
		</div>
	</footer>
<div class="modal" data-modal="impressum">
		<div class="modal-bg"></div>
		<div class="modal-container">
			<div class="modal-header">
				<div class="modal-close"></div>
				<h6>Impressum</h6>
			</div>
			<div class="modal-content">
				<p>
				<span class="text-dark">Rolltreff<br>
				Mag. Christine Egger<br>
				Kaiserweg 1<br>
				6342 Niederndorf</span><br>
				Telefon: <a href="tel:+43537361477">+43 5373 61477</a><br>
				eMail: <a href="mailto:rolltreff@haut-haar.eu">rolltreff@haut-haar.eu</a><br>
				Internet: <a href="https://haut-haar.eu">haut-haar.eu</a>
				</p>
				<p>
				UID: <span class="text-dark">ATU 41999101</span><br>
				Unternehmensart: <span class="text-dark">Enthaarung und Massage</span><br>
				Geschäftsleitung: <span class="text-dark">Mag. Christine Egger</span><br>
				WKO-Nummer: <span class="text-dark">7070521</span><br>
				WKO-Fachgruppe: <span class="text-dark">Fachgruppe der Kosmetiker und Fußpfleger</span>
				</p>
				<h4>Idee, Konzept und Umsetzung</h4>
				<p><a href="https://it-b.at">www.it-b.at</a><br>
				Die Homepage wurde von it-b.at realisiert.</p>
				<h4>SEO Suchmaschinenoptimierung</h4>
				<p><a href="https://it-b.at">www.it-b.at</a><br>
				Die Homepage wird von it-b.at suchmaschinenoptimiert.</p>
				<h4>Design</h4>
				<p><a href="https://it-b.at">www.it-b.at</a><br>
				Das Design wurde von it-b suchmaschinenoptimiert.</p>
				<h4>Technische Umsetzung</h4>
				<p>Die Internetseite wurde mit dem CMS System Contao (www.contao.de) realisiert.</p>
				<h4>Bildquellen</h4>
				<p>Die Homepage verwendet Bilder von Rolltreff, Pixabay und Fotolia.</p>
				<h4>Haftung</h4>
				<p>Sämtliche Texte (und Links auch zu externen Inhaltsanbietern) auf dieser Homepage wurden sorgfältig geprüft. Dessen ungeachtet kann keine Garantie für die Richtigkeit, Vollständigkeit und Aktualität der Angaben übernommen werden. Eine Haftung der Firma Rolltreff wird daher ausgeschlossen.</p>
			</div>
		</div>
	</div>
	<div class="modal" data-modal="datenschutz">
		<div class="modal-bg"></div>
		<div class="modal-container">
			<div class="modal-header">
				<div class="modal-close"></div>
				<h6>Datenschutz</h6>
			</div>
			<div class="modal-content">
				<p>Der Schutz Ihrer personenbezogenen Daten ist uns ein besonderes Anliegen. Ihre Daten werden von uns auf Basis der gesetzlichen Bestimmungen (Datenschutz-Grundverordnung Nr 2016/679 – im Folgenden „DS-GVO“ sowie der nationalen Datenschutzvorschriften) verarbeitet.</p>
				<h4>1. Verantwortlicher</h4>
				<p>Verantwortlicher im Sinne von Art 4 Z 7 DS-GVO ist der Betreiber dieser Webseite gemäß den Angaben im Impressum (in dieser Datenschutzerklärung auch als „Wir“, „Uns“ bezeichnet). Dort finden Sie auch alle notwendigen Kontaktdaten zur Geltendmachung Ihrer Rechte (Punkt 6.).</p>
				<h4>2. Personenbezogene Daten</h4>
				<p>Wir verarbeiten lediglich jene personenbezogenen Daten, die Sie uns (durch Besuch unserer Webseite bzw durch die von Ihnen gemachten Angaben in einem Kontaktformular oder einer Newsletter-Anmeldung) zur Verfügung stellen, etwa: Vorname, Nachname, E-Mail-Adresse, Telefonnummer, Geburtsdatum/Alter, Geschlecht, Bankdaten (zB Kreditkartenummer, Kontonummer), IP-Adresse; wobei nicht in jedem Fall sämtliche der angegeben Datenarten betroffen sind oder angegeben werden müssen. Besondere Kategorien personenbezogener Daten im Sinne des Art 9 DS-GVO werden von uns im Rahmen dieser Webseite nicht verarbeitet.</p>
				<h4>3. Verarbeitung der personenbezogenen Daten</h4>
				<p>Die Verarbeitung Ihrer personenbezogenen Daten erfolgt in erster Linie zur Erfüllung eines Vertrages bzw zur Durchführung vorvertraglicher Maßnahmen (Art 6 Abs 1 lit b DS-GVO), da wir ohne diese Daten einen Vertrag mit Ihnen nicht vorbereiten, abschließen bzw erfüllen können. Weiters erfolgt die Verarbeitung zur Wahrung unserer berechtigten Interessen bzw berechtigten Interessen Dritter (Art 6 Abs 1 lit f DS-GVO), insbesondere auch zu Zwecken der Betriebssicherheit der Webseite, des Forderungsmanagements, des Direktmarketings in analoger und digitaler Form, der Bestandskundenwerbung, der statistischen Auswertung sowie der Verbesserung unseres Dienstleistungsangebots und dessen Qualität (zum Widerrufsrecht siehe Punkt 6.).</p>
				<p>Wir werden Ihre personenbezogenen Daten lediglich in dem von der DS-GVO gedeckten Umfang verarbeiten. Eine Übermittlung Ihrer personenbezogenen Daten an Dritte erfolgt in der Regel nicht. Wenn – etwa zur Vertragserfüllung – eine Übermittlung an Dritte erforderlich sein sollte, wird diese Übermittlung im Einklang mit den Bestimmungen der DS-GVO erfolgen. Wir bitten Sie, in diesem Fall auch die Datenschutzerklärungen dieser Dritten zu beachten, da diese allenfalls zur Anwendung gelangen können. Ausgenommen hiervon ist die Nutzung für statistische und ähnliche Zwecke, hierzu werden jedoch keine personenbezogenen Daten, sondern ausschließlich anonymisierte Daten übermittelt, die eine Identifizierung einer natürlichen Person nicht erlauben und nicht einer spezifischen natürlichen Person zugeordnet werden können (siehe dazu auch Punkte 8, 9, 10).</p>
				<h4>4. Datensicherheit</h4>
				<p>Der Schutz Ihrer personenbezogenen Daten erfolgt durch organisatorische und technische Maßnahmen, wie etwa dem Schutz vor unberechtigtem Zugriff und technische Datensicherheitsvorkehrungen.</p>
				<p>Bitte beachten Sie jedoch, dass ungeachtet dieser Bemühungen nicht gänzlich ausgeschlossen werden kann, dass Daten, welche durch Sie über das Internet bekannt gegeben werden, dennoch von anderen Personen eingesehen und potenziell genutzt werden könnten. Wir können deshalb keine Haftung oder Verantwortung für Fehler in der Datenübertragung oder den unautorisierten Zugriff durch Dritte (zB Hackerangriffe, Spyware, Malware etc) übernehmen.</p>
				<h4>5. Aufbewahrung personenbezogener Daten</h4>
				<p>Ihre personenbezogenen Daten werden von uns nur so lange aufbewahrt, wie dies zur Erfüllung vertraglicher bzw gesetzlicher Verpflichtungen notwendig ist (entsprechende Aufbewahrungspflichten können sich zB insbesondere aus steuerrechtlichen Vorschriften oder aus Vorschriften über die Produkthaftung ergeben). Ist diese Erforderlichkeit nicht mehr gegeben, werden die Daten gelöscht.</p>
				<h4>6. Auskunft, Löschung, Beschwerderecht</h4>
				<p>Vorbehaltlich des Bestehens allfälliger gesetzlicher Verschwiegenheitsverpflichtungen haben Sie das Recht, jederzeit Auskunft über Ihre gespeicherten personenbezogenen Daten, deren Herkunft, den Verarbeitungszweck sowie gegebenenfalls den Empfänger dieser Daten zu erhalten. Weiters haben Sie das Recht, die Berichtigung, Übertragung, Einschränkung der Bearbeitung, Sperrung oder Löschung Ihrer personenbezogenen Daten zu verlangen, wenn diese unrichtig sind oder die Grundlage für die Datenverarbeitung wegfällt. Ebenso haben Sie die Möglichkeit, Widerspruch gegen die Verarbeitung Ihrer personenbezogenen Daten auf Basis von Art 6 Abs 1 lit f DS-GVO („Wahrung berechtigter Interessen“) zu erklären.</p>
				<p>Wir bitten Sie, sämtliche dieser Ansprüche an eine(n) der in unserem Impressum der Webseite bekannt gegebenen Kontaktmöglichkeit / Ansprechpartner zu richten.</p>
				<p>Wir weisen darauf hin, dass ein allfälliger Widerspruch keinen Einfluss auf die Zulässigkeit der Verarbeitung personenbezogener Daten auf Basis sonstiger Erlaubnistatbestände nach Art 6 DS-GVO hat.</p>
				<p>Sollten Sie der Ansicht sein, dass die Verarbeitung Ihrer personenbezogenen Daten gegen geltende datenschutzrechtliche Bestimmungen verstößt oder Ihre Ansprüche nach dem Datenschutzrecht in sonstiger Weise verletzt worden sind, haben sie das Recht, eine Beschwerde bei der zuständigen Aufsichtsbehörde (gemäß Art 77 DS-GVO) einzubringen.</p>
				<h4>7. Verwendung von Cookies</h4>
				<p>Um die Website nach Ihren Bedürfnissen zu gestalten und bestimmte Informationen zu sammeln, nutzen wir verschiedene Technologien, ua sogenannte Cookies. Cookies dienen dazu, die Internetnutzung und die Kommunikation zu vereinfachen.</p>
				<p>Cookies sind kleine Textdateien, die unsere Website an Ihren Browser schickt und die auf Ihrem Computer abgelegt werden, um sie dort als eine anonyme Kennung zu speichern. Zweck dieser Cookies sind zB die bessere Steuerung der Verbindung während Ihres Besuchs auf unserer Webseite und eine effektivere Unterstützung, wenn Sie wieder auf unsere Website zurückkehren. Ohne diese befristete "Zwischenspeicherung" müssten bei einigen Anwendungen bereits getätigte Eingaben erneut erfolgen. Ein Cookie enthält nur die Daten, die ein Server ausgibt oder/und der Nutzer auf Anforderung eingibt (zB Aufbau: Angaben zu Domain, Pfad, Ablaufdatum, Cookiename und -wert). Cookies beinhalten also rein technische Informationen, keine personenbezogenen Daten. Cookies können auch nicht die Festplatte des Nutzers ausspähen, Schaden verursachen oder dergleichen.</p>
				<p>Folgende Arten von Cookies können zum Einsatz gelangen:</p>
				<ul class="list">
					<li>Session Cookies: Diese werden automatisch gelöscht, wenn der Internetbrowser geschlossen wird.</li>
					<li>Persistent Cookies: Diese bleiben für einen bestimmten Zeitraum auf Ihrem Computer gespeichert, die Dauer ist abhängig von dem hinterlegten Ablaufdatum.</li>
					<li>Third Party Cookies: Diese können insbesondere auch Cookies von diversen Social-Media-Plattformen (wie etwa Facebook, Twitter, You Tube, Instagram, Pinterest, Flickr etc) oder sonstigen Internetdiensleistern (wie etwa Google) beinhalten. Diese Cookies sammeln Informationen wie Verweildauer, Seitenaufrufe, Bewegung über Links etc. Sie werden etwa dazu genutzt, bestimmte Werbeinhalte einzublenden, die sich aus Suchverläufen, besuchten Webseiten und dergleichen ergeben. Diese Cookies können von uns nicht ausgelesen werden.</li>
				</ul>
				<p>Falls Sie es wünschen, können Sie eine Speicherung von Cookies (bzw bestimmter Arten von Cookies) über Ihren Web Browser generell unterdrücken oder entscheiden, ob Sie per Hinweis eine Speicherung wünschen oder nicht. Die Nichtannahme von Cookies kann jedoch zur Folge haben, dass einige Seiten nicht mehr richtig angezeigt werden oder die Nutzbarkeit eingeschränkt ist.</p>
				<h4>8. Analysetools</h4>
				<p>Die Webseite benutzt Google Analytics, einen Webanalysedienst der Google Inc. („Google"). Google Analytics verwendet sog. "Cookies", Textdateien, die auf Ihrem Computer gespeichert werden und die eine Analyse der Benutzung der Plattform durch Sie ermöglichen. Die durch den Cookie erzeugten Informationen über Ihre Benutzung dieser Webseite werden in der Regel an einen Server von Google in den USA übertragen und dort gespeichert. Im Falle der Aktivierung der IP-Anonymisierung auf der Website/Plattform, wird Ihre IP-Adresse von Google jedoch innerhalb von Mitgliedstaaten der Europäischen Union oder in anderen Vertragsstaaten des Abkommens über den Europäischen Wirtschaftsraum zuvor gekürzt. Nur in Ausnahmefällen wird die volle IP-Adresse an einen Server von Google in den USA übertragen und dort gekürzt. Im Auftrag des Betreibers dieser Webseite wird Google diese Informationen benutzen, um Ihre Nutzung der Webseite/Plattform auszuwerten, um Reports über die Websiteaktivitäten zusammenzustellen und um weitere mit der Websitenutzung und der Internetnutzung verbundene Dienstleistungen gegenüber dem Websitebetreiber zu erbringen. Die im Rahmen von Google Analytics von Ihrem Browser übermittelte IP-Adresse wird nicht mit anderen Daten von Google zusammengeführt. Sie können die Speicherung der Cookies durch eine entsprechende Einstellung Ihrer Browser-Software verhindern; wir weisen Sie jedoch darauf hin, dass Sie in diesem Fall gegebenenfalls nicht sämtliche Funktionen dieser Website vollumfänglich werden nutzen können. Sie können darüber hinaus die Erfassung der durch das Cookie erzeugten und auf Ihre Nutzung der Website bezogenen Daten (inkl. Ihrer IP-Adresse) an Google sowie die Verarbeitung dieser Daten durch Google verhindern, indem sie das unter diesem Link verfügbare Browser-Plugin herunterladen und installieren: https://tools.google.com/dlpage/gaoptout?hl=de</p>
				<p>Google bietet an, die Erfassung durch Google Analytics zu verhindern. Bitte besuchen Sie dazu die entsprechende Internetspräsenz von Google.</p>
				<h4>9. Facebook-Plugins</h4>
				<p>Diese Website verwendet Facebook Social Plugins, welches von der Facebook Inc. (1 Hacker Way, Menlo Park, California 94025, USA; „Facebook“) betrieben wird. Erkennbar sind die Einbindungen an dem Facebook-Logo bzw. an den Begriffen „Like“, „Gefällt mir“, „Teilen“ etc in den Farben Facebooks (Blau und Weiß). Die Plugins werden erst aktiviert, wenn Sie auf die entsprechenden Schaltflächen klicken. Sie haben die Möglichkeit, die Plugins einmalig oder dauerhaft zu aktivieren. Die Plugins stellen eine direkte Verbindung zwischen Ihrem Browser und den Facebook-Servern her. Wir haben keinerlei Einfluss auf die Natur und den Umfang der Daten, welche das Plugin an die Server der Facebook übermittelt. Das Plugin informiert Facebook darüber, dass Sie als Nutzer diese Website besucht haben. Es besteht hierbei die Möglichkeit, dass Ihre IP-Adresse gespeichert wird. Sind Sie während des Besuchs auf dieser Website in Ihrem Facebook-Konto eingeloggt, werden die genannten Informationen mit diesem verknüpft. Nutzen Sie die Funktionen des Plugins – etwa indem Sie einen Beitrag teilen oder den „Gefällt Mir“ Button anklicken – werden die entsprechenden Informationen ebenfalls an Facebook übermittelt und gegebenenfalls mit Ihrem Facebook-Konto verknüpft. Sie können dies nur durch Ausloggen vor Nutzung des Plugins verhindern. Nähere Informationen zur Erhebung und Nutzung der Daten durch Facebook, über Ihre diesbezüglichen Rechte und Möglichkeiten zum Schutz Ihrer Privatsphäre finden Sie in den Datenschutzhinweisen von Facebook.</p>
				<h4>10. Weitere Web-Tools</h4>
				<p>Auf dieser Webseite können unter Umständen weitere Web-Tools von Google zum Einsatz gelangen (etwa „Google AdWords“, „Google AdSense“, „Google AdExchange“ oder „Google Double Klick for Publishers“) – darüber, ob und in welchem Umfang diese Tools konkret eingesetzt werden, geben wir gerne Auskunft und ersuchen Sie, uns bei Fragen über eine der im Impressum der Webseite angegebene Kontaktmöglichkeit zu kontaktieren. Wir verarbeiten beim Einsatz dieser Tools keine personenbezogenen Daten von Ihnen, allenfalls erfolgt eine Datenverarbeitung jedoch durch Google selbst – bitte setzen Sie sich daher mit den entsprechenden Datenschutzhinweisen von Google auseinander um weitere Details der Nutzung Ihrer personenbezogenen Daten zu erlangen.</p>
				<h4>11. Newsletter</h4>
				<p>Sie haben die Möglichkeit, über die Webseite unseren Newsletter zu abonnieren. Dies erfolgt selbstverständlich auf freiwilliger Basis und ist jederzeit stornierbar. Für die Aufnahme in unsere Newsletter-Datenbank benötigen wir Ihre E-Mail-Adresse sowie Ihre Erklärung, dass Sie mit dem Bezug des Newsletters einverstanden sind. Sobald Sie sich für diesen Newsletter angemeldet haben, erhalten Sie eine E-Mail-Nachricht mit einem Link zur Bestätigung der Anmeldung („Double-Opt-In“). Den Bezug des Newsletters können Sie jederzeit stornieren; bitte verwenden Sie für eine Abmeldung eine der im Impressum der Webseite angegebene Kontaktmöglichkeit oder klicken Sie auf den Link zur Abmeldung, welcher in jeder Ausgabe des Newsletters enthalten ist.</p>
				<h4>12. Änderungsvorbehalt</h4>
				<p>Wir müssen uns vorbehalten, die gegenständliche Datenschutzerklärung im Bedarfsfall anzupassen, etwa zur Abbildung von Rechtsentwicklungen im Bereich des Datenschutzes. Für die künftige Nutzung unserer Webseite gelten sodann die angepassten/geänderten Datenschutzbestimmungen. Wir empfehlen daher, diese von Zeit zu Zeit einzusehen.</p>
			</div>
		</div>
	</div>
	<div class="modal" data-modal="dauerhafte_haarentfernung">
		<div class="modal-bg"></div>
		<div class="modal-container">
			<div class="modal-header">
				<div class="modal-close"></div>
				<h6>Dienstleistungen</h6>
			</div>
			<div class="modal-content">
				<h3>Dauerhafte Haarentfernung (IPL)</h3>
				<p>Mithilfe des Gerätes von Cosmetic Solution werden kontrollierte Lichtimpulse erzeugt die zur selektiven Verödung der Haarwurzel zum Zwecke der Epilation führen. Hierbei gilt grundsätzlich, daß die Behandlung umso einfacher, bzw. erfolgreicher ist, je heller die Haut und je dunkler die Haare sind. Jedes Haar durchläuft verschiedene Wachstumsphasen, erfolgreich behandelt werden kann nur in der Anagenphase. Da sich aber immer nur ein bestimmter Teil Ihrer Haare in dieser Wachstumsphase befindet, braucht es in der Regel 8-10 Behandlungen(abhängig vom Behandlungsbereich) um alle Haare in der richtigen Wachstumsphase zu erreichen.</p>
				<h3>Wie sollten Sie sich auf die Behandlung vorbereiten </h3>
				<p>Bitte rasieren (nur rasieren, keine Epilation oder Enthaarung mit Wachs und Enthaarungscremen) Sie sich am Vortag der Behandlung, damit eventuell auftretende Hautreizungen zum Termin abgeklungen sind. Vermeiden Sie mindestens 10 Tage vor und nach der Behandlung natürliche Sonne oder Solarium. Ist die Sonne nicht vermeidbar so verwenden Sie bitte einen Sunblocker (LSF30+). Bitte auch keine Peelings im Behandlungsbereich.</p>
				<h3>Ist man nach dem Ende des Behandlungszyklus für immer haarfrei ?</h3>
				<p>Eine absolute Garantie dafür kann nicht abgegeben werden. Die Wahrscheinlichkeit ist allerdings sehr hoch, da das verwendete System optimale Leistung abgibt. Trotzdem kann es nach Jahren der Haarfreiheit an den behandelnden Stellen wieder zu einem geringen Haarwachstum kommen. Auslöser können Hormonhaushaltsstörungen oder Veränderungen in diesem sein, oder Medikamenteneinnahme. Eine weitere Möglichkeit ist das Wachstum von Haarwurzeln, die bisher noch nie ein Haar produziert haben(schlafende Follikel). Mit ein- oder zwei Nachbehandlungen kann aber auch diesem Problem abgeholfen werden.</p>
				<h3>Kontraindikationen</h3>
				<ul class="list">
					<li>Einnahme von lichtsensibilisierenden Mitteln</li>
					<li>Starke Durchblutungsstörungen</li>
					<li>Umfangreiche Venenleiden</li>
					<li>Einnahme von Macumar, Acutan, Aspirin, Antidepressiva, Cortison, Anabolika und Drogen</li>
					<li>Schwangerschaft</li>
					<li>Epilepsie</li>
					<li>Herzschrittmacher</li>
					<li>Alkohol</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="modal" data-modal="temporare_haarentfernung">
		<div class="modal-bg"></div>
		<div class="modal-container">
			<div class="modal-header">
				<div class="modal-close"></div>
				<h6>Dienstleistungen</h6>
			</div>
			<div class="modal-content">
				<h3>Temporäre Haarentfernung</h3>
				<h4>Haarentfernung mit Heißwachs <br><span>(speziell im Arm-und Beinbereich)</span></h4>
				<p>Das warme Heißwachs wird auf die Körperzonen aufgebracht und mithilfe eines Vliesstreifens werden die Haare abgezogen.</p>
				<p>Die Haare sollten idealerweise eine Länge zwischen 4-5mm haben damit sie vom Wachs erfasst werden können.</p>
				<h4>Haarentfernung mit Filmwachs <br><span>(für empfindliche Bereiche)</span></h4>
				<p>Für die Behandlung mit Filmwachs sollten die Haare idealerweise eine Länge von 4-5mm haben.</p>
				<p>Das erwärmte Wachs wird direkt auf die behaarten Stellen aufgetragen, wird bei Abkühlung fest und kann dann schonend entfernt werden.</p>
				<p>Auch für Brazilian waxing verwende ich ausschliesslich Filmwachs, weil es sehr gut verträglich ist und gut dosiert werden kann.</p>
				<h4>Danach haben Sie für mindestens 2-3 Wochen Ruhe vor lästiger Behaarung.</h4>
			</div>
		</div>
	</div>
	<div class="modal" data-modal="menu">
		<div class="modal-bg"></div>
		<div class="modal-container">
			<div class="modal-logo">
				<img src="images/logo.png" alt="Haarentfernung Wörgl - Haut & Haar" width="61" height="50">
			</div>
			<div class="modal-close"></div>
			<div class="modal-content">
				<nav class="mobile-nav">
					 <ul>
					 	<li><a href="#services" class="link-js" onclick="return false">Behandlungen</a></li>
				 		<li><a href="#about-us" class="link-js" onclick="return false">Über uns</a></li>
				 		<li><a href="#contact" class="link-js" onclick="return false">Kontakt</a></li>
					 </ul>
				</nav>
				<div class="menu-contact">
					<a href="mailto:rolltreff@haut-haar.eu"><i class="icon-email"></i></a>
					<a href="tel:+43537361477"><i class="icon-phone"></i></a>
				</div>
			</div>
		</div>
	</div>
	<script src="js/jquery.js"></script>
	<script src="js/scripts.js"></script>
</body>
</html>'
?>