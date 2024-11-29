Return-Path: <linux-kernel+bounces-423569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057299DA9CB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB2E16588E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A0E1FF616;
	Wed, 27 Nov 2024 14:20:27 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2531FF7AF;
	Wed, 27 Nov 2024 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732717226; cv=none; b=ahGyANpV8Na9yvlyCFmXL+hgAyW3+bDKvFHug3A+BGe699w/UoLAMjBFMB4hJH1sovuZJmRr2ha7uk+nZGvrU3bJ/Y2IJ2Y5I7VfGykday6COJPfaECuJebdpoAeEs6VudRwHlbhrS6/VQBuxZOH30yxSrc05g8gbn/jPuOF3IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732717226; c=relaxed/simple;
	bh=XfE06RngR4nXqQNuI3zZKmY7V9UPvqtTZnQ0RhPMDNo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j48MZtqPco+l2+NJMPPxQuIZjGnULRpSo3f4gDJoZqD88anKb8BvZP9esf7PA+AKHHMioZg0kNoLd2ue4qSTb5NhHDOkFoRbICgtzJ42mmah0Spdv4UEBQIPXP8ip56uQ0m7GJAGbdbzpbeiqIQIoOlBPuZn2CmfyJUfM6caztE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTPS id 4AREKADs083221
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Wed, 27 Nov 2024 22:20:10 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Nov
 2024 22:20:10 +0800
From: CL Wang <cl634@andestech.com>
To: <cl634@andestech.com>, <alexandre.belloni@bootlin.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC: <linux-rtc@vger.kernel>, <linux-kernel@vger.kernel.org>,
        <tim609@andestech.com>, <ycliang@andestech.com>
Subject: [PATCH V4 RESEND 2/3] dt-bindings: rtc: Add support for ATCRTC100 RTC
Date: Wed, 27 Nov 2024 22:19:38 +0800
Message-ID: <20241127141939.1570952-3-cl634@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241127141939.1570952-1-cl634@andestech.com>
References: <20241127141939.1570952-1-cl634@andestech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 4AREKADs083221

Document Device Tree bindings for the Andes ATCRTC100 Real-Time Clock.

Signed-off-by: CL Wang <cl634@andestech.com>

---
Changes for v2:
 - First version of devicetree bindings for the Andes ATCRTC100 Real-Time Clock.

Changes for v3:
 - Used compatible as the filename.
 - Placed allOf after maintainers.
 - Replaced additionalProperties: false with unevaluatedProperties: false.
 - Added descriptions for interrupts.

Changes for v4:
 - Removed wakeup-source attribute.
---
 .../bindings/rtc/andestech,atcrtc100.yaml     | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/andestech,atcrtc100.yaml

diff --git a/Documentation/devicetree/bindings/rtc/andestech,atcrtc100.yaml b/Documentation/devicetree/bindings/rtc/andestech,atcrtc100.yaml
new file mode 100644
index 000000000000..ec0a736793c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/andestech,atcrtc100.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/andestech,atcrtc100.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Andes ATCRTC100 Real-Time Clock
+
+maintainers:
+  - CL Wang <cl634@andestech.com>
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    enum:
+      - andestech,atcrtc100
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Periodic timekeeping interrupt
+      - description: RTC alarm interrupt
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    rtc@f0300000 {
+        compatible = "andestech,atcrtc100";
+        reg = <0xf0300000 0x100>;
+        interrupts = <1 IRQ_TYPE_LEVEL_HIGH>, <2 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.34.1


