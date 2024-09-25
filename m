Return-Path: <linux-kernel+bounces-339277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A454198627D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58CFEB309A4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95217185E7A;
	Wed, 25 Sep 2024 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="ZymeKhun"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A86183CAF;
	Wed, 25 Sep 2024 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276032; cv=none; b=Ei6tieENhP7OhgaobzYkLZXMRb1Sthh6DGmtiR4fx2g9shkXmCQ06zq+6GU0btJlRkr0g+IrdDDvPUWJTvIDmA+ykmncYThuOTbttFGmKnbmCNoQ56l+i/h1rD0gZwZvW2IZ40SNqZZsx2xGIv6xyQHt4TF5ct+SSAL4v0tFhDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276032; c=relaxed/simple;
	bh=1rbAU8l/g/D/HFPzgxe4ZGLqQep60+AWEiB6UhVM0iU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tWh0ZtKcJqyYJDnVcR5z2sROpKr3MTpm4Pf74EaZd6nU3wxcVPkQ35MaF99ntNHUvnMKpY4aGc59ekYqRkqGWalyqEbcm2V9XPMmJX+ne7LobdGQph6XAMx0anYA04y5uV6Ck+CWIp1qYgQLeSM0BUK11d1gr1Kbf5g43Yn+Tlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=ZymeKhun; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 86B1410004D;
	Wed, 25 Sep 2024 17:53:40 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 86B1410004D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1727276020;
	bh=XnkFJndoeLJ3o1ZX8kU8TX/WeTHaiAvXRBl3fzDiYtE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:From;
	b=ZymeKhunCfIVPSJkaWwFOkwiKr4vwTAO0sV4You82NKC/Rc5PG+sy6KiuS1fqRrMn
	 lzKme0sv5NHYrUJhRZy7Se0fbQutwf2aTOGfwcVgT+K2Bnzf70djdA+svGYJcfsSB+
	 jq33X96DZ01i3cXp8X+fv1gcx7uoiqG0UzoOxcX/yoGfYf9vLMqnAv+vDrbdv6fUR6
	 QexXMb626v7qC1x0BvpfElAZHwfwruA4wMrUu0RxiqNhsbulR3Gn2p01/ZJkzCTZK5
	 QRVTaElPXmVpJXl/4Yejv+ijwjJ7Y9Wu5zKLEvCPYPGRCLV4XDDMCzIjfAxvdb7ZX7
	 zCPC/v5Qs4rCA==
Received: from smtp.sberdevices.ru (unknown [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 25 Sep 2024 17:53:40 +0300 (MSK)
From: Igor Prusov <ivprusov@salutedevices.com>
Date: Wed, 25 Sep 2024 17:52:43 +0300
Subject: [PATCH v3 5/6] ASoC: dt-bindings: Add NeoFidelity NTP8835
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240925-ntp-amps-8918-8835-v3-5-e2459a8191a6@salutedevices.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34 8a1fac695d5606478feba790382a59668a4f0039, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;devicetree.org:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/09/25 12:44:00
X-KSMG-LinksScanning: Clean, bases: 2024/09/25 12:44:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/09/25 13:22:00 #26670925
X-KSMG-AntiVirus-Status: Clean, skipped

Add dt-bindings for NeoFidelity NTP8835C/NTP8835C Amplifiers

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---
 .../bindings/sound/neofidelity,ntp8835.yaml        | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/neofidelity,ntp8835.yaml b/Documentation/devicetree/bindings/sound/neofidelity,ntp8835.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..44d72a2ddfc9abc29039106c4a1baed8a5f6e5d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/neofidelity,ntp8835.yaml
@@ -0,0 +1,73 @@
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
+
+  reset-gpios:
+    maxItems: 1
+
+  '#sound-dai-cells':
+    const: 0
+
+  clocks:
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: wck
+      - const: bck
+      - const: scl
+      - const: mclk
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
+      audio-codec@2b {
+        compatible = "neofidelity,ntp8835";
+        #sound-dai-cells = <0>;
+        reg = <0x2b>;
+        reset-gpios = <&gpio 5 GPIO_ACTIVE_LOW>;
+        clocks = <&clkc 551>, <&clkc 552>, <&clkc 553>, <&clkc 554>;
+        clock-names = "wck", "bck", "scl", "mclk";
+      };
+    };

-- 
2.34.1


