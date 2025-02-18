Return-Path: <linux-kernel+bounces-520086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF15AA3A57C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 655567A30A4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD68617A317;
	Tue, 18 Feb 2025 18:27:14 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C432356BC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903234; cv=none; b=pl+Xqu6STEZJ+Cwy8J76KyH3bZ0dwiFB8KIVW5sWzWUtE6RyYEDzd55pJPTmjro06Vdp9jvDjn4uBjQgyoKJbIJfIApisMQ9WejLLkqoSREi2+is4uE7RiAOloL7uf+JP6utRof5kU8D/1nKzNXD9uJ1PXNcmVlFBf3ZPk4SbYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903234; c=relaxed/simple;
	bh=GCTzL/xCfB6V2jDS+azd6MV1z1lY7BGs8D0xGHNINRk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=S+GASm2lbkf1jOq1A4BBTi/ZSn3v2xiuIvOn78PQ6TM/7/BAzLaVMFir5OrIRj3rsHGIZLdFtF4rQSujwLFL6NYG2uZwljCR1sshMCAVRhACVni4tfv3ZbUBLcSiyUACjGkU9oy9bfucGxCXlpb6W0W8Bi9+0tef2n9VgzXoGEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tkSIy-0006Be-0w; Tue, 18 Feb 2025 19:26:48 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tkSIx-001dV9-1T;
	Tue, 18 Feb 2025 19:26:47 +0100
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tkSIx-00A9Hm-1A;
	Tue, 18 Feb 2025 19:26:47 +0100
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: [PATCH v4 0/6] arm64: dts: freescale: imx8mp-skov: switch to
 nominal drive mode
Date: Tue, 18 Feb 2025 19:26:40 +0100
Message-Id: <20250218-imx8m-clk-v4-0-b7697dc2dcd0@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAODQtGcC/23MTQqDMBCG4atI1k1JokbtqvcoXUyTiYbWH6INF
 vHujYIQaJffMM+7kBGdxZFckoU49Ha0fRdGdkqIaqCrkVodNhFMZFzwgtp2LluqXk9aZbIoZKq
 N0iUJ/4NDY+e9dbuH3dhx6t1nT3u+XY9KFVU8p4wqA8YAKwsN8jpgV78n13d2PmskW8qLg+eMM
 xlzEbgEQNCgZG7wL08jztOYp4EzLbF6aATIfvm6rl///j44JQEAAA==
X-Change-ID: 20241217-imx8m-clk-9467763dfcd8
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Frank Li <Frank.li@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Abel Vesa <abel.vesa@linaro.org>, 
 Marek Vasut <marex@denx.de>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Ahmad Fatoum <a.fatoum@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Unlike the i.MX8MM and i.MX8MN SoCs added earlier, the imx8mp.dtsi
configures some clocks at frequencies that are only validated for
overdrive mode, i.e., when VDD_SOC is 950 mV.

For the Skov i.MX8MP board, we want to run the SoC at the lower voltage of
850 mV though to reduce heat generation and power usage. For this to work,
clock rates need to adhere to the limits of the nominal drive mode.

This is done by this series: A new imx8mp-nominal.dtsi reconfigures
the imx8mp.dtsi clock tree to be compatible with nominal mode, an adaptation
to the Linux clock driver makes it sanity check the actual clock rates against
the SoC operating mode's constraints and finally the Skov DT makes use
of it.

Actual configuration of the VDD_SOC rail continues to happen prior to Linux
as well as PLL configuration that needs to happen earlier than the kernel
running. See the corresponding barebox patch series[1] for details.
Note that the barebox series didn't yet include VDD_SOC reconfiguration
to 850mV, that would follow once the kernel changes have been merged.

[1]: https://lore.kernel.org/barebox/20240503103717.1370636-1-a.fatoum@pengutronix.de/

---
Changes in v4:
- remove unnecessary oneOf in dt-bindings schema (Frank)
- rebase on top of DT clock rate change v6.14-rc3
- Link to v3: https://lore.kernel.org/r/20250113-imx8m-clk-v3-0-0d6e9bdeaa4e@pengutronix.de

Changes in v3:
- change boolean mode properties to string property, so it's possible to
  override in overlays (Frank).
- Dropped Conor's Ack again due to aforementioned binding change.
- make struct imx8mp_clock_constraints::clkid unsigned (Stephen)
- Remove comma after sentinel member (Stephen)
- Link to v2: https://lore.kernel.org/r/20250106-imx8m-clk-v2-0-6aaeadac65fe@pengutronix.de

Changes in v2:
- Explain in Patch 1/6 why two properties are added instead of one
  (Conor)
- Collect Conor's Acked-by
- Collect Peng's Reviewed-by
- Link to v1: https://lore.kernel.org/r/20241219-imx8m-clk-v1-0-cfaffa087da6@pengutronix.de

---
Ahmad Fatoum (6):
      dt-bindings: clock: imx8m: document nominal/overdrive properties
      arm64: dts: imx8mp: Add optional nominal drive mode DTSI
      arm64: dts: imx8mp: add fsl,nominal-mode property into nominal.dtsi
      arm64: dts: freescale: imx8mp-skov: configure LDB clock automatically
      arm64: dts: freescale: imx8mp-skov: operate SoC in nominal mode
      clk: imx8mp: inform CCF of maximum frequency of clocks

 .../devicetree/bindings/clock/imx8m-clock.yaml     |   8 ++
 arch/arm64/boot/dts/freescale/imx8mp-nominal.dtsi  |  64 +++++++++
 .../arm64/boot/dts/freescale/imx8mp-skov-reva.dtsi |   5 +-
 .../freescale/imx8mp-skov-revb-mi1010ait-1cp1.dts  |  19 +--
 drivers/clk/imx/clk-imx8mp.c                       | 151 +++++++++++++++++++++
 5 files changed, 231 insertions(+), 16 deletions(-)
---
base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
change-id: 20241217-imx8m-clk-9467763dfcd8

Best regards,
-- 
Ahmad Fatoum <a.fatoum@pengutronix.de>


