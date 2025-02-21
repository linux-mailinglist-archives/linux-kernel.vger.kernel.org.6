Return-Path: <linux-kernel+bounces-525209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D42A3EC6B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 06:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966A6173971
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 05:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EBC1FBEB6;
	Fri, 21 Feb 2025 05:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deepcomputing-io.20200927.dkim.feishu.cn header.i=@deepcomputing-io.20200927.dkim.feishu.cn header.b="RRxUJVls"
Received: from va-1-15.ptr.blmpb.com (va-1-15.ptr.blmpb.com [209.127.230.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87281FBEAD
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 05:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740117575; cv=none; b=fT3n7zpfW1QuZ4T7/nn/gNdL1l3uVnaqFeA4CBzEjYPJpkUo2b0tveimh0DyVBLjPrqWzcZs0zSzbEKa3Ci7gvmIT9UGBYCi1GBVKXab0R0eyYNlgLFNrDW6R4eG3Z4LK1wUpCAp94qthopwhTVRJ8qOUKNBm2RyjUcP3WxKhPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740117575; c=relaxed/simple;
	bh=BEhPyWoe88ynSYj4aP1CNbsSke4vuUdji0OKmUXRiCY=;
	h=Content-Type:From:Date:Mime-Version:To:Cc:Subject:Message-Id; b=gBJAYYhFuvXlnK38CjgJwpHLuKwl6FA3/A6c1qVqSLIIK+acCsmG6iaUaNk+V1Z/h29pVYUyA+BVRTa64I++bWlc5Cxb2KK/zyU/zGJG2x+/Asj9DIDWYpBzQboCCBG327UvSdKDR6QBqlV5U82B0sJX4QVVCl8+AmUibCBdW3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepcomputing.io; spf=pass smtp.mailfrom=deepcomputing.io; dkim=pass (2048-bit key) header.d=deepcomputing-io.20200927.dkim.feishu.cn header.i=@deepcomputing-io.20200927.dkim.feishu.cn header.b=RRxUJVls; arc=none smtp.client-ip=209.127.230.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepcomputing.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepcomputing.io
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=deepcomputing-io.20200927.dkim.feishu.cn; t=1740117566;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=BiMZmOITyEUPnY+3LucOL7m+LxVP9/9g5AtKDW/M6a4=;
 b=RRxUJVlsf+2eRg+eyh9qCYD5NxGE9AaldGR+SAxrROwXmUz6xBoRwojeePpaR1j9zqIePn
 fA1+BSzyphOOpU3LDcGnSyvJcDFp3bZDdTEx6RVK87OncIE/9fw5wgdUeq37XK1WpB6SWj
 XAUM5TckuKnGY1yyF9aeBrSN09ZL1V0xLhEk7S2QeOc5B8a2f+4GipAxMomLbUa3H59+2p
 Xh+/oIfKYmM9oex1Sad4r1owbWjUY6aAun+Cr6E+IIbou0iGAvTV+xGhhHQ9NGrseAPYSj
 /L4uNjvudi3A5kzxW7gmWbwpH2XNKWCc78ChHdTHQxdQOELBUkRts9XPY9rqqw==
X-Original-From: Sandie Cao <sandie.cao@deepcomputing.io>
Content-Type: text/plain; charset=UTF-8
From: "Sandie Cao" <sandie.cao@deepcomputing.io>
Date: Fri, 21 Feb 2025 13:58:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from roma-MacBookPro.. ([113.110.143.117]) by smtp.feishu.cn with ESMTPS; Fri, 21 Feb 2025 13:59:22 +0800
Content-Transfer-Encoding: 7bit
To: "Emil Renner Berthing" <kernel@esmil.dk>, 
	"Conor Dooley" <conor@kernel.org>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>
Cc: "Paul Walmsley" <paul.walmsley@sifive.com>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Albert Ou" <aou@eecs.berkeley.edu>, <linux-riscv@lists.infradead.org>, 
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<sandie.cao@deepcomputing.io>
Subject: [PATCH v2] riscv: dts: starfive: fml13v01: enable USB 3.0 port
Message-Id: <20250221055857.481992-1-sandie.cao@deepcomputing.io>
X-Lms-Return-Path: <lba+267b8163c+d8ab31+vger.kernel.org+sandie.cao@deepcomputing.io>
X-Mailer: git-send-email 2.34.1

Add usb_cdns3 and usb0_pins configuration to support super speed USB 
device on the FML13V01 board.

Signed-off-by: Sandie Cao <sandie.cao@deepcomputing.io>
---

Changes in v2:
- Remove space to pass checkpatch.pl.
- Add usb0_pins and pass test on board.

 .../jh7110-deepcomputing-fml13v01.dts         | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts b/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
index 8d9ce8b69a71..f2857d021d68 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
@@ -43,9 +43,28 @@ GPOEN_DISABLE,
 			slew-rate = <0>;
 		};
 	};
+
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
 };
 
 &usb0 {
 	dr_mode = "host";
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_pins>;
 	status = "okay";
 };
+
+&usb_cdns3 {
+	phys = <&usbphy0>, <&pciephy0>;
+	phy-names = "cdns3,usb2-phy", "cdns3,usb3-phy";
+};

base-commit: 38818f7c9c179351334b1faffc4d40bd28cc9c72
-- 
2.34.1

