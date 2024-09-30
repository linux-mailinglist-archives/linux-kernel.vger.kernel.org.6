Return-Path: <linux-kernel+bounces-344794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB7F98AE4C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B7E2825C5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A298F19F10E;
	Mon, 30 Sep 2024 20:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="c5Qb1KN7"
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8841A0B0E;
	Mon, 30 Sep 2024 20:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.103.80.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727906; cv=none; b=Rx6gwrN4/51qkZg4qPnwGhYj++oB4FI1MorVLYANH6wW1a4meNkrPdnVEnjQx9Ok7pGQ/OFKvKIlkJRFL3g4SpB5kKYuCarY4tKsXXNFm52W9zrZmwCTYGPc5AFNrSdyz50wr8vLV0Jd5Qd+ZzsbWBNsO/cQXae5O2+T7tDfMyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727906; c=relaxed/simple;
	bh=4KvG/pvm8KV2DmsLZNSHUjxpibx3aeV/AHRIka868HY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=L6of8CaLF+lqMGuT4jVHnyn87fDqmBp40IOYKtlxd9Mjr3pb9My4yfBbHK604jO6Q17PdY9/EwnDHUDb1RrLjfnEWp2WoTgMdgcCqd7bedEU40Q9pnxjzENRPYGbbXmltBsmqqEVoU0rOk414iWZGme3Lu75XxN+FCdrydBuEaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it; spf=pass smtp.mailfrom=vaga.pv.it; dkim=pass (2048-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b=c5Qb1KN7; arc=none smtp.client-ip=212.103.80.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaga.pv.it
Received: from localhost (unknown [127.0.0.1])
	by mx.kolabnow.com (Postfix) with ESMTP id 0608B2E6000;
	Mon, 30 Sep 2024 22:24:59 +0200 (CEST)
Authentication-Results: ext-mx-out013.mykolab.com (amavis);
 dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
 header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:message-id:date:date:subject:subject:from:from:received
	:received:received; s=dkim20240523; t=1727727893; x=1729542294;
	 bh=x6DIfVqsks6U3HyB0X3ZyFHWxI9nGPgPYR0FTKViOWo=; b=c5Qb1KN7/yeU
	Le45TJivG/z9VfpN1QRCugR0vM/cbt4nQw3LO3mAYTQPJ8BTdEW1uxuu4sGESl7F
	nPfdhil/D685djiROmF22h+S9bfqSfIPfBGz8Q86kKAD5nNB+VMjSsBqUPmCrkqa
	LNtyUqnwJlFWm+3UwrN0oYgbYYZu7R3WIKd434JQkE2FWEe/N78cw8pUoawxowoM
	vpPhdvGXWnv20oMp99L58sucRLmOy8kMdweu3lJbyWIE5oceRi31XA37HgETM0TI
	zuJy51Hd6wu2espoHKVSvieiYs6Qj2YuN3HTiM/kGckY7DIGQeCUn21Ub6s/zQlt
	Jghnttwq/w==
X-Virus-Scanned: amavis at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level:
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out013.mykolab.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id rYCn2UfQw2D5; Mon, 30 Sep 2024 22:24:53 +0200 (CEST)
Received: from int-mx009.mykolab.com (unknown [10.9.13.9])
	by mx.kolabnow.com (Postfix) with ESMTPS id 8B57B348AD0;
	Mon, 30 Sep 2024 22:24:52 +0200 (CEST)
Received: from ext-subm010.mykolab.com (unknown [10.9.6.10])
	by int-mx009.mykolab.com (Postfix) with ESMTPS id B271120AA551;
	Mon, 30 Sep 2024 22:24:52 +0200 (CEST)
From: Federico Vaga <federico.vaga@vaga.pv.it>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH v3] doc:it_IT: update documents in process/
Date: Mon, 30 Sep 2024 22:24:33 +0200
Message-Id: <20240930202433.37110-1-federico.vaga@vaga.pv.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update Italian translation following these changes under Documentation/process

