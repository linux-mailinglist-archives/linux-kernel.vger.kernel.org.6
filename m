Return-Path: <linux-kernel+bounces-440865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8A59EC598
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AB76188A135
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 07:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD87B1D8A0B;
	Wed, 11 Dec 2024 07:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="rG4dnS5y"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E74E1D7E4F;
	Wed, 11 Dec 2024 07:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733902183; cv=none; b=VM732ViiZv89GsDJhScIk9QlCZtA7XZPCjADKLcPgM6ejhpgv+hYY1Pz2/IABFWO1AfaHPje2VgYB2nPOA/ICgabRK6fX3rhN4Uss9vbE0kDMFkkgVhYvRvtELrBPFzIWer0Xj1/t7OGi/lJPbudzaeOnUINm2fPILzKNlanEyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733902183; c=relaxed/simple;
	bh=60Gl75FbOb7f1sqLyRSsP32t2VD/75Ekq7eLr8Pt1aY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rHXcjOgIFeC/EHqqX35fMVO59jDFp0OClGGYydeAEOZPmstnTlLwDE76ZRTJ/i3FhPdlYBLq9ZmFvv9oEnFLsmhlNj0YmERAQUN/Duu+PCVQRbTSUV9ZTSzYNx4IC2Nwso+ypV49F90o71RQ+kxLlgzlWr/CMiEbev1mI8WRSdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=rG4dnS5y; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1733902179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hSvPaPYTDrhaxeXHOjgIwmnYGfYQBlYwxY0RwWwuTDc=;
	b=rG4dnS5y6JnYoM1DAPyUi8dQvdMTe4IKS8rR8evqzGQHVFSLrYV8R2cuG4NLsht7d//3sm
	nSxum/OIHO7IS/2w7w2xwLr/jk0b/CBI9XUfszoDHQAV0vQM+t5fqw9yLB8ArUgHcwwlSH
	6pSncdl6KmtufzEsEIODza0Q++MRWr/MXivVowlvAXnwH9N7AlgERmokJR/rTdEctr06wp
	WQUaGzWo4bVgHuUic/iO1exwpUvlgkwBVRRD3TcOAcJxYnQrmiRi07QTum0mezA1Pqajik
	McBCzIm9e+9r3C32AcsgdRvVkBOFWzlOWr2QEPezozMRXlimU3leYjMHT34fhw==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH] arm64: dts: rockchip: Delete redundant RK3328 GMAC stability fixes
Date: Wed, 11 Dec 2024 08:29:32 +0100
Message-Id: <e00f08d2351e82d6acd56271a68c7ed05b3362e8.1733901896.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Since the commit 8a469ee35606 ("arm64: dts: rockchip: Add txpbl node for
RK3399/RK3328"), having "snps,txpbl" properties defined as Ethernet stability
fixes in RK3328-based board dts(i) files is redundant, because that commit
added the required fix to the RK3328 SoC dtsi, so let's delete them.

It has been determined that the Ethernet stability fixes no longer require
the "snps,rxpbl" and "snps,aal" properties, [1] out of which the latter also
induces performance penalties, so let's delete these properties from the
relevant RK3328-based board dts(i) files.

This commit completes the removal of these redundant "snps,*" properties
that was started by a patch from Peter Geis. [2]

[1] https://lore.kernel.org/linux-rockchip/CAMdYzYpj3d7Rq0O0QjV4r6HEf_e07R0QAhPT2NheZdQV3TnQ6g@mail.gmail.com/
[2] https://lore.kernel.org/linux-rockchip/20241210013010.81257-7-pgwipeout@gmail.com/

Cc: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3328-a1.dts                | 1 -
 arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2.dtsi        | 1 -
 arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi | 1 -
 arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts         | 3 ---
 4 files changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-a1.dts b/arch/arm64/boot/dts/rockchip/rk3328-a1.dts
index 824183e515da..24baaa7f1d8c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-a1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-a1.dts
@@ -110,7 +110,6 @@ &gmac2io {
 	phy-supply = <&vcc_io>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&rgmiim1_pins>;
-	snps,aal;
 	snps,pbl = <0x4>;
 	tx_delay = <0x26>;
 	rx_delay = <0x11>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2.dtsi b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2.dtsi
index f9fab35aed23..d5f129e304e5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2.dtsi
@@ -142,7 +142,6 @@ &gmac2io {
 	phy-supply = <&vcc_io_33>;
 	pinctrl-0 = <&rgmiim1_pins>;
 	pinctrl-names = "default";
-	snps,aal;
 
 	mdio {
 		compatible = "snps,dwmac-mdio";
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
index 181ec6de0019..9ec93f61433e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
@@ -113,7 +113,6 @@ &gmac2io {
 	phy-supply = <&vcc_io>;
 	pinctrl-0 = <&rgmiim1_pins>;
 	pinctrl-names = "default";
-	snps,aal;
 
 	mdio {
 		compatible = "snps,dwmac-mdio";
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
index 3e08e2fd0a78..59dead1cc503 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
@@ -153,9 +153,6 @@ &gmac2io {
 	phy-supply = <&vcc_io>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&rgmiim1_pins>;
-	snps,aal;
-	snps,rxpbl = <0x4>;
-	snps,txpbl = <0x4>;
 	tx_delay = <0x26>;
 	rx_delay = <0x11>;
 	status = "okay";

