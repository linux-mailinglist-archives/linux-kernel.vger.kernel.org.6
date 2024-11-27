Return-Path: <linux-kernel+bounces-423628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A97BB9DAAA2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F540281B73
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B213A20011A;
	Wed, 27 Nov 2024 15:19:42 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A161FF7D2;
	Wed, 27 Nov 2024 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732720782; cv=none; b=la4pdtdxs/mmWYWtY8BmT2TAMEtIb2hwRsZ/efuAcG8RWypoaVy/r3v/LkmDsJGD6ON1UzJ+CqHRe6+GVEFeu3a8wWscPDAIIWvOS7k+KJSfkGsuUHZ+ru8F3RBtdYzA3wAOwnnTMo+f/HtP1AzKuQCufokO4xLZTKcKZqu3Jco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732720782; c=relaxed/simple;
	bh=DkRHqWAbNhp4SZDG+p0EGdXobSLkwWSBrjiqBMTB8Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T0Lk6akZrfjy0uyX7jNO005PmWMo9PFIAVF/WxYsPHkLtUwSGSDq7zyxUb3hVBeUhm0nANxexWTy/WmyciZNF/vCFCFrxhgVf/Lu8MAXWR+CK9rcPyE6K38rzZhvrSM0nagilXNqkcOqUPxMrFfhzx+AUw9Sevdo6UULUBAU/T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan. (unknown [IPv6:2605:59c8:31de:bf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 2B8C0B4B1DCD;
	Wed, 27 Nov 2024 16:19:35 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Henry Bell <dmoo_dv@protonmail.com>
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
Subject: [PATCH v4 1/1] riscv: dts: starfive: jh7110-pine64-star64: enable usb0  host function
Date: Wed, 27 Nov 2024 07:15:05 -0800
Message-ID: <20241127151843.70341-2-e@freeshell.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127151843.70341-1-e@freeshell.de>
References: <20241127151843.70341-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pine64 Star64 board routes all four USB-A ports to USB0 on the SoC.
Set JH7110 on-chip USB host mode and vbus pin assignment accordingly.

Signed-off-by: E Shattow <e@freeshell.de>
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
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


