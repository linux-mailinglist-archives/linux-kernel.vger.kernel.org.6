Return-Path: <linux-kernel+bounces-553302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE9FA5871D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 929B47A4268
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA97320B81E;
	Sun,  9 Mar 2025 18:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="RIqI16wD"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ACB1F0985;
	Sun,  9 Mar 2025 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544498; cv=none; b=Tqf89MVqI0+HeN0Roi+d7TDK1/w45ACHEmGHGgArokFgJvvpB8hXf4706jdXdl4dDIcdIcqWtibOPE8O8taz+eQqI7bz99UJt3ZIrcC0Gbyy+FXo2QzPG2KXkr92HW8e1BCq0w8OJnVyeHo5MmuJ7LoUdGhDJW2T1rhHZoDH9As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544498; c=relaxed/simple;
	bh=yqiIwjG/S7XDJV/pa1WQy2erlDBpjOznaZZknYGr6Bk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ReYWgy/Ij0BLidxcIK8BvCPr6lBa2kxxETH/jtNWusr17p2T9ghRxL/pkPvyE7kMbyB8NYol7EeCKQmIOSzQHY97RMxgKMvc2EBAmj3GszMbBS1jo/XnW+VDxrhGUz4XSBWCKARE5R2ywrYcKh+2l5oJk1SHSOjsei9D/QKfJWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=RIqI16wD; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 69FF5120007;
	Sun,  9 Mar 2025 21:21:34 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 69FF5120007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1741544494;
	bh=KNZWo7RkvOeyvRwAeuVGN8+SUS+q1CnUsbKOy62L+dA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=RIqI16wDuci9u0AbT2v2XcoYAJyj7yJ+74tWQkBvOzLfDWC8CuwyTBKK/Am9BdqXq
	 MLxpvVZh8JOoj64QE0yJ7dkikp6qa+WAuVRUoMdLch+4Z1YhTB3wZgvvh8wNZnflSU
	 RTHq7nua50mq/p+ZJuhhkK41QY7aZJrbLod/S+hx/tmFy3VL29CHrf/EpPK5juWqjU
	 gP0H0CIJOfJwhV2tFjB9sGblTbAbmbMzklVAVNiG3tjY4GXdethWZ+qc/MrYgroZRx
	 LAV3aKt81D7tFkbxsr8Kv+GeG/VxSk8b9uqsJ30A58Z/eDpaiKxfk9I10CPMZtB5FK
	 mVqtOvhPwXnig==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun,  9 Mar 2025 21:21:34 +0300 (MSK)
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
Subject: [PATCH v2 4/6] ASoC: dt-bindings: meson: axg-tdm-formatters: claim support of A1 SoC family
Date: Sun, 9 Mar 2025 21:21:25 +0300
Message-ID: <20250309182127.1322890-5-jan.dakinevich@salutedevices.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_smtp_not_equal_from}, sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, FromAlignment: n
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/03/09 17:28:00 #27692143
X-KSMG-AntiVirus-Status: Clean, skipped

Add "amlogic,a1-tdmout" and "amlogic,a1-tdmin" compatible string aliases
to "amlogic,sm1-tdmout" and "amlogic,sm1-tdmin" respectevely.

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 .../sound/amlogic,axg-tdm-formatters.yaml     | 22 ++++++++++++-------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.yaml
index 719ca8fc98c7..154522488020 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.yaml
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.yaml
@@ -11,14 +11,20 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - amlogic,g12a-tdmout
-      - amlogic,sm1-tdmout
-      - amlogic,axg-tdmout
-      - amlogic,g12a-tdmin
-      - amlogic,sm1-tdmin
-      - amlogic,axg-tdmin
-
+    oneOf:
+      - enum:
+          - amlogic,g12a-tdmout
+          - amlogic,sm1-tdmout
+          - amlogic,axg-tdmout
+          - amlogic,g12a-tdmin
+          - amlogic,sm1-tdmin
+          - amlogic,axg-tdmin
+      - items:
+          - const: amlogic,a1-tdmout
+          - const: amlogic,sm1-tdmout
+      - items:
+          - const: amlogic,a1-tdmin
+          - const: amlogic,sm1-tdmin
   clocks:
     items:
       - description: Peripheral clock
-- 
2.34.1


