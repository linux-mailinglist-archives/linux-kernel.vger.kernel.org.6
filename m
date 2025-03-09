Return-Path: <linux-kernel+bounces-553298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C1AA58715
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54F3C3A539B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E8F1F8737;
	Sun,  9 Mar 2025 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="FCrS7RUD"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5137910E5;
	Sun,  9 Mar 2025 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544497; cv=none; b=JcSkM9i9v/HKkD0CuNlKmIsYTsgai25f6GmqtFnOZPXR5NufzvM5psH0yeLkd9VajzMCqv/nDynwkW+ZOzC4JpaU79dNLGo4ZtKvIWyVe0A9OXc6/ehEPnzsRqiyalwIdJXrQmA6cazRrBHGJx3SK8yUiqBchLJZCQCXYKvp6EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544497; c=relaxed/simple;
	bh=ULTZgz7wemJg/2kZYe2i3hPuq8ZAwSs1+YjpciWGnDI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H9+K/aH3VjykkWiOhYWhptMvyLzg5S6nZSikxskViDHP6v76auX9wAL5RJr8b5lweWF5su8BlNEAT611/r/6CrHuCb2hBbKc/kGwlLaFoDALc5ms00EzQ+hzzY2lmLCtHVwOGWeiq1eqTokBvAZ/kqvj85rrZ+3DL0Rch4JHhz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=FCrS7RUD; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 7A918100006;
	Sun,  9 Mar 2025 21:21:33 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7A918100006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1741544493;
	bh=Pr8V4mkPI24+3PnszozIdpHRsk1mgCHgXbW1+J/O23s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=FCrS7RUDp8druoAQeGG/pMztduXYBr/DtzpgFCBvaAnW1BIdcaaY4dxCw9xhnZECM
	 rjnONwA6LnDB0MggS+iluDj2b8tTAHcwCCccSY/fhnKoHG/LaDRukU6ZjlDmtl8qsK
	 Xdp68y1j3p9w7GmNb5CgyZBD/ISK6LugIhG+mJH2/h2Otnj3GpIbDGiQUP0iSxhOv1
	 v5rVSpGf9766cwf410DlmgIaVrx/Ml0H0bHqxVV5sLcCam6kPzrnHznDLS60E6wZLb
	 fE5FG2LusALvJ2NVmgvz87mxUYdULdWizb85L4aNSzR0dUfdKqnwfhG9u9iJH2HUVJ
	 FRBynDio+forg==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun,  9 Mar 2025 21:21:33 +0300 (MSK)
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Conor Dooley
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>, Jerome Brunet
	<jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>, Mark Brown
	<broonie@kernel.org>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, Rob
 Herring <robh@kernel.org>
Subject: [PATCH v2 1/6] ASoC: dt-bindings: meson: meson-axg-audio-arb: claim support of A1 SoC family
Date: Sun, 9 Mar 2025 21:21:22 +0300
Message-ID: <20250309182127.1322890-2-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309182127.1322890-1-jan.dakinevich@salutedevices.com>
References: <20250309182127.1322890-1-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 191599 [Mar 09 2025]
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_smtp_not_equal_from}, sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, FromAlignment: n
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/03/09 17:28:00 #27692143
X-KSMG-AntiVirus-Status: Clean, skipped

Add "amlogic,meson-a1-audio-arb" compatible string alias to
"amlogic,meson-sm1-audio-arb".

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 .../bindings/reset/amlogic,meson-axg-audio-arb.yaml    | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.yaml b/Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.yaml
index bc1d284785e1..57e977db029f 100644
--- a/Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.yaml
+++ b/Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.yaml
@@ -15,9 +15,13 @@ description: The Amlogic Audio ARB is a simple device which enables or disables
 
 properties:
   compatible:
-    enum:
-      - amlogic,meson-axg-audio-arb
-      - amlogic,meson-sm1-audio-arb
+    oneOf:
+      - enum:
+          - amlogic,meson-axg-audio-arb
+          - amlogic,meson-sm1-audio-arb
+      - items:
+          - const: amlogic,meson-a1-audio-arb
+          - const: amlogic,meson-sm1-audio-arb
 
   reg:
     maxItems: 1
-- 
2.34.1


