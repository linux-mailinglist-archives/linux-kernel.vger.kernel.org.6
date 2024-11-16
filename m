Return-Path: <linux-kernel+bounces-411615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4059CFCE3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 07:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99BC1F22822
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 06:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5013C191F6A;
	Sat, 16 Nov 2024 06:20:02 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D9A15381A;
	Sat, 16 Nov 2024 06:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731738001; cv=none; b=tXfhq4WdZpk1D1Snoy3mJ7u5xrFBmNw2XU/6bpDLfhlL8a0eLg/LY0T9dVm3AUANGhJ5boBHTOvrXplbcD3lFvPfVRnMh5ot1BEH5GM4OyhiepNO9MM9TAefnNbmLCmf0tNCq/+0zp8Kx+OJZTB7GXW2JQR2CO0ZmmhfeJE6mQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731738001; c=relaxed/simple;
	bh=5qZX/irv7vROqZzDFB92unCNlQhsQh8iql2m46HhDGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJje4TOqnQX8tnk6X+ymfFmIyavFjXdFgD8c5iyGT+qPDst204J/tkUX6FBM0mVGgE7fVkcRY/t7hacFK0CPVwx79invM4fDfJf9ngXRply+NYe8dbVSjXyWwMqXUflHCsEdAAiTv93IO/z3VLOLZucAORjEaYOMmP2RdVwnk6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan. (unknown [IPv6:2605:59c8:31de:bf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 5BFBAB4B0E06;
	Sat, 16 Nov 2024 07:19:55 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: E Shattow <e@freeshell.de>,
	Conor Dooley <conor@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] riscv: dts: starfive: jh7110-milkv-mars: enable usb0 host function
Date: Fri, 15 Nov 2024 22:17:09 -0800
Message-ID: <20241116061719.36409-4-e@freeshell.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241116061719.36409-2-e@freeshell.de>
References: <20241116061719.36409-2-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set host mode and vbus pin for JH7110 on-chip USB 2.0

Signed-off-by: E Shattow <e@freeshell.de>
---
 .../boot/dts/starfive/jh7110-milkv-mars.dts    | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
index 0d248b671d4b..3bd62ab78523 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
@@ -53,7 +53,23 @@ &spi0 {
 	status = "okay";
 };
 
+&sysgpio {
+	usb0_pins: usb0-0 {
+		vbus-pins {
+			pinmux = <GPIOMUX(25, GPOUT_SYS_USB_DRIVE_VBUS,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-disable;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+};
+
 &usb0 {
-	dr_mode = "peripheral";
+	dr_mode = "host";
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_pins>;
 	status = "okay";
 };
-- 
2.45.2