commit eb5ed2fae197 ("docs: submitting-patches: Advertise b4")
commit 413e775efaec ("Documentation: fix links to mailing list services")
commit 47c67ec1e8ef ("docs: submit-checklist: use subheadings")
commit 5969fbf30274 ("docs: submit-checklist: structure by category")
commit 5f99665ee8f4 ("kbuild: raise the minimum GNU Make requirement to 4.0")
commit 627395716cc3 ("docs: document python version used for compilation")
commit 7a23b027ec17 ("arm64: boot: Support Flat Image Tree")
commit 56f64b370612 ("rust: upgrade to Rust 1.78.0")
commit 82b8000c28b5 ("net: drop special comment style")
commit 6813216bbdba ("Documentation: coding-style: ask function-like macros to evaluate parameters")
commit 91031ca349ee ("docs: improve comment consistency in .muttrc example configuration")
commit 7fe7de7be828 ("Docs/process/email-clients: Document HacKerMaiL")
commit 9c03bc90c065 ("Documentation: process: Revert "Document suitability of Proton Mail for kernel development"")
commit f9a4f4a0e1f5 ("Docs: Move magic-number from process to staging")
commit 7400d25a0a5c ("Docs/process/index: Remove riscv/patch-acceptance from 'Other materi
al' section")

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 .../{process => dev-tools}/clang-format.rst   |   0
 .../translations/it_IT/dev-tools/index.rst    |  17 ++
 Documentation/translations/it_IT/index.rst    |   8 +-
 .../translations/it_IT/process/2.Process.rst  |   6 +-
 .../translations/it_IT/process/4.Coding.rst   |   2 +-
 .../translations/it_IT/process/changes.rst    |  33 +++-
 .../it_IT/process/coding-style.rst            |  37 ++--
 .../it_IT/process/email-clients.rst           |  33 +---
 .../translations/it_IT/process/howto.rst      |  10 +-
 .../translations/it_IT/process/index.rst      |  10 --
 .../it_IT/process/submit-checklist.rst        | 167 +++++++++---------
 .../it_IT/process/submitting-patches.rst      |  23 +--
 .../translations/it_IT/staging/index.rst      |  13 ++
 .../{process => staging}/magic-number.rst     |   0
 14 files changed, 208 insertions(+), 151 deletions(-)
 rename Documentation/translations/it_IT/{process => dev-tools}/clang-format.rst (100%)
 create mode 100644 Documentation/translations/it_IT/dev-tools/index.rst
 create mode 100644 Documentation/translations/it_IT/staging/index.rst
 rename Documentation/translations/it_IT/{process => staging}/magic-number.rst (100%)

diff --git a/Documentation/translations/it_IT/process/clang-format.rst b/Documentation/translations/it_IT/dev-tools/clang-format.rst
similarity index 100%
rename from Documentation/translations/it_IT/process/clang-format.rst
rename to Documentation/translations/it_IT/dev-tools/clang-format.rst
diff --git a/Documentation/translations/it_IT/dev-tools/index.rst b/Documentation/translations/it_IT/dev-tools/index.rst
new file mode 100644
index 000000000000..3d3ed9d15ea1
--- /dev/null
+++ b/Documentation/translations/it_IT/dev-tools/index.rst
@@ -0,0 +1,17 @@
+.. include:: ../disclaimer-ita.rst
+
+:Original: Documentation/dev-tools/index.rst
+
+===================================
+Strumenti di sviluppo per il kernel
+===================================
+
+Qui raccogliamo i vari documenti riguardanti gli strumenti di sviluppo che
+possono essere usati per lavorare col kernel . Per ora, questa è una raccolta
+senza un particolare struttura; si accettano patch!
+
+.. toctree::
+   :caption: Tabella dei contenuti
+   :maxdepth: 2
+
+   clang-format
diff --git a/Documentation/translations/it_IT/index.rst b/Documentation/translations/it_IT/index.rst
index 9220f65e30d1..afa680607750 100644
--- a/Documentation/translations/it_IT/index.rst
+++ b/Documentation/translations/it_IT/index.rst
@@ -103,9 +103,11 @@ sviluppatori del kernel.
 .. toctree::
    :maxdepth: 1
 
-   process/license-rules
-   doc-guide/index
-   kernel-hacking/index
+   Regole sulle licenze <process/license-rules>
+   Scrivere la documentazione <doc-guide/index>
+   Strumenti di sviluppo <dev-tools/index>
+   La guida all'*hacking*<kernel-hacking/index>
+
 
 Documentazione per gli utenti
 =============================
diff --git a/Documentation/translations/it_IT/process/2.Process.rst b/Documentation/translations/it_IT/process/2.Process.rst
index 0a62c0f33faf..6262c3908665 100644
--- a/Documentation/translations/it_IT/process/2.Process.rst
+++ b/Documentation/translations/it_IT/process/2.Process.rst
@@ -424,10 +424,10 @@ o entrambi.
 Molte delle liste di discussione del Kernel girano su vger.kernel.org;
 l'elenco principale lo si trova sul sito:
 
-	http://vger.kernel.org/vger-lists.html
+	https://subspace.kernel.org
 
-Esistono liste gestite altrove; un certo numero di queste sono in
-redhat.com/mailman/listinfo.
+Tuttavia, esistono liste gestite altrove; controllare il file MAINTAINERS per
+trovare la lista relativa ad un sottosistema specifico.
 
 La lista di discussione principale per lo sviluppo del kernel è, ovviamente,
 linux-kernel.  Questa lista è un luogo ostile dove trovarsi; i volumi possono
diff --git a/Documentation/translations/it_IT/process/4.Coding.rst b/Documentation/translations/it_IT/process/4.Coding.rst
index b7b9ab6df103..4ce61db34563 100644
--- a/Documentation/translations/it_IT/process/4.Coding.rst
+++ b/Documentation/translations/it_IT/process/4.Coding.rst
@@ -69,7 +69,7 @@ e per revisionare interi file per individuare errori nello stile di codifica,
 refusi e possibili miglioramenti.  Inoltre è utile anche per classificare gli
 ``#includes``, per allineare variabili/macro, per testi derivati ed altri
 compiti del genere.  Consultate il file
-:ref:`Documentation/translations/it_IT/process/clang-format.rst <clangformat>`
+:ref:`Documentation/translations/it_IT/dev-tools/clang-format.rst <clangformat>`
 per maggiori dettagli
 
 Se utilizzate un programma compatibile con EditorConfig, allora alcune
diff --git a/Documentation/translations/it_IT/process/changes.rst b/Documentation/translations/it_IT/process/changes.rst
index 0bcf8423cc80..c7d05e2fff15 100644
--- a/Documentation/translations/it_IT/process/changes.rst
+++ b/Documentation/translations/it_IT/process/changes.rst
@@ -34,9 +34,9 @@ PC Card, per esempio, probabilmente non dovreste preoccuparvi di pcmciautils.
 ====================== =================  ========================================
 GNU C                  5.1                gcc --version
 Clang/LLVM (optional)  13.0.0             clang --version
-Rust (opzionale)       1.76.0             rustc --version
+Rust (opzionale)       1.78.0             rustc --version
 bindgen (opzionale)    0.65.1             bindgen --version
-GNU make               3.81               make --version
+GNU make               4.0                make --version
 bash                   4.2                bash --version
 binutils               2.25               ld -v
 flex                   2.5.35             flex --version
@@ -65,6 +65,8 @@ Sphinx\ [#f1]_         2.4.4              sphinx-build --version
 cpio                   any                cpio --version
 GNU tar                1.28               tar --version
 gtags (opzionale)      6.6.5              gtags --version
+mkimage (opzionale)    2017.01            mkimage --version
+Python (opzionale)     3.5.x              python3 --version
 ====================== =================  ========================================
 
 .. [#f1] Sphinx è necessario solo per produrre la documentazione del Kernel
@@ -88,10 +90,25 @@ potremmo rimuovere gli espedienti che abbiamo implementato per farli
 funzionare. Per maggiori informazioni
 :ref:`Building Linux with Clang/LLVM <kbuild_llvm>`.
 
+Rust (opzionale)
+----------------
+
+È necessaria una versione recente del compilatore Rust.
+
+Verificate le istruzioni Documentation/rust/quick-start.rst su come soddisfare i
+requisiti per compilare code Rust. In particolare, la regola ``rustavailable``
+nel ``Makefile`` è utile per verificare perché gli strumenti di compilazione non
+vengono trovati.
+
+bindgen (opzionale)
+-------------------
+
+``bindgen`` viene usato per generare il collegamento (binding) da Rust al lato C del kernel. Dipende da ``libclang``.
+
 Make
 ----
 
-Per compilare il kernel vi servirà GNU make 3.81 o successivo.
+Per compilare il kernel vi servirà GNU make 4.0 o successivo.
 
 Bash
 ----
@@ -168,6 +185,16 @@ Il programma GNU GLOBAL versione 6.6.5, o successiva, è necessario quando si
 vuole eseguire ``make gtags`` e generare i relativi indici. Internamente si fa
 uso del parametro gtags ``-C (--directory)`` che compare in questa versione.
 
+mkimage
+-------
+
+Questo strumento viene usato per produrre un *Flat Image Tree* (FIT),
+tipicamente usato su sistemi ARM. Questo strumento è disponibile tramite il
+pacchetto ``u-boot-tools`` oppure può essere compilato dal codice sorgente di
+U-Boot. Consultate le istruzioni
+https://docs.u-boot.org/en/latest/build/tools.html#building-tools-for-linux
+
+
 Strumenti di sistema
 ********************
 
diff --git a/Documentation/translations/it_IT/process/coding-style.rst b/Documentation/translations/it_IT/process/coding-style.rst
index a4b9f44081da..c0dc786b8474 100644
--- a/Documentation/translations/it_IT/process/coding-style.rst
+++ b/Documentation/translations/it_IT/process/coding-style.rst
@@ -620,18 +620,6 @@ Lo stile preferito per i commenti più lunghi (multi-riga) è:
 	 * with beginning and ending almost-blank lines.
 	 */
 
-Per i file in net/ e in drivers/net/ lo stile preferito per i commenti
-più lunghi (multi-riga) è leggermente diverso.
-
-.. code-block:: c
-
-	/* The preferred comment style for files in net/ and drivers/net
-	 * looks like this.
-	 *
-	 * It is nearly the same as the generally preferred comment style,
-	 * but there is no initial almost-blank line.
-	 */
-
 È anche importante commentare i dati, sia per i tipi base che per tipi
 derivati.  A questo scopo, dichiarate un dato per riga (niente virgole
 per una dichiarazione multipla).  Questo vi lascerà spazio per un piccolo
@@ -726,7 +714,7 @@ di stile, refusi e possibilmente anche delle migliorie. È anche utile per
 ordinare gli ``#include``, per allineare variabili/macro, per ridistribuire
 il testo e altre cose simili.
 Per maggiori dettagli, consultate il file
-:ref:`Documentation/translations/it_IT/process/clang-format.rst <it_clangformat>`.
+:ref:`Documentation/translations/it_IT/dev-tools/clang-format.rst <it_clangformat>`.
 
 Se utilizzate un programma compatibile con EditorConfig, allora alcune
 configurazioni basilari come l'indentazione e la fine delle righe verranno
@@ -827,6 +815,29 @@ blocco do - while:
 				do_this(b, c);		\
 		} while (0)
 
+Le macro che sembrano funzioni con parametri non usati dovrebbero essere
+sostituite da funzioni inline per evitare il problema.
+
+.. code-block:: c
+
+       static inline void fun(struct foo *foo)
+       {
+       }
+
+Per motivi storici, molti file usano ancora l'approccio "cast a (void)" per
+valutare i parametri. Tuttavia, non è raccomandato. Le funzioni inline risolvono
+i problemi di "espressioni con effetti avversi valutate più di una volta",
+variabili non utilizzate, e in genere per qualche motivo sono documentate
+meglio.
+
+.. code-block:: c
+
+       /*
+        * Avoid doing this whenever possible and instead opt for static
+        * inline functions
+        */
+       #define macrofun(foo) do { (void) (foo); } while (0)
+
 Cose da evitare quando si usano le macro:
 
 1) le macro che hanno effetti sul flusso del codice:
diff --git a/Documentation/translations/it_IT/process/email-clients.rst b/Documentation/translations/it_IT/process/email-clients.rst
index 76ca3226c8cd..97173746d8c9 100644
--- a/Documentation/translations/it_IT/process/email-clients.rst
+++ b/Documentation/translations/it_IT/process/email-clients.rst
@@ -228,7 +228,7 @@ Mutt è molto personalizzabile. Qui di seguito trovate la configurazione minima
 per iniziare ad usare Mutt per inviare patch usando Gmail::
 
   # .muttrc
-  # ================  IMAP ====================
+  # ================  IMAP  ====================
   set imap_user = 'yourusername@gmail.com'
   set imap_pass = 'yourpassword'
   set spoolfile = imaps://imap.gmail.com/INBOX
@@ -365,27 +365,12 @@ un editor esterno.
 Un altro problema è che Gmail usa la codifica base64 per tutti quei messaggi
 che contengono caratteri non ASCII. Questo include cose tipo i nomi europei.
 
-Proton Mail
-***********
+HacKerMaiL (TUI)
+****************
 
-Il servizio Proton Mail ha una funzionalità che cripta tutti i messaggi verso
-ogni destinatario per cui è possibile trovare una chiave usando il *Web Key
-Directory* (WKD). Il servizio kernel.org pubblica il WKD per ogni sviluppatore
-in possesso di un conto kernel.org. Di conseguenza, tutti i messaggi inviati
-usando Proton Mail verso indirizzi kernel.org verranno criptati.
-
-Proton Mail non fornisce alcun meccanismo per disabilitare questa funzionalità
-perché verrebbe considerato un problema per la riservatezza. Questa funzionalità
-è attiva anche quando si inviano messaggi usando il Proton Mail Bridge. Dunque
-tutta la posta in uscita verrà criptata, incluse le patch inviate con ``git
-send-email``.
-
-I messaggi criptati sono una fonte di problemi; altri sviluppatori potrebbero
-non aver configurato i loro programmi, o strumenti, per gestire messaggi
-criptati; inoltre, alcuni programmi di posta elettronica potrebbero criptare le
-risposte a messaggi criptati per tutti i partecipanti alla discussione, inclusa
-la lista di discussione stessa.
-
-A meno che non venga introdotta una maniera per disabilitare questa
-funzionalità, non è consigliato usare Proton Mail per contribuire allo sviluppo
-del kernel.
+HacKerMaiL (hkml) è una semplice casella pubblica per la gestione dei messaggi
+di posta che non richiede alcuna sottoscrizione ad una lista di discussione.
+Viene sviluppato e mantenuto dal manutentore di DAMON e si pone come obiettivo
+quello di gestire il processo di sviluppo semplice come quello di DAMON e più in
+generale i sottosistemi del kernel. Per maggiori dettagli, fate riferimento al
+documento README (https://github.com/sjp38/hackermail/blob/master/README.md).
diff --git a/Documentation/translations/it_IT/process/howto.rst b/Documentation/translations/it_IT/process/howto.rst
index 090941a0a898..f51288602ee3 100644
--- a/Documentation/translations/it_IT/process/howto.rst
+++ b/Documentation/translations/it_IT/process/howto.rst
@@ -344,7 +344,7 @@ principale 4.x, sarà necessario un test d'integrazione.
 A tale scopo, esiste un repositorio speciale di test nel quale virtualmente
 tutti i rami dei sottosistemi vengono inclusi su base quotidiana:
 
-	https://git.kernel.org/?p=linux/kernel/git/next/linux-next.git
+	https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
 
 In questo modo, i kernel -next offrono uno sguardo riassuntivo su quello che
 ci si aspetterà essere nel kernel principale nel successivo periodo
@@ -389,12 +389,12 @@ sviluppatori del kernel partecipano alla lista di discussione Linux Kernel.
 I dettagli su come iscriversi e disiscriversi dalla lista possono essere
 trovati al sito:
 
-	http://vger.kernel.org/vger-lists.html#linux-kernel
+	https://subspace.kernel.org/subscribing.html
 
 Ci sono diversi archivi della lista di discussione. Usate un qualsiasi motore
 di ricerca per trovarli. Per esempio:
 
-	https://lore.kernel.org/lkml/
+	https://lore.kernel.org/linux-kernel/
 
 É caldamente consigliata una ricerca in questi archivi sul tema che volete
 sollevare, prima di pubblicarlo sulla lista. Molte cose sono già state
@@ -407,13 +407,13 @@ discussione e il loro uso.
 Molte di queste liste sono gestite su kernel.org. Per informazioni consultate
 la seguente pagina:
 
-	http://vger.kernel.org/vger-lists.html
+	https://subspace.kernel.org
 
 Per favore ricordatevi della buona educazione quando utilizzate queste liste.
 Sebbene sia un pò dozzinale, il seguente URL contiene alcune semplici linee
 guida per interagire con la lista (o con qualsiasi altra lista):
 
-	http://www.albion.com/netiquette/
+	https://subspace.kernel.org/etiquette.html
 
 Se diverse persone rispondo alla vostra mail, la lista dei riceventi (copia
 conoscenza) potrebbe diventare abbastanza lunga. Non cancellate nessuno dalla
diff --git a/Documentation/translations/it_IT/process/index.rst b/Documentation/translations/it_IT/process/index.rst
index c24500f74660..5a5214f5fd72 100644
--- a/Documentation/translations/it_IT/process/index.rst
+++ b/Documentation/translations/it_IT/process/index.rst
@@ -99,16 +99,6 @@ degli sviluppatori:
 
    kernel-docs
 
-Ed infine, qui ci sono alcune guide più tecniche che son state messe qua solo
-perché non si è trovato un posto migliore.
-
-.. toctree::
-   :maxdepth: 1
-
-   magic-number
-   clang-format
-   ../arch/riscv/patch-acceptance
-
 .. only::  subproject and html
 
    Indices
diff --git a/Documentation/translations/it_IT/process/submit-checklist.rst b/Documentation/translations/it_IT/process/submit-checklist.rst
index 60ec660702fa..37bb28e8d57e 100644
--- a/Documentation/translations/it_IT/process/submit-checklist.rst
+++ b/Documentation/translations/it_IT/process/submit-checklist.rst
@@ -5,8 +5,9 @@
 
 .. _it_submitchecklist:
 
+============================================================================
 Lista delle verifiche da fare prima di inviare una patch per il kernel Linux
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+============================================================================
 
 Qui troverete una lista di cose che uno sviluppatore dovrebbe fare per
 vedere le proprie patch accettate più rapidamente.
@@ -15,118 +16,126 @@ Tutti questi punti integrano la documentazione fornita riguardo alla
 sottomissione delle patch, in particolare
 :ref:`Documentation/translations/it_IT/process/submitting-patches.rst <it_submittingpatches>`.
 
+Revisiona il tuo codice
+=======================
+
 1) Se state usando delle funzionalità del kernel allora includete (#include)
    i file che le dichiarano/definiscono.  Non dipendente dal fatto che un file
    d'intestazione include anche quelli usati da voi.
 
-2) Compilazione pulita:
-
-  a) con le opzioni ``CONFIG`` negli stati ``=y``, ``=m`` e ``=n``. Nessun
-     avviso/errore di ``gcc`` e nessun avviso/errore dal linker.
-
-  b) con ``allnoconfig``, ``allmodconfig``
-
-  c) quando si usa ``O=builddir``
-
-  d) Qualsiasi modifica in Documentation/ deve compilare con successo senza
-     avvisi o errori. Usare ``make htmldocs`` o ``make pdfdocs`` per verificare
-     e correggere i problemi
-
-3) Compilare per diverse architetture di processore usando strumenti per
-   la cross-compilazione o altri.
+2) Controllate lo stile del codice della vostra patch secondo le direttive
+   scritte in :ref:`Documentation/translations/it_IT/process/coding-style.rst <it_codingstyle>`.
 
