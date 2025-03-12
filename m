Return-Path: <linux-kernel+bounces-557543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A315A5DAA1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A1E87A562B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89A123E33F;
	Wed, 12 Mar 2025 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EVl0hhQo"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB59235C16;
	Wed, 12 Mar 2025 10:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741776183; cv=none; b=e4lZ0IhjvsNtJOPkDObKtcVoKUzTfZPcW7D8zsBJ+YF++D0Omo1lEP0TkA5INHlF4Nf2VNFWkKxoSMPOBds9FtFmygQmL/9TFXqN8BJcpLYFKaNYZ8PCzb+q3ZrAPncSMydHUGLh9l3/LlIXzKuU+IXNlTQZgT8SZeMJ1HiLWSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741776183; c=relaxed/simple;
	bh=/H3FDkxshC1fxhhthfXIOoYE9auOzHFWyBl+0JT72Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VnpGigzZWtNajNFtu4aPOTS7s3dtRZ2YX2jm6GacXDaTVRXhQT0vbByq6LGS5EmHfcRSiMB9wimPKdxyhsjgloUhtKrZfPdEyPEudXimJZ3o1YCTW/3h+PKp4ffeBTAeTwmtzi6kf2sbS1gnd1sT679Hu8Ya9NRUC5zuUvsyB2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EVl0hhQo; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=Qjp9r
	M3rKs/6Qv8yCCbCK02pbv+0ERB6DYIOcn1yZ+g=; b=EVl0hhQob5D0oBE/6q6w6
	YyTwuavGUrDXHrWJ5DDv5zMDKpxESLhLuRuhMP0tTnzVx5pwB2bnfYv0FU0dc2cu
	5yAa84LANa+KvJRbaFYOEmeL+TfMO1bbjlRTlM5/LKTIipaaSqrrXg3Fy8CMoZIa
	jvU2YGkDsshJssvMCmLH34=
Received: from ProDesk.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgAHUvcHZdFnEN_+Kg--.14177S6;
	Wed, 12 Mar 2025 18:42:25 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	mripard@kernel.org,
	cristian.ciocaltea@collabora.com,
	neil.armstrong@linaro.org,
	yubing.zhang@rock-chips.com,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	lumag@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org,
	sebastian.reichel@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v2 4/7] arm64: dts: rockchip: Add DP0 for rk3588
Date: Wed, 12 Mar 2025 18:42:05 +0800
Message-ID: <20250312104214.525242-5-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312104214.525242-1-andyshrk@163.com>
References: <20250312104214.525242-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgAHUvcHZdFnEN_+Kg--.14177S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFyxJryUuw45Cr4rKr1fXrb_yoW8Xw45p3
	ZrCrZ3Xry8uF42q39xKr1ktrZ0yan5CFZ3Krn7Gryjkr1Sqr9FkryfKrnxA34DXr47XwsF
	vFs3try0kF4qyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07URHqxUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqBkOXmfRYalQgwAAsM

From: Andy Yan <andy.yan@rock-chips.com>

The DP0 is compliant with the DisplayPort Specification
Version 1.4, and share the USBDP combo PHY0 with USB 3.1
HOST0 controller.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

(no changes since v1)

 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index 000b119d50f4..675aebe4e8ff 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -1371,6 +1371,36 @@ i2s9_8ch: i2s@fddfc000 {
 		status = "disabled";
 	};
 
+	dp0: dp@fde50000 {
+		compatible = "rockchip,rk3588-dp";
+		reg = <0x0 0xfde50000 0x0 0x4000>;
+		interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru PCLK_DP0>, <&cru CLK_AUX16M_0>,
+			 <&cru CLK_DP0>, <&cru MCLK_I2S4_8CH_TX>,
+			 <&cru MCLK_SPDIF2_DP0>;
+		clock-names = "apb", "aux", "hdcp", "i2s", "spdif";
+		assigned-clocks = <&cru CLK_AUX16M_0>;
+		assigned-clock-rates = <16000000>;
+		resets = <&cru SRST_DP0>;
+		phys = <&usbdp_phy0 PHY_TYPE_DP>;
+		power-domains = <&power RK3588_PD_VO0>;
+		#sound-dai-cells = <0>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			dp0_in: port@0 {
+				reg = <0>;
+			};
+
+			dp0_out: port@1 {
+				reg = <1>;
+			};
+		};
+	};
+
 	hdmi0: hdmi@fde80000 {
 		compatible = "rockchip,rk3588-dw-hdmi-qp";
 		reg = <0x0 0xfde80000 0x0 0x20000>;
-- 
2.34.1


