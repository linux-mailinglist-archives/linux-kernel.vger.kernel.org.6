Return-Path: <linux-kernel+bounces-403460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 718E19C3609
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 02:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27D721F225C6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 01:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D59015533B;
	Mon, 11 Nov 2024 01:31:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBBA154C04;
	Mon, 11 Nov 2024 01:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731288661; cv=none; b=OAqJO/Qfe851UvSX68Of1man8f4BzGzJV2vn2qRPlyHdz0Wh0GXSsnRhHcP+7UOuv9JCMVVghgLhKeRi26xKfp2Zxtx4Zm4C4Vvjfuo4SrAUE7hZPqRFvBlYVETOMS7ysluPteu27Z2x1xJuLW5X7G8JO+NwePUT7d8u8YQI8cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731288661; c=relaxed/simple;
	bh=CgadDdYWs3CAM+2bELfGUg5Jr452m2Ji1Iw8/54B7vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nM0YSh5deGarwh9cS+rH5nD5WjCsslbIlQpViugh3SbINF3jHDf6Afu2FSU5Z0dfMCXrFz/4JNXFi5r/7O1uLmFb1P6czkGg08jxMs1VNEnCbrS74Xj8TGW7AQPrFvaUwpUBHcQWnJOUEDAcLiESRhdA+bqiTAFv1mf30erPEjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA89D13D5;
	Sun, 10 Nov 2024 17:31:29 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 152FE3F66E;
	Sun, 10 Nov 2024 17:30:57 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org
Subject: [PATCH 07/14] dt-bindings: phy: document Allwinner A523 USB-2.0 PHY
Date: Mon, 11 Nov 2024 01:30:26 +0000
Message-ID: <20241111013033.22793-8-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241111013033.22793-1-andre.przywara@arm.com>
References: <20241111013033.22793-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Allwinner A523 SoC contains a USB-2.0 PHY fully compatible to the
one used in the D1/T113s SoCs. This PHY controls the two USB-2.0 ports,
there is a separate and quite different PHY for the USB-3.0 port.

Add the new compatible string, with a fallback to the D1 version.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../bindings/phy/allwinner,sun50i-a64-usb-phy.yaml     | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml
index f557feca97630..b070a5aeab11d 100644
--- a/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml
@@ -15,9 +15,13 @@ properties:
     const: 1
 
   compatible:
-    enum:
-      - allwinner,sun20i-d1-usb-phy
-      - allwinner,sun50i-a64-usb-phy
+    oneOf:
+      - enum:
+          - allwinner,sun20i-d1-usb-phy
+          - allwinner,sun50i-a64-usb-phy
+      - items:
+          - const: allwinner,sun55i-a523-usb-phy
+          - const: allwinner,sun20i-d1-usb-phy
 
   reg:
     items:
-- 
2.46.2