-4) Una buona architettura per la verifica della cross-compilazione è la ppc64
-   perché tende ad usare ``unsigned long`` per le quantità a 64-bit.
+3) Tutte le barriere di sincronizzazione {per esempio, ``barrier()``,
+   ``rmb()``, ``wmb()``} devono essere accompagnate da un commento nei
+   sorgenti che ne spieghi la logica: cosa fanno e perché.
 
-5) Controllate lo stile del codice della vostra patch secondo le direttive
-   scritte in :ref:`Documentation/translations/it_IT/process/coding-style.rst <it_codingstyle>`.
-   Prima dell'invio della patch, usate il verificatore di stile
-   (``script/checkpatch.pl``) per scovare le violazioni più semplici.
-   Dovreste essere in grado di giustificare tutte le violazioni rimanenti nella
-   vostra patch.
+Revisionate i cambiamenti a Kconfig
+===================================
 
-6) Le opzioni ``CONFIG``, nuove o modificate, non scombussolano il menu
+1) Le opzioni ``CONFIG``, nuove o modificate, non scombussolano il menu
    di configurazione e sono preimpostate come disabilitate a meno che non
    soddisfino i criteri descritti in ``Documentation/kbuild/kconfig-language.rst``
    alla punto "Voci di menu: valori predefiniti".
 
