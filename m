Return-Path: <linux-kernel+bounces-246741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E0992C61B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 00:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1331F22610
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC734192491;
	Tue,  9 Jul 2024 22:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="E95RW92j"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F105618FA26;
	Tue,  9 Jul 2024 22:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720563151; cv=none; b=sXuTy+/D0F8XlFA7BbjJvpL1ph/Cy5m/GKqYAr4X6SP+imEFaWW2GXALSHsJqQyJLNMpqDdFkqh/U5+7F/ftavWtOt8rACeTbk8dVpvckyYkgm1k/DVB77kV9oY1JLdCEadRTaGALZTfTts0WzNs4GgSiEY173ezMWW9EAvQq7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720563151; c=relaxed/simple;
	bh=AyjKp9jOrytuX4TOhKxkfSiIpbdbNbKYJTc5eEHa38I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7S6LG4oPFjoliGxWHSJ01Gw7slVr5ma0vn3d+4XUXWt1Uf0UKANAW2aJmAvNzmCw1es9i8lW4J3yx97ANllUR0IoySr/dhWGPbrsDXrY90MKWM4ylZLGZT7YOUzcGxglUFqmk31vhHlbo/Xtv4b0dVhuRcviKaqUb2ENlUxEtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=E95RW92j; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id DDEC6100028;
	Wed, 10 Jul 2024 01:12:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru DDEC6100028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1720563147;
	bh=oiN0AIhlv/Yj1OiMsbHytdbfV88YB2DnrBagNdpzmwQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=E95RW92jmfllUJZQ9oZ9JZjCVjAkjbhmzVyKIeiBmliTo+f7VG7OidvXiB+YM3Rsq
	 xO803A3msYMwuHYMwwPirCsb8Xr2kA0uK4pYEpBttuC9fSm+YiwEpj7+l5LOAminkN
	 xAKXg3djMXG1B6DR+fKugiTAHi3/PjzIoUm5ZAQRWpy7wjV/FuVoupuwSoNUFgW2Qz
	 U4jQHIlAJaqPombuhGyuWPRVj3a6KwYSL5UWFUdJsAliuZqS5t/dPW6Gp8nuI8J3DF
	 Qc/9UjLQEohV8yV9m1VZpUvlZC7zM3rEqmtaRHoNrSFhvQNgsm+6TzOeIqKzKOoC3f
	 H+zzndHqv/3Xg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 10 Jul 2024 01:12:27 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jul 2024 01:12:27 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Philipp Zabel <p.zabel@pengutronix.de>, Igor Prusov
	<ivprusov@salutedevices.com>
CC: <prusovigor@gmail.com>, <kernel@salutedevices.com>,
	<linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/6] ASoC: dt-bindings: Add bindings for NeoFidelity NTP8918
Date: Wed, 10 Jul 2024 01:12:00 +0300
Message-ID: <20240709221203.92167-4-ivprusov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709221203.92167-1-ivprusov@salutedevices.com>
References: <20240709221203.92167-1-ivprusov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186406 [Jul 09 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24 186c4d603b899ccfd4883d230c53f273b80e467f, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, devicetree.org:7.1.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/09 21:28:00
X-KSMG-LinksScanning: Clean, bases: 2024/07/09 21:28:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/07/09 15:25:00 #25923573
X-KSMG-AntiVirus-Status: Clean, skipped

Add dt-bindings for NeoFidelity NTP8918 Amplifier

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---
 .../bindings/sound/neofidelity,ntp8918.yaml   | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/neofidelity,ntp8918.yaml

diff --git a/Documentation/devicetree/bindings/sound/neofidelity,ntp8918.yaml b/Documentation/devicetree/bindings/sound/neofidelity,ntp8918.yaml
new file mode 100644
index 000000000000..506b1e4b8e39
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/neofidelity,ntp8918.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/neofidelity,ntp8918.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NeoFidelity NTP8918 Amplifier
+
+maintainers:
+  - Igor Prusov <ivprusov@salutedevices.com>
+
+description: |
+  The NTP8918 is a single chip full digital audio amplifier
+  including power stage for stereo amplifier system.
+  The NTP8918 is integrated with versatile digital audio signal
+  processing functions, high-performance, high-fidelity fully
+  digital PWM modulator and two high-power full-bridge MOSFET
+  power stages.
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - neofidelity,ntp8918
+
+  reg:
+    enum:
+      - 0x2a
+      - 0x2b
+      - 0x2c
+      - 0x2d
+    description: |
+      I2C address of the device.
+
+  reset-gpios:
+    maxItems: 1
+    description: GPIO used to control the state of the device.
+
+  '#sound-dai-cells':
+    enum: [0]
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+   #include <dt-bindings/gpio/gpio.h>
+   i2c {
+     #address-cells = <1>;
+     #size-cells = <0>;
+     ntp8918@2a {
+       compatible = "neofidelity,ntp8918";
+       #sound-dai-cells = <0>;
+       reg = <0x2a>;
+       reset-gpios = <&gpio 5 GPIO_ACTIVE_LOW>;
+    };
+   };
-- 
2.34.1


