Return-Path: <linux-kernel+bounces-413710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D3C9D1D85
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA8A2828BA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 01:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C4F2E3EB;
	Tue, 19 Nov 2024 01:45:39 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222DF22619;
	Tue, 19 Nov 2024 01:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731980739; cv=none; b=BOR8fYR5BrE0k+1eNzD8BQ/V/BCnPI9VpVG+d9t40vXYSzXjkJQ21wYQiYxSWBriL8R2B8Bd2yWXN9/qlj3OHRM2KS71/X7RVZS9ahnfo1EFgttn9NX9Q7Uorqu+Mdx0f+iwsm2rXg41XA9PdQncdBw8zvydYCGMQ7h/UZHPDOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731980739; c=relaxed/simple;
	bh=Z7+zGDMXb0dADGv/pA/z5wYKgAMyFUrogKpqewMdchk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0DdLArKqJ4BnC7dO24pN+KG+Y7obuxX65qpHVG0oTOUrl2xW4+M3OUugWeAr6+27vnrxm23U460Y1aQbKlplvWNmRPa7iFXamGPj5KRRG5rZIlKb0j2mG0pE2GDC8t356sVaekNVuLnySDBS+H6JDx1ax7YEIzAP7A2+YrU/C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan. (unknown [IPv6:2605:59c8:31de:bf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id DD0B0B4B0DAF;
	Tue, 19 Nov 2024 02:45:31 +0100 (CET)
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
Subject: [PATCH v4 1/1] riscv: dts: starfive: jh7110-milkv-mars: enable usb0 host function
Date: Mon, 18 Nov 2024 17:44:35 -0800
Message-ID: <20241119014449.49936-2-e@freeshell.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119014449.49936-1-e@freeshell.de>
References: <20241119014449.49936-1-e@freeshell.de>
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