-7) Tutte le nuove opzioni ``Kconfig`` hanno un messaggio di aiuto.
+2) Tutte le nuove opzioni ``Kconfig`` hanno un messaggio di aiuto.
 
-8) La patch è stata accuratamente revisionata rispetto alle più importanti
+3) La patch è stata accuratamente revisionata rispetto alle più importanti
    configurazioni ``Kconfig``.  Questo è molto difficile da fare
    correttamente - un buono lavoro di testa sarà utile.
 
-9) Verificare con sparse.
+Fornite documentazione
+======================
 
-10) Usare ``make checkstack`` e correggere tutti i problemi rilevati.
+1) Includete :ref:`kernel-doc <kernel_doc>` per documentare API globali del
+   kernel.
 
-    .. note::
+2) Tutti i nuovi elementi in ``/proc`` sono documentati in ``Documentation/``.
 
-       ``checkstack`` non evidenzia esplicitamente i problemi, ma una funzione
-       che usa più di 512 byte sullo stack è una buona candidata per una
-       correzione.
+3) Tutti i nuovi parametri d'avvio del kernel sono documentati in
+    ``Documentation/admin-guide/kernel-parameters.rst``.
 
-11) Includete commenti :ref:`kernel-doc <kernel_doc>` per documentare API
-    globali del kernel.  Usate ``make htmldocs`` o ``make pdfdocs`` per
-    verificare i commenti :ref:`kernel-doc <kernel_doc>` ed eventualmente
-    correggerli.
+4) Tutti i nuovi parametri dei moduli sono documentati con ``MODULE_PARM_DESC()``.
 
