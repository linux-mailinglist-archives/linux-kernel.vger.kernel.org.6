Return-Path: <linux-kernel+bounces-547765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3396BA50D49
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E5A7172120
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1931FECAD;
	Wed,  5 Mar 2025 21:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="SEVI2LBS"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283351C6FE1;
	Wed,  5 Mar 2025 21:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741209931; cv=pass; b=MVWaVs1lJ282TBm89ogkMARy5WqNJRkMvS3Zr54rZKUfq/LG3xoXLP8QIZ+W2L9cxf9Sxu/9dF+aFlppRWmY8DP7zdfbhJkZD4vOEt4HrOq9ueB93dncx/gspvyfKfkarSX+hACkK0CDDFuZBpnhy4hhlyO8gZUqtKEE7EJ+hEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741209931; c=relaxed/simple;
	bh=jLOOjWApcp9OJszvlkNggAmMoe8M/uG5DU7YDTZVOTo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rQThjDCUxspemtTDxlwWALCBesFgfCQKq+3clFyDbqITeQkOWB1WWe06eJRic06dRc8iFYRObRAuWPdNpbI4V4Aw6JVEqC84jm+Pl5n2+YogzQAqbuIQpZYUCCvaPnNPlCNTxLpVN0PXG/jBgYnKlEbkNHmuuKl+2oN+t1WLFvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=SEVI2LBS; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741209895; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bzzh4J066rrlw/ihx9SLlY9zNNloZQebThe9AanCEKNf/e+8VOgCHxIXTTW7xevUvZ4QGun97hwXW7C5PEdExoYn2zIhoAN8n4AyzNGJtJy03F4AEYXvoT3kJsXeP0qtSIq5y36Vmr+WKxNlR1OrNXsfA9y+LFIJ6EAaMKk84Cw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741209895; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oDZwMEiKq4FsOgak5vQT4YukQizxtAjLgSODP2Tnuxo=; 
	b=IgTCk5EeMB/shkwzD58Rro5ckfJPfaiucDqxl1CYcYnrHhVxAekcCrM77OFeHftE+YBc1g2tuf9jM/4lBwIrZeXLKfDt70lz17t4OkE7tn+tEL5AVNTbx3PNFDSDsCDnEMccwE4LQAD/aeWZq4OQE0CiaiKPhBbUn0Xc+ISx20s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741209895;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=oDZwMEiKq4FsOgak5vQT4YukQizxtAjLgSODP2Tnuxo=;
	b=SEVI2LBS4pji0ctEHwmFV91C8epT7xQIAur9xxQztsqBzYcddjC6bVpVdeg6yv/s
	mrlLIbYNjQTVNz/UpVwltUTLT3RFZ9kmX8XAEbherSW3ipeM/RdjspwQMgqA5OvbMXO
	pQH1jZSGVLRc8IqwJd2BzMTy74ikczMpYg0tDQ0w=
Received: by mx.zohomail.com with SMTPS id 1741209893493878.8606211832787;
	Wed, 5 Mar 2025 13:24:53 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH 0/7] Add RK3576 SAI Audio Controller Support
Date: Wed, 05 Mar 2025 22:24:20 +0100
Message-Id: <20250305-rk3576-sai-v1-0-64e6cf863e9a@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAATByGcC/zXMQQrCMBCF4auEWTswNsbGXkW6iHHUQZraSZRC6
 d0NFpf/g/ctkFmFM3RmAeWPZBlTjf3OQHyEdGeUa21oqHFkyaE+rWuPmINgbD3TwZI/eYZ6eCn
 fZP5h535r5eldzbKNcAmZMY7DIKUzieeCfxf6df0CpSjUSY0AAAA=
X-Change-ID: 20250305-rk3576-sai-c78e0430898e
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Sugar Zhang <sugar.zhang@rock-chips.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

This series adds support for Rockchip's Serial Audio Interface (SAI)
controller, found on SoCs such as the RK3576. The SAI is a flexible
controller IP that allows both transmitting and receiving digital audio
in the I2S, TDM and PCM formats. Instances of this controller are used
both for externally exposed audio interfaces, as well as for audio on
video interfaces such as HDMI.

