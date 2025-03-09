Return-Path: <linux-kernel+bounces-553300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A28FA5871B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC4F33A99A7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B372204C0E;
	Sun,  9 Mar 2025 18:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="YorzCAHK"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AAB1DF732;
	Sun,  9 Mar 2025 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544497; cv=none; b=XxPknS+0v6SZ/eETB0r152VrVmef54V8FXxSKgF+WzBJb+WORZ/yCSf+erKA8JjcYamOWgL5zWC8WWDrN1HiAcemoYYha7PIkMGsAib8tsOKuItfVC7rjSn02vAyRJ5qzEAx4x060Ao+qeBMApfVIhEVDgLKTsT/DGbwRnyMhVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544497; c=relaxed/simple;
	bh=ybkbzx+DIvWdFpyy8EDoKSIvtWeGkBDccrQr3+eS2DI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UOfpiQh1Y2GDc0ESZGi6gYXJkn18qjphRVKLEAP/LVqs0lZv32l7oGNVuMqpYLQDz9PypdCfwkxzbDoWiiQtKoLzYmeU2oq7dRYYXl2zI3VsDmPfUAEuIx2XA4P8KLgHEnvlZxFOMCk/vThc7wSLvBDnEjxxhDAhLtTmR2acvJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=YorzCAHK; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id C71EB120006;
	Sun,  9 Mar 2025 21:21:33 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C71EB120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1741544493;
	bh=9SRIX/FvqDap0SMfdebaXOrywr2NEUWz33l2V3WObDM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=YorzCAHKzCsMS+6VKaHX0r5RlLmFzlEIJ7JlD7IdXHtP6t2dQkz5rKTAn6n9WEed0
	 A0itdLoQHIZ1yhLBh1dp5TrwH3dOlIgKYnPI2bh7P1EgtOCg6hhQir5E05QZynCGtN
	 ucBR150JdDS/W0FC7Stg07gfPUSBcIAbiubk1hK6p7GZUd4SJrWSD8qNzY06C0F68B
	 VveyE1XQkT9FHVlmgnDdJzasMNk80iSSgacrKyg2XDh4Es1e2GSjfUituMKr3fkC70
	 g9GE+Uu0Fq0AF3daNHcEfdUmFwdQGKXvjXjB/6Dz8khv5ox/ISc4uGIoOU5wdWQwJ6
	 a4e20yZHnPqIQ==
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
Subject: [PATCH v2 2/6] ASoC: dt-bindings: meson: axg-fifo: claim support of A1 SoC family
Date: Sun, 9 Mar 2025 21:21:23 +0300
Message-ID: <20250309182127.1322890-3-jan.dakinevich@salutedevices.com>
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

Add "amlogic,a1-toddr" and "amlogic,a1-frddr" compatible string aliases
to "amlogic,sm1-toddr" and "amlogic,sm1-frddr" respectevely.

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 .../devicetree/bindings/sound/amlogic,axg-fifo.yaml       | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml
index b1b48d683101..1e809c7c2179 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml
@@ -25,6 +25,14 @@ properties:
               - amlogic,g12a-frddr
               - amlogic,sm1-frddr
           - const: amlogic,axg-frddr
+      - items:
+          - const: amlogic,a1-toddr
+          - const: amlogic,sm1-toddr
+          - const: amlogic,axg-toddr
+      - items:
+          - const: amlogic,a1-frddr
+          - const: amlogic,sm1-frddr
+          - const: amlogic,axg-frddr
 
   reg:
     maxItems: 1
-- 
2.34.1


