Return-Path: <linux-kernel+bounces-279260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F71094BB0B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B73A21F25F54
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE50918A922;
	Thu,  8 Aug 2024 10:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flokli.de header.i=@flokli.de header.b="md9sUA+9"
Received: from mail.flokli.de (mail.flokli.de [116.203.226.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BCE143723;
	Thu,  8 Aug 2024 10:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.226.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723113063; cv=none; b=suDIyfshTcpSxwIh3BSr3VPGuQbhMRQ8ghagPNcWVgVoIq1OMINqr0l6ARt23hVz5fe6Fshv/RdZ7tBGZzCHDjgEqyI/yiGzM1efNkBICam8Xjn5oFnuY6XnTt3gxGZwh1yayNmQB+tkmFOC+UUREqVipUl8ru0jcukPeaOvdrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723113063; c=relaxed/simple;
	bh=XiJgQD6YSJrRRaTO7bqHls0JhDWNh89QYFfC94qvyMM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GEfCEzBqzcgkdapzPmfU5ra2KZHKgyxgqbbCe51m1sXH6PgFBY4LI1oYD2ZJBqlpfcUcga7jKqtt/sE/MnCja6F+klNuYACK31iHYJTCrE76mR9RoGlFsE0nj0FMhwrMYiAGYnkVwG7HpD/gEoC2erYq1Pd70sLx34erpo5/O3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flokli.de; spf=pass smtp.mailfrom=flokli.de; dkim=pass (1024-bit key) header.d=flokli.de header.i=@flokli.de header.b=md9sUA+9; arc=none smtp.client-ip=116.203.226.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flokli.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flokli.de
From: Florian Klink <flokli@flokli.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flokli.de; s=mail;
	t=1723113056; bh=XouRIGdjjotaC4BSAJBWtJ4WaLP4kN9KpTcsRMgKXws=;
	h=From:To:Subject:Date;
	b=md9sUA+9yyh9QQ5SPV9t4UgE/WqdAfdjxs+gA3SLEqx7i5N6NdfHMR51Ap7FzTz93
	 SDXsWanI0f186fJx4dwDzSk/9m6GGL/2zKQEiYJ4IZb9qp/mdamsrr7yHHz5n2JYES
	 tycF30XZ5ETFeHcicaTLCkvvnJuEEuN8/yh9EBDw=
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Florian Klink <flokli@flokli.de>,
	Kever Yang <kever.yang@rock-chips.com>,
	Muhammed Efe Cetin <efectn@protonmail.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	=?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@protonmail.ch>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] arm64: dts: rockchip: add rfkill node for M.2 E wifi on orangepi-5-plus
Date: Thu,  8 Aug 2024 13:30:47 +0300
Message-ID: <20240808103052.1894764-1-flokli@flokli.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This follows the same logic as 82d40b141a4c ("arm64: dts: rockchip: add
rfkill node for M.2 Key E WiFi on rock-5b").

On the orangepi-5-plus, there's also a GPIO pin connecting the WiFi
enable signal inside the M.2 Key E slot.

The exact GPIO PIN can be validated in the Armbian rk-5.10-rkr4 kernel
rk3588-orangepi-5-plus.dtsi file [1], which contains a `wifi_disable`
node referencing RK_PC4 on &gpio0.

With this change, I was able to get a "Intel Corporation Wi-Fi
6E(802.11ax) AX210/AX1675* 2x2 [Typhoon Peak] (rev 1a)" up, while
`rfkill` previously only mentioned to be hardware blocked.

[1] https://github.com/armbian/linux-rockchip/blob/9fbe23c9da24f236c6009f42d3f02c1ffb84c169/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts

Signed-off-by: Florian Klink <flokli@flokli.de>
---
 arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
index e74871491ef5..c3a6812cc93a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
@@ -105,6 +105,13 @@ led {
 		};
 	};
 
+	rfkill {
+		compatible = "rfkill-gpio";
+		label = "rfkill-pcie-wlan";
+		radio-type = "wlan";
+		shutdown-gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_HIGH>;
+	};
+
 	sound {
 		compatible = "simple-audio-card";
 		pinctrl-names = "default";
-- 
2.45.2


