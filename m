Return-Path: <linux-kernel+bounces-545705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59890A4F06F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C4B87A92A0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD012803E0;
	Tue,  4 Mar 2025 22:26:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9F227F4C5;
	Tue,  4 Mar 2025 22:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741127161; cv=none; b=Tak1FcSuqQC52du1+AmTCUGuNRdI0ALWVUJOzIpaXrEFeetIPflzBpaMS5H+sg2VIgZlxNqtwjLRlOQzs8Ul+8PW2C1O88Fj1voBbZ8i6RSYvRJtuEoYVcMSVknG5hZqTp3PlhktcOL9g722otYnK7LuxNDJVETEp/vX7f4SCqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741127161; c=relaxed/simple;
	bh=sPe0I+eLCQ0E6y5DzdJS/R/SLIP6E40N4CDeBE+qlrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYVha6UFGTaDk8iVRVwHn0pXYo8UFV0LW3K2tYGEbS+q+7Kfv27tijUA0bA49H7ckGW7IwZ+8Zs90fQZ9MF1nK0MIlY6z4z1fNSXy4HdX9iWXF9JcByPhpoWnc3lvPlYY/+NXtnwjh5YxBcYeBj9J7EZz0IPcYQGJWET54/JWc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57618497;
	Tue,  4 Mar 2025 14:26:11 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E01D3F5A1;
	Tue,  4 Mar 2025 14:25:56 -0800 (PST)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/15] dt-bindings: arm: sunxi: Add new board names for A523 generation
Date: Tue,  4 Mar 2025 22:23:04 +0000
Message-ID: <20250304222309.29385-11-andre.przywara@arm.com>
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

The new Allwinner A523 SoC family comes in different packages, though
they all share the same die, and so the devicetree bindings.

Add three board names that use a version from this SoC family:
- The Avaota A1: an Open Source hardware router board.
- The Radxa Cubie A5E: a typical development board
- The X96QPro+: a TV box

Add their compatible name to the list.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
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


