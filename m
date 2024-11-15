Return-Path: <linux-kernel+bounces-411247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07F69CF52D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5621DB35729
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CB31E5021;
	Fri, 15 Nov 2024 19:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBDt5/c9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2062A1E285D;
	Fri, 15 Nov 2024 19:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731699540; cv=none; b=NAmO4hoDq7NkzZ0yij/3+WPsVNf7ASBA3cIkCOHbdcnwB5mbOTy0JLjgcEZCS5I3I64/OUvLkFhxRx0n854crId+/XcU/fvPcbEq779NMv0Xb8ueKgI+WejKkc2kyveqvf+aPtwJCUn/IpC3SPoiHCfpmHfaCnbQOen3rCnnnnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731699540; c=relaxed/simple;
	bh=LP0u3QqCbmQC1vap+Z+0ND0Z2RGUjbmmF6GaJXzgnOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J1fS6wpczjS5CWtZUtldL/bMYMFD3QSU13EiJpGPeiYk3ujRGybpEsUNeOY8+S8obWZiAY0omzZ+0N0lSsdLsyNHdPFAuosEBOaKhSp1G7/eS4LsvCX5lHIZEFr31yQVR2VdWOP5hJDlUZ1APyZtqRoxjSQTtmgRhCTJiiCaocM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBDt5/c9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F34AC4CECF;
	Fri, 15 Nov 2024 19:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731699539;
	bh=LP0u3QqCbmQC1vap+Z+0ND0Z2RGUjbmmF6GaJXzgnOE=;
	h=From:To:Cc:Subject:Date:From;
	b=bBDt5/c96q0G7FjXYGwQaRDfNE5SP7ZBj4URNMEb83NofF1jiB02MtyKktH8Bm0zB
	 SHjnRd364PVSjBDYVCwhUysALvQYtXQWWr7HC7Zgv5zO8W19GdPlqpX4n/9d3Kfa7t
	 zJS6p6hZWECyQosIYu2rMREXTqV3aOZQLA0g09kmr3jlOeoywwYWgNEwSKL7eMMHp+
	 UU+XO7eX10G2URWnHtlaZCu/PXe+7wCUnhehaIxOh/cqz+VlgsBzDgqapcEbRZrbKI
	 HRuK7M3ilHFYuOus3WTdKqMBWrRALaAiu0HCjSanvB2fmrvC0wMLon5eB/yeprecvI
	 rRUl0BWaTlNJw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: broadcom: Remove unused and undocumented properties
Date: Fri, 15 Nov 2024 13:38:53 -0600
Message-ID: <20241115193854.3624123-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove properties which are both unused in the kernel and undocumented.
Most likely they are leftovers from downstream.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts | 2 --
 arch/arm64/boot/dts/broadcom/northstar2/ns2-xmc.dts | 1 -
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi    | 2 --
 3 files changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts
index f43cfe66b6af..5939d342aec7 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts
@@ -137,7 +137,6 @@ at25@0 {
 		spi-cpha;
 		spi-cpol;
 		pl022,interface = <0>;
-		pl022,slave-tx-disable = <0>;
 		pl022,com-mode = <0>;
 		pl022,rx-level-trig = <1>;
 		pl022,tx-level-trig = <1>;
@@ -200,7 +199,6 @@ nand_sel: nand_sel {
 };
 
 &qspi {
-	bspi-sel = <0>;
 	flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2-xmc.dts b/arch/arm64/boot/dts/broadcom/northstar2/ns2-xmc.dts
index c50df1d02797..0e134a94e142 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2-xmc.dts
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2-xmc.dts
@@ -151,7 +151,6 @@ flash: flash@0 {
 		#size-cells = <1>;
 		compatible = "m25p80";
 		spi-max-frequency = <62500000>;
-		m25p,default-addr-width = <3>;
 		reg = <0x0 0x0>;
 
 		partition@0 {
diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
index cfd9fd23a1c2..5a4b81faff20 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
@@ -134,7 +134,6 @@ pcie0: pcie@20020000 {
 		brcm,pcie-ob;
 		brcm,pcie-ob-oarr-size;
 		brcm,pcie-ob-axi-offset = <0x00000000>;
-		brcm,pcie-ob-window-size = <256>;
 
 		status = "disabled";
 
@@ -165,7 +164,6 @@ pcie4: pcie@50020000 {
 		brcm,pcie-ob;
 		brcm,pcie-ob-oarr-size;
 		brcm,pcie-ob-axi-offset = <0x30000000>;
-		brcm,pcie-ob-window-size = <256>;
 
 		status = "disabled";
 
-- 
2.45.2


