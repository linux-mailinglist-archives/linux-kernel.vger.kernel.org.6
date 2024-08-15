Return-Path: <linux-kernel+bounces-288046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5727695322C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 899371C26303
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3BB1A76CC;
	Thu, 15 Aug 2024 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmLZ0Gty"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F3F1A2570;
	Thu, 15 Aug 2024 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730514; cv=none; b=YVdvKVaJeavAVg2kolSDPg52rT3VCaumizbxa81mzvRqDym4YqwG5ct3GDUnUN7nnAn0uBeaUKZ8vpQPtY6D7DbOVBq8mYTbacyw8TOHXszADMLgFfKBF4RyEeLWY2N+bviY0AmqC1BYhmJpt9KKmdwpz1FtYI2PUisTX3u31b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730514; c=relaxed/simple;
	bh=fB0OEDblSTWS+1OrourHNKnerO8x2dGxroXG5xI23Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UANg+Ge49t9MRIj5gmfWyeE9OeFogmHQ45gv/awTSo/ceH/Cv1ICxDKS/lf567ySgLsU6te6xceIp1TXoafMMCSunIvW2N6HMEyb3mPstDueZ0Hp+muH2eF7CyLWivW5LUHJzD4v8duXZIzzDu9BVL6aEWYcYi6PoHuibReKwIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmLZ0Gty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC8CC4AF10;
	Thu, 15 Aug 2024 14:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723730514;
	bh=fB0OEDblSTWS+1OrourHNKnerO8x2dGxroXG5xI23Dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HmLZ0GtyIiHLqOxO+mvyT3OvArzfvvHah1TCLxY8BH5Lguv+jt3PuosVz5j61u3mb
	 bgphO5bXoGm8ZhLzcyhXKkH682lQ2Rb0trYFPHnhK07izglKbxvvPrrZvJVgSW97+3
	 tYOu8xeHQ9NA2Sw977W0GXNvJ4vww19WJdvm/G2rxz9Ix8ikuw12eROXCWPYh9gM6H
	 UN1P0SiMs8IGFUJOzRCKz6dhJRf/N8jkn5+EPLl4pkA0cu3eKGCv1aPSGPGo8qKv+a
	 bxLbfs+OYj5CFyxKoVH2lYhN4X25r1EkKDSNqudv+hxKQmHYPRPY0Sim30LuLgowG2
	 tGA3tb+v6G55Q==
From: Conor Dooley <conor@kernel.org>
To: devicetree@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 04/11] riscv: dts: microchip: fix mailbox description (TODO drop 3rd syscon from here)
Date: Thu, 15 Aug 2024 15:01:07 +0100
Message-ID: <20240815-skydiver-generous-c1ab980d6300@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240815-shindig-bunny-fd42792d638a@spud>
References: <20240815-shindig-bunny-fd42792d638a@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2524; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=aJBHo+ioF9aGJ0SgdGbkuMDmZeNae1T9gy8tsO62fD8=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGn7uHT+cJzoEW3l81sS8mSh+0T/VczfWF9O+Oqy4hzfv 4luwQrmHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZiI8xqGf4Ymkzfta7seL8Cn WXjzR9JsFy6XZza7az7Eq4Wf7XiyR42R4XhlRVT/l9joVfu65R9ffvJYc8FqrVPu0t0/tu6ayur ZwwEA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

When the binding for the mailbox on PolarFire SoC was originally
written, and later modified, mistakes were made - and the precise
nature of the later modification should have been a giveaway, but alas
I was naive at the time.

A more correct modelling of the hardware is to use two syscons and have
a single reg entry for the mailbox, containing the mailbox region. The
two syscons contain the general control/status registers for the mailbox
and the interrupt related registers respectively. The reason for two
syscons is that the same mailbox is present on the non-SoC version of
the FPGA, which has no interrupt controller, and the shared part of the
rtl was unchanged between devices.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/mpfs.dtsi | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs.dtsi b/arch/riscv/boot/dts/microchip/mpfs.dtsi
index 9883ca3554c5..1d655126b66f 100644
--- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
@@ -251,6 +251,11 @@ pdma: dma-controller@3000000 {
 			#dma-cells = <1>;
 		};
 
+		mss_top_scb: syscon@20002000 {
+			compatible = "microchip,mpfs-mss-top-sysreg", "syscon", "simple-mfd";
+			reg = <0x0 0x20002000 0x0 0x1000>;
+		};
+
 		clkcfg: clkcfg@20002000 {
 			compatible = "microchip,mpfs-clkcfg";
 			reg = <0x0 0x20002000 0x0 0x1000>, <0x0 0x3E001000 0x0 0x1000>;
@@ -259,6 +264,11 @@ clkcfg: clkcfg@20002000 {
 			#reset-cells = <1>;
 		};
 
+		sysreg_scb: syscon@20003000 {
+			compatible = "microchip,mpfs-sysreg-scb", "syscon";
+			reg = <0x0 0x20003000 0x0 0x1000>;
+		};
+
 		ccc_se: clock-controller@38010000 {
 			compatible = "microchip,mpfs-ccc";
 			reg = <0x0 0x38010000 0x0 0x1000>, <0x0 0x38020000 0x0 0x1000>,
@@ -521,10 +531,18 @@ usb: usb@20201000 {
 			status = "disabled";
 		};
 
-		mbox: mailbox@37020000 {
+		control_scb: syscon@37020000 {
+			compatible = "microchip,mpfs-control-scb", "syscon", "simple-mfd";
+			reg = <0x0 0x37020000 0x0 0x100>;
+
+			sensor {
+				compatible = "microchip,mpfs-tvs";
+			};
+		};
+
+		mbox: mailbox@37020800 {
 			compatible = "microchip,mpfs-mailbox";
-			reg = <0x0 0x37020000 0x0 0x58>, <0x0 0x2000318C 0x0 0x40>,
-			      <0x0 0x37020800 0x0 0x100>;
+			reg = <0x0 0x37020800 0x0 0x100>;
 			interrupt-parent = <&plic>;
 			interrupts = <96>;
 			#mbox-cells = <1>;
-- 
2.43.0


