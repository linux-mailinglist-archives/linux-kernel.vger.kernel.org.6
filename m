Return-Path: <linux-kernel+bounces-550193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDFCA55C6C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33BFE173516
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58461922E8;
	Fri,  7 Mar 2025 00:57:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38A018FC72;
	Fri,  7 Mar 2025 00:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309064; cv=none; b=KVdUfHnxj4qyqg/R9sADJZ+mBKWJ7XTWlIHEtQSnRruAmngh15z+mPMC+jRRf5vSemoTm1Y/cIjj03ETrr05RD2cbb2RKj/5vvdJNQg1U7y6nj7ZoRgCz9UGSVjUckBbjkRNnIq3rUdglw9LJC/9VHUE2Ij0ItX1IfHK7RenL8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309064; c=relaxed/simple;
	bh=8sXhQaB/gFaaPKgrUaamVTBu14GdoJq0nYw4DnuFjgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LwcHAQJGREFIYeUiU/2MdBl9wWjmcXiyFTnDuj0LyscK4Xltfth+litlMPmGjGpRaAwRa+b+MtNyhomMGBKjdGVOZsIOZsIB6bRt/wgiHQCynyIp6+36NXnbXtg0X45DN8/pZ2xRLoXq9GUEHTSLkqJH6rnb/TZbmbWB4BylFvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E9401BC0;
	Thu,  6 Mar 2025 16:57:54 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 114E73F5A1;
	Thu,  6 Mar 2025 16:57:39 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 10/15] dt-bindings: arm: sunxi: Add new board names for A523 generation
Date: Fri,  7 Mar 2025 00:57:07 +0000
Message-ID: <20250307005712.16828-11-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250307005712.16828-1-andre.przywara@arm.com>
References: <20250307005712.16828-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new Allwinner A523 SoC family comes in different packages, though
they all share the same die, and so the devicetree bindings.

Add three board names that use a version from this SoC family:
- The Avaota A1: an Open Source hardware router board.
- The Radxa Cubie A5E: a typical development board
- The X96QPro+: a TV box

Add their compatible name to the list.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 046536d02706f..80096819fda91 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -840,6 +840,11 @@ properties:
           - const: allwinner,r7-tv-dongle
           - const: allwinner,sun5i-a10s
 
+      - description: Radxa Cubie A5E
+        items:
+          - const: radxa,cubie-a5e
+          - const: allwinner,sun55i-a527
+
       - description: Remix Mini PC
         items:
           - const: jide,remix-mini-pc
@@ -961,6 +966,11 @@ properties:
           - const: hechuang,x96-mate
           - const: allwinner,sun50i-h616
 
+      - description: X96Q Pro+
+        items:
+          - const: amediatech,x96q-pro-plus
+          - const: allwinner,sun55i-h728
+
       - description: Xunlong OrangePi
         items:
           - const: xunlong,orangepi
@@ -1076,4 +1086,9 @@ properties:
           - const: xunlong,orangepi-zero3
           - const: allwinner,sun50i-h618
 
+      - description: YuzukiHD Avaota A1
+        items:
+          - const: yuzukihd,avaota-a1
+          - const: allwinner,sun55i-t527
+
 additionalProperties: true
-- 
2.46.3


