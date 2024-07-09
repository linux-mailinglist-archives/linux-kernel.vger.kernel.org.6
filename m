Return-Path: <linux-kernel+bounces-245657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4141492B591
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFBCC282515
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70A0157460;
	Tue,  9 Jul 2024 10:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="jCZcahHr"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B72F156236;
	Tue,  9 Jul 2024 10:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720521709; cv=none; b=r4i1oRhfbh+p8yOYto/LLFJruku/ZNdzSD4BZhMZRH4HBOFfTD9O9dBQuAlQnsxY6YVyctxzfxuirn5m0pn8V9P4YICNSGS0XrIV3kRiHxgykoltBjW53NP2vzuxeyX0mSBD4geaz4zSnPkmr+aHlnMvtbZJm4uYbOQcNFoco6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720521709; c=relaxed/simple;
	bh=j2+L2e88TkuaA/6frD91x0+p8/7XHi644xNEYPa5YXc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDv83olPQIuNj+K0sUUFmznXy3feLDzV7JX5E9uywE2LjkEZHHNcAlkQdFFI17KRAzFnX8r9e7v8lySxvhnqY/UQg5eas5izzM2lE3SAovQ4Ng5D1+djkB6TgNR2N3UF+9DBXBahQ5c72gl3Mly2EEj1Rnq0U9OylOXBwSIu37E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=jCZcahHr; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id B78D6120002;
	Tue,  9 Jul 2024 13:41:38 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B78D6120002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1720521698;
	bh=1rQ03YCTMn6AdvusY9O6EEAwdsx6CFw18/Rm22Rk62M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=jCZcahHrhsWHh4LzI1dzS3ZQfxJsqLqgtTOZaozG4VYN39a9l8JXSvpvoc/k9V3dK
	 LPwpoy6I6lzqXypaWVa5ZRig91GXN9lpe0zohFotaqOFRtG9Q139rUrkXfX2t9zuRN
	 vjmzqisinP9Zxv5DPyjp5pEzkCqOv+G/DBRIg7vfFPoGQM7phhLrbI2Rri3UIaXAiD
	 QQuUCdUQizFAWkni94KKG8CjRc8iHf9Dyivz58e6IvD+tAR3RYdn8v5mwhuBXax5gJ
	 1vKgCI11iSkt6g+6wGYrOJ0yHYCN/ngY0J4RONsJBG7C/FNvincTYpDEfdwa8lcmxx
	 xwPfnIp3PRFtw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue,  9 Jul 2024 13:41:38 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jul 2024 13:41:38 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Igor Prusov <ivprusov@salutedevices.com>
CC: <prusovigor@gmail.com>, <kernel@salutedevices.com>,
	<linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ASoC: dt-bindings: Add bindings for Everest ES7243E
Date: Tue, 9 Jul 2024 13:41:16 +0300
Message-ID: <20240709104117.33431-2-ivprusov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709104117.33431-1-ivprusov@salutedevices.com>
References: <20240709104117.33431-1-ivprusov@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 186389 [Jul 09 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 23 0.3.23 8881c50ebb08f9085352475be251cf18bb0fcfdd, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;devicetree.org:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/09 09:10:00
X-KSMG-LinksScanning: Clean, bases: 2024/07/09 09:10:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/07/09 09:37:00 #25918307
X-KSMG-AntiVirus-Status: Clean, skipped

Add dt-bindings for Everest Semi ES7243E ADC.

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---
 .../bindings/sound/everest,es7243e.yaml       | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/everest,es7243e.yaml

diff --git a/Documentation/devicetree/bindings/sound/everest,es7243e.yaml b/Documentation/devicetree/bindings/sound/everest,es7243e.yaml
new file mode 100644
index 000000000000..16452c75e0b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/everest,es7243e.yaml
@@ -0,0 +1,42 @@
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
+required:
+  - compatible
+  - reg
+  - "#sound-dai-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      es7243e: es7243e@14 {
+        compatible = "everest,es7243e";
+        reg = <0x14>;
+        #sound-dai-cells = <0>;
+      };
+    };
-- 
2.34.1


