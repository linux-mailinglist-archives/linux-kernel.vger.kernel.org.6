Return-Path: <linux-kernel+bounces-553301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B09A3A5871C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B578C3AA867
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954F7206F1F;
	Sun,  9 Mar 2025 18:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Mu/vQFRm"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BB21EF387;
	Sun,  9 Mar 2025 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544498; cv=none; b=aFnUFeUXPODzqPDZfnFHn947DaEGF96I5HMaNx0q/BIGnu+kz7RBbxUsuBB3kU3hP8X9tg86SekA4OymosnMGhE8BoR8G0KCEIcJYrrOVO30hzwO9ByKU9c9h/sFPV0TiiJ4tBzqzW5JaKpoAH7ZFza1Lz2yQvzoP2hOSukvhaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544498; c=relaxed/simple;
	bh=/azyPIo5CYCGEWjCSvL0vwbf5cNKUnjcODbJtuIxWek=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0zREEFZ1pUnIPi6c1E/MLK5eFhENlT/MMcrap2oqabyeymnbmCANiZzfwJi9zuPumv3Y4X9Q0y3q58w8bINZi/mB60seOlf4fmF6W4BXxpkL7nrQyFwoBlDhnlqsvMSaFT9Yqb3bVYl3pnnUJ6+PgCBxPBdwm1FvScHDfKtUu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Mu/vQFRm; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 2CD0D100008;
	Sun,  9 Mar 2025 21:21:34 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2CD0D100008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1741544494;
	bh=mgADVFm35fjqdsjh2H21jJh+/8meBttbKXxeyoaClCk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Mu/vQFRmlO3dBUzdJ2O4tHEvycuVl61PL+RzFbgH/ZVOjI+M2CbhAU79bjZicb4SE
	 GIuKrxcsvGBlgQoaTmwBPOEZ6IOR1bzDcDLytNOhti5UYWl2RkeY4iqwKUWcAP334H
	 LtEd4eY2f0CGqCWKJ4/IcTGLUSY62af7FtJub9Xt0Z42u/F3tHPsqVu+7/NYiVKdnn
	 0PUyBJXmjoABAniiA0ecclzoK9DBgRvdGQ9sdUQC6LzgIU3bqU7PxfkwZorhQVDw6z
	 iQv0FB4HoGr/RYQhsw3m+FKsK5JNHeXcA7rVKaCojcWX81XIWeOXoJA4RjtVdY00d4
	 7GrCdGFGYUm1w==
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
Subject: [PATCH v2 3/6] ASoC: dt-bindings: meson: axg-pdm: claim support of A1 SoC family
Date: Sun, 9 Mar 2025 21:21:24 +0300
Message-ID: <20250309182127.1322890-4-jan.dakinevich@salutedevices.com>
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

Add "amlogic,a1-pdm" compatible string alias to "amlogic,axg-pdm".

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml
index df21dd72fc65..9b6cd9f03a0c 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml
@@ -16,6 +16,7 @@ properties:
           - enum:
               - amlogic,g12a-pdm
               - amlogic,sm1-pdm
+              - amlogic,a1-pdm
           - const: amlogic,axg-pdm
       - const: amlogic,axg-pdm
 
-- 
2.34.1


