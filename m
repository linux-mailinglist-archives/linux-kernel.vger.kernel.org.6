Return-Path: <linux-kernel+bounces-553291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA40DA586FC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25057169B48
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EF81F9F5C;
	Sun,  9 Mar 2025 18:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="a9kYQhLS"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F7E16B3B7;
	Sun,  9 Mar 2025 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544171; cv=none; b=TOk4+Qd6F4VcscyEtiShIupAW02f4+793PdGdiK+UShacm8Rv+ln4NG3nDoxc3Fb+vugz/kzss00z5ANz0Twm1M/9prnnh5+GhYGrxo8UCnlYgmAeQ+uR81avUCySIcJPhrbDTmeZhll2UM0Sm5hcZK0ns8B1WHhM5fuaEmhrIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544171; c=relaxed/simple;
	bh=WZm6aGYafspZGqZlKpDblBNiGRhDc+4xrZN9Eus+Fag=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uvpIoJq9wZt0d1KEx+hyHtPzo22TjHD/qefoFqvk2E/+y4p/HEisAwR9XR5U0XhfR7QeEAWErTS3LEJCgJGtzWlmfuMV8WCw94TNkmUWq8u+7nJqWym97edX1oMygydzyRLoSwLkwi1HIQcGP2LnPP3CE2n2gC+CwggI6pLsDC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=a9kYQhLS; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id E0F0C100006;
	Sun,  9 Mar 2025 21:16:07 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru E0F0C100006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1741544167;
	bh=NK0/S9lD6J4LrJ0za2Y5lt/Fq95o4i6toJkcTTbksdo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=a9kYQhLSEKIt9eH6h05y5xl2QBhpA6VlsTPW615kc77SZZOXCMnmdOuzKpgIOpobO
	 QvQdxHs4WPutsKwdFD/Xs0Dq/IvMdzi9RQC7IXwET26Vo1cGWFFhlqVe4QlcvKHSVO
	 fbAZKDdnmcR+b058Ct7VP3b8Z21oY3rW9JOlFcoRaYy6UUpcaVWkTHPWQR5B8HF/pN
	 kGWZDtWVN2ArLvfMTuQ31p6vk+F3K7Guq22gLh0AeWLkI7vdysd1C8nXsCBvVyDmKZ
	 p30kGxlC3p5vEB1S5JlzgcG/UV/iWf2STa1CU5f2V0mU/qAoRObNOBuiX0bb99jTM2
	 qrcA71gAq0NBQ==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun,  9 Mar 2025 21:16:07 +0300 (MSK)
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Conor Dooley
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman
	<khilman@baylibre.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, Takashi Iwai
	<tiwai@suse.com>
Subject: [PATCH v2 3/4] ASoC: dt-bindings: meson: g12a-toacodec: add support for A1 SoC family
Date: Sun, 9 Mar 2025 21:15:59 +0300
Message-ID: <20250309181600.1322701-4-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309181600.1322701-1-jan.dakinevich@salutedevices.com>
References: <20250309181600.1322701-1-jan.dakinevich@salutedevices.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_smtp_not_equal_from}, 127.0.0.199:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, FromAlignment: n
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/03/09 17:28:00 #27692143
X-KSMG-AntiVirus-Status: Clean, skipped

Add support for "toacodec" audio component found A1 SoC family. On this
SoC the component supports capture streams, additional DAI ids are added
to configure this feature.

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 .../devicetree/bindings/sound/amlogic,g12a-toacodec.yaml     | 1 +
 include/dt-bindings/sound/meson-g12a-toacodec.h              | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml b/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml
index 23f82bb89750..c47604aa590f 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml
+++ b/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml
@@ -26,6 +26,7 @@ properties:
       - items:
           - enum:
               - amlogic,sm1-toacodec
+              - amlogic,a1-toacodec
           - const: amlogic,g12a-toacodec
 
   reg:
diff --git a/include/dt-bindings/sound/meson-g12a-toacodec.h b/include/dt-bindings/sound/meson-g12a-toacodec.h
index 69d7a75592a2..f726e2c6064d 100644
--- a/include/dt-bindings/sound/meson-g12a-toacodec.h
+++ b/include/dt-bindings/sound/meson-g12a-toacodec.h
@@ -7,4 +7,9 @@
 #define TOACODEC_IN_C	2
 #define TOACODEC_OUT	3
 
+#define TOACODEC_CAPTURE_OUT_A	4
+#define TOACODEC_CAPTURE_OUT_B	5
+#define TOACODEC_CAPTURE_OUT_C	6
+#define TOACODEC_CAPTURE_IN	7
+
 #endif /* __DT_MESON_G12A_TOACODEC_H */
-- 
2.34.1


