Return-Path: <linux-kernel+bounces-442054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2F29ED765
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C599418839D7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A57211A0E;
	Wed, 11 Dec 2024 20:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="jAc4zyL4"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C75C209695;
	Wed, 11 Dec 2024 20:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733949665; cv=none; b=fRJ/IMh4YQ5XT6gBvM2UeqxNVQAoJ0fsBeqnYfvI74lzX5g1lF0VjS8d7aadS0BSexZlC27Ka/NB2KKPQ4eU1FlPMpmyssvnvr0xZxMuZmcOLcN60nDBMcs5W8kdWKpdy+2TekH3Lwg82AZNI7fSOWqfK+vBSS5CgTMaOKiqUHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733949665; c=relaxed/simple;
	bh=tYZU+K0uzwr+EtSHqAvINqlV6dTSsope7yHk2ChjW1s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c83OklTdTDV7IlKNAXI7/4PsFnd0xoeQNXr+lXOezSh4PtBA/b0x2q7JsroUjE569hgVGYaEP3sYUEbatyTbfOnOq7LcBJ7cgzcl265/1h0deoEHDaV9wtvc3eXQLDbuSWcjS8oUxQbedEY6pjuqwErqdoxC0oXOFLydjdx65nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=jAc4zyL4; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1733949659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vUZouHY51dv6HhTZgqqmU/lpMVbWxcnkaVUPPMXUAZE=;
	b=jAc4zyL4AS+0IZUZUCfQT5892wMBNOB7of3Yw0n+Fwb3yT3HYETJNSCzHAwl1Ec9XVvYNx
	U6TdHs4Ev2HbQL7vZUkxLuq2IGqRvbZ8MdLYhmdQEOeTF9G4Fa11bLkKyLGc5lndcVYaP3
	ouEI7hZUp7wBpU4utxaPigCjquCxzpVXbJzPT/k6pGBEUsr1fADPteBsGFbup2WMUVhSjS
	xKUq7j3yi0bvEFuXtuKgv+8sxKM3mnhwGe9ogPw3H7858COKxngjqsedRiFDmr4/TMdQeK
	hOWn/d9msKePGM1IC7gHTXUlygs50diCV5wzRcuXToYD9vvaIO8sREMK3YavTg==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH v2] arm64: dts: rockchip: Delete redundant RK3328 GMAC stability fixes
Date: Wed, 11 Dec 2024 21:40:52 +0100
Message-Id: <fe05ecccc9fe27a678ad3e700ea022429f659724.1733943615.git.dsimic@manjaro.org>
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
"snps,rxpbl", "snps,aal" and "snps,force_thresh_dma_mode" properties, [1][2]
out of which the last two also induce performance penalties, so let's delete
these properties from the relevant RK3328-based board dts(i) files.

This commit completes the removal of these redundant "snps,*" DT properties
that was started by a patch from Peter Geis. [3]

[1] https://lore.kernel.org/linux-rockchip/CAMdYzYpj3d7Rq0O0QjV4r6HEf_e07R0QAhPT2NheZdQV3TnQ6g@mail.gmail.com/
[2] https://lore.kernel.org/linux-rockchip/CAMdYzYpnx=pHJ+oqshgfZFp=Mfqp3TcMmEForqJ+s9KuhkgnqA@mail.gmail.com/
[3] https://lore.kernel.org/linux-rockchip/20241210013010.81257-7-pgwipeout@gmail.com/

Cc: Peter Geis <pgwipeout@gmail.com>
Acked-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    Changes in v2:
      - Added "snps,force_thresh_dma_mode" to the set of redundant properties
        deleted from RK3328 board dts(i) files, as suggested by Peter, [2] and
        updated the patch description to reflect the set extension
      - Collected Acked-by tag from Peter [2]
    
    Link to v1: https://lore.kernel.org/linux-rockchip/e00f08d2351e82d6acd56271a68c7ed05b3362e8.1733901896.git.dsimic@manjaro.org/T/#u

 arch/arm64/boot/dts/rockchip/rk3328-a1.dts                | 1 -
 arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2.dtsi        | 1 -
 arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi | 1 -
 arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts         | 3 ---
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts            | 1 -
 5 files changed, 7 deletions(-)

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
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 90fef766f3ae..2ed602d44ec8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -144,7 +144,6 @@ &gmac2io {
 	phy-mode = "rgmii";
 	pinctrl-names = "default";
 	pinctrl-0 = <&rgmiim1_pins>;
-	snps,force_thresh_dma_mode;
 	snps,reset-gpio = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 50000>;