-12) La patch è stata verificata con le seguenti opzioni abilitate
-    contemporaneamente: ``CONFIG_PREEMPT``, ``CONFIG_DEBUG_PREEMPT``,
-    ``CONFIG_DEBUG_SLAB``, ``CONFIG_DEBUG_PAGEALLOC``, ``CONFIG_DEBUG_MUTEXES``,
-    ``CONFIG_DEBUG_SPINLOCK``, ``CONFIG_DEBUG_ATOMIC_SLEEP``,
-    ``CONFIG_PROVE_RCU`` e ``CONFIG_DEBUG_OBJECTS_RCU_HEAD``.
+5) Tutte le nuove interfacce verso lo spazio utente sono documentate in
+    ``Documentation/ABI/``.  Leggete ``Documentation/ABI/README`` per maggiori
+    informazioni.  Le patch che modificano le interfacce utente dovrebbero
+    essere inviate in copia anche a linux-api@vger.kernel.org.
 
-13) La patch è stata compilata e verificata in esecuzione con, e senza,
-    le opzioni ``CONFIG_SMP`` e ``CONFIG_PREEMPT``.
+6) Se la patch aggiunge nuove chiamate ioctl, allora aggiornate
+    ``Documentation/userspace-api/ioctl/ioctl-number.rst``.
 
