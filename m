Return-Path: <linux-kernel+bounces-543914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B762CA4DB5C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A63BA7A5E95
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35846200BB8;
	Tue,  4 Mar 2025 10:49:53 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0F7200109;
	Tue,  4 Mar 2025 10:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085392; cv=none; b=cMlah5g6vHJHpVvAi7EJiJ4Brd2q4cy2T4pGvcKtHlnDi5rMz+YWuqq27wn0bdPgAIBYjK0h6dJiy/EsBPnlMEqtZhVBRTS7QLFvYD2biNKSkAQknYrvebwBiTumTM9Uk88q42rNpFOjUGwLG8ySRLkTEmuZvAS6333ga4g8jXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085392; c=relaxed/simple;
	bh=dRTXT3uzhYit7zM3zBnkk0O1vIi6AqwtDXwnUSVAN8A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVgnUzD4NAqC5U/I2/sea3VHI1FlZEmqciHpmTGGFczSf4ivSprHWBfmiQL85t4YGDldw2Qvqwg0hNBKljpE1P5Z0yCiqR8U1/zUtezD9+hbFtzt2w+eTt18t56sWqtB1xGmq1n0n0sAQS4cq3uTEWSbgHLy8jZ2f05qRqaFnec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 4 Mar
 2025 18:44:39 +0800
Received: from aspeed-fw03.aspeedtech.com (192.168.10.13) by
 TWMBX01.aspeed.com (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12
 via Frontend Transport; Tue, 4 Mar 2025 18:44:39 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<derek.kiernan@amd.com>, <dragan.cvetic@amd.com>, <arnd@arndb.de>,
	<gregkh@linuxfoundation.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
CC: Kevin Chen <kevin_chen@aspeedtech.com>
Subject: [PATCH v2 1/3] dt-binding: aspeed: Add LPC PCC controller
Date: Tue, 4 Mar 2025 18:44:32 +0800
Message-ID: <20250304104434.481429-2-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304104434.481429-1-kevin_chen@aspeedtech.com>
References: <20250304104434.481429-1-kevin_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add dt-bindings for Aspeed for Aspeed LPC POST code capture controller.

Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
---
 .../devicetree/bindings/mfd/aspeed-lpc.yaml   | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
index 5dfe77aca167..367847bd7e75 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
+++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
@@ -149,6 +149,35 @@ patternProperties:
       - interrupts
       - snoop-ports
 
+  "^lpc-pcc@[0-9a-f]+$":
+    type: object
+    additionalProperties: false
+
+    description:
+      The LPC pcc interface allows the BMC to listen on and record the data
+      bytes written by the Host to the targeted LPC I/O pots.
+
+    properties:
+      compatible:
+        items:
+          - enum:
+              - aspeed,ast2600-lpc-pcc
+
+      reg:
+        maxItems: 1
+
+      interrupts:
+        maxItems: 1
+
+      pcc-ports:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        description: The LPC I/O ports to pcc
+
+    required:
+      - compatible
+      - interrupts
+      - pcc-ports
+
   "^uart-routing@[0-9a-f]+$":
     $ref: /schemas/soc/aspeed/uart-routing.yaml#
     description: The UART routing control under LPC register space
@@ -176,6 +205,13 @@ examples:
         #size-cells = <1>;
         ranges = <0x0 0x1e789000 0x1000>;
 
+        lpc_pcc: lpc-pcc@0 {
+            compatible = "aspeed,ast2600-lpc-pcc";
+            reg = <0x0 0x140>;
+            interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+            pcc-ports = <0x80>;
+        };
+
         lpc_ctrl: lpc-ctrl@80 {
             compatible = "aspeed,ast2600-lpc-ctrl";
             reg = <0x80 0x80>;
-- 
2.34.1


