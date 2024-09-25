Return-Path: <linux-kernel+bounces-339275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C27239861FE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B6A1F28EE5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1DE184545;
	Wed, 25 Sep 2024 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="qnJcdvBj"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4221218452B;
	Wed, 25 Sep 2024 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276032; cv=none; b=kM8x4vpt/nr0VEXVBT1MmOfXSLtzM0rEcbZjAoQqf+NIYfLL7446/B9w8mY75FN9teNCJibtY6xfxg6mT9lSMJToxCu3e6Pu5lCleRKVyhnM5YpnIybHqtzAdRUM5dx+veYyGEA9kSwmXOdBc5eENkwCpFtTcJYdi1pHusuN+U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276032; c=relaxed/simple;
	bh=gDNygw227Hz8AaWhVQfQiQNI7y5aoF56Cdd48Okc2IU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=TaFhugA5retTfmK6XM46RWck20d5AViKy7G0KcxMYQhYWhOlC0VyIM+CEDFCyf+tp8IGBZufu4mxxtriUZxAjBi0/WJDtZ7UiKcaM38vjD3tDD+lAH2RYGILIcMX3I/so1zavDjhQMDGBDKTPHD8P8pDmoAkTlj/u8O/1lM8YA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=qnJcdvBj; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 2C6F2120022;
	Wed, 25 Sep 2024 17:53:40 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2C6F2120022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1727276020;
	bh=xV4ahJv5OMtQUBk00s671m7FF+0eKcXToPTxvFes0jo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:From;
	b=qnJcdvBjWHQqnsm7a7y5zLf3RLP+5S4Cfi2PjXm5vaVOWdQfnuis+a273EFsQl2AY
	 gTP2KheBYtjcQshlVJoQ7ISqG6mqdHL45c8U0rswINQ970OKc92EHdh9UPcVWDdMbz
	 QThmnYKGp7CZK5BclLvP2jXaAAXj7iZXY61QgjeqxE1mvJmAEStq92iN4TXyA6NAeD
	 E/aCd9EtqstYVPlL5FBF/5PeAq7M18A+Sah4cXQ9rc40yTVn7D7Lub6lnERiCcTd9w
	 EUCZocj0TX+FeJVpG5vGOQPe/GO97dej0lNtCg27fqVpkEWjFqe/axykEadv+4uJ9B
	 me8tohLw28Ujg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 25 Sep 2024 17:53:39 +0300 (MSK)
From: Igor Prusov <ivprusov@salutedevices.com>
Date: Wed, 25 Sep 2024 17:52:41 +0300
Subject: [PATCH v3 3/6] ASoC: dt-bindings: Add NeoFidelity NTP8918
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240925-ntp-amps-8918-8835-v3-3-e2459a8191a6@salutedevices.com>
References: <20240925-ntp-amps-8918-8835-v3-0-e2459a8191a6@salutedevices.com>
In-Reply-To: <20240925-ntp-amps-8918-8835-v3-0-e2459a8191a6@salutedevices.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	"Mark Brown" <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, Igor Prusov <ivprusov@salutedevices.com>, Philipp
 Zabel <p.zabel@pengutronix.de>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>, <kernel@salutedevices.com>,
	<prusovigor@gmail.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187980 [Sep 25 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34 8a1fac695d5606478feba790382a59668a4f0039, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, devicetree.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/09/25 12:44:00
X-KSMG-LinksScanning: Clean, bases: 2024/09/25 12:44:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/09/25 13:22:00 #26670925
X-KSMG-AntiVirus-Status: Clean, skipped

Add dt-bindings for NeoFidelity NTP8918 Amplifier

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---
 .../bindings/sound/neofidelity,ntp8918.yaml        | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/neofidelity,ntp8918.yaml b/Documentation/devicetree/bindings/sound/neofidelity,ntp8918.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..952768b3590286a19d0f039369b7e9a33994fa64
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/neofidelity,ntp8918.yaml
@@ -0,0 +1,70 @@
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
+description:
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
+
+  reset-gpios:
+    maxItems: 1
+
+  '#sound-dai-cells':
+    const: 0
+
+  clocks:
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: wck
+      - const: scl
+      - const: bck
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
+     audio-codec@2a {
+       compatible = "neofidelity,ntp8918";
+       #sound-dai-cells = <0>;
+       reg = <0x2a>;
+       clocks = <&clkc 150>, <&clkc 151>, <&clkc 152>;
+       clock-names =  "wck", "scl", "bck";
+       reset-gpios = <&gpio 5 GPIO_ACTIVE_LOW>;
+    };
+   };

-- 
2.34.1


