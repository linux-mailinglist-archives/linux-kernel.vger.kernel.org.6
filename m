Return-Path: <linux-kernel+bounces-412379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE5E9D0845
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 05:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9529281B4B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 04:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9563013BACB;
	Mon, 18 Nov 2024 04:03:27 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D632682D66;
	Mon, 18 Nov 2024 04:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731902607; cv=none; b=dI58ZfFrytu+UZ3fKlq3J14/iiNA1JW6wAmDPQUnEfcl8ZPA5XBqmdMdnXfmW+aHCf9RAyxySnZ/BXl+bYLpbFepg08a+5UYu8TR8viD8SWHJVc2P3K9WsUvXPvmRbWdlo0Eb3QzvzWwEgE3YLuZ0zWOq0YfdHxjSQlQIgmZu4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731902607; c=relaxed/simple;
	bh=8ciB0gOfLeSI3UfIWu23aJODHF04Z8UgAlPISxne1yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GuoPM+Iwwg8uxddyU8kw2RSPpYaD+I9lYQzfanWLZRkNRk0mrD+kaLOGEQCPxbzd+z6JtcFZ/u5ATrKKtrVHWxw6bYIh7nvpE/ybhcrEoz7cEb1LCx7w8TVL/bBE+smKwlJXhTmpRj772y80nK5Ek5gRYJTKqhlFs7DG40QgFP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan. (unknown [IPv6:2605:59c8:31de:bf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 99FC3B4B1654;
	Mon, 18 Nov 2024 05:03:20 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Henry Bell <dmoo_dv@protonmail.com>
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
Subject: [PATCH 1/1] riscv: dts: starfive: jh7110-pine64-star64: enable usb0 host function
Date: Sun, 17 Nov 2024 20:02:10 -0800
Message-ID: <20241118040250.43625-2-e@freeshell.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241118040250.43625-1-e@freeshell.de>
References: <20241118040250.43625-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pine64 Star64 set host mode and vbus pin for JH7110 on-chip USB 2.0

Signed-off-by: E Shattow <e@freeshell.de>
---
 .../dts/starfive/jh7110-pine64-star64.dts     | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
index 8e39fdc73ecb..9f608d00d3d3 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
@@ -62,3 +62,24 @@ &phy1 {
 	motorcomm,tx-clk-10-inverted;
 	motorcomm,tx-clk-100-inverted;
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


