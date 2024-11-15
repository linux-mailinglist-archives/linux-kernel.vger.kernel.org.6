Return-Path: <linux-kernel+bounces-411231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1E69CF4F6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DBD2B30577
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026D61E201D;
	Fri, 15 Nov 2024 19:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvrqaNCp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4811E103B;
	Fri, 15 Nov 2024 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731699311; cv=none; b=aJBT64L01qDl0/QB6DX6DOWT4IpDoS6NqCtn68rXIi2INPvuwdsv2vBJdfcvf2chTlGL6jV04HoGgiBrAqzaF5StGH4shvL5UGbYXcLpuaj1OHLAfRM4f3XlJwoB1im2s5LaMAd3WaZlnnFAXeVEDHGD+4IlLvemn4VosNKfv0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731699311; c=relaxed/simple;
	bh=IxUUtQsWk3PURpycsSmzgb1xBSlDbCJ37q6nf31dtYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Faf5dirp7J70pv0jLjRJN8Qf5JcKzXc5CBomZJqddAUP2lVtIYuHdVXEsx3Z7oL+u8FWmeUo2MrTN3G+6WkVlQoIVAgioezoxV3FXkI1tPdaI1xuENtvytmyblQgqFGwlzMiUJpDPLE4JNFCnq6mcFmX0gm3HzcXSCbvzSPJTyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvrqaNCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEE9C4CECF;
	Fri, 15 Nov 2024 19:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731699310;
	bh=IxUUtQsWk3PURpycsSmzgb1xBSlDbCJ37q6nf31dtYk=;
	h=From:To:Cc:Subject:Date:From;
	b=YvrqaNCpK6PsNp0tlPJ6cpBhvBb8IfGZ8O4vbfTp43LaUKuT5UOyxwnbuDi1UMENf
	 yak0kqkudR+KSp/CIk4mVnbr+yBxQaRw/3wrmC81mTBS+cbkRSBEb/Cmz5MhhuoC4Y
	 U+bf71uyQqSz/JoMsUGcl0KeLnuIx2wwGWv7VdRzksIyWb7ResMfV2C0CRzvGZeeg4
	 uVMLibsIEZ3M/BnBl5S8Gx21s1aEC8s3a5pwdczlV6nvH4YuYkM2OQFNZ/WKdGDJVr
	 RtWwQg+ERnux8df2dlrlhlQbP9CZ6IusklRSMNa3twuuEvDVAPzIWUIBLiCwP7p1lM
	 bXNktSRkLJekg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: freescale: Remove unused and undocumented "cooling-(min|max)-state" properties
Date: Fri, 15 Nov 2024 13:35:03 -0600
Message-ID: <20241115193504.3619533-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove "cooling-(min|max)-state" properties which are both unused in the
kernel and undocumented. Most likely they are leftovers from downstream.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts   | 2 --
 arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi             | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
index d9fac647f432..1d53b529af88 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
@@ -19,8 +19,6 @@ / {
 
 	pwm-fan {
 		compatible = "pwm-fan";
-		cooling-min-state = <0>;
-		cooling-max-state = <3>;
 		#cooling-cells = <2>;
 		pwms = <&sl28cpld_pwm0 0 4000000>;
 		cooling-levels = <1 128 192 255>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
index d32a52ab00a4..aef63a4f698c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
@@ -94,8 +94,6 @@ i2c@1 {
 			fan-temperature-ctrlr@18 {
 				compatible = "ti,amc6821";
 				reg = <0x18>;
-				cooling-min-state = <0>;
-				cooling-max-state = <9>;
 				#cooling-cells = <2>;
 			};
 		};
-- 
2.45.2


