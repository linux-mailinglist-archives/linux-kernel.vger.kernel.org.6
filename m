Return-Path: <linux-kernel+bounces-396942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1749BD4B4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33D01C22213
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7D81EABB4;
	Tue,  5 Nov 2024 18:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="l20hPCFh"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994D11E8825;
	Tue,  5 Nov 2024 18:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730831795; cv=none; b=Ox95XbG3g5xPq9PMluCpoHCex1yiOCZDyVc+6JifF+uyVlah/lq7UlG3Pj8+fquh1Z0mI9qBJxyt1HEY4gu+WbHZvcodAj90QxEQyv7oJrO3TOUUs978lEWdjw4KvVOGv2nqhWzqRsR+u1+8/Ihnlzw8cBnDu6bdsIDxEAQn3DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730831795; c=relaxed/simple;
	bh=o3lz7dS/0X/IsotdugNCOPCUgilgkWwAiXObrss6PhM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t1MbnnvKh0ef7XHrR1E7+m1rWrG7XRtYMULWWrTZD0KpGyssadMPbhv5U9iygue3vxPNYaXzQLQ8Hm3rivREag06Bat/xJ6tQoWWGz3zeG+qvZSnVaCGnLAEddmhLKTy54WS3PGbtxe/MiMP38LaBU6L1oHLeKuLbwAw02VjNBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=l20hPCFh; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1730831793; x=1762367793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o3lz7dS/0X/IsotdugNCOPCUgilgkWwAiXObrss6PhM=;
  b=l20hPCFhR5e42DbKWvawnmVCd8G+OsL/AJ9hIV53i0MoNJaRyx+oc1CN
   4zZ21PtaE7GO0AJKyJ1bPjK1IGS75n6CaCmzVGNRg4dAympe2IxsECWrL
   lsrdDDDtWOWYPXFDKxOkMf2h7vc8rwuOUnfoGmIxv9nvAEBYudax1621e
   35Hp5ZJu6UJ1wG1gBm76jY96PrjHHroElAJf19BK8KBYxd0RJhy+WT/o1
   j4bNyHgBsGtIYLvubiCZhfPY/byAy/e1MCH9QcFJYvUUWwm0EUgDc+IDj
   2hfMPsXFhBdbKzRa0yuN7lucVt296FWCfeebzSZiWVna9V5ZG+kYQNv74
   w==;
X-CSE-ConnectionGUID: T1uVhdVNQzWREZUebUBC5w==
X-CSE-MsgGUID: jf9X/ks1T1CHW9+cqU6PUA==
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="37385617"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Nov 2024 11:36:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Nov 2024 11:36:24 -0700
Received: from valentina.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 5 Nov 2024 11:36:21 -0700
From: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
To: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<ycliang@andestech.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	<peterlin@andestech.com>, <samuel.holland@sifive.com>,
	<conor.dooley@microchip.com>, <alexghiti@rivosinc.com>,
	<ruanjinjie@huawei.com>, <takakura@valinux.co.jp>, <conor+dt@kernel.org>,
	<jassisinghbrar@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<valentina.fernandezalanis@microchip.com>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v3 3/4] dt-bindings: mailbox: add binding for Microchip IPC mailbox controller
Date: Tue, 5 Nov 2024 18:35:12 +0000
Message-ID: <20241105183513.1358736-4-valentina.fernandezalanis@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105183513.1358736-1-valentina.fernandezalanis@microchip.com>
References: <20241105183513.1358736-1-valentina.fernandezalanis@microchip.com>
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
index 000000000000..9e67c09e4bea
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
+        items:
+          - const: microchip,sbi-ipc
+
+      - description:
+          SoC-specific compatible, intended for use by the SBI
+          implementation in machine mode (m-mode).
+        items:
+          - const: microchip,miv-ihc-rtl-v2
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
+      pattern: "^hart-[0-5]+$"
+
+  "#mbox-cells":
+    description: >
+      For the SBI "device", the cell represents the global "logical" channel IDs.
+      The meaning of channel IDs are platform firmware dependent.
+
+      For the SoC-specific compatible string, the cell represents the physical
+      channel and does not vary based on the platform firmware.
+    const: 1
+
+  microchip,ihc-chan-disabled-mask:
+    description: >
+      Represents the enable/disable state of the bi-directional IHC
+      channels within the MIV-IHC IP configuration.
+
+      The mask is a 16-bit value, but only the first 15 bits are utilized.
+      Each of the bits corresponds to one of the 15 IHC channels.
+
+      A bit set to '1' indicates that the corresponding channel is disabled,
+      and any read or write operations to that channel will return zero.
+
+      A bit set to '0' indicates that the corresponding channel is enabled
+      and will be accessible through its dedicated address range registers.
+
+      The remaining bit of the 16-bit mask is reserved and should be ignored.
+
+      The actual enable/disable state of each channel is determined by the
+      IP block’s configuration.
+    $ref: /schemas/types.yaml#/definitions/uint16
+    default: 0
+
+required:
+  - compatible
+  - interrupts
+  - interrupt-names
+  - "#mbox-cells"
+
+additionalProperties: false
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
+      reg = <0x50000000 0x1C000>;
+      interrupt-parent = <&plic>;
+      interrupts = <180>, <179>, <178>;
+      interrupt-names = "hart-1", "hart-2", "hart-3";
+      #mbox-cells = <1>;
+    };
-- 
2.34.1


