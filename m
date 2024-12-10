Return-Path: <linux-kernel+bounces-439012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 976809EA980
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4781655D5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F204722CBFF;
	Tue, 10 Dec 2024 07:24:23 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB4322CBEB;
	Tue, 10 Dec 2024 07:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733815463; cv=none; b=a+Zg5gYL+jY8zTPJygyKSCCG/HdmA85NzY9VZGAdBnuw9ZCk4tRBnCnFEKZQJWvAPW+0K1mEr27+yuvdrU8jN9LTUrd5NbDq7QQLIejbhBlApIJoiaMBjDweJkirDULVRIUHz5LVzr0kkkBWWt5QcVPauxXmS7ucjJeYWTTF168=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733815463; c=relaxed/simple;
	bh=wjBJSdLomNChUivjQNlxq8BZURHOE8lEvmgIfbAU4ac=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o7rhyfuYU0KN5FFh7JfVZbb8fxJNtMiTjGrb0oRwF8KxOy2UeCHZC6mdoclsRlnMNCf4RYmh1fYZ4UkAVsTBYU992FfEGlS67Gf6IF6jwKibHS3wDIeOvV62IjCKur1Uk5nXCouOdsUKD9ct38mQd92VCRTcQqaj7Dw323WKqUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 10 Dec
 2024 15:24:12 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 10 Dec 2024 15:24:12 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <tglx@linutronix.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<kevin_chen@aspeedtech.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>
Subject: [PATCH] dt-bindings: interrupt-controller: Fix the size-cells in ast2700-intc
Date: Tue, 10 Dec 2024 15:24:09 +0800
Message-ID: <20241210072409.1429725-1-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

It is no need to let size-cells to 2 for the ASPEED AST27XX INTC. Modify
the ast2700-intc example usage.

Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
---
 .../bindings/interrupt-controller/aspeed,ast2700-intc.yaml    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
index 55636d06a674..69503aa638fb 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
@@ -69,11 +69,11 @@ examples:
 
     bus {
         #address-cells = <2>;
-        #size-cells = <2>;
+        #size-cells = <1>;
 
         interrupt-controller@12101b00 {
             compatible = "aspeed,ast2700-intc-ic";
-            reg = <0 0x12101b00 0 0x10>;
+            reg = <0 0x12101b00 0x10>;
             #interrupt-cells = <2>;
             interrupt-controller;
             interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.34.1


