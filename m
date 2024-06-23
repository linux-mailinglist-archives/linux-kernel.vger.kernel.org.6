Return-Path: <linux-kernel+bounces-225989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D249138C2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 09:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35250B2099E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 07:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E802B482DB;
	Sun, 23 Jun 2024 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNEZS2CQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3179E10A0C;
	Sun, 23 Jun 2024 07:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719127502; cv=none; b=amrtD0SRlkLKnv63+8BfV1BMl2CvHHXFUykqR53EFFlz0kqvphwIv24CQK5p1JHiRbrgO9kvQ29WbcXJI9W5MXugRNWaxoam9pArB70b0gYxRLIiPzU6rOZ6G67J4KHGTIismEfbOO21MVM2F9RbJI+mtW8anRwOX2rZvwE7ggc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719127502; c=relaxed/simple;
	bh=BwtYHR9K/qaXat08dSgtAq8LjtWakgkgkqSmffFvvWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b6157Nl6maWFOfRODcqlMqj9zqatTA5rPuSDMY2ws+Hc4j/QkrjYz0/b18gD/OK4AMCHMOLXLZAhZFvL3igkIZTPoCpQSMw8ZgCALXUT041YlJf/DDG0PPodWrx4j++gOhVei29eMjJNw9u+n4dI+ctKkpSx0Em0N311PVlhHaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNEZS2CQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11099C2BD10;
	Sun, 23 Jun 2024 07:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719127501;
	bh=BwtYHR9K/qaXat08dSgtAq8LjtWakgkgkqSmffFvvWI=;
	h=From:Date:Subject:To:Cc:From;
	b=DNEZS2CQX6ee1fgShn2Lb7Ay3nYjdTo+DMp91eRyYzTmKB9SAAST2KqQ6A/nUTe+X
	 Hlqu+8AfSXcngNhaAwKfEev7IO88XgHnMWbOX+z5tylDurd97br7e7bBKpjtezIOmB
	 n4rp0hB7zD8ZoYX3CmHSyKQRKxkRYemM5qonmuRSy2w+jOETQvt7O0WWq6ryeDVW3r
	 CJaNW7UT51YJKJ4zc1fPCuOaNES2CdzvhbJz7c5RwXoCpcUyaxwneyrleN7H/4inZB
	 u/BpLeo3eE9P+wPN0Wq2ztPbqEhqPe2gtBEOtr5pEZnrVCtiwQ0EPKB/1jxoF5P08r
	 VvY3X0dr3G2BA==
From: Roger Quadros <rogerq@kernel.org>
Date: Sun, 23 Jun 2024 10:24:56 +0300
Subject: [PATCH] arm: dts: k3-am642-evm-nand: Add bootph-all to NAND
 related nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240623-am642-evm-nand-bootph-v1-1-dc3af37a3322@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMfNd2YC/x3MQQqAIBBA0avErBswE6muEi00p5yFGhoRRHdPW
 r7F/w8UykwFpuaBTBcXTrGiaxtYvYk7IbtqkEIqoWWPJmglka6A0USHNqXz8Ch6qwer1tGNBLU
 9Mm18/995ed8PKpvpKGcAAAA=
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: srk@ti.com, praneeth@ti.com, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1554; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=BwtYHR9K/qaXat08dSgtAq8LjtWakgkgkqSmffFvvWI=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBmd83K31AQjJo2X8Im5rI3r3U93XfIAB0ZZSOm0
 OaT9bNTcr6JAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZnfNygAKCRDSWmvTvnYw
 k5BGD/9d0YuiqFIu/lGwDFuvUAirPmcmBc8h+uz9Qb1REEL2Ajs3xXyXJTBoNg+wUH4Ih4+ScX4
 vE69JCto3mv0Ty3qzR8VtKdbRTxZ0oPGG+ZVLNVfVDIaSMsGVdI6PaeGdltnOLNxF2Kb5R4oe5V
 7nsrkX0xQv/ITG4DAmHNPwwSA5s55ABDSqCOHPBAI5pxbu284DRBYPl2S6vK0xHRA2ylaVnQ3bF
 A+dC1pfSgIqVMoQ8dB+RtiOCNjaUmGA1TZWW+dD8hkQ0JkdLsvwEpitkWUb0U0THd3/3Tg+Mj4t
 0dJagyinQKwUkdUKb8+LVVCG2F7FEv7UHGvWu07+kLonsoDs2vN3bJBN2B4DQs/JMHhBGIkBNKs
 PwcmVr6trAYlgzbj3bR9w+fUci0xpV20yb6UPuGKtm7RFgywMnhCBWa7qlG0lrcWYqeIq9FTcoO
 BEgSjpP1J9whR2rJ+mIYqbfGbZQpLgKIyhJ1TF/Fyl+SE9ntLrKp7RjLZg/LTsvlILzpxNP4P4l
 mnSLa3ZZwIy/cbYkCO1KOq0AgW89tYqlFR41Ts0hl7pEmBV9DvVCAGCcazRXWhNNIUDFnNubjit
 ubJWAUswL+/J8p6ImGHbZ0XqVb8P7aJ2nThxA1AxAx49AJlJTqGEhO25A0i7AcszSCaNWnr1sq0
 8ptwYkwrwFjO5fA==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

NAND boot would require these nodes to be present at early stage.
Ensure that by adding "bootph-all" to relevant nodes.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso b/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso
index dc70b6fbc3d7..babd681666f4 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso
@@ -13,6 +13,7 @@
 
 &main_pmx0 {
 	gpmc0_pins_default: gpmc0-pins-default {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0094, PIN_INPUT, 7) /* (T19) GPMC0_BE1n.GPIO0_36 */
 			AM64X_IOPAD(0x003c, PIN_INPUT, 0) /* (T20) GPMC0_AD0 */
@@ -49,7 +50,9 @@ AM64X_IOPAD(0x00a4, PIN_OUTPUT, 0) /* (N17) GPMC0_DIR */
 };
 
 &main_gpio0 {
+	bootph-all;
 	gpio0-36 {
+		bootph-all;
 		gpio-hog;
 		gpios = <36 0>;
 		input;
@@ -58,10 +61,12 @@ gpio0-36 {
 };
 
 &elm0 {
+	bootph-all;
 	status = "okay";
 };
 
 &gpmc0 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&gpmc0_pins_default>;
@@ -69,6 +74,7 @@ &gpmc0 {
 	#size-cells = <1>;
 
 	nand@0,0 {
+		bootph-all;
 		compatible = "ti,am64-nand";
 		reg = <0 0 64>;		/* device IO registers */
 		interrupt-parent = <&gpmc0>;

---
base-commit: 4031a2866a9f0f5c585cfee65b3fb5ab17c95276
change-id: 20240623-am642-evm-nand-bootph-03b68b4c9d9e

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>


