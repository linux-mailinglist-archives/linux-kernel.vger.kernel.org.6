Return-Path: <linux-kernel+bounces-536120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76796A47BB4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4834188C17D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A3C22C331;
	Thu, 27 Feb 2025 11:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="hspV/toZ"
Received: from mail-m19731105.qiye.163.com (mail-m19731105.qiye.163.com [220.197.31.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27800227EAE;
	Thu, 27 Feb 2025 11:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654799; cv=none; b=uhb/ebIMZDJ8FqAqvoHC3nELJnag4VxP3AnvvezuF+zaKetvXBCVJx+f4XDbEaQdJdnDSHrs3RKRvbN834ZK2oXJyMPkbalLGeXykkajoDBFNgzqQDHd1dkdvhZ/p+UGbvg494c92w5x2PVBwarG1lUvHXXAFG8wXb3cNu24Dlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654799; c=relaxed/simple;
	bh=RlONGQxFkfaVCaCHqR5hdAZRP3+jWCLKHge/Fd44p2g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qyP+gvXzlbXRZAs7a39EAr45Y8IZfWPziZ3EsMNjNhz9aqICb0LfnHQb7m4M5lJ+UGnrtvoTpzAkYE3Lgbn1LDcCx5Hvy11iSkLiG+9y8ET7KLoKgCDIg49orXpiIOsNIuxdYFyW/4mMtWpUgtIgAQcTowk24Jzr0jb1/06OFFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=hspV/toZ; arc=none smtp.client-ip=220.197.31.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id c65b37d9;
	Thu, 27 Feb 2025 19:08:05 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/3] dt-bindings: nvmem: rockchip,otp: Add support for rk3562 and rk3568
Date: Thu, 27 Feb 2025 19:08:02 +0800
Message-Id: <20250227110804.2342976-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk0aH1ZOHUwZGkhNGUNOTR9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9547179f2b03afkunmc65b37d9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PBQ6TAw5MjIWNw1JEhQxLilN
	CQIaCjFVSlVKTE9LTU5PT0NNSENNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTEtPNwY+
DKIM-Signature:a=rsa-sha256;
	b=hspV/toZNKfN8Mbx1pRYGbdIchgyFEK23TYRO89SrNo6eUGZZ9ZjFplwfLsJsKzcdU9px4owG7jeGH9ZGJgDarEPrIEjE4BSA0XGr75HULNHQ+jfsjBMF3Pe5bZARBaiENe2VtHIcYtPulKO5eqsgqLZjlLN+PAzDcbKE1xdA2A=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=qPdG0uqXJNCLpi+c8n+pbqoC1a0sWOgDfdz7/HqC6dE=;
	h=date:mime-version:subject:message-id:from;

Add compatible entry for the otp controller in rk3562 and rk3568, add schema
for different clock names for new entry.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v2:
- Update the commit message and add maxItems in schema.

 .../bindings/nvmem/rockchip,otp.yaml          | 53 ++++++++++++++++---
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml b/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
index a44d44b32809..7572f4a1d73b 100644
--- a/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
@@ -14,6 +14,8 @@ properties:
     enum:
       - rockchip,px30-otp
       - rockchip,rk3308-otp
+      - rockchip,rk3562-otp
+      - rockchip,rk3568-otp
       - rockchip,rk3588-otp
 
   reg:
@@ -25,19 +27,15 @@ properties:
 
   clock-names:
     minItems: 3
-    items:
-      - const: otp
-      - const: apb_pclk
-      - const: phy
-      - const: arb
+    maxItems: 4
 
   resets:
     minItems: 1
-    maxItems: 3
+    maxItems: 4
 
   reset-names:
     minItems: 1
-    maxItems: 3
+    maxItems: 4
 
 required:
   - compatible
@@ -62,12 +60,45 @@ allOf:
       properties:
         clocks:
           maxItems: 3
+        clock-names:
+          items:
+            - const: otp
+            - const: apb_pclk
+            - const: phy
         resets:
           maxItems: 1
         reset-names:
           items:
             - const: phy
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,rk3562-otp
+              - rockchip,rk3568-otp
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 4
+        clock-names:
+          items:
+            - const: usr
+            - const: sbpi
+            - const: apb_pclk
+            - const: phy
+        resets:
+          minItems: 4
+          maxItems: 4
+        reset-names:
+          items:
+            - const: usr
+            - const: sbpi
+            - const: apb
+            - const: phy
+
   - if:
       properties:
         compatible:
@@ -78,8 +109,16 @@ allOf:
       properties:
         clocks:
           minItems: 4
+          maxItems: 4
+        clock-names:
+          items:
+            - const: otp
+            - const: apb_pclk
+            - const: phy
+            - const: arb
         resets:
           minItems: 3
+          maxItems: 3
         reset-names:
           items:
             - const: otp
-- 
2.25.1


