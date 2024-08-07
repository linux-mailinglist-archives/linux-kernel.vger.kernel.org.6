Return-Path: <linux-kernel+bounces-278311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC9994AE9E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4342FB263CF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CE77D3F5;
	Wed,  7 Aug 2024 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flokli.de header.i=@flokli.de header.b="LdfSJ7Gr"
Received: from mail.flokli.de (mail.flokli.de [116.203.226.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5B013AD32;
	Wed,  7 Aug 2024 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.226.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723050052; cv=none; b=X2hBPNnt3s3AVxJ+86VN/u6a6ITaWOkAywkFlohs8kYF/Xpn8uj6HuXFhzHHeCA8kBkJ19lJoeOvkCsIXu6Is1enJ6+bUYAWdUpQtY0mfwfXtcEQ5o3FmuaTBwGSopU1YyrVNo/WXWvjV8Glt4FTPJ8+5tWjsodryoE/jdG2uOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723050052; c=relaxed/simple;
	bh=wN+ULY68P2cEW6vX9Qaf6NJvoClPhdMM9VDWSqsqllM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUSWBOsKBXMSyXI1IrB2EN32StCVGwHYgZEbu36UCYk8O4buU72tphkFJwFp/wMsmkXfka0HYh61OBuBHwE1kg7iP9o8pkYK39NDHDuTcl9VQ0Uv0LlzB/IE1rpeiAgwOVp3tyJBQ1Ao5tbP2VYYbpogNDsTwp2YhoFTCwKP6hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flokli.de; spf=pass smtp.mailfrom=flokli.de; dkim=pass (1024-bit key) header.d=flokli.de header.i=@flokli.de header.b=LdfSJ7Gr; arc=none smtp.client-ip=116.203.226.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flokli.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flokli.de
From: Florian Klink <flokli@flokli.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flokli.de; s=mail;
	t=1723050046; bh=/RFk5++xISD2w7ZR9m6Kr5hjptqHJpE5fLiKs0wQOkY=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=LdfSJ7GrVCw9bboxPX0YrmXSKan5A1u5fU5rIVVaG78lOZTGQOlW5nIOeYcFbDnSh
	 mg/obh6f7Msy9R++3EVh/ovVRW7JkdFUZPaYTUhPlGH/gzF5oekk8rSDCy5BmzJHd1
	 2hlqWd9t6/EQYknG7OlRVl8snJx1GRpwyZQ1E2ko=
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
Subject: [PATCH v2] arm64: dts: rockchip: add rfkill node for M.2 E wifi on orangepi-5-plus
Date: Wed,  7 Aug 2024 20:00:21 +0300
Message-ID: <20240807170030.1747381-1-flokli@flokli.de>
In-Reply-To: <20240807162001.1737829-1-flokli@flokli.de>
References: <20240807162001.1737829-1-flokli@flokli.de>
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

Signed-off-by: Florian Klink <flokli@flokli.de>
Tested-by: Florian Klink <flokli@flokli.de>
Link: https://github.com/armbian/linux-rockchip/blob/9fbe23c9da24f236c6009f42d3f02c1ffb84c169/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts [1]
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


