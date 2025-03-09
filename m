Return-Path: <linux-kernel+bounces-553284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DB8A586DF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3388718889C3
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E231F8730;
	Sun,  9 Mar 2025 18:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="VRllCi6c"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0BD1F4C9F;
	Sun,  9 Mar 2025 18:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741543791; cv=none; b=WbvwqG0IF/9o13ctmLaea8ztp86fknH7OFXgCUkvi98QNyEg/LUFGYL4KamIf6/hq/JbMdJQh0HxoD5ocCrLckaqd1T6KdKgDRE3RvnQGwwCAfx34Hs7XF8uObQSUcP70/ExBX9ZdSiBWJhwDbQ5hMr1wmo+M3mVaGJtwqiRUfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741543791; c=relaxed/simple;
	bh=0jA0jE1d3VZYRFj2dEWSaC1XvTehPnfNraI7FcCBe0A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IqFEcbBbX90ciV18d1AhO32vGZOq1ZSyStB8O+1Hewh4hIrHOqj3/tiPI/BVE4X+HCruOlg+GB6M3dPEapIiCE/7xNaenQnaoSVisJy4xCpI4le78nEzu90eT4y9F7fc9COGXm2IoE2wsbEyJeV+q1DuTjz/9J4/1Kty8U/RqBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=VRllCi6c; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 11DAF100002;
	Sun,  9 Mar 2025 21:09:47 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 11DAF100002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1741543787;
	bh=GrOqXh07i7N0ySZW77DG1Gd9b3sEB1loXlmnzaagEgc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=VRllCi6cDAX0b3dseG36loA+RegoaPqcUqxtREFs9CsmTA4iLRbbXmxFvs/fCRcUW
	 7vNsrZinuEjW5Yz+s9HO+JNqDrb/AKMkIriM4b2Xzgwc4Q+tXM0szVtlWKHU1rM15Z
	 Hvcad15kn81zKpkBD05xOPpiV0UyuIbQKTy+tImfnr3UXsBNB8mrI7Ey5QvMPL56F+
	 YjINXXxS61yUIdiS5DWhXxwVE1awqp9vQvgUkwdxiU0M6Pas1dTQC6nZ5NtIZL5DN7
	 iEzcqhlK5f24kaSJPh30hbtU0++VwxIBx+9R7ogG2O8jXWYhQm0IgOTV8LCWQjY3mL
	 whsF5u16VogfQ==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun,  9 Mar 2025 21:09:46 +0300 (MSK)
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Conor Dooley
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>, Jerome Brunet
	<jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Michael Turquette
	<mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, Rob
 Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v6 0/4] Add A1 Soc audio clock controller driver
Date: Sun, 9 Mar 2025 21:09:36 +0300
Message-ID: <20250309180940.1322531-1-jan.dakinevich@salutedevices.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_smtp_not_equal_from}, {Tracking_uf_ne_domains}, salutedevices.com:7.1.1;127.0.0.199:7.1.2;sberdevices.ru:7.1.1,5.0.1;smtp.sberdevices.ru:7.1.1,5.0.1;lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, FromAlignment: n
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2025/03/09 17:18:00
X-KSMG-LinksScanning: Clean, bases: 2025/03/09 17:18:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/03/09 17:28:00 #27692143
X-KSMG-AntiVirus-Status: Clean, skipped

This series adds support for audio clock and reset controllers on A1 SoC family.

Depends on [7]

Changes v5 [5] -> v6
 - use __devm_auxiliary_device_create() helper that is being introduced in [7]

Changes v4 [4] -> v5
 - moved changes of aux reset driver to series [6]
 - added reset controller on top of audio-vad
 - merged into single file
 - reworked variables/defines naming
 - added clk81 clock hierarchy
 - added TDMIN_VAD-related clocks
 - excluded DT patch (it will submitted separately)

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
 - Detached from v1's series (patch 2, 3, 4, 25)
 - Reuse some of defines from axg-audio
 - Split the controller into two memory regions

Links:
 [1] https://lore.kernel.org/lkml/20240314232201.2102178-1-jan.dakinevich@salutedevices.com/
 [2] https://lore.kernel.org/lkml/20240328010831.884487-1-jan.dakinevich@salutedevices.com/
 [3] https://lore.kernel.org/lkml/20240419125812.983409-1-jan.dakinevich@salutedevices.com/
 [4] https://lore.kernel.org/all/20240913121152.817575-1-jan.dakinevich@salutedevices.com/
 [5] https://lore.kernel.org/all/20241112230443.1406460-1-jan.dakinevich@salutedevices.com/
 [6] https://lore.kernel.org/all/20241112230056.1406222-1-jan.dakinevich@salutedevices.com/
 [7] https://lore.kernel.org/all/20250218-aux-device-create-helper-v4-0-c3d7dfdea2e6@baylibre.com/

Jan Dakinevich (4):
  clk: meson: axg: share the set of audio helper macros
  dt-bindings: clock: axg-audio: document A1 SoC audio clock controller
    driver
  clk: meson: a1: add the audio clock controller driver
  arm64: dts: meson: a1: add the audio clock controller

 .../clock/amlogic,axg-audio-clkc.yaml         |   4 +
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi     |  49 +
 drivers/clk/meson/Kconfig                     |  14 +
 drivers/clk/meson/Makefile                    |   1 +
 drivers/clk/meson/a1-audio.c                  | 856 ++++++++++++++++++
 drivers/clk/meson/axg-audio.c                 | 215 +----
 drivers/clk/meson/meson-audio.h               | 156 ++++
 .../dt-bindings/clock/amlogic,a1-audio-clkc.h | 139 +++
 8 files changed, 1254 insertions(+), 180 deletions(-)
 create mode 100644 drivers/clk/meson/a1-audio.c
 create mode 100644 drivers/clk/meson/meson-audio.h
 create mode 100644 include/dt-bindings/clock/amlogic,a1-audio-clkc.h

-- 
2.34.1


