Return-Path: <linux-kernel+bounces-545702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16AEA4F067
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B07427A7834
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0FF27E1D2;
	Tue,  4 Mar 2025 22:25:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BAD27D786;
	Tue,  4 Mar 2025 22:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741127154; cv=none; b=DaRA9u3JgST7ZgxDSzJRzi48/ssFTZM9Ksuqa5YD1y88pSkyOyFWayUR+82JAAzKIejLRynJzqLrK8HnzplPAYesymk6ISG2ghcBm/y0FowFvpkA4Md5dHBs7FgT7zq3BWWkJYCUU+Zmpl1FQLt4NLhkOozMc6fJH+cdzzaTygo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741127154; c=relaxed/simple;
	bh=mI/KQp1Pka0NtO36Oq1/oFIBxkswFQ7b2yyuh4Hs5v8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HFoPTpEADB9xJNfJYUgV75rfhxhhl1FtRyag09zyOpNlthuLxDESAKvhfHP616i1dxIeHPyKaOwH9bwmZ3MZ3wvLVlI1STEkNYu2mhXulaXEi03ihQeCC3AGCRcx7TUWJF0rLEY6ea73YPeexQgRF3VE2Zuj4PuPGRfmaXuWa0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26A072F;
	Tue,  4 Mar 2025 14:26:06 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B36BD3F5A1;
	Tue,  4 Mar 2025 14:25:50 -0800 (PST)
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
	linux-phy@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 07/15] dt-bindings: phy: document Allwinner A523 USB-2.0 PHY
Date: Tue,  4 Mar 2025 22:23:01 +0000
Message-ID: <20250304222309.29385-8-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250304222309.29385-1-andre.przywara@arm.com>
References: <20250304222309.29385-1-andre.przywara@arm.com>
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
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml
index 21209126ed008..580c3296a18d7 100644
--- a/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml
@@ -20,7 +20,9 @@ properties:
           - allwinner,sun20i-d1-usb-phy
           - allwinner,sun50i-a64-usb-phy
       - items:
-          - const: allwinner,sun50i-a100-usb-phy
+          - enum:
+              - allwinner,sun50i-a100-usb-phy
+              - allwinner,sun55i-a523-usb-phy
           - const: allwinner,sun20i-d1-usb-phy
 
   reg:
-- 
2.46.3


