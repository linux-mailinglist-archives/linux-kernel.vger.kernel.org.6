Return-Path: <linux-kernel+bounces-278271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF9394AE21
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8282844E7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700D513C697;
	Wed,  7 Aug 2024 16:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flokli.de header.i=@flokli.de header.b="QnRpCDis"
Received: from mail.flokli.de (mail.flokli.de [116.203.226.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A41C13C676;
	Wed,  7 Aug 2024 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.226.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723048008; cv=none; b=hcgfSci3r59hdrzoU6ppnqlIv6pf0eyW0Zqlhfx28S5+/af9mGiiB/zIwSd131F1xdc/76jYTFZuzBzqLIet5ry/BQ4O0KMuXPkL/QY4lOckG0ddpMScldKbFw1MIiZP1tH/6IE1HPtjnSqbSl4A4kR0qVgSqXPoEQuwQRhL9OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723048008; c=relaxed/simple;
	bh=nRl6NFtv5qCjJ3bS1qt9Kk/vd3/H6TnGKCO7mHKrAg8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=afQfzBDQAFu/8KcAxSL/TV8RgwZgFxNyK6aIf0qkVKaStmZFebstNOeQ5eS3rlV7lsy+4jaRPhtEm1HxtktwYOtJzWncpCM0/cAt9kKJgMtp+JqazhkSMiMhSIOjfDwPU8GUipJsgu818HPrlc6MCGsF37rO6rr9RmE8rVL34CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flokli.de; spf=pass smtp.mailfrom=flokli.de; dkim=pass (1024-bit key) header.d=flokli.de header.i=@flokli.de header.b=QnRpCDis; arc=none smtp.client-ip=116.203.226.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flokli.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flokli.de
From: Florian Klink <flokli@flokli.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flokli.de; s=mail;
	t=1723047609; bh=xzTHPU4ay+ojdbSyqF8Os8imRNbH54y0xGyqIDsp8TI=;
	h=From:To:Subject:Date;
	b=QnRpCDisb3Xljb/+6HX+YkFlvqGPXsLih7lMAmZPSgaasfWfoyu17PsMb2e+DiOJg
	 Rs94BZfEa1ebxQys2TaZyGHDUC5bKO7JQTpEIyNN1MVbsqmha2kuODdpbkCPUNemfX
	 52KZLRa0eB2XxhBOpagIccyxGhe0mRNHtTJPZ9zE=
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
Subject: [PATCH] arm64: dts: rockchip: add rfkill node for M.2 E wifi on orangepi-5-plus
Date: Wed,  7 Aug 2024 19:20:01 +0300
Message-ID: <20240807162001.1737829-1-flokli@flokli.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This follows the same logic as 82d40b141a4c7ab66, which did the same
for rock-5b.

The GPIO pin connecting the WiFi enable signal inside the M.2 Key E slot
is the same as there.

This can be validated in
arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dtsi from Armbian
rk-5.10-rkr4 kernel, which contains a `wifi_disable` node with that same
GPIO pin.

Signed-off-by: Florian Klink <flokli@flokli.de>
Tested-by: Florian Klink <flokli@flokli.de>
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


