Return-Path: <linux-kernel+bounces-334465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AB297D799
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 17:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75C361F24DDD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 15:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0B017D344;
	Fri, 20 Sep 2024 15:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="hm58FrwC"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DD815E8B;
	Fri, 20 Sep 2024 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726846909; cv=none; b=CQ7lKbC9iNVNW1+vaeQ2OjFQgQX2shGidyT85Qam+1C97vphO3QJa6Erco0wo78PhUtGFWamSjALhi6LtDE5dx52XRPq1o8okY3RtPL8LSgCa++FJ3VkuOWHosKNJwwY6UGJosrHlrUDuSQxPHdzYeW/x0zTdB7bhqTFnvAiakc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726846909; c=relaxed/simple;
	bh=38XsT9FJ8E4so/HaQMPOsBSafRnhePgTnG0vjIuIovU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qAhVkdy+BlWE0qN1/I+J0fyY7q2jsSVi5kTLaurSexq5EE/PoJNThil+dpk/1ODyfr76fFol9xi+WwZQlkTLxK1xNxcgMDHl3VHbOUmDd5SsJ0PYPdEmp5FbVQfTQOoM5o7/w0aruW5WwrVDoltcRtNIwDKAM6Z7XMIqzTFoj24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=hm58FrwC; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id DAE9F100004;
	Fri, 20 Sep 2024 18:41:33 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru DAE9F100004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1726846893;
	bh=z4zFPmsPRLrB73HEvnDKbuQRv5eafhr9TG42FX8UOBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:From;
	b=hm58FrwCo4fJ5xaRkvEmnnk3a/kgehqXH/em+jp7C+IsZg4xlKG8KZLaTGJikTSaH
	 WbKFNIabLQ62h1SHce4d7VKjSVtb5PzcgNJG4YBY/k3XeB+IpsqEcozjFG62NrU2AM
	 0i6SmvlSuyUlV0coEuNvKCdlP+W2URfahzlM4YwYEGKPOj5yaifzLh2UDQbIL8d6nW
	 yH0oNG0ObFgoFArSMiGn4gKRJFaEKMeAOGhuN9OGEySVOYRK3RuONja2Ux/KYIOYeQ
	 M8yjAtJiMv1g4S+J/POgyx7NgK0C5a/NxQ/u5c1L8mktx02Tp2rDW2VJUFXe2oxfLH
	 uiZ/HQuWRfENw==
Received: from smtp.sberdevices.ru (unknown [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 20 Sep 2024 18:41:33 +0300 (MSK)
From: Igor Prusov <ivprusov@salutedevices.com>
Date: Fri, 20 Sep 2024 18:41:07 +0300
Subject: [PATCH v2 1/2] ASoC: dt-bindings: Add Everest ES7243E
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240920-es7243e-adc-v2-1-0be019735b81@salutedevices.com>
References: <20240920-es7243e-adc-v2-0-0be019735b81@salutedevices.com>
In-Reply-To: <20240920-es7243e-adc-v2-0-0be019735b81@salutedevices.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Igor Prusov <ivprusov@salutedevices.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <kernel@salutedevices.com>,
	<prusovigor@gmail.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187889 [Sep 20 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34 8a1fac695d5606478feba790382a59668a4f0039, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;devicetree.org:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/09/20 12:16:00
X-KSMG-LinksScanning: Clean, bases: 2024/09/20 12:16:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/09/20 14:03:00 #26646385
X-KSMG-AntiVirus-Status: Clean, skipped

Add dt-bindings for Everest Semi ES7243E ADC.

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---
 .../devicetree/bindings/sound/everest,es7243e.yaml | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/everest,es7243e.yaml b/Documentation/devicetree/bindings/sound/everest,es7243e.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..6afb467f389a70ad406a0fd953448b83b39ed858
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/everest,es7243e.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/everest,es7243e.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Everest ES7243E audio ADC
+
+maintainers:
+  - Igor Prusov <ivprusov@salutedevices.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: everest,es7243e
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+  clocks:
+    minItems: 2
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: sclk
+      - const: lrclk
+
+required:
+  - compatible
+  - reg
+  - "#sound-dai-cells"
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      es7243e: audio-codec@14 {
+        compatible = "everest,es7243e";
+        reg = <0x14>;
+        #sound-dai-cells = <0>;
+        clocks = <&clk_audio_sclk>,
+                 <&clk_audio_lrclk>;
+        clock-names = "sclk", "lrclk";
+      };
+    };

-- 
2.34.1


