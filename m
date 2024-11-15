Return-Path: <linux-kernel+bounces-411260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313F69CF548
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E95BD2824DD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D341E1C11;
	Fri, 15 Nov 2024 19:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kM0CWeIM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8ED1D54E1;
	Fri, 15 Nov 2024 19:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731700306; cv=none; b=WVRMwhVbzHOxITJ4YkMcp6rDw2hxYPPCIoGPIqQnWz1BBRAbdrV/WRiIQ/plM7SDJtQul99DJe96WHQZBnFWv577bt2se86ozGyEv9OFX0Fb77pFjblovWP9E1GVLQm4gVcIfX1/iUKSMb1sw5pzg3oqI8Bz6yZKlNyiMYvj7es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731700306; c=relaxed/simple;
	bh=e8LT/AOosJE1s+TaGvF+vfwCSygOro0BM++afUbz9Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rW5M5M4PCk+5mChaoaQklPy46Ja3mTu6XOrDlfjvzhufn1b3//nSKmWh+fPl2EIKI7hmPHlRIPdEQ2anfhXbT1lXPrnOyHhvJ3tPB3RhsGUag3M2wPvWIJIBwNMC2YztqLr9V1ZgO6AEfbMKM+qHDcPWEbVBfTA5tRlxZdxdtVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kM0CWeIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE41FC4CECF;
	Fri, 15 Nov 2024 19:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731700306;
	bh=e8LT/AOosJE1s+TaGvF+vfwCSygOro0BM++afUbz9Yw=;
	h=From:To:Cc:Subject:Date:From;
	b=kM0CWeIMyWAwhB/2KIJxJtAIXBIQhqECMZ6A55SL1qgpFMu7+dof0lHfwCmW09fag
	 riSj0GO8PpbyI3IhjaOX4il0R+hmOUj/UHgcvK148NNo6WRCyQFXqu0a3kGKQ0r2P0
	 soO2hmDrSOkcf7FQe/iTueU2XivEQXlkt4QnTYbqRLlMwvNVXDh3eprmepwSw/QpKn
	 Rjjd0AGyB33mAS6H1EzUMZzFkQSNKIvW/KLmnz07XwVXD6CEyp8z2H7b0VlUE13SL2
	 aQAwdeUNoVnCDgroR0yQHjp9MWYPS6Ma5XsiHIkMsUFml9hSeLn2fevaRXVWHs+AWG
	 kG2MPaEyHn0GA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: soc@kernel.org,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] arm64: dts: apm: Remove unused and undocumented "bus_num" property
Date: Fri, 15 Nov 2024 13:50:49 -0600
Message-ID: <20241115195049.3637454-2-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove "bus_num" property which is both unused in the kernel and
undocumented. Most likely they are leftovers from downstream.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
SoC Maintainers, please take directly.

 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi | 2 --
 arch/arm64/boot/dts/apm/apm-storm.dtsi     | 1 -
 2 files changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
index ea5721ea02f0..5a64239b4708 100644
--- a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
@@ -809,7 +809,6 @@ i2c1: i2c@10511000 {
 			interrupts = <0 0x45 0x4>;
 			#clock-cells = <1>;
 			clocks = <&sbapbclk 0>;
-			bus_num = <1>;
 		};
 
 		i2c4: i2c@10640000 {
@@ -819,7 +818,6 @@ i2c4: i2c@10640000 {
 			reg = <0x0 0x10640000 0x0 0x1000>;
 			interrupts = <0 0x3a 0x4>;
 			clocks = <&i2c4clk 0>;
-			bus_num = <4>;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index 6ad4703925dc..872093b05ce1 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -851,7 +851,6 @@ i2c0: i2c@10512000 {
 			interrupts = <0 0x44 0x4>;
 			#clock-cells = <1>;
 			clocks = <&ahbclk 0>;
-			bus_num = <0>;
 		};
 
 		phy1: phy@1f21a000 {
-- 
2.45.2


