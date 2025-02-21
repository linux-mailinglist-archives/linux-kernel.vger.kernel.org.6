Return-Path: <linux-kernel+bounces-525088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2EAA3EA9D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 03:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D21B17D921
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F018B1D516D;
	Fri, 21 Feb 2025 02:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deepcomputing-io.20200927.dkim.feishu.cn header.i=@deepcomputing-io.20200927.dkim.feishu.cn header.b="U1GWQHhI"
Received: from va-2-37.ptr.blmpb.com (va-2-37.ptr.blmpb.com [209.127.231.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD4619D087
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 02:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740104000; cv=none; b=jmv8qTKQY04Rd26d0h0GxeygGegfdH9nL8k9YwIllsqSJtk76tFO0s37QIMvKJv3il3Q0ZN3ZMJ5/GeL8OIb+C8fvIRmtOb3puikkNBRUHw2aoXuAsvV8riroLbLvGoMFUAyzPAQTfBlQHIyzqvYTra2OpALHK64JDdFjMG2yYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740104000; c=relaxed/simple;
	bh=hlm1M6ahY0CYSiVTuxAdUw59lv8G+DoHwmaCHg6AnIg=;
	h=Mime-Version:Date:Content-Type:From:To:Cc:Subject:Message-Id; b=U+v5ZjV1mHPVxjSV0lM+aDu/0MWAZqrE/Hnsf9Lv67+IXfxeb1JdUMzC0tNFQOHTDSc0PQKQWGs9nWuD3brcYDDyxyzxvjv75lthCTIvsvG+MJ0r34HNKQzfiGALInj6gP5ginWRG3xonHuBuTGGmQcEeh032gsTkzww1BF+7F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepcomputing.io; spf=pass smtp.mailfrom=deepcomputing.io; dkim=pass (2048-bit key) header.d=deepcomputing-io.20200927.dkim.feishu.cn header.i=@deepcomputing-io.20200927.dkim.feishu.cn header.b=U1GWQHhI; arc=none smtp.client-ip=209.127.231.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepcomputing.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepcomputing.io
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=deepcomputing-io.20200927.dkim.feishu.cn; t=1740103985;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=252guJ30wHEGOM0mF3VIvyLsmSRltl8PT5yIko8TGpg=;
 b=U1GWQHhI0ARL5PG7Xgie+/CNClhTdeO2ve7wCOp7Kf//AaUNKmfAEbW341E2xagS6CjjHf
 gfmbLo8lKQCyfZjs/UpYDYgQFunmpc1gLZcxUd3iiZRyXH9na638QDhVe8r/AGXlpUecj5
 NWHrIUntkxUY5+Y768xql8QgdBice+o5V4VAT66+RK7d4NQX3VyFl9l1pqKEREwMPbDIyY
 2r2vLKbE85N3L2XEQtoYZf5t8rEtiJ5xyDFAk/bYM6fboEEKF1rwfOHupi01RmeUeYhWc4
 CJ9tHfQmAdYzj3tPRSoxZqB6GKAHlNLjvQ+mFnETvtmaAaCQvBImSyzqKB976g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 21 Feb 2025 10:12:15 +0800
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+267b7e12f+a6b4fe+vger.kernel.org+sandie.cao@deepcomputing.io>
Received: from roma-MacBookPro.. ([113.110.143.117]) by smtp.feishu.cn with ESMTPS; Fri, 21 Feb 2025 10:13:02 +0800
Content-Type: text/plain; charset=UTF-8
From: "Sandie Cao" <sandie.cao@deepcomputing.io>
X-Original-From: Sandie Cao <sandie.cao@deepcomputing.io>
X-Mailer: git-send-email 2.34.1
To: "Emil Renner Berthing" <kernel@esmil.dk>, 
	"Conor Dooley" <conor@kernel.org>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>
Cc: "Paul Walmsley" <paul.walmsley@sifive.com>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Albert Ou" <aou@eecs.berkeley.edu>, <linux-riscv@lists.infradead.org>, 
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<sandie.cao@deepcomputing.io>
Subject: [PATCH] riscv: dts: starfive: fml13v01: enable USB 3.0 port
Message-Id: <20250221021215.407988-1-sandie.cao@deepcomputing.io>

Add usb_cdns3 configuration to support super speed USB device on the
FML13V01 board.

Signed-off-by: Sandie Cao <sandie.cao@deepcomputing.io>
---
 .../boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts b/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
index 8d9ce8b69a71..221c91696ffd 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
@@ -49,3 +49,9 @@ &usb0 {
 	dr_mode = "host";
 	status = "okay";
 };
+
+&usb_cdns3 {
+       phys = <&usbphy0>, <&pciephy0>;
+       phy-names = "cdns3,usb2-phy", "cdns3,usb3-phy";
+};
+

base-commit: 38818f7c9c179351334b1faffc4d40bd28cc9c72
-- 
2.34.1

