Return-Path: <linux-kernel+bounces-178099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0D78C48AF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 23:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6C21C22C90
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAA7824BC;
	Mon, 13 May 2024 21:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="tHptVoqw"
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F413F1DA24;
	Mon, 13 May 2024 21:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.103.80.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715634909; cv=none; b=gnGyTP+AUBQNEyhG29FHMa/7AJoQByYAjKGFUejuRMBjIqc0ke+CjcWyUdDVUcQ5WDTPSpyO8AjutR7qPIJP8G7TWqv6gr97iZ42J6aPQQ9FxTRDMSGPPBnjw+R1ZaelNOQ3L5S20zY7vikubt8xq24HJslsox6I9ratWCK92eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715634909; c=relaxed/simple;
	bh=a/brmcAF1LoYyRkwzV1GcKMsg01p2BpABPWWRK9drVA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bac1IbwYZRLlsX1LXTi44pZmps2yag9bafgsu4KiK1cjytxtfBtm/CwbPFEtZQqK3ViBUcUQyw2Kx+yEnVhrQNVW1LWgHtGayYDoHiOH8IKNC1qFwUXt78fyFjIVEFXE6jVKojq+XEuWBKvO7DGskP2SdNLhaYugz7NKvIlYjhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it; spf=pass smtp.mailfrom=vaga.pv.it; dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b=tHptVoqw; arc=none smtp.client-ip=212.103.80.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaga.pv.it
Received: from localhost (unknown [127.0.0.1])
	by mx.kolabnow.com (Postfix) with ESMTP id 0A25830E3E27;
	Mon, 13 May 2024 23:05:46 +0200 (CEST)
Authentication-Results: ext-mx-out013.mykolab.com (amavis);
 dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
 header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:message-id:date:date:subject:subject:from:from:received
	:received:received; s=dkim20160331; t=1715634343; x=1717448744;
	 bh=uosIiTjl1Ic8GRQ64GyoYPriYXv2M6gt6Vb7P6VMwmw=; b=tHptVoqwnizt
	pnfEdIyttaUsP9gARGFEwwIL1/XigmCarHmjFd7Q78aJgSFHaI/9DJruYdZzklg0
	3B2gH6QVpOS2qyLw27n/vPHE0zz6Dg6L6BfKQuH75o+uen9d8sKTejbnqWfEagdF
	33yfiG5qCKaNmcZuEzHu1RpQPbZ79wwo7kFxEyN9kpW7tAmULI433qGStS1cnlKP
	0vtRY9lwY0z34iYV4m0N+0uy/579Q6ECtimp3k+xHiYy8okG9pzswRgpBFXxf9xi
	8p1b3fArJxK5pv8aPZDoVdmhvngSQ/5cRO0Vh1JdoS4vKnSu8OnCOVEU7FY9utML
	lPLBMU5puzMj0kFkhr2uXRwOMZvPFqIXULwBF0K5p70MOJsKgpsnas5whnj1ypN6
	i+QYEW4ZeHQiiSIauoL82iidva1E989N51aN9CIrJ3zbWf66DZbfBLrzfQmzu1kD
	sfagByADvmjSfAaTyuplCVpSoi298cfQeVFcKVlCicTk6iQ9j8k984fAbDK+6fFI
	3eHX/Vg6N7irBug77dI6kYS2FPLrFCZlikUeqXkUOwFMvYr9G/9RFRsaL97Cj3wK
	Gtv2X7ueXprp2pEFqkSn0zOBy6O4RpjkPANIEUh+d26WhD6hd90zrh50CoHIyh0p
	Gfagg+etB8Jkf4/DQsg3r5r8jAfCX2Y=
X-Virus-Scanned: amavis at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -0.001
X-Spam-Level:
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out013.mykolab.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id XEZlh5hnIxuz; Mon, 13 May 2024 23:05:43 +0200 (CEST)
Received: from int-mx011.mykolab.com (unknown [10.9.13.11])
	by mx.kolabnow.com (Postfix) with ESMTPS id ED46730E3E24;
	Mon, 13 May 2024 23:05:42 +0200 (CEST)
Received: from ext-subm010.mykolab.com (unknown [10.9.6.10])
	by int-mx011.mykolab.com (Postfix) with ESMTPS id 29E51314D6DB;
	Mon, 13 May 2024 23:05:42 +0200 (CEST)
From: Federico Vaga <federico.vaga@vaga.pv.it>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH] doc:it_IT: align Italian documentation
Date: Mon, 13 May 2024 23:05:10 +0200
Message-Id: <20240513210510.10929-1-federico.vaga@vaga.pv.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This commit translats in Italian the following changes:

