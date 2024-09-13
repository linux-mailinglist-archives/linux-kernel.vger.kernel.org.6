Return-Path: <linux-kernel+bounces-328147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B521B977F8A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40DC91F2869C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDF61DB534;
	Fri, 13 Sep 2024 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="PRhSUgsR"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F5B1DA620;
	Fri, 13 Sep 2024 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726229647; cv=none; b=L+UeFgoPVZ50n1/nJya+cZ2eTEkKwOKh+j6Ww8owr/9lth5YHcsdnAEsZQlRTghKvVn6iyB7F4o2Qg3cAr1WrYb387465Vn/5t2yBEArIfTP2mVuuLbNA2xRNS00/k4HKdXEvfFbR/YA8Ovh1CP8CBsXU6UApti4ScV1OQPwCMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726229647; c=relaxed/simple;
	bh=H1hHs2/CpO+weIq4IBU7XAsPIYNU9E1H4s8ouTG37B8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hcd0Bsvy7XWpstTZ1Y3UvHIgbPyb0ao/+dTUT3BP6/8lbWXI+Uu9QPNdgUHsYfYMx2kNKWdQ5EzGF8y165VSGf8Qzqk7UEbav0vtZSB55FEYyym5W1WCbDqN8byF2t8Vx0JDrfs1xAUaTOutTnNs5h7nB+pKTle1sCqgGh9hF30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=PRhSUgsR; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 8C820100016;
	Fri, 13 Sep 2024 15:13:53 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8C820100016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1726229633;
	bh=zCP8OSIeGAb7u3eR0jUeoJWzHJlMuxWsql4KkrdkLS4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=PRhSUgsRPk2DTv1J3x6tfmE9H548s4Rc6418FbvGUEJkOhUegfBGuztP0GG/j9fKv
	 3vmJA8HkEJb2fa3GEQuQDzgYlV7hfynLiA95xUs4mYG4q3UmgxdEw4RdkmAiMrk2Ku
	 Wb15nQ1bXPCxZkdVmgrH9J0nz1/yXMKRUM/rM8ZL2cS6u40lMIIEsU4wDcjZqcAPNR
	 3weGhGF1TkpcUJ8i2rjv9ecLAwTGSbMwQhaS4lmyKkzL7Q/CLhur1wFRnvN17tU79s
	 WsncET3xAMXtgNf4EHU6OVrE7GjZxj+YLp2DVkkj8/B/1W9rR2oWzfZzOiLUs9GlMO
	 729H4idBpHyDQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 13 Sep 2024 15:13:53 +0300 (MSK)
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Conor Dooley
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>, Jerome Brunet
	<jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Michael Turquette
	<mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [RFC PATCH v4 0/5] Add A1 Soc audio clock controller driver
Date: Fri, 13 Sep 2024 15:11:47 +0300
Message-ID: <20240913121152.817575-1-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187732 [Sep 13 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34 8a1fac695d5606478feba790382a59668a4f0039, {Tracking_smtp_not_equal_from}, {Tracking_uf_ne_domains}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;lore.kernel.org:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, FromAlignment: n
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/09/13 10:32:00
X-KSMG-LinksScanning: Clean, bases: 2024/09/13 10:32:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/09/13 11:43:00 #26577866
X-KSMG-AntiVirus-Status: Clean, skipped

This series adds support for audio clock and reset controllers on A1 SoC family.

Dependency: [4]

Changes v3 [3] -> v4
 - Use auxiliary reset device implemented in [4]
 - Split the driver into files
 - Use common with axg-audio yaml schema
 - Unify clock-names with axg-audio

Changes v2 [2] -> v3
 - reset:
   * added auxiliary device
 - yaml:
   * added declaration of optional clocks
   * fixed names in example and another cosmetics
 - clocks:
   * reworked naming
   * stop using of "core" clock name
   * fixed wrong parenting

Changes v1 [1] -> v2:
 - Detached from v1's series (patch 2, 3, 4, 25).
 - Reuse some of defines from axg-audio;
 - Split the controller into two memory regions.

Links:
 [1] https://lore.kernel.org/lkml/20240314232201.2102178-1-jan.dakinevich@salutedevices.com/
 [2] https://lore.kernel.org/lkml/20240328010831.884487-1-jan.dakinevich@salutedevices.com/
 [3] https://lore.kernel.org/lkml/20240419125812.983409-1-jan.dakinevich@salutedevices.com/
 [4] https://lore.kernel.org/lkml/9a4377fe27d8eb940399e452b68fb5a6d678929f.camel@pengutronix.de/

Jan Dakinevich (5):
  reset: amlogic: add support for A1 SoC in auxiliary reset driver
  clk: meson: axg: share the set of audio helper macro
  dt-bindings: clock: axg-audio: document A1 SoC audio clock controller
    driver
  clk: meson: a1: add the audio clock controller driver
  arm64: dts: meson: a1: add the audio clock controller

 .../clock/amlogic,axg-audio-clkc.yaml         |   3 +
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi     |  48 +++
 drivers/clk/meson/Kconfig                     |  14 +
 drivers/clk/meson/Makefile                    |   3 +
 drivers/clk/meson/a1-audio-clkc.c             | 359 ++++++++++++++++++
 drivers/clk/meson/a1-audio-drv.c              | 104 +++++
 drivers/clk/meson/a1-audio-vad-clkc.c         |  85 +++++
 drivers/clk/meson/a1-audio.h                  | 131 +++++++
 drivers/clk/meson/axg-audio.c                 | 138 +------
 drivers/clk/meson/meson-audio.h               | 143 +++++++
 drivers/reset/amlogic/reset-meson-aux.c       |   9 +
 .../dt-bindings/clock/amlogic,a1-audio-clkc.h | 122 ++++++
 .../reset/amlogic,meson-a1-audio-reset.h      |  29 ++
 13 files changed, 1051 insertions(+), 137 deletions(-)
 create mode 100644 drivers/clk/meson/a1-audio-clkc.c
 create mode 100644 drivers/clk/meson/a1-audio-drv.c
 create mode 100644 drivers/clk/meson/a1-audio-vad-clkc.c
 create mode 100644 drivers/clk/meson/a1-audio.h
 create mode 100644 drivers/clk/meson/meson-audio.h
 create mode 100644 include/dt-bindings/clock/amlogic,a1-audio-clkc.h
 create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-audio-reset.h

-- 
2.34.1


