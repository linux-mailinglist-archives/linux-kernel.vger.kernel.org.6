Return-Path: <linux-kernel+bounces-550218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64121A55CAE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503373B366C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF3F1624F6;
	Fri,  7 Mar 2025 01:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMQ/lPav"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1467E157E99;
	Fri,  7 Mar 2025 01:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309686; cv=none; b=LeNgTsc3gyjLu1sHUcOB9dS/oFGoWE02KYcGXGvQ5du22iYvQ5s7P/VeRuibr2ojLmghCK1/5XJB0ReLzo+9Zx5MSUPCEo5usEpv1Xhm/W4bmQ4UYJF5oWxT/8J0d+5P//scitoXuY7DLAM48XUaeGoJvM1w+OHrRSRmSdb1bp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309686; c=relaxed/simple;
	bh=yrfMBUq/COL8QsDzDzUyUu9cmIfagRbgcrP51oY+J1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z2gZxrcIzG7nnVLxauPFt6HAMN4UsKP1eEBz31d7ZCXmsP7k4S6wzBV//0u9Yf+/pD6zbrKY9Te5HETDI4TIOZ1hzJv1HCxxwfy7f5lQEiyxxCGyeDIB/xPqe9pcrHiet3YL2LYgu1HvIDe6fS5U5wvDJcxQJuTEpDa5r2r2i5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMQ/lPav; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C991BC4CEE8;
	Fri,  7 Mar 2025 01:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741309685;
	bh=yrfMBUq/COL8QsDzDzUyUu9cmIfagRbgcrP51oY+J1o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WMQ/lPavHGoMzikOI4O4yoXURDmbs+KziHWdYAMlZiWRKxkWdD+/ciK66AroIQvNl
	 WuO2Q+jhwO/AFT6AfXIencgEhEPfHSpUKsswItZqcfW/dIRYjdemnaNqvPfp7zC7al
	 G9Fc9d9cEC8WRTQLaRrB1PqAy+PWefsMn2xtthCCBWME4pOW6DzfTmQIH6QLumhZil
	 Kv9f/yKeV0k4QqOj0jDQXpQlyB2+J1D19gwADCBItKvMtb5CqS2J8kimb2HmXgxzgU
	 hdEAswQN7sKonBOQkBwceECHHHKVCRfQGa8S8qqliEfthODpCN7kT1Cmhl6JATLQVn
	 rkKuc+8XB1hzQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 06 Mar 2025 19:07:45 -0600
Subject: [PATCH 3/4] arm64: dts: amd/seattle: Fix bus, mmc, and ethernet
 node names
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-dt-amd-fixes-v1-3-011c423ba99a@kernel.org>
References: <20250306-dt-amd-fixes-v1-0-011c423ba99a@kernel.org>
In-Reply-To: <20250306-dt-amd-fixes-v1-0-011c423ba99a@kernel.org>
To: soc@kernel.org, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 Tom Lendacky <thomas.lendacky@amd.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev

Use preferred node names for bus, mmc, and ethernet.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts | 2 +-
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi     | 2 +-
 arch/arm64/boot/dts/amd/amd-seattle-xgbe-b.dtsi  | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts b/arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts
index 7c82d90e940d..8862adae44e9 100644
--- a/arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts
+++ b/arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts
@@ -58,7 +58,7 @@ &spi0 {
 
 &spi1 {
 	status = "okay";
-	sdcard0: sdcard@0 {
+	sdcard0: mmc@0 {
 		compatible = "mmc-spi-slot";
 		reg = <0>;
 		spi-max-frequency = <20000000>;
diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
index 6a073d13478d..aa7fe884a458 100644
--- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
+++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
@@ -40,7 +40,7 @@ timer {
 			     <1 10 0xff04>;
 	};
 
-	smb0: smb {
+	smb0: bus {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
diff --git a/arch/arm64/boot/dts/amd/amd-seattle-xgbe-b.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-xgbe-b.dtsi
index 056dd3e35042..18b0c2dd1b2d 100644
--- a/arch/arm64/boot/dts/amd/amd-seattle-xgbe-b.dtsi
+++ b/arch/arm64/boot/dts/amd/amd-seattle-xgbe-b.dtsi
@@ -5,7 +5,7 @@
  * Copyright (C) 2015 Advanced Micro Devices, Inc.
  */
 
-	xgmac0: xgmac@e0700000 {
+	xgmac0: ethernet@e0700000 {
 		compatible = "amd,xgbe-seattle-v1a";
 		reg = <0 0xe0700000 0 0x80000>,
 		      <0 0xe0780000 0 0x80000>,
@@ -31,7 +31,7 @@ xgmac0: xgmac@e0700000 {
 		dma-coherent;
 	};
 
-	xgmac1: xgmac@e0900000 {
+	xgmac1: ethernet@e0900000 {
 		compatible = "amd,xgbe-seattle-v1a";
 		reg = <0 0xe0900000 0 0x80000>,
 		      <0 0xe0980000 0 0x80000>,

-- 
2.47.2