-14) Se la patch ha effetti sull'IO dei dischi, eccetera: allora dev'essere
-    verificata con, e senza, l'opzione ``CONFIG_LBDAF``.
+Verificate il vostro codice con gli strumenti
+=============================================
 
-15) Tutti i percorsi del codice sono stati verificati con tutte le funzionalità
-    di lockdep abilitate.
+1) Prima dell'invio della patch, usate il verificatore di stile
+   (``script/checkpatch.pl``) per scovare le violazioni più semplici.
+   Dovreste essere in grado di giustificare tutte le violazioni rimanenti nella
+   vostra patch.
 
-16) Tutti i nuovi elementi in ``/proc`` sono documentati in ``Documentation/``.
+2) Verificare il codice con sparse.
 
-17) Tutti i nuovi parametri d'avvio del kernel sono documentati in
-    ``Documentation/admin-guide/kernel-parameters.rst``.
 
-18) Tutti i nuovi parametri dei moduli sono documentati con ``MODULE_PARM_DESC()``.
+3) Usare ``make checkstack`` e correggere tutti i problemi rilevati. Da notare
+   che ``checkstack`` non evidenzia esplicitamente i problemi, ma una funzione
+   che usa più di 512 byte sullo stack è una buona candidata per una correzione.
 
-19) Tutte le nuove interfacce verso lo spazio utente sono documentate in
-    ``Documentation/ABI/``.  Leggete ``Documentation/ABI/README`` per maggiori
-    informazioni.  Le patch che modificano le interfacce utente dovrebbero
-    essere inviate in copia anche a linux-api@vger.kernel.org.
+Compilare il codice
+===================
+
+1) Compilazione pulita:
+
+  a) con le opzioni ``CONFIG`` negli stati ``=y``, ``=m`` e ``=n``. Nessun
+     avviso/errore di ``gcc`` e nessun avviso/errore dal linker.
 