commit 5db34f5bfd78 ("docs: stable-kernel-rules: remove code-labels tags and a indention level")
commit 2263c40e6525 ("docs: stable-kernel-rules: call mainline by its name and change example")
commit db483303b58f ("docs: stable-kernel-rules: reduce redundancy")
commit af3e4a5ab9a0 ("docs: stable-kernel-rules: create special tag to flag 'no backporting'"")
commit 91a3d6be99e6 ("doc-guide: kernel-doc: tell about object-like macros")
commit b104dbedbe61 ("Documentation: RISC-V: patch-acceptance: mention patchwork's role")
commit ed843ae947f8 ("docs: move riscv under arch")
commit b45d8f387157 ("docs: remove the tips on how to submit patches from MAINTAINERS")
commit 0d828200ad56 ("docs: process: allow Closes tags with links")
commit c23f28975abc ("Merge tag 'docs-6.4' of git://git.lwn.net/linux")
commit 329ac9af902e ("docs: submitting-patches: Discuss interleaved replies")
commit 02f9998754b0 ("docs: submitting-patches: Suggest a longer expected time for responses")
commit 1fae02e7eb99 ("docs: submitting-patches: encourage direct notifications to commenters")
commit d254d263f6c8 ("docs: submitting-patches: improve the base commit explanation")
commit 0d828200ad56 ("docs: process: allow Closes tags with links")
commit 9c1b86f8ce04 ("kbuild: raise the minimum supported version of LLVM to 13.0.1")
commit 768409cff6cc ("rust: upgrade to Rust 1.76.0")
commit 23bfb947eb0a ("doc: fix spelling about ReStructured Text")
commit d0bde9ca0ecf ("docs: stable-kernel-rules: mention other usages for stable tag comments")
commit 33568553b3fc ("docs: stable-kernel-rules: make rule section more straight forward")
commit 3feb21bb0bb4 ("docs: stable-kernel-rules: move text around to improve flow")
commit 0f11447d9fcc ("docs: stable-kernel-rules: improve structure by changing headlines")
commit 189057a1b61b ("docs: stable-kernel-rules: make the examples for option 1 a proper list")
commit 6e160d29f654 ("docs: stable-kernel-rules: fine-tune various details")
commit bbaee49cce7c ("docs: stable-kernel-rules: mention that regressions must be prevented")
commit 4f01342464a8 ("Documentation: stable: clarify patch series prerequisites")

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 .../{ => arch}/riscv/patch-acceptance.rst     |  24 +-
 .../it_IT/doc-guide/kernel-doc.rst            |  44 +++
 .../it_IT/doc-guide/parse-headers.rst         |   2 +-
 .../translations/it_IT/process/5.Posting.rst  |  27 +-
 .../it_IT/process/6.Followthrough.rst         |   7 +
 .../translations/it_IT/process/changes.rst    |   4 +-
 .../translations/it_IT/process/index.rst      |   2 +-
 .../it_IT/process/stable-kernel-rules.rst     | 310 ++++++++++--------
 .../it_IT/process/submitting-patches.rst      | 135 ++++++--
 9 files changed, 377 insertions(+), 178 deletions(-)
 rename Documentation/translations/it_IT/{ => arch}/riscv/patch-acceptance.rst (64%)

diff --git a/Documentation/translations/it_IT/riscv/patch-acceptance.rst b/Documentation/translations/it_IT/arch/riscv/patch-acceptance.rst
similarity index 64%
rename from Documentation/translations/it_IT/riscv/patch-acceptance.rst
rename to Documentation/translations/it_IT/arch/riscv/patch-acceptance.rst
index 2d7afb1f6959..e0ad63643f1b 100644
--- a/Documentation/translations/it_IT/riscv/patch-acceptance.rst
+++ b/Documentation/translations/it_IT/arch/riscv/patch-acceptance.rst
@@ -1,6 +1,6 @@
-.. include:: ../disclaimer-ita.rst
+.. include:: ../../disclaimer-ita.rst
 
-:Original: :doc:`../../../arch/riscv/patch-acceptance`
+:Original: :doc:`../../../../arch/riscv/patch-acceptance`
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 arch/riscv linee guida alla manutenzione per gli sviluppatori
@@ -22,6 +22,26 @@ sperimentale.  Desideriamo estendere questi stessi principi al codice
 relativo all'architettura RISC-V che verrà accettato per l'inclusione
 nel kernel.
 
+Patchwork
+---------
+
+RISC-V ha un'istanza di patchwork dov'è possibile controllare lo stato delle patch:
+
+  https://patchwork.kernel.org/project/linux-riscv/list/
+
+Se la vostra patch non appare nella vista predefinita, i manutentori di RISC-V
+hanno probabilmente richiesto delle modifiche o si aspettano che venga applicata
+a un altro albero.
+
+Il processo automatico viene eseguito su questa istanza di patchwork, costruendo
+e collaudando le patch man mano che arrivano. Il processo applica le patch al
+riferimento HEAD corrente dei rami `for-next` e `fixes` dei sorgenti RISC-V,
+questo a seconda che la patch sia stata o meno individuata come correzione. In
+caso contrario, utilizzerà il ramo `master` di RISC-V. L'esatto commit a cui è
+stata applicata una serie di patch sarà annotato su patchwork. È improbabile che
+vengano applicate Le patch che non passano i controlli, nella maggior parte dei
+casi dovranno essere ripresentate.
+
 In aggiunta alla lista delle verifiche da fare prima di inviare una patch
 -------------------------------------------------------------------------
 
diff --git a/Documentation/translations/it_IT/doc-guide/kernel-doc.rst b/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
index 74057d203539..aa0e31d353d6 100644
--- a/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
+++ b/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
@@ -370,6 +370,50 @@ Anche i tipi di dato per prototipi di funzione possono essere documentati::
    */
    typedef void (*type_name)(struct v4l2_ctrl *arg1, void *arg2);
 
+Documentazione di macro simili a oggetti
+----------------------------------------
+
+Le macro simili a oggetti si distinguono dalle macro simili a funzione. Esse si
+distinguono in base al fatto che il nome della macro simile a funzione sia
+immediatamente seguito da una parentesi sinistra ('(') mentre in quelle simili a
+oggetti no.
+
+Le macro simili a funzioni sono gestite come funzioni da ``scripts/kernel-doc``.
+Possono avere un elenco di parametri. Le macro simili a oggetti non hanno un
+elenco di parametri.
+
+Il formato generale di un commento kernel-doc per una macro simile a oggetti è::
+
+  /**
+   * define object_name - Brief description.
+   *
+   * Description of the object.
+   */
+
+Esempio::
+
+  /**
+   * define MAX_ERRNO - maximum errno value that is supported
+   *
+   * Kernel pointers have redundant information, so we can use a
+   * scheme where we can return either an error code or a normal
+   * pointer with the same return value.
+   */
+  #define MAX_ERRNO	4095
+
+Esempio::
+
+  /**
+   * define DRM_GEM_VRAM_PLANE_HELPER_FUNCS - \
+   *	Initializes struct drm_plane_helper_funcs for VRAM handling
+   *
+   * This macro initializes struct drm_plane_helper_funcs to use the
+   * respective helper functions.
+   */
+  #define DRM_GEM_VRAM_PLANE_HELPER_FUNCS \
+	.prepare_fb = drm_gem_vram_plane_helper_prepare_fb, \
+	.cleanup_fb = drm_gem_vram_plane_helper_cleanup_fb
+
 Marcatori e riferimenti
 -----------------------
 
diff --git a/Documentation/translations/it_IT/doc-guide/parse-headers.rst b/Documentation/translations/it_IT/doc-guide/parse-headers.rst
index c7076a21667a..026a23e49767 100644
--- a/Documentation/translations/it_IT/doc-guide/parse-headers.rst
+++ b/Documentation/translations/it_IT/doc-guide/parse-headers.rst
@@ -63,7 +63,7 @@ DESCRIZIONE
 ***********
 
 Converte un file d'intestazione o un file sorgente C (C_FILE) in un testo
-ReStructuredText incluso mediante il blocco ..parsed-literal
+reStructuredText incluso mediante il blocco ..parsed-literal
 con riferimenti alla documentazione che descrive l'API. Opzionalmente,
 il programma accetta anche un altro file (EXCEPTIONS_FILE) che
 descrive quali elementi debbano essere ignorati o il cui riferimento
diff --git a/Documentation/translations/it_IT/process/5.Posting.rst b/Documentation/translations/it_IT/process/5.Posting.rst
index a7e2a3238415..a61d9e6f7433 100644
--- a/Documentation/translations/it_IT/process/5.Posting.rst
+++ b/Documentation/translations/it_IT/process/5.Posting.rst
@@ -223,8 +223,9 @@ Un'etichetta ci può dire quale commit ha introdotto il problema che viene corre
        Fixes: 1f2e3d4c5b6a ("The first line of the commit specified by the first 12 characters of its SHA-1 ID")
 
 Un'altra etichetta viene usata per fornire collegamenti a pagine web contenenti
-maggiori informazioni, per esempio un rapporto circa il baco risolto dalla
-patch, oppure un documento con le specifiche implementate dalla patch::
+maggiori informazioni, per esempio una discussione avvenuta precedentemente
+circa il baco risolto dalla patch, oppure un documento con le specifiche
+implementate dalla patch::
 
        Link: https://example.com/somewhere.html  optional-other-stuff
 
@@ -233,7 +234,19 @@ alla più recente discussione pubblica. A volte questo è fatto automaticamente
 alcuni strumenti come b4 or un *hook* git come quello descritto qui
 'Documentation/translations/it_IT/maintainer/configure-git.rst'
 
-Un terzo tipo di etichetta viene usato per indicare chi ha contribuito allo
+
+Se il collegamento indirizza verso un rapporto su un baco risolto dalla patch,
+allora usate l'etichetta "Closes:"::
+
+       Closes: https://example.com/issues/1234  optional-other-stuff
+
+Alcune piattaforme di tracciamento di bachi hanno la capacità di chiudere
+automaticamente il problema se l'etichetta è presente nel messaggio. Alcuni
+automatismi che monitorano la liste di discussione possono anche tracciare
+queste etichette e intraprendere azioni. Piattaforme private e URL invalidi sono
+proibiti.
+
+Un altro tipo di etichetta viene usato per indicare chi ha contribuito allo
 sviluppo della patch. Tutte queste etichette seguono il formato::
 
 	tag: Full Name <email address>  optional-other-stuff
@@ -267,7 +280,13 @@ Le etichette in uso più comuni sono:
  - Reported-by: menziona l'utente che ha riportato il problema corretto da
    questa patch; quest'etichetta viene usata per dare credito alle persone che
    hanno verificato il codice e ci hanno fatto sapere quando le cose non
-   funzionavano correttamente. Se esiste un rapporto disponibile sul web, allora
+   funzionavano correttamente. Questa etichetta dovrebbe essere seguita da
+   quella Closes: con un indirizzo al rapporto, a meno che questo non sia
+   disponibile sul web. L'etichetta Link: può essere usata in alternativa a
+   Closes: se la patch corregge solo in parte il problema riportato nel
+   rapporto.
+
+   Se esiste un rapporto disponibile sul web, allora
    L'etichetta dovrebbe essere seguita da un collegamento al suddetto rapporto.
 
  - Cc: la persona menzionata ha ricevuto una copia della patch ed ha avuto
diff --git a/Documentation/translations/it_IT/process/6.Followthrough.rst b/Documentation/translations/it_IT/process/6.Followthrough.rst
index df7d5fb28832..685eee5690f3 100644
--- a/Documentation/translations/it_IT/process/6.Followthrough.rst
+++ b/Documentation/translations/it_IT/process/6.Followthrough.rst
@@ -60,6 +60,13 @@ resa molto più facile se tenete presente alcuni dettagli:
    stanno lavorando per la creazione del miglior kernel possibile; non
    stanno cercando di creare un disagio ad aziende concorrenti.
 
+  - Preparatevi a richieste apparentemente sciocche di modifiche allo stile di
+    codifica e a richieste di trasferire parte del vostro codice in parti
+    condivise del kernel. Uno dei compiti dei manutentori è quello di mantenere
+    lo aspetto del codice. A volte questo significa che l'ingegnoso stratagemma
+    nel vostro driver per aggirare un problema deve diventare una caratteristica
+    generalizzata del kernel pronta per essere riutilizzata.
+
 Quello che si sta cercando di dire è che, quando i revisori vi inviano degli
 appunti dovete fare attenzione alle osservazioni tecniche che vi stanno
 facendo.  Non lasciate che il loro modo di esprimersi o il vostro orgoglio
diff --git a/Documentation/translations/it_IT/process/changes.rst b/Documentation/translations/it_IT/process/changes.rst
index ade695a7de19..0bcf8423cc80 100644
--- a/Documentation/translations/it_IT/process/changes.rst
+++ b/Documentation/translations/it_IT/process/changes.rst
@@ -33,8 +33,8 @@ PC Card, per esempio, probabilmente non dovreste preoccuparvi di pcmciautils.
         Programma       Versione minima       Comando per verificare la versione
 ====================== =================  ========================================
 GNU C                  5.1                gcc --version
-Clang/LLVM (optional)  11.0.0             clang --version
-Rust (opzionale)       1.74.1             rustc --version
+Clang/LLVM (optional)  13.0.0             clang --version
+Rust (opzionale)       1.76.0             rustc --version
 bindgen (opzionale)    0.65.1             bindgen --version
 GNU make               3.81               make --version
 bash                   4.2                bash --version
diff --git a/Documentation/translations/it_IT/process/index.rst b/Documentation/translations/it_IT/process/index.rst
index 73c643dcc541..c24500f74660 100644
--- a/Documentation/translations/it_IT/process/index.rst
+++ b/Documentation/translations/it_IT/process/index.rst
@@ -107,7 +107,7 @@ perché non si è trovato un posto migliore.
 
    magic-number
    clang-format
-   ../riscv/patch-acceptance
+   ../arch/riscv/patch-acceptance
 
 .. only::  subproject and html
 
diff --git a/Documentation/translations/it_IT/process/stable-kernel-rules.rst b/Documentation/translations/it_IT/process/stable-kernel-rules.rst
index a2577a806a18..b1592f10f7a7 100644
--- a/Documentation/translations/it_IT/process/stable-kernel-rules.rst
+++ b/Documentation/translations/it_IT/process/stable-kernel-rules.rst
@@ -11,32 +11,31 @@ Tutto quello che volevate sapere sui rilasci -stable di Linux
 Regole sul tipo di patch che vengono o non vengono accettate nei sorgenti
 "-stable":
 
- - Ovviamente dev'essere corretta e verificata.
- - Non dev'essere più grande di 100 righe, incluso il contesto.
- - Deve correggere una cosa sola.
- - Deve correggere un baco vero che sta disturbando gli utenti (non cose del
-   tipo "Questo potrebbe essere un problema ...").
- - Deve correggere un problema di compilazione (ma non per cose già segnate
-   con CONFIG_BROKEN), un kernel oops, un blocco, una corruzione di dati,
-   un vero problema di sicurezza, o problemi del tipo "oh, questo non va bene".
-   In pratica, qualcosa di critico.
- - Problemi importanti riportati dagli utenti di una distribuzione potrebbero
-   essere considerati se correggono importanti problemi di prestazioni o di
-   interattività.  Dato che questi problemi non sono così ovvi e la loro
-   correzione ha un'alta probabilità d'introdurre una regressione, dovrebbero
-   essere sottomessi solo dal manutentore della distribuzione includendo un
-   link, se esiste, ad un rapporto su bugzilla, e informazioni aggiuntive
-   sull'impatto che ha sugli utenti.
- - Non deve correggere problemi relativi a una "teorica sezione critica",
-   a meno che non venga fornita anche una spiegazione su come questa si
-   possa verificare.
- - Non deve includere alcuna correzione "banale" (correzioni grammaticali,
-   pulizia dagli spazi bianchi, eccetera).
- - Deve rispettare le regole scritte in
-   :ref:`Documentation/translations/it_IT/process/submitting-patches.rst <it_submittingpatches>`
- - Questa patch o una equivalente deve esistere già nei sorgenti principali di
-   Linux
-
+- Questa patch o una equivalente deve esistere già nei sorgenti principali di
+  Linux (upstream)
+- Ovviamente dev'essere corretta e verificata.
+- Non dev'essere più grande di 100 righe, incluso il contesto.
+- Deve rispettare le regole scritte in
+  :ref:`Documentation/translations/it_IT/process/submitting-patches.rst <it_submittingpatches>`
+- Deve correggere un vero baco che causi problemi agli utenti oppure aggiunge
+  un nuovo identificatore di dispositivo. Maggiori dettagli per il primo caso:
+
+  - Corregge un problema come un oops, un blocco, una corruzione di dati, un
+    vero problema di sicurezza, una stranezza hardware, un problema di
+    compilazione (ma non per cose già segnate con CONFIG_BROKEN), o problemi
+    del tipo "oh, questo non va bene".
+  - Problemi importanti riportati dagli utenti di una distribuzione potrebbero
+    essere considerati se correggono importanti problemi di prestazioni o di
+    interattività. Dato che questi problemi non sono così ovvi e la loro
+    correzione ha un'alta probabilità d'introdurre una regressione,
+    dovrebbero essere sottomessi solo dal manutentore della distribuzione
+    includendo un link, se esiste, ad un rapporto su bugzilla, e informazioni
+    aggiuntive sull'impatto che ha sugli utenti.
+  - Non si accettano cose del tipo "Questo potrebbe essere un problema ..."
+    come una teorica sezione critica, senza aver fornito anche una spiegazione
+    su come il baco possa essere sfruttato.
+  - Non deve includere alcuna correzione "banale" (correzioni grammaticali,
+    pulizia dagli spazi bianchi, eccetera).
 
 Procedura per sottomettere patch per i sorgenti -stable
 -------------------------------------------------------
@@ -46,177 +45,204 @@ Procedura per sottomettere patch per i sorgenti -stable
   di revisione -stable, ma dovrebbe seguire le procedure descritte in
   :ref:`Documentation/translations/it_IT/process/security-bugs.rst <it_securitybugs>`.
 
-Per tutte le altre sottomissioni, scegliere una delle seguenti procedure
-------------------------------------------------------------------------
+Ci sono tre opzioni per inviare una modifica per i sorgenti -stable:
+
+1. Aggiungi un'etichetta 'stable' alla descrizione della patch al momento della
+   sottomissione per l'inclusione nei sorgenti principali.
+2. Chiedere alla squadra "stable" di prendere una patch già applicata sui
+   sorgenti principali
+3. Sottomettere una patch alla squadra "stable" equivalente ad una modifica già
+   fatta sui sorgenti principali.
+
+Le seguenti sezioni descrivono con maggiori dettagli ognuna di queste opzioni
+
+L':ref:`it_option_1` è **fortemente** raccomandata; è il modo più facile e
+usato. L':ref:`it_option_2` si usa quando al momento della sottomissione non si
+era pensato di riportare la modifica su versioni precedenti.
+L':ref:`it_option_3` è un'alternativa ai due metodi precedenti quando la patch
+nei sorgenti principali ha bisogno di aggiustamenti per essere applicata su
+versioni precedenti (per esempio a causa di cambiamenti dell'API).
+
+Quando si utilizza l'opzione 2 o 3 è possibile chiedere che la modifica sia
+inclusa in specifiche versioni stabili. In tal caso, assicurarsi che la correzione
+o una equivalente sia applicabile, o già presente in tutti i sorgenti
+stabili più recenti ancora supportati. Questo ha lo scopo di prevenire
+regressioni che gli utenti potrebbero incontrare in seguito durante
+l'aggiornamento, se ad esempio una correzione per 5.19-rc1 venisse
+riportata a 5.10.y, ma non a 5.15.y.
 
 .. _it_option_1:
 
 Opzione 1
 *********
 
-Per far sì che una patch venga automaticamente inclusa nei sorgenti stabili,
-aggiungete l'etichetta
+Aggiungete la seguente etichetta nell'area delle firme per far sì che una patch
+che state inviando per l'inclusione nei sorgenti principali venga presa
+automaticamente anche per quelli stabili::
 
-.. code-block:: none
+  Cc: stable@vger.kernel.org
 
-     Cc: stable@vger.kernel.org
+Invece, usate ``Cc: stable@vger.kernel.org`` quando state inviando correzioni
+per vulnerabilità non ancora di pubblico dominio: questo riduce il rischio di
+esporre accidentalmente al pubblico la correzione quando si usa 'git
+send-email', perché i messaggi inviati a quell'indirizzo non vengono inviati da
+nessuna parte.
 
-nell'area dedicata alla firme. Una volta che la patch è stata inclusa, verrà
-applicata anche sui sorgenti stabili senza che l'autore o il manutentore
-del sottosistema debba fare qualcosa.
+Una volta che la patch è stata inclusa, verrà applicata anche sui sorgenti
+stabili senza che l'autore o il manutentore del sottosistema debba fare
+qualcosa.
 
-.. _it_option_2:
+Per lasciare una nota per la squadra "stable", usate commenti in linea in stile
+shell (leggere oltre per maggiori dettagli).
 
-Opzione 2
-*********
+* Specificate i prerequisiti per le patch aggiuntive::
 
-Dopo che la patch è stata inclusa nei sorgenti Linux, inviate una mail a
-stable@vger.kernel.org includendo: il titolo della patch, l'identificativo
-del commit, il perché pensate che debba essere applicata, e in quale versione
-del kernel la vorreste vedere.
+    Cc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle
+    Cc: <stable@vger.kernel.org> # 3.3.x: 1b9508f: sched: Rate-limit newidle
+    Cc: <stable@vger.kernel.org> # 3.3.x: fd21073: sched: Fix affinity logic
+    Cc: <stable@vger.kernel.org> # 3.3.x
+    Signed-off-by: Ingo Molnar <mingo@elte.hu>
 
-.. _it_option_3:
+  La sequenza di etichette ha il seguente significato::
 
-Opzione 3
-*********
+     git cherry-pick a1f84a3
+     git cherry-pick 1b9508f
+     git cherry-pick fd21073
+     git cherry-pick <this commit>
 
-Inviata la patch, dopo aver verificato che rispetta le regole descritte in
-precedenza, a stable@vger.kernel.org.  Dovete annotare nel changelog
-l'identificativo del commit nei sorgenti principali, così come la versione
-del kernel nel quale vorreste vedere la patch.
+  Notate che per una serie di patch non dovere elencare come necessarie tutte
+  le patch della serie stessa. Per esempio se avete la seguente serie::
 
-L':ref:`it_option_1` è fortemente raccomandata; è il modo più facile e usato.
-L':ref:`it_option_2` e l':ref:`it_option_3` sono più utili quando, al momento
-dell'inclusione dei sorgenti principali, si ritiene che non debbano essere
-incluse anche in quelli stabili (per esempio, perché si crede che si dovrebbero
-fare più verifiche per eventuali regressioni). L':ref:`it_option_3` è
-particolarmente utile se una patch dev'essere riportata su una versione
-precedente (per esempio la patch richiede modifiche a causa di cambiamenti di
-API).
+     patch1
+     patch2
 
-Notate che per l':ref:`it_option_3`, se la patch è diversa da quella nei
-sorgenti principali (per esempio perché è stato necessario un lavoro di
-adattamento) allora dev'essere ben documentata e giustificata nella descrizione
-della patch.
+  dove patch2 dipende da patch1, non dovete elencare patch1 come requisito per
+  patch2 se avete già menzionato patch1 per l'inclusione in "stable"
 
-L'identificativo del commit nei sorgenti principali dev'essere indicato sopra
-al messaggio della patch, così:
+* Evidenziate le patch che hanno dei requisiti circa la versione del kernel::
 
-.. code-block:: none
+    Cc: <stable@vger.kernel.org> # 3.3.x
 
-    commit <sha1> upstream.
+  L'etichetta ha il seguente significato::
 
-o in alternativa:
+     git cherry-pick <this commit>
 
-.. code-block:: none
+  per ogni sorgente "-stable" che inizia con la versione indicata.
 
-    [ Upstream commit <sha1>  ]
+  Notate che queste etichette non sono necessarie se la squadre "stable" può
+  dedurre la versione dalle etichette Fixes:
 
-In aggiunta, alcune patch inviate attraverso l':ref:`it_option_1` potrebbero
-dipendere da altre che devo essere incluse. Questa situazione può essere
-indicata nel seguente modo nell'area dedicata alle firme:
+* Ritardare l'inclusione di patch::
+    Cc: <stable@vger.kernel.org> # after -rc3
 
-.. code-block:: none
+* Evidenziare problemi noti::
 
-     Cc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle
-     Cc: <stable@vger.kernel.org> # 3.3.x: 1b9508f: sched: Rate-limit newidle
-     Cc: <stable@vger.kernel.org> # 3.3.x: fd21073: sched: Fix affinity logic
-     Cc: <stable@vger.kernel.org> # 3.3.x
-     Signed-off-by: Ingo Molnar <mingo@elte.hu>
+     Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for <= 6.3
 
-La sequenza di etichette ha il seguente significato:
+Esiste un'ulteriore variante per l'etichetta "stable" che permette di comunicare
+allo strumento di *backporting* di ignorare un cambiamento::
 
-.. code-block:: none
+     Cc: <stable+noautosel@kernel.org> # reason goes here, and must be present
 
-     git cherry-pick a1f84a3
-     git cherry-pick 1b9508f
-     git cherry-pick fd21073
-     git cherry-pick <this commit>
 
-Inoltre, alcune patch potrebbero avere dei requisiti circa la versione del
-kernel. Questo può essere indicato usando il seguente formato nell'area
-dedicata alle firme:
+.. _it_option_2:
 
-.. code-block:: none
+Opzione 2
+*********
 
-     Cc: <stable@vger.kernel.org> # 3.3.x
+Se la patch è già stata inclusa nei sorgenti Linux, inviate una mail a
+stable@vger.kernel.org includendo: il titolo della patch, l'identificativo
+del commit, il perché pensate che debba essere applicata, e in quali versioni
+del kernel la vorreste vedere.
 
-L'etichetta ha il seguente significato:
+.. _it_option_3:
 
-.. code-block:: none
+Opzione 3
+*********
 
-     git cherry-pick <this commit>
+Dopo aver verificato che rispetta le regole descritte in precedenza, inviata la
+patch a stable@vger.kernel.org facendo anche menzione delle versioni nella quale
+si vorrebbe applicarla. Nel farlo, dovete annotare nel changelog
+l'identificativo del commit nei sorgenti principali, così come la versione del
+kernel nel quale vorreste vedere la patch.::
 
-per ogni sorgente "-stable" che inizia con la versione indicata.
+    commit <sha1> upstream.
 
-Dopo la sottomissione:
+o in alternativa::
 
- - Il mittente riceverà un ACK quando la patch è stata accettata e messa in
-   coda, oppure un NAK se la patch è stata rigettata.  A seconda degli impegni
-   degli sviluppatori, questa risposta potrebbe richiedere alcuni giorni.
- - Se accettata, la patch verrà aggiunta alla coda -stable per essere
-   revisionata dal altri sviluppatori e dal principale manutentore del
-   sottosistema.
+    [ Upstream commit <sha1>  ]
 
+Se la patch inviata devia rispetto all'originale presente nei sorgenti
+principali (per esempio per adattarsi ad un cambiamento di API), allora questo
+dev'essere giustificato e dettagliato in modo chiaro nella descrizione.
+
+Dopo la sottomissione
+---------------------
+
+Il mittente riceverà un ACK quando la patch è stata accettata e messa in coda,
+oppure un NAK se la patch è stata rigettata. La risposta potrebbe richiedere
+alcuni giorni in funzione dei piani dei membri della squadra "stable",
+
+Se accettata, la patch verrà aggiunta alla coda -stable per essere revisionata
+dal altri sviluppatori e dal principale manutentore del sottosistema.
 
 Ciclo di una revisione
 ----------------------
 
- - Quando i manutentori -stable decidono di fare un ciclo di revisione, le
-   patch vengono mandate al comitato per la revisione, ai manutentori soggetti
-   alle modifiche delle patch (a meno che il mittente non sia anche il
-   manutentore di quell'area del kernel) e in CC: alla lista di discussione
-   linux-kernel.
- - La commissione per la revisione ha 48 ore per dare il proprio ACK o NACK
-   alle patch.
- - Se una patch viene rigettata da un membro della commissione, o un membro
-   della lista linux-kernel obietta la bontà della patch, sollevando problemi
-   che i manutentori ed i membri non avevano compreso, allora la patch verrà
-   rimossa dalla coda.
- - Le patch che hanno ricevuto un ACK verranno inviate nuovamente come parte di
-   un rilascio candidato (-rc) al fine di essere verificate dagli sviluppatori e
-   dai testatori.
- - Solitamente si pubblica solo una -rc, tuttavia se si riscontrano problemi
-   importanti, alcune patch potrebbero essere modificate o essere scartate,
-   oppure nuove patch potrebbero essere messe in coda. Dunque, verranno pubblicate
-   nuove -rc e così via finché non si ritiene che non vi siano più problemi.
- - Si può rispondere ad una -rc scrivendo sulla lista di discussione un'email
-   con l'etichetta "Tested-by:". Questa etichetta verrà raccolta ed aggiunta al
-   commit rilascio.
- - Alla fine del ciclo di revisione il nuovo rilascio -stable conterrà tutte le
-   patch che erano in coda e sono state verificate.
- - Le patch di sicurezza verranno accettate nei sorgenti -stable direttamente
-   dalla squadra per la sicurezza del kernel, e non passerà per il normale
-   ciclo di revisione. Contattate la suddetta squadra per maggiori dettagli
-   su questa procedura.
+- Quando i manutentori -stable decidono di fare un ciclo di revisione, le
+  patch vengono mandate al comitato per la revisione, ai manutentori soggetti
+  alle modifiche delle patch (a meno che il mittente non sia anche il
+  manutentore di quell'area del kernel) e in CC: alla lista di discussione
+  linux-kernel.
+- La commissione per la revisione ha 48 ore per dare il proprio ACK o NACK
+  alle patch.
+- Se una patch viene rigettata da un membro della commissione, o un membro
+  della lista linux-kernel obietta la bontà della patch, sollevando problemi
+  che i manutentori ed i membri non avevano compreso, allora la patch verrà
+  rimossa dalla coda.
+- Le patch che hanno ricevuto un ACK verranno inviate nuovamente come parte di
+  un rilascio candidato (-rc) al fine di essere verificate dagli sviluppatori e
+  dai testatori.
+- Solitamente si pubblica solo una -rc, tuttavia se si riscontrano problemi
+  importanti, alcune patch potrebbero essere modificate o essere scartate,
+  oppure nuove patch potrebbero essere messe in coda. Dunque, verranno pubblicate
+  nuove -rc e così via finché non si ritiene che non vi siano più problemi.
+- Si può rispondere ad una -rc scrivendo sulla lista di discussione un'email
+  con l'etichetta "Tested-by:". Questa etichetta verrà raccolta ed aggiunta al
+  commit rilascio.
+- Alla fine del ciclo di revisione il nuovo rilascio -stable conterrà tutte le
+  patch che erano in coda e sono state verificate.
+- Le patch di sicurezza verranno accettate nei sorgenti -stable direttamente
+  dalla squadra per la sicurezza del kernel, e non passerà per il normale
+  ciclo di revisione. Contattate la suddetta squadra per maggiori dettagli
+  su questa procedura.
 
 Sorgenti
 --------
 
- - La coda delle patch, sia quelle già applicate che in fase di revisione,
-   possono essere trovate al seguente indirizzo:
+- La coda delle patch, sia quelle già applicate che in fase di revisione,
+  possono essere trovate al seguente indirizzo:
 
-	https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
+    https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
 
- - Il rilascio definitivo, e marchiato, di tutti i kernel stabili può essere
-   trovato in rami distinti per versione al seguente indirizzo:
+- Il rilascio definitivo, e marchiato, di tutti i kernel stabili può essere
+  trovato in rami distinti per versione al seguente indirizzo:
 
-	https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
+    https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
 
- - I rilasci candidati di tutti i kernel stabili possono essere trovati al
-   seguente indirizzo:
+- I rilasci candidati di tutti i kernel stabili possono essere trovati al
+  seguente indirizzo:
 
     https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/
 
-
-   .. warning::
-     I sorgenti -stable-rc sono un'istantanea dei sorgenti stable-queue e
-     subirà frequenti modifiche, dunque verrà anche trapiantato spesso.
-     Dovrebbe essere usato solo allo scopo di verifica (per esempio in un
-     sistema di CI)
+  .. warning::
+    I sorgenti -stable-rc sono un'istantanea dei sorgenti stable-queue e
+    subirà frequenti modifiche, dunque verrà anche trapiantato spesso.
+    Dovrebbe essere usato solo allo scopo di verifica (per esempio in un
+    sistema di CI)
 
 Comitato per la revisione
 -------------------------
 
- - Questo comitato è fatto di sviluppatori del kernel che si sono offerti
-   volontari per questo lavoro, e pochi altri che non sono proprio volontari.
+- Questo comitato è fatto di sviluppatori del kernel che si sono offerti
+  volontari per questo lavoro, e pochi altri che non sono proprio volontari.
diff --git a/Documentation/translations/it_IT/process/submitting-patches.rst b/Documentation/translations/it_IT/process/submitting-patches.rst
index 4c6a276bdc08..a7252e73937a 100644
--- a/Documentation/translations/it_IT/process/submitting-patches.rst
+++ b/Documentation/translations/it_IT/process/submitting-patches.rst
@@ -106,9 +106,29 @@ do frotz" piuttosto che "[This patch] makes xyzzy do frotz" or "[I] changed
 xyzzy to do frotz", come se steste dando ordini al codice di cambiare il suo
 comportamento.
 
+Se volete far riferimento a uno specifico commit, non usate solo
+l'identificativo SHA-1.  Per cortesia, aggiungete anche la breve riga
+riassuntiva del commit per rendere la chiaro ai revisori l'oggetto.
+Per esempio::
+
+	Commit e21d2170f36602ae2708 ("video: remove unnecessary
+	platform_set_drvdata()") removed the unnecessary
+	platform_set_drvdata(), but left the variable "dev" unused,
+	delete it.
+
+Dovreste anche assicurarvi di usare almeno i primi 12 caratteri
+dell'identificativo SHA-1.  Il repositorio del kernel ha *molti* oggetti e
+questo rende possibile la collisione fra due identificativi con pochi
+caratteri.  Tenete ben presente che anche se oggi non ci sono collisioni con il
+vostro identificativo a 6 caratteri, potrebbero essercene fra 5 anni da oggi.
+
 Se ci sono delle discussioni, o altre informazioni d'interesse, che fanno
 riferimento alla patch, allora aggiungete l'etichetta 'Link:' per farvi
-riferimento. Per esempio, se la vostra patch corregge un baco potete aggiungere
+riferimento. Se la patch è il risultato di una discussione avvenuta
+precedentemente o di un documento sul presente sul web, allora fatevi
+riferimento.
+
+Per esempio, se la vostra patch corregge un baco potete aggiungere
 quest'etichetta per fare riferimento ad un rapporto su una lista di discussione
 o un *bug tracker*. Un altro esempio; potete usare quest'etichetta per far
 riferimento ad una discussione precedentemente avvenuta su una lista di
@@ -129,21 +149,16 @@ Tuttavia, provate comunque a dare una spiegazione comprensibile anche senza
 accedere alle fonti esterne. Inoltre, riassumente i punti più salienti che hanno
 condotto all'invio della patch.
 
-Se volete far riferimento a uno specifico commit, non usate solo
-l'identificativo SHA-1.  Per cortesia, aggiungete anche la breve riga
-riassuntiva del commit per rendere la chiaro ai revisori l'oggetto.
-Per esempio::
+Se il collegamento indirizza verso un rapporto su un baco risolto dalla patch,
+allora usate l'etichetta "Closes:"::
 
-	Commit e21d2170f36602ae2708 ("video: remove unnecessary
-	platform_set_drvdata()") removed the unnecessary
-	platform_set_drvdata(), but left the variable "dev" unused,
-	delete it.
+       Closes: https://example.com/issues/1234  optional-other-stuff
 
-Dovreste anche assicurarvi di usare almeno i primi 12 caratteri
-dell'identificativo SHA-1.  Il repositorio del kernel ha *molti* oggetti e
-questo rende possibile la collisione fra due identificativi con pochi
-caratteri.  Tenete ben presente che anche se oggi non ci sono collisioni con il
-vostro identificativo a 6 caratteri, potrebbero essercene fra 5 anni da oggi.
+Alcune piattaforme di tracciamento di bachi hanno la capacità di chiudere
+automaticamente il problema se l'etichetta è presente nel messaggio. Alcuni
+automatismi che monitorano la liste di discussione possono anche tracciare
+queste etichette e intraprendere azioni. Piattaforme private e URL invalidi sono
+proibiti.
 
 Se la vostra patch corregge un baco in un commit specifico, per esempio avete
 trovato un problema usando ``git bisect``, per favore usate l'etichetta
@@ -237,13 +252,19 @@ nella vostra patch.
 5) Selezionate i destinatari della vostra patch
 -----------------------------------------------
 
-Dovreste sempre inviare una copia della patch ai manutentori dei sottosistemi
-interessati dalle modifiche; date un'occhiata al file MAINTAINERS e alla storia
-delle revisioni per scoprire chi si occupa del codice. Lo script
-scripts/get_maintainer.pl può esservi d'aiuto (passategli il percorso alle
-vostre patch). Se non riuscite a trovare un manutentore per il sottosistema su
-cui state lavorando, allora Andrew Morton (akpm@linux-foundation.org) sarà la
-vostra ultima possibilità.
+Dovreste sempre inviare una copia della patch ai manutentori e alle liste di
+discussione dei sottosistemi interessati dalle modifiche; date un'occhiata al
+file MAINTAINERS e alla storia delle revisioni per scoprire chi si occupa del
+codice. Lo script scripts/get_maintainer.pl può esservi d'aiuto (passategli il
+percorso alle vostre patch). Se non riuscite a trovare un manutentore per il
+sottosistema su cui state lavorando, allora Andrew Morton
+(akpm@linux-foundation.org) sarà la vostra ultima possibilità.
+
+La lista linux-kernel@vger.kernel.org dovrebbe essere usata per l'invio di tutte
+le patch, ma il volume ha raggiunto un livello tale d'aver spinto alcuni
+sviluppatori a non seguirla più. Dunque, per favore, evitate di inviare messaggi
+scorrelati al tema della lista o a persone che non dovrebbero essere
+interessate all'argomento.
 
 Normalmente, dovreste anche scegliere una lista di discussione a cui inviare la
 vostra serie di patch. La lista di discussione linux-kernel@vger.kernel.org
@@ -343,7 +364,8 @@ questo caso, rispondete con educazione e concentratevi sul problema che hanno
 evidenziato. Quando inviate una versione successiva ricordatevi di aggiungere un
 ``patch changelog`` alla email di intestazione o ad ogni singola patch spiegando
 le differenze rispetto a sottomissioni precedenti (vedere
-:ref:`it_the_canonical_patch_format`).
+:ref:`it_the_canonical_patch_format`). Aggiungete a CC tutte le persone che
+vi hanno fornito dei commenti per notificarle di eventuali nuove versioni.
 
 Leggete Documentation/translations/it_IT/process/email-clients.rst per
 le raccomandazioni sui programmi di posta elettronica e l'etichetta da usare
@@ -385,10 +407,10 @@ Dopo che avete inviato le vostre modifiche, siate pazienti e aspettate.
 I revisori sono persone occupate e potrebbero non ricevere la vostra patch
 immediatamente.
 
-Un tempo, le patch erano solite scomparire nel vuoto senza alcun commento,
-ma ora il processo di sviluppo funziona meglio.  Dovreste ricevere commenti
-in una settimana o poco più; se questo non dovesse accadere, assicuratevi di
-aver inviato le patch correttamente.  Aspettate almeno una settimana prima di
+Un tempo, le patch erano solite scomparire nel vuoto senza alcun commento, ma
+ora il processo di sviluppo funziona meglio. Dovreste ricevere commenti in poche
+settimane (tipicamente 2 o 3); se questo non dovesse accadere, assicuratevi di
+aver inviato le patch correttamente. Aspettate almeno una settimana prima di
 rinviare le modifiche o sollecitare i revisori - probabilmente anche di più
 durante la finestra d'integrazione.
 
@@ -552,6 +574,10 @@ e si spera che questo possa ispirarli ad aiutarci nuovamente in futuro.
 Rammentate che se il baco è stato riportato in privato, dovrete chiedere il
 permesso prima di poter utilizzare l'etichetta Reported-by. Questa etichetta va
 usata per i bachi, dunque non usatela per richieste di nuove funzionalità.
+Questa etichetta dovrebbe essere seguita da quella Closes: con un indirizzo al
+rapporto, a meno che questo non sia disponibile sul web. L'etichetta Link: può
+essere usata in alternativa a Closes: se la patch corregge solo in parte il
+problema riportato nel rapporto.
 
 L'etichetta Tested-by: indica che la patch è stata verificata con successo
 (su un qualche sistema) dalla persona citata.  Questa etichetta informa i
@@ -808,6 +834,63 @@ giungla di riferimenti all'interno dei programmi di posta.  Se un collegamento
 ad una versione precedente di una serie di patch (per esempio, potete usarlo
 per l'email introduttiva alla serie).
 
+Fornire informazioni circa i sorgenti
+-------------------------------------
+
+Quando gli altri sviluppatori ricevono le vostre patch e iniziano il processo di
+revisione, è assolutamente necessario che sappiano qual è il commit/ramo di base
+su cui si base il vostro lavoro: considerate l'enorme quantità di sorgenti dei
+manutentori presenti al giorno d'oggi. Si noti ancora una volta la voce **T:**
+nel file MAINTAINERS spiegato sopra.
+
+Questo è ancora più importante per i processi automatizzati di CI che tentano di
+eseguire una serie di test per stabilire la qualità del codice prima che il
+manutentore inizi la revisione.
+
+Se si usa ``git format-patch`` per generare le patch, si possono includere
+automaticamente le informazioni sull'albero di base nell'invio usando il flag
+``--base``. Il modo più semplice e comodo di usare questa opzione è con i rami
+topici::
+
+    $ git checkout -t -b my-topical-branch master
+    Branch 'my-topical-branch' set up to track local branch 'master'.
+    Switched to a new branch 'my-topical-branch'
+
+    [perform your edits and commits]
+
+    $ git format-patch --base=auto --cover-letter -o outgoing/ master
+    outgoing/0000-cover-letter.patch
+    outgoing/0001-First-Commit.patch
+    outgoing/...
+
+Aprendo ``outgoing/0000-cover-letter.patch`` per la modifica, si noterà
+che ha ``base-commit:`` in fondo, questo fornisce al revisore e agli
+strumenti CI informazioni sufficienti per eseguire correttamente ``git am``
+senza preoccuparsi dei conflitti::
+
+    $ git checkout -b patch-review [base-commit-id]
+    Switched to a new branch 'patch-review'
+    $ git am patches.mbox
+    Applying: First Commit
+    Applying: ...
+
+Consultate ``man git-format-patch`` per maggiori informazioni circa questa
+opzione.
+
+.. note::
+
+   L'opzione ``--base`` fu introdotta con git versione 2.9.0
+
+Se non si usa git per produrre le patch, si può comunque includere
+``base-commit`` per indicare l'hash del commit dei sorgenti su cui si basa il
+lavoro. Dovreste aggiungerlo nella lettera di accompagnamento o nella prima
+patch della serie e dovrebbe essere collocato sotto la riga ``---`` o in fondo a
+tutti gli altri contenuti, subito prima della vostra firma e-mail.
+
+Assicuratevi che il commit si basi su sorgenti ufficiali del
+manutentore/mainline e non su sorgenti interni, accessibile solo a voi,
+altrimenti sarebbe inutile.
+
 Riferimenti
 -----------
 
-- 
2.39.2


