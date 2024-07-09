Return-Path: <linux-kernel+bounces-246482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EFF92C281
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13C85B246A5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAABC182A66;
	Tue,  9 Jul 2024 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="vLZIhp/+"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444727F476;
	Tue,  9 Jul 2024 17:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720546138; cv=none; b=XOPo03UvyrvnRqpbdSZrg6u5rtgHT8QFI/RWLRFIEx2UDQrb6IJ4TR5GgBxRtp7CsmGU7WGMJOuNf7c58s49NF3pDf6cRjBvTF3JCummK9BqEWoPPFxGUgANwzY3bd5/FiZlkHF3QCGuKRHjGAQxwTfqEF3JZxGnU+NMgMqQbS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720546138; c=relaxed/simple;
	bh=0bZhT0CAXqx8Icag9qMzhrFkZOYuFRiZC3mwgiGeEZQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mSfMvFiRmTr5oKZVnnU5czQfA5GFGlS0e/QKjl7mfA9EfpP/fqyODQ95pflcyuSJtLfXJbc36FRNwXlUQXervfH/SQADEnY/exUOzY+c9mV7BggeI8BgYpRbe/zOcsSKEPfhPnwEOjDghmOsHzSyFJzTzWHbfwX+e+TcylveSJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=vLZIhp/+; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id E13CA12000A;
	Tue,  9 Jul 2024 20:28:53 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru E13CA12000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1720546133;
	bh=f5EblfokftYW7e/k32dF4L6KO1zX55IWYXbcPb/iZsw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=vLZIhp/+/o6H/vK4ovKfUjKGHkCLd6nJr8cT4+vL+/vtJPQBNwJ4bwt4xKG85OWHb
	 ikp9NPuBBxq1pb45Z/eWwMSWxsO9WFPmYE6mC95H4ptMaEUo9qTKCI5oMF2YN/THbU
	 Fr5je5VRsXyyr58ZgEBw2j/mJ6bio6ru/ZiFmBTY48g6vrzNF8jrQwEuCt/DKL6luW
	 v30dDv6EQQUuBxldN3KOBUBH0ovwfocfQqElbkoPPlAXmGRtWJmFdk7VSGHsbMJdL4
	 ubm9oFkQdtuOY0VwqucA2G4FoksKHdd0ju/3b1wKfYTdxHkoOhN1xYH9QliXsBYICk
	 Vtp6ifex6bSlw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue,  9 Jul 2024 20:28:53 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jul 2024 20:28:53 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Philipp Zabel <p.zabel@pengutronix.de>, Igor Prusov
	<ivprusov@salutedevices.com>
CC: <prusovigor@gmail.com>, <kernel@salutedevices.com>,
	<linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 5/6] ASoC: dt-bindings: Add bindings for NeoFidelity NTP8835
Date: Tue, 9 Jul 2024 20:28:33 +0300
Message-ID: <20240709172834.9785-6-ivprusov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709172834.9785-1-ivprusov@salutedevices.com>
References: <20240709172834.9785-1-ivprusov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186398 [Jul 09 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24 186c4d603b899ccfd4883d230c53f273b80e467f, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;devicetree.org:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/09 14:24:00
X-KSMG-LinksScanning: Clean, bases: 2024/07/09 15:33:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/07/09 15:25:00 #25923573
X-KSMG-AntiVirus-Status: Clean, skipped

Add dt-bindings for NeoFidelity NTP8835C/NTP8835C Amplifiers

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---
 .../bindings/sound/neofidelity,ntp8835.yaml   | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/neofidelity,ntp8835.yaml

diff --git a/Documentation/devicetree/bindings/sound/neofidelity,ntp8835.yaml b/Documentation/devicetree/bindings/sound/neofidelity,ntp8835.yaml
new file mode 100644
index 000000000000..6dbe0eb2e93d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/neofidelity,ntp8835.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/neofidelity,ntp8835.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NeoFidelity NTP8835/NTP8835C Amplifiers
+
+maintainers:
+  - Igor Prusov <ivprusov@salutedevices.com>
+
+description: |
+  The NTP8835 is a single chip full digital audio amplifier
+  including power stages for stereo amplifier systems.
+  NTP8835 is integrated with versatile digital audio signal
+  processing functions, high-performance, high-fidelity fully
+  digital PWM modulator and two high-power full-bridge MOSFET
+  power stages. NTP8835C has identical programming interface,
+  but has different output signal characteristics.
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - neofidelity,ntp8835
+      - neofidelity,ntp8835c
+
+  reg:
+    enum:
+      - 0x2a
+      - 0x2b
+      - 0x2c
+      - 0x2d
+    maxItems: 1
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
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      ntp8835@56 {
+        compatible = "neofidelity,ntp8835";
+        #sound-dai-cells = <0>;
+        reg = <0x56>;
+        reset-gpios = <&gpio 5 GPIO_ACTIVE_LOW>;
+      };
+    };
-- 
2.34.1


