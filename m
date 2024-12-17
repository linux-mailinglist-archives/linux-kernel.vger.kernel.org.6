Return-Path: <linux-kernel+bounces-449107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF789F49F2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 916507A3007
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5897D1F3D39;
	Tue, 17 Dec 2024 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="emGmI+Af"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6F21F131B;
	Tue, 17 Dec 2024 11:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734435109; cv=none; b=ZUNXfLXBYLLNzd+r2hMsCIE2CUNJKQbu6TKnaMHxc/OLkis2wH8SB2WM9kg2Y5841wP+urS8B+uPYZcLp3ihk1FxQA3jNxMq/OjxOa/fMnwAIE4oloIgsDAUlBX0fOWVdrMZ7qGnzCdK7QvRK9EpM/RLcgEXrmMJpGY13VZCRC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734435109; c=relaxed/simple;
	bh=jb8YqOp2h/g+W5ZwU09IpQtNOQClMuCx3xE6O2uXec4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P72mUmLho0/4a18kFVXAeFdGV5DH3dmpp2E/n3nXvM75KpvrMJkPo1yPXZucknpbiNCFhROb7b8RvRNXA3rgtxQBf8cpO1nnhNZJo1s1DJag2650dlFF4iYawekNCgA1t5GS7klcpsZGyDg9aWtyJvQ3qtAbjhhrI4Wi0s/Avms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=emGmI+Af; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734435107; x=1765971107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jb8YqOp2h/g+W5ZwU09IpQtNOQClMuCx3xE6O2uXec4=;
  b=emGmI+AfV+S0W3/JjaiIliWQYKNVQkmQCSmE7h+VeexzasEHE2oMzEXP
   rtdkA3rySgOFTPRL0e/Idqs6lF9bFThhyTZanJLcyBSTbEQx1nuNcmHk/
   bkWvQv3JSAQCS9z9r+dN3u22mJ7FH8jSSUjN8OyKt3DpNjk1kw7WhdVkZ
   3sM39Dm32ECz+Cd1Pr/ChIy1baOgnqC5lxBWueOO0+AKP1Ei192JKasH3
   XySkmYsNas3+Sj55li1Hs/rifLf0LWReGiif7uLP/L8+WjrTOy214bNuo
   0ARh+vJBr874g/NT6+VQ76vzJXEBbToxJTATr8pTtOSk+kqM5Emypp3pL
   g==;
X-CSE-ConnectionGUID: AFXRsVMVRgWVCl8fi3oPIQ==
X-CSE-MsgGUID: K06UQkBfSqOrMAX67yaMCA==
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; 
   d="scan'208";a="39361182"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Dec 2024 04:31:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 17 Dec 2024 04:31:13 -0700
Received: from valentina.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 17 Dec 2024 04:31:11 -0700
From: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
To: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<conor.dooley@microchip.com>, <conor+dt@kernel.org>,
	<jassisinghbrar@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<valentina.fernandezalanis@microchip.com>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v6 3/4] dt-bindings: mailbox: add binding for Microchip IPC mailbox controller
Date: Tue, 17 Dec 2024 11:31:33 +0000
Message-ID: <20241217113134.3508333-4-valentina.fernandezalanis@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217113134.3508333-1-valentina.fernandezalanis@microchip.com>
References: <20241217113134.3508333-1-valentina.fernandezalanis@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Add a dt-binding for the Microchip Inter-Processor Communication (IPC)
mailbox controller.

Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
---
 .../bindings/mailbox/microchip,sbi-ipc.yaml   | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml b/Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml
new file mode 100644
index 000000000000..8ed67ea7c883
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/microchip,sbi-ipc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip Inter-processor communication (IPC) mailbox controller
+
+maintainers:
+  - Valentina Fernandez <valentina.fernandezalanis@microchip.com>
+
+description:
+  The Microchip Inter-processor Communication (IPC) facilitates
+  message passing between processors using an interrupt signaling
+  mechanism.
+
+properties:
+  compatible:
+    oneOf:
+      - description:
+          Intended for use by software running in supervisor privileged
+          mode (s-mode). This SBI interface is compatible with the Mi-V
+          Inter-hart Communication (IHC) IP.
+        const: microchip,sbi-ipc
+
+      - description:
+          Intended for use by the SBI implementation in machine mode
+          (m-mode), this compatible string is for the MIV_IHC Soft-IP.
+        const: microchip,miv-ihc-rtl-v2
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 5
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 5
+    items:
+      enum:
+        - hart-0
+        - hart-1
+        - hart-2
+        - hart-3
+        - hart-4
+        - hart-5
+
+  "#mbox-cells":
+    description: >
+      For "microchip,sbi-ipc", the cell represents the global "logical"
+      channel IDs. The meaning of channel IDs are platform firmware dependent.
+
+      For "microchip,miv-ihc-rtl-v2", the cell represents the physical
+      channel and does not vary based on the platform firmware.
+    const: 1
+
+  microchip,ihc-chan-disabled-mask:
+    description: >
+      Represents the enable/disable state of the bi-directional IHC
+      channels within the MIV-IHC IP configuration.
+
+      A bit set to '1' indicates that the corresponding channel is disabled,
+      and any read or write operations to that channel will return zero.
+
+      A bit set to '0' indicates that the corresponding channel is enabled
+      and will be accessible through its dedicated address range registers.
+
+      The actual enable/disable state of each channel is determined by the
+      IP block’s configuration.
+    $ref: /schemas/types.yaml#/definitions/uint16
+    maximum: 0x7fff
+    default: 0
+
+required:
+  - compatible
+  - interrupts
+  - interrupt-names
+  - "#mbox-cells"
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: microchip,sbi-ipc
+    then:
+      properties:
+        reg:
+          not: {}
+          description:
+            The 'microchip,sbi-ipc' operates in a programming model
+            that does not require memory-mapped I/O (MMIO) registers
+            since it uses SBI ecalls provided by the m-mode/firmware
+            SBI implementation to access hardware registers.
+        microchip,ihc-chan-disabled-mask: false
+    else:
+      required:
+        - reg
+        - microchip,ihc-chan-disabled-mask
+
+additionalProperties: false
+
+examples:
+  - |
+    mailbox {
+      compatible = "microchip,sbi-ipc";
+      interrupt-parent = <&plic>;
+      interrupts = <180>, <179>, <178>;
+      interrupt-names = "hart-1", "hart-2", "hart-3";
+      #mbox-cells = <1>;
+    };
+  - |
+    mailbox@50000000 {
+      compatible = "microchip,miv-ihc-rtl-v2";
+      microchip,ihc-chan-disabled-mask = /bits/ 16 <0>;
+      reg = <0x50000000 0x1c000>;
+      interrupt-parent = <&plic>;
+      interrupts = <180>, <179>, <178>;
+      interrupt-names = "hart-1", "hart-2", "hart-3";
+      #mbox-cells = <1>;
+    };
-- 
2.34.1


