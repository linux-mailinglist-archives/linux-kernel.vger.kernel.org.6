Return-Path: <linux-kernel+bounces-421962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4881E9D92A3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03469166E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 07:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AA719A2B0;
	Tue, 26 Nov 2024 07:39:54 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBC1194AE6;
	Tue, 26 Nov 2024 07:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732606794; cv=none; b=OVsrnnSRiGNUNvvRPOp6eOLvummvTKCA4AZAcUJZKni6+cz6nbBkXoIRmklEJTMTesyAj4ALIuG/nqlh2rA0snUof7OCcHmxxKncEI7m4X2zqZmHmbQNkxYNzjDsCibAt8tKyJA4+LHOkKZnssFs1CZGfIpSqA1F+QIq6fTIjKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732606794; c=relaxed/simple;
	bh=i0DnHgfiOxaD3VM7M7nCkry3/nTB2faZKjZOguAk5m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RN7/mqmQlK1f/tFNrtgIEbDP1UTD21e1orxVpX0Cn0QyIA45Im1GEKHIR6KgXyV9x7Je+0VXxzSXISoC8JaRax8rq1F5iNCjwNxqdZs0972dmEnzR5sLIkxXZI6l+8CIBt3Q9qDfyjxeBGFbfoJXTJJ8Sb6M59uCpJG28VfKU6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan. (unknown [IPv6:2605:59c8:31de:bf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 5E39DB2C2215;
	Tue, 26 Nov 2024 08:39:40 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Henry Bell <dmoo_dv@protonmail.com>
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
Subject: [PATCH v3 1/1] riscv: dts: starfive: jh7110-pine64-star64: enable usb0 host function
Date: Mon, 25 Nov 2024 23:38:17 -0800
Message-ID: <20241126073836.17208-2-e@freeshell.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126073836.17208-1-e@freeshell.de>
References: <20241126073836.17208-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pine64 Star64 set JH7110 on-chip USB host mode and vbus pin assignment

Signed-off-by: E Shattow <e@freeshell.de>
---
 .../boot/dts/starfive/jh7110-pine64-star64.dts | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
index fe4a490ecc61..b764d4d92fd9 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
@@ -80,7 +80,23 @@ &spi0 {
 	status = "okay";
 };
 
+&sysgpio {
+	usb0_pins: usb0-0 {
+		vbus-pins {
+			pinmux = <GPIOMUX(25,  GPOUT_SYS_USB_DRIVE_VBUS,
+					       GPOEN_ENABLE,
+					       GPI_NONE)>;
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