-20) La patch è stata verificata con l'iniezione di fallimenti in slab e
-    nell'allocazione di pagine.  Vedere ``Documentation/dev-tools/fault-injection/``.
+  b) con ``allnoconfig``, ``allmodconfig``
+
+  c) quando si usa ``O=builddir``
 
-    Se il nuovo codice è corposo, potrebbe essere opportuno aggiungere
-    l'iniezione di fallimenti specifici per il sottosistema.
+  d) Qualsiasi modifica in Documentation/ deve compilare con successo senza
+     avvisi o errori. Usare ``make htmldocs`` o ``make pdfdocs`` per verificare
+     e correggere i problemi
 
-21) Il nuovo codice è stato compilato con ``gcc -W`` (usate
+2) Compilare per diverse architetture di processore usando strumenti per la
+   cross-compilazione o altri. Una buona architettura per la verifica della
+   cross-compilazione è la ppc64 perché tende ad usare ``unsigned long`` per le
+   quantità a 64-bit.
+
+3) Il nuovo codice è stato compilato con ``gcc -W`` (usate
     ``make KCFLAGS=-W``).  Questo genererà molti avvisi, ma è ottimo
     per scovare bachi come  "warning: comparison between signed and unsigned".
 
-22) La patch è stata verificata dopo essere stata inclusa nella serie di patch
-    -mm; questo al fine di assicurarsi che continui a funzionare assieme a
-    tutte le altre patch in coda e i vari cambiamenti nei sottosistemi VM, VFS
-    e altri.
+4) Se il codice che avete modificato dipende o usa una qualsiasi interfaccia o
+   funzionalità del kernel che è associata a uno dei seguenti simboli
+   ``Kconfig``, allora verificate che il kernel compili con diverse
+   configurazioni dove i simboli sono disabilitati e/o ``=m`` (se c'è la
+   possibilità) [non tutti contemporaneamente, solo diverse combinazioni
+   casuali]:
 
-23) Tutte le barriere di sincronizzazione {per esempio, ``barrier()``,
-    ``rmb()``, ``wmb()``} devono essere accompagnate da un commento nei
-    sorgenti che ne spieghi la logica: cosa fanno e perché.
+   ``CONFIG_SMP``, ``CONFIG_SYSFS``, ``CONFIG_PROC_FS``, ``CONFIG_INPUT``,
+   ``CONFIG_PCI``, ``CONFIG_BLOCK``, ``CONFIG_PM``, ``CONFIG_MAGIC_SYSRQ``,
+   ``CONFIG_NET``, ``CONFIG_INET=n`` (ma l'ultimo con ``CONFIG_NET=y``).
 
-24) Se la patch aggiunge nuove chiamate ioctl, allora aggiornate
-    ``Documentation/userspace-api/ioctl/ioctl-number.rst``.
+Verificate il vostro codice
+===========================
+
+1) La patch è stata verificata con le seguenti opzioni abilitate
+   contemporaneamente: ``CONFIG_PREEMPT``, ``CONFIG_DEBUG_PREEMPT``,
+   ``CONFIG_DEBUG_SLAB``, ``CONFIG_DEBUG_PAGEALLOC``, ``CONFIG_DEBUG_MUTEXES``,
+   ``CONFIG_DEBUG_SPINLOCK``, ``CONFIG_DEBUG_ATOMIC_SLEEP``,
+   ``CONFIG_PROVE_RCU`` e ``CONFIG_DEBUG_OBJECTS_RCU_HEAD``.
+
+2) La patch è stata compilata e verificata in esecuzione con, e senza,
+   le opzioni ``CONFIG_SMP`` e ``CONFIG_PREEMPT``.
+
+3) Tutti i percorsi del codice sono stati verificati con tutte le funzionalità
+   di lockdep abilitate.
 
-25) Se il codice che avete modificato dipende o usa una qualsiasi interfaccia o
-    funzionalità del kernel che è associata a uno dei seguenti simboli
-    ``Kconfig``, allora verificate che il kernel compili con diverse
-    configurazioni dove i simboli sono disabilitati e/o ``=m`` (se c'è la
-    possibilità) [non tutti contemporaneamente, solo diverse combinazioni
-    casuali]:
+4) La patch è stata verificata con l'iniezione di fallimenti in slab e
+   nell'allocazione di pagine. Vedere ``Documentation/dev-tools/fault-injection/``.
+   Se il nuovo codice è corposo, potrebbe essere opportuno aggiungere
+   l'iniezione di fallimenti specifici per il sottosistema.
 
