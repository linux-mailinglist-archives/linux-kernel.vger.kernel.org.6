Return-Path: <linux-kernel+bounces-272336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D73945A68
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F36D81C21900
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD651D365E;
	Fri,  2 Aug 2024 09:06:05 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445971D3638;
	Fri,  2 Aug 2024 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722589565; cv=none; b=HBI8EynnzKQN6iPH+5qgvhX2Wp78Q0fqIME+3BygTVOCMDqOrc7zx88rdsJs069eBBlEUO/vv4nxnNWt2SLx06olmjOg2+65qI7lSK81kE0oGxs0PWAlNd2ysF46wVlFn4agAG42Zr7tTmawWt6PFrGmDL7hS7JOgFYVwUfCpe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722589565; c=relaxed/simple;
	bh=PGSJFTAO9j3LdDGmp/Yj9+DaWbgEh/SVI7oMHMYTqxY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=neiarcWq54jyI6lXGI8KcS44rv/cqSYViyRIC0SZ6QXV+ET2p4yB1dwnKPmoN0KdPdbtBDEXW3qb+qJxzsQCvdnTzXcfRgS83zaSdzGDfRnwxKyOy3fPg+Y/I7UJMUPmHI2RJ73LGuo7pB3GP/0CPtkxTM5rq+Q1Lg6JH3f7gAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 2 Aug
 2024 17:05:51 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 2 Aug 2024 17:05:51 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <lee@kernel.org>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <arnd@arndb.de>,
	<olof@lixom.net>, <soc@kernel.org>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <p.zabel@pengutronix.de>, <quic_bjorande@quicinc.com>,
	<geert+renesas@glider.be>, <dmitry.baryshkov@linaro.org>,
	<shawnguo@kernel.org>, <neil.armstrong@linaro.org>,
	<m.szyprowski@samsung.com>, <nfraprado@collabora.com>, <u-kumar1@ti.com>,
	<kevin_chen@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v2 1/9] dt-bindings: mfd: aspeed,ast2x00-scu: Add ASPEED AST2700-SCUX schema
Date: Fri, 2 Aug 2024 17:05:36 +0800
Message-ID: <20240802090544.2741206-3-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240802090544.2741206-1-kevin_chen@aspeedtech.com>
References: <20240802090544.2741206-1-kevin_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add compatible for two SCU of SCU0 and SCU1 in AST2700.

Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
---
 .../bindings/mfd/aspeed,ast2x00-scu.yaml      | 70 +++++++++++++------
 1 file changed, 50 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
index 86ee69c0f45b..3426b1c84132 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
+++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
@@ -13,33 +13,62 @@ description:
 maintainers:
   - Joel Stanley <joel@jms.id.au>
   - Andrew Jeffery <andrew@aj.id.au>
+  - Kevin Chen <kevin_chen@aspeedtech.com>
 
-properties:
-  compatible:
-    items:
-      - enum:
-          - aspeed,ast2400-scu
-          - aspeed,ast2500-scu
-          - aspeed,ast2600-scu
-      - const: syscon
-      - const: simple-mfd
+scu@ast2xx00-scu:
+  properties:
+    compatible:
+      items:
+        - enum:
+            - aspeed,ast2400-scu
+            - aspeed,ast2500-scu
+            - aspeed,ast2600-scu
+        - const: syscon
+        - const: simple-mfd
 
-  reg:
-    maxItems: 1
+    reg:
+      maxItems: 1
 
-  ranges: true
+    ranges: true
 
-  '#address-cells':
-    const: 1
+    '#address-cells':
+      const: 1
 
-  '#size-cells':
-    const: 1
+    '#size-cells':
+      const: 1
 
-  '#clock-cells':
-    const: 1
+    '#clock-cells':
+      const: 1
 
-  '#reset-cells':
-    const: 1
+    '#reset-cells':
+      const: 1
+
+scu@ast2xx00-scux:
+  properties:
+    compatible:
+      items:
+        - enum:
+            - aspeed,ast2700-scu0
+            - aspeed,ast2700-scu1
+        - const: syscon
+        - const: simple-mfd
+
+    reg:
+      maxItems: 1
+
+    ranges: true
+
+    '#address-cells':
+      const: 2
+
+    '#size-cells':
+      const: 2
+
+    '#clock-cells':
+      const: 1
+
+    '#reset-cells':
+      const: 1
 
 patternProperties:
   '^p2a-control@[0-9a-f]+$':
@@ -76,6 +105,7 @@ patternProperties:
               - aspeed,ast2400-silicon-id
               - aspeed,ast2500-silicon-id
               - aspeed,ast2600-silicon-id
+              - aspeed,ast2700-silicon-id
           - const: aspeed,silicon-id
 
       reg:
-- 
2.34.1


