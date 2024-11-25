Return-Path: <linux-kernel+bounces-421474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B40199D8BDF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BD7AB2AA60
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBE31BCA19;
	Mon, 25 Nov 2024 17:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wdHSEicu"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ACF1B87D9;
	Mon, 25 Nov 2024 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732557543; cv=none; b=GpiyNwZRC6We8wlHehpwSag2J1xQO9TndT/PzghdUMUebgTsBzCuuczxQ4kd6nRR+Tt3RcGaZL1/UwvQ8sRtP0lAHmRTne+Wt4pZTqfImyNZBK2CM4yt5oHtCQXUPQmexTA7BP3teOE2GU67YYc77uMXnuht+lZdMX3OOgPoI18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732557543; c=relaxed/simple;
	bh=U+npF1NvJtoJ4T6hVxDwsCJ5YF+JSUTcWrivx8R4two=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZp9ZaGOnHwF3Lsr5uLl+SbXFxjX2gvrG1Y0Frtr4UjT+sR/E6qLuMRMMCC562xL+QiCT0CvjzwBk80CRiMSvXMumDqqHhuitKI18wUcULZ0l1AxYzhqu7XTqUDRNQU8Ayfiu7zi/BxayregIHQC38kMVz8R28+eeF8zoL+DhAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wdHSEicu; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732557542; x=1764093542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U+npF1NvJtoJ4T6hVxDwsCJ5YF+JSUTcWrivx8R4two=;
  b=wdHSEicumcfKJZ3gbdqO8p0n4FrpvE42HklrLI/p3U0df2EoEmaPFkxc
   pfSzvGern68pz062BQbwLz2MTZ3fj6NxraUzA8w/PT+7AahZQuQYyZPpT
   v4SYDgqZoL88XTf8HTPK+bIFBvaYE0xNHRT7tUKfyKbKDbtSk/FYAVAsJ
   27plA2OSbMXqmZ/ms2AMejrJXJ3W3rSNt3QBTEXrVwQ8LFU1SDAAyiVoY
   q7/AgAxG5TLmPQVtFYDDiEfJryEpCpbX39b2OAxIBzsi7DRAads9BY/P+
   4aayxdTDjZ2Lf8okQR3tg96hb1O0j2zTz9Ma1uSDg5ivdGNR3FqeO/0XW
   w==;
X-CSE-ConnectionGUID: QcIy3zy5RLCJ7zVSqoxwVg==
X-CSE-MsgGUID: rlNRxlbmRjCAsP7JRKUTyw==
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="38361999"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Nov 2024 10:58:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Nov 2024 10:58:45 -0700
Received: from valentina.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 25 Nov 2024 10:58:42 -0700
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
Subject: [PATCH v4 3/4] dt-bindings: mailbox: add binding for Microchip IPC mailbox controller
Date: Mon, 25 Nov 2024 17:58:17 +0000
Message-ID: <20241125175818.213108-4-valentina.fernandezalanis@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125175818.213108-1-valentina.fernandezalanis@microchip.com>
References: <20241125175818.213108-1-valentina.fernandezalanis@microchip.com>
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
 .../bindings/mailbox/microchip,sbi-ipc.yaml   | 111 ++++++++++++++++++
 1 file changed, 111 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml b/Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml
new file mode 100644
index 000000000000..b69af85ec608
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml
@@ -0,0 +1,111 @@
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
+      pattern: "^hart-[0-5]+$"
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