Patch 1 and 2 do some preparatory work in the clock bindings and clock
controller. The RK3576 has the SAI0 through SAI4 output mclks as well as
the FSPI0 and FSPI1 clocks gated behind some GRF register writes. The
RK3588 had this for its I2S audio clocks as well, but got away with not
caring about it in mainline because the clocks were ungated by default.
This is no longer the case with RK3576: the SAI mclk need to be ungated
before they can be used.

The gritty details are in patch 2, but to sum it up: we need to
introduce a new clock branch type, and also rework the rockchip clock
code to deal with multiple separate GRF regmaps.

NB: checkpatch.pl seems to trip over patch 2 in some way that seems like
a combination of the diff being too clever and at the same time too
stupid.

Patch 3 adds the devicetree schema for the SAI. Right now, we only have
a RK3576 compatible, but as I understand it, the RK3528 uses this audio
controller as well.

Patch 4 is the main course and adds the driver. It's based on the
downstream vendor driver, but substantial changes have been made in the
hopes to make it suitable for upstream inclusion.

Patch 5 and 6 are boring devicetree changes to add the nodes and use
them in the ArmSoM Sige5 board. Patch 6 goes into some schematic-derived
knowledge about where the audio signal can actually be tapped into in
order to test this.

Patch 7 enables the driver in the arm64 defconfig, as the RK3576 is
supported in mainline, so its drivers should be enabled in the
defconfig.

To test this on the Sige5, I both soldered to the output 2 testpads, as
well as fashioned a cable to plug into the headphone header. I should
have some stuff arriving by mid-March to make more such cables, so if
you have a Sige5 and want to test this but don't happen to sit on a pile
of 03SUR-32S cables, then you may contact me off-list to request I send
you such a cable from Switzerland, and I'll see what I can do.

HDMI audio isn't enabled in this series yet, but I'll look into it
either for a v2 or in a follow-up series. I really wanted to get this
out to be reviewed now, as there's a substantial amount of code to look
at that is ready for both review and testing.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
Nicolas Frattaroli (7):
      dt-bindings: clock: rk3576: add IOC gated clocks
      clk: rockchip: add support for GRF gated clocks
      ASoC: dt-bindings: add schema for rockchip SAI controllers
      ASoC: rockchip: add Serial Audio Interface (SAI) driver
      arm64: dts: rockchip: Add RK3576 SAI nodes
      arm64: dts: rockchip: Add analog audio on RK3576 Sige5
      arm64: defconfig: Enable Rockchip SAI

 .../devicetree/bindings/sound/rockchip,sai.yaml    |  151 ++
 MAINTAINERS                                        |    7 +
 .../boot/dts/rockchip/rk3576-armsom-sige5.dts      |   56 +
 arch/arm64/boot/dts/rockchip/rk3576.dtsi           |  194 +++
 arch/arm64/configs/defconfig                       |    1 +
 drivers/clk/rockchip/Makefile                      |    1 +
 drivers/clk/rockchip/clk-rk3328.c                  |    6 +-
 drivers/clk/rockchip/clk-rk3568.c                  |    2 +-
 drivers/clk/rockchip/clk-rk3576.c                  |   59 +-
 drivers/clk/rockchip/clk.c                         |   24 +-
 drivers/clk/rockchip/clk.h                         |   49 +-
 drivers/clk/rockchip/gate-grf.c                    |  105 ++
 include/dt-bindings/clock/rockchip,rk3576-cru.h    |   10 +
 sound/soc/rockchip/Kconfig                         |    8 +
 sound/soc/rockchip/Makefile                        |    2 +
 sound/soc/rockchip/rockchip_sai.c                  | 1623 ++++++++++++++++++++
 sound/soc/rockchip/rockchip_sai.h                  |  251 +++
 17 files changed, 2533 insertions(+), 16 deletions(-)
---
base-commit: a03be51d680391ba113e2e22b38743c276b6e2fa
change-id: 20250305-rk3576-sai-c78e0430898e

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


