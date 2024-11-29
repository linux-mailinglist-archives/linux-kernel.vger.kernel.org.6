Return-Path: <linux-kernel+bounces-412375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5109B9D0836
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 04:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1560C2819D5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 03:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA55D7E0E4;
	Mon, 18 Nov 2024 03:48:08 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C686645BE3;
	Mon, 18 Nov 2024 03:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731901688; cv=none; b=B/qM5yGPV3q1OBpSHacHRRE0sNtGaUlyj1d34YQBY+7kGJQv1AUyrP2ic7K0WPsVeIuEsUYWPcJ9YTBR7/wcx1MREDbI3NdZUbLaLILn5rFHMmIUilZEFWG6XaaR4jZmZTtawkaZk+8j3j4mx6EINHAkbAFu0waVzYmR2ydKx0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731901688; c=relaxed/simple;
	bh=diMf6qyAZGtpRKamyqwqBZtHYf9R2FcwS4bgNZXFy9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucMs38S04wwn0A7TYTTlwM7Hq7GEKeU+BwFY2akVlLP9KSF44cbaLjJ9lG8eMBLxoD1vdwwwX3TmNGGDkfearEiF7Ot2YFAexDiSt0YeRMuLS8WX0IcVUdGhAlO6Wan4l7GZ/HUD1EAkmFis5ac+AnkPD5yGaVZCh3CGj3z3rTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan. (unknown [IPv6:2605:59c8:31de:bf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 82314B4B08E6;
	Mon, 18 Nov 2024 04:48:01 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: E Shattow <e@freeshell.de>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] riscv: dts: starfive: jh7110-milkv-mars: enable usb0 host function
Date: Sun, 17 Nov 2024 19:45:09 -0800
Message-ID: <20241118034558.43226-4-e@freeshell.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241118034558.43226-2-e@freeshell.de>
References: <20241118034558.43226-2-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Milk-V Mars set host mode and vbus pin for JH7110 on-chip USB 2.0

Signed-off-by: E Shattow <e@freeshell.de>
---
 .../boot/dts/starfive/jh7110-milkv-mars.dts   | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
index 5cb9e99e1dac..45d4f7556521 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
@@ -35,3 +35,24 @@ &phy0 {
 	rx-internal-delay-ps = <1500>;
 	tx-internal-delay-ps = <1500>;
 };
+
+&sysgpio {
+        usb0_pins: usb0-0 {
+                vbus-pins {
+                        pinmux = <GPIOMUX(25, GPOUT_SYS_USB_DRIVE_VBUS,
+                                              GPOEN_ENABLE,
+                                              GPI_NONE)>;
+                        bias-disable;
+                        input-disable;
+                        input-schmitt-disable;
+                        slew-rate = <0>;
+                };
+        };
+};
+
+&usb0 {
+        dr_mode = "host";
+        pinctrl-names = "default";
+        pinctrl-0 = <&usb0_pins>;
+        status = "okay";
+};
-- 
2.45.2


