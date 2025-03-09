Return-Path: <linux-kernel+bounces-553289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47266A586F8
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84849169A78
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACE41F584B;
	Sun,  9 Mar 2025 18:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="lWf1R2q3"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA697288DB;
	Sun,  9 Mar 2025 18:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544170; cv=none; b=XLogUqhXB8HDdPH/eTtn5uYMrFspkxY0JwX+2H+KutuF7zf+XtsbLl0X6vl+3T7JI1ejEu3YI4D86drIyBi33WbSsg8Y2MCrcTflicLQl2JCfh2g7mNjcNil5ttvmdjqyeGRFZAKtZI1e9Ud4eEP5+8zx1Iteoc6OBEPPs7hYFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544170; c=relaxed/simple;
	bh=Lmwa9oWRWgD2JNaTz2dK4LFye8+v03wV8rRgOHvIMqc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fe7ejvvusppP02VijFylx6Oq11ORmur+RU5BeewJ6ajSNlchknSP70esG0IBIvesd11yIgD8IVsBSHVfSQ8fbpFtogo7Lfnur+oYAxTd2hRSRdtSzwFpu0u2DxrjsVanImcUyS+CIe7l+mTkDn4p2IrXTVzTAzYJuKbD5fgna6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=lWf1R2q3; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id A7A97120004;
	Sun,  9 Mar 2025 21:16:06 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru A7A97120004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1741544166;
	bh=38pc2HrGEn22seG8bYETzhJAzcp/r821LyC9GborcOQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=lWf1R2q3Y9vIzUvEUxW8WMbsN4mTWPOfyx3qoa3zSoodKL/iLt6tV5B74MlP8LgOA
	 e8+nSN8SXymf5XUTE81x3TbuBHdPzv2u0SAFMMmZaJ9LDpx2PVG1mTU77L6u+i+jj2
	 BTCelsL6S85r+B7buA69Sazi0BhjVyhT18/5SBzbCGcdW3QBG94gIxTIrDMeKa7DSB
	 vPE0SdKSTBQi/P9IqIj0X77EYGHwc/ZrD3G8keZXOsTFECBC4U/l53E4wrfJecVoII
	 ff0NHdP5BuOVewXCXiI5iFD2hTZulPLD4N0r02vTWSir2dswRdO1kxd7vTmaqCwKUH
	 kB8MPnPaNcXMQ==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun,  9 Mar 2025 21:16:06 +0300 (MSK)
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
Subject: [PATCH v2 0/4] ASoC: meson: g12a-toacodec: add support for A1 SoC
Date: Sun, 9 Mar 2025 21:15:56 +0300
Message-ID: <20250309181600.1322701-1-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
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
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_smtp_not_equal_from}, {Tracking_uf_ne_domains}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;sberdevices.ru:5.0.1,7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;lore.kernel.org:7.1.1, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, FromAlignment: n
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2025/03/09 17:18:00
X-KSMG-LinksScanning: Clean, bases: 2025/03/09 17:18:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/03/09 17:28:00 #27692143
X-KSMG-AntiVirus-Status: Clean, skipped

This series adds support for A1 SoC family in g12a-toacodec driver. The main
change is that the driver now supports capture streams which are suitable for
ADC found on A1's internal audio codec.

Changes v1 [1] -> v2
 - detached from v1's series (patch 6, 7, 8, 9)
 - reworked the definition of bits

Links:
 [1] https://lore.kernel.org/lkml/20240314232201.2102178-1-jan.dakinevich@salutedevices.com/

Jan Dakinevich (4):
  ASoC: meson: codec-glue: add support for capture stream
  ASoC: meson: g12a-toacodec: drop the definition of bits
  ASoC: dt-bindings: meson: g12a-toacodec: add support for A1 SoC family
  ASoC: meson: g12a-toacodec: add support for A1 SoC family

 .../bindings/sound/amlogic,g12a-toacodec.yaml |   1 +
 .../dt-bindings/sound/meson-g12a-toacodec.h   |   5 +
 sound/soc/meson/g12a-toacodec.c               | 242 ++++++++++++++----
 sound/soc/meson/meson-codec-glue.c            | 174 ++++++++++---
 sound/soc/meson/meson-codec-glue.h            |  23 ++
 5 files changed, 358 insertions(+), 87 deletions(-)

-- 
2.34.1


