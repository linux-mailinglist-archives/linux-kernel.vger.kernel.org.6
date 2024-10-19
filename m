Return-Path: <linux-kernel+bounces-372581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A86E19A4AB1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 02:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0671F226E0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 00:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B66E1922ED;
	Sat, 19 Oct 2024 00:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pU6GiByr"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF3F29CF6;
	Sat, 19 Oct 2024 00:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729298328; cv=none; b=tbq+RDhkmkrV8dLB7610YGv/GXu3yxbNsf4D8Jed8jQ0A4AhP4YfggVWD37nCKJaSYxmAuPAy1DZDt5r09ZdDDq23dgscTe5RZf79UKsJBiesxygSKoLr39f1LmPK9ShrvMfj584FWB3/MVtDxsYpZJVZljh9R9zI+GOOxPBygk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729298328; c=relaxed/simple;
	bh=lyUmwSP2Z3VUSJb/ROJNqLwP+S/dVxdakV7oW54hie4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=umoGxdOc/24BxRwlH7v0bvwCzaIyrGXmyzbGLNOcCuF7dbp/1m1b/p2dx4FoE1ftxfbVn3Sualg1Slvq/XtcSF9l1S/eMGZngSjWevUbHPkFZymUHQTjy67s1gJ3CAQTi4NUBpdqSUcAaqTFBspKrAHhfLN1CDwErfLvZc5D5KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pU6GiByr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729298324;
	bh=lyUmwSP2Z3VUSJb/ROJNqLwP+S/dVxdakV7oW54hie4=;
	h=From:Date:Subject:To:Cc:From;
	b=pU6GiByrYU3Mgtu7xjor6dsWgBnGxiocIDECQBCBTFvOQ60IVyT/MJnTYmB3p5hgm
	 Tc021m9Dof+36499ThGi1tvPbp/J0HPUcfmCTctw/i77WWR7gthNCJzCn6f6NZqemy
	 YXwNCv4W3sGMtnEEjCAMJRobie3+0iFzMtGJDBRE1dujE9K9E0vvHKMp45GFylhZpt
	 iwmeBLuzuls6FOU1hJJsXZmV4N2t25L5I2zHxSN0CaNO2ollJxqbce3iy0bwrzM+9y
	 f7pkI6W7st9TQyqyoeYB9JasIGcu+MFHuW8LvgQQ6ZXbN6z5lIk+4f4jGfmOtaYrJQ
	 L/RFyzyGBm0bw==
Received: from localhost (unknown [188.24.146.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 429C817E0F6B;
	Sat, 19 Oct 2024 02:38:44 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 19 Oct 2024 03:38:10 +0300
Subject: [PATCH] arm64: dts: rockchip: Drop invalid clock-names from es8388
 codec nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241019-es8328-dt-fixes-v1-1-ca77d5ce21ad@collabora.com>
X-B4-Tracking: v=1; b=H4sIAHH/EmcC/x3LMQqAMAxA0atIZgNtFKxeRRyqjZqlSiMiSO9uc
 Xx8/gvKSVhhqF5IfIvKEQtsXcGy+7gxSigGMtRaY3tkdQ05DBeu8rAi07wE8s74roVynYn/UKZ
 xyvkDxOWZ8GEAAAA=
X-Change-ID: 20241019-es8328-dt-fixes-e2bcd2a80a74
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

The binding for Everest ES8328/ES8388 audio CODEC doesn't support the
'clock-names' property:

  rk3588-orangepi-5-plus.dtb: audio-codec@11: 'clock-names' does not match any of the regexes: 'pinctrl-[0-9]+'
    from schema $id: http://devicetree.org/schemas/sound/everest,es8328.yaml#

Since the related audio driver is also not making use of it, drop the
invalid property from all es8388 codec nodes.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Several DT fixes involving the usage of the Everest ES8328/ES8388 audio
CODEC.
---
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts      | 1 -
 arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts  | 1 -
 arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts      | 1 -
 arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts | 1 -
 4 files changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts
index 2c41e017f4f402e9c7eea80955219ee23f2f582d..ca1d3253d3e1f4c6f272a27737b5660c099538e5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts
@@ -114,7 +114,6 @@ &i2c1 {
 	es8388: es8388@11 {
 		compatible = "everest,es8388";
 		reg = <0x11>;
-		clock-names = "mclk";
 		clocks = <&cru SCLK_I2S_8CH_OUT>;
 		#sound-dai-cells = <0>;
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
index c73fecf1c73c94944bb25e1243d5390b84241338..4cfce107be73652ba5eb2c03e3e2ca0c65ed5d50 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
@@ -328,7 +328,6 @@ es8388: audio-codec@11 {
 		compatible = "everest,es8388";
 		reg = <0x11>;
 		clocks = <&cru I2S0_8CH_MCLKOUT>;
-		clock-names = "mclk";
 		AVDD-supply = <&vcc_1v8_s0>;
 		DVDD-supply = <&vcc_1v8_s0>;
 		HPVDD-supply = <&vcc_3v3_s0>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts b/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
index 50c7a5e9af1904b87925bc526752a87deb3460a6..177e00d45b3d19e91525e62b5ce40d1079bea330 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
@@ -316,7 +316,6 @@ es8388: audio-codec@11 {
 		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
 		assigned-clock-rates = <12288000>;
 		clocks = <&cru I2S0_8CH_MCLKOUT>;
-		clock-names = "mclk";
 		AVDD-supply = <&avcc_1v8_codec_s0>;
 		DVDD-supply = <&avcc_1v8_codec_s0>;
 		HPVDD-supply = <&vcc_3v3_s0>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts b/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts
index d8c50fdcca3b57e50d70325e1d7a7efad2e314bd..8ba111d9283fefcf77093be7f74705d06f67edfa 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts
@@ -377,7 +377,6 @@ es8388: audio-codec@11 {
 		assigned-clock-rates = <12288000>;
 		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
 		AVDD-supply = <&vcc_3v3_s3>;
-		clock-names = "mclk";
 		clocks = <&cru I2S0_8CH_MCLKOUT>;
 		DVDD-supply = <&vcc_1v8_s3>;
 		HPVDD-supply = <&vcc_3v3_s3>;

---
base-commit: f2493655d2d3d5c6958ed996b043c821c23ae8d3
change-id: 20241019-es8328-dt-fixes-e2bcd2a80a74