-    ``CONFIG_SMP``, ``CONFIG_SYSFS``, ``CONFIG_PROC_FS``, ``CONFIG_INPUT``,
-    ``CONFIG_PCI``, ``CONFIG_BLOCK``, ``CONFIG_PM``, ``CONFIG_MAGIC_SYSRQ``,
-    ``CONFIG_NET``, ``CONFIG_INET=n`` (ma l'ultimo con ``CONFIG_NET=y``).
+5) La patch è stata verificata sul tag più recente di linux-next per assicurarsi
+   che funzioni assieme a tutte le altre patch in coda, assieme ai vari
+   cambiamenti nei sottosistemi VM, VFS e altri.
diff --git a/Documentation/translations/it_IT/process/submitting-patches.rst b/Documentation/translations/it_IT/process/submitting-patches.rst
index a7252e73937a..1cc4808139ce 100644
--- a/Documentation/translations/it_IT/process/submitting-patches.rst
+++ b/Documentation/translations/it_IT/process/submitting-patches.rst
@@ -137,10 +137,10 @@ questione.
 
 Quando volete fare riferimento ad una lista di discussione, preferite il
 servizio d'archiviazione lore.kernel.org. Per create un collegamento URL è
-sufficiente usare il campo ``Message-Id``, presente nell'intestazione del
+sufficiente usare il campo ``Message-ID``, presente nell'intestazione del
 messaggio, senza parentesi angolari. Per esempio::
 
-     Link: https://lore.kernel.org/r/30th.anniversary.repost@klaava.Helsinki.FI/
+     Link: https://lore.kernel.org/30th.anniversary.repost@klaava.Helsinki.FI
 
 Prima d'inviare il messaggio ricordatevi di verificare che il collegamento così
 creato funzioni e che indirizzi verso il messaggio desiderato.
@@ -275,11 +275,9 @@ patch riceverà molta più attenzione. Tuttavia, per favore, non spammate le lis
 di discussione che non sono interessate al vostro lavoro.
 
 Molte delle liste di discussione relative al kernel vengono ospitate su
-vger.kernel.org; potete trovare un loro elenco alla pagina
-http://vger.kernel.org/vger-lists.html.  Tuttavia, ci sono altre liste di
-discussione ospitate altrove.
-
-Non inviate più di 15 patch alla volta sulle liste di discussione vger!!!
+kernel.org; potete trovare un loro elenco alla pagina
+https://subspace.kernel.org. Tuttavia, ci sono altre liste di discussione
+ospitate altrove.
 
 L'ultimo giudizio sull'integrazione delle modifiche accettate spetta a
 Linux Torvalds.  Il suo indirizzo e-mail è <torvalds@linux-foundation.org>.
@@ -891,6 +889,14 @@ Assicuratevi che il commit si basi su sorgenti ufficiali del
 manutentore/mainline e non su sorgenti interni, accessibile solo a voi,
 altrimenti sarebbe inutile.
 
+Strumenti
+---------
+
+Molti degli aspetti più tecnici di questo processo possono essere automatizzati
+usando b4, la cui documentazione è disponibile all'indirizzo
+<https://b4.docs.kernel.org/en/latest/>. Può aiutare a tracciare la dipendenze,
+eseguire checkpatch e con la formattazione e l'invio di messaggi di posta.
+
 Riferimenti
 -----------
 
@@ -913,9 +919,6 @@ Greg Kroah-Hartman, "Come scocciare un manutentore di un sottosistema"
 
   <http://www.kroah.com/log/linux/maintainer-06.html>
 
-No!!!! Basta gigantesche bombe patch alle persone sulla lista linux-kernel@vger.kernel.org!
-  <https://lore.kernel.org/r/20050711.125305.08322243.davem@davemloft.net>
-
 Kernel Documentation/translations/it_IT/process/coding-style.rst.
 
 E-mail di Linus Torvalds sul formato canonico di una patch:
diff --git a/Documentation/translations/it_IT/staging/index.rst b/Documentation/translations/it_IT/staging/index.rst
new file mode 100644
index 000000000000..6b56707f3a3a
--- /dev/null
+++ b/Documentation/translations/it_IT/staging/index.rst
@@ -0,0 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-ita.rst
+
+:Original: :ref:`Documentation/staging/index.rst <process_index>`
+
+Documenti in ordine sparso
+==========================
+
+.. toctree::
+   :maxdepth: 2
+
+   magic-number
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Documentation/translations/it_IT/staging/magic-number.rst
similarity index 100%
rename from Documentation/translations/it_IT/process/magic-number.rst
rename to Documentation/translations/it_IT/staging/magic-number.rst
-- 
2.39.5


