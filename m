Return-Path: <linux-kernel+bounces-427675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E6C9E04AA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77D8F16317E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3CA2040B4;
	Mon,  2 Dec 2024 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DpXMff01"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4391E20370C;
	Mon,  2 Dec 2024 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733148678; cv=none; b=m9NfrWCp7cUN6x0hBWuYZ+do8FVY15tVBNqDd9IcFwbaCDKEM/6gdjoudTgIS2bRhJrRBaEzFERi0ptze8/adE8XFobspvwwjV2tWMSTCzAQwcS8k9hUWl9EWSp2VGx2MSNs2IwAtZro/opmypbBTXZXBuh6LMe8YBbJPxN2Kg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733148678; c=relaxed/simple;
	bh=Z2yMR3HeLu7KsABDCKgRF2wGwySvMO/GUfxeUu1aVEE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XabGSwW9NjNHTY7pYMR5AVgecot/JrJ4mGzgUJxtNcczX3SOS9xIEDw3oy1jSiJf3ab31BG2QNatCzUozVNTXzapMFNQFIVvGpbdZfBmYPKEGzDe3EifterklIpLWY0iQaMYxmii0LWYeueVbm6nzr0n1uygz1dtJTy8m5UEGSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DpXMff01; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733148678; x=1764684678;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z2yMR3HeLu7KsABDCKgRF2wGwySvMO/GUfxeUu1aVEE=;
  b=DpXMff01oD+XMwySNPH4h0DxNVihtmuWuNJd3LEtwK4JfDiLgdANZQzT
   HSl5UsxMMrVD8aqIHvJlsQr8DFyqvT2/SCvAxRrxxnWw4u/I6F20WtJk8
   oCRrsHx24Prk/ljCPGO01Qq8w0tHhFFPZfiSSX1uC5fr788BFNcWpaa7I
   Kbh3IIks9S3DBYn5ZKiMjNm6RJni7gDgJxVkj5XcR8LwijFgwFC/ICtD6
   dBYau3Y6adpUHed9NDyI4gX+xdkUYWZ+TsHw8+gdmq7tiiMMhOkV9t6oM
   OfhcVOdGZIB+rkGL/xWv3691O5A8exdutAEcZJSMWeccF9wU1sRGMeGz8
   Q==;
X-CSE-ConnectionGUID: 2KutSU5NQueuFpBXpCyxJA==
X-CSE-MsgGUID: K3v+bPITSaGMmmI42Ho0gA==
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="266205962"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Dec 2024 07:11:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Dec 2024 07:10:57 -0700
Received: from valentina.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 2 Dec 2024 07:10:55 -0700
From: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
To: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<conor.dooley@microchip.com>, <conor+dt@kernel.org>,
	<jassisinghbrar@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<valentina.fernandezalanis@microchip.com>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v5 3/4] dt-bindings: mailbox: add binding for Microchip IPC mailbox controller
Date: Mon, 2 Dec 2024 14:11:06 +0000
Message-ID: <20241202141107.193809-4-valentina.fernandezalanis@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202141107.193809-1-valentina.fernandezalanis@microchip.com>
References: <20241202141107.193809-1-valentina.fernandezalanis@microchip.com>
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
 .../bindings/mailbox/microchip,sbi-ipc.yaml   | 117 ++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml b/Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml
new file mode 100644
index 000000000000..e104573d45c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml
@@ -0,0 +1,117 @@
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
+        reg: false
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


