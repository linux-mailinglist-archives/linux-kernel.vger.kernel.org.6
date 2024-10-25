Return-Path: <linux-kernel+bounces-381677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 135409B027B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC126284165
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BBD231C8F;
	Fri, 25 Oct 2024 12:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZF76x14L"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C83231C9E;
	Fri, 25 Oct 2024 12:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729859758; cv=none; b=LFe8uaIbM/I0Bn+wQcXM0mdDNYkS2KDZF2Zpe3mGz6zhmAAzXas5Im6rNRHzhb6M98aQd0GmyLjG6A1FghOWlZyq141tvtBfSvWitYgMDBDTIAXRMaT1tCOQtid0LLdyUZL6GXNkJm4D4F/nZKKUVGwXjCbxUaQiE+wTJd2gI8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729859758; c=relaxed/simple;
	bh=XNbe3RDia/LjR3HAQDs4QpuQr1O4y7m0scbekuFJ+hI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGqwlGSfGbSe6hebu07oUXQzdKeELgadjoJA1xKWDzd//ahodImOA0UNMeSoDgdSj2BAqjs8SjnWC0CrIq44Kl20utRSA6CeZ+rKLesCR8gA/KlEiSSkn0A+XAwnDaMCYCq8SNsJum+Tsyxp+NWEM/+JYeKcONTj/JAWuAgBINc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZF76x14L; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729859755; x=1761395755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XNbe3RDia/LjR3HAQDs4QpuQr1O4y7m0scbekuFJ+hI=;
  b=ZF76x14LrNnMSWvEsHcNzpxS4ejaPDKMbROmA2t5MokBzZBaljmtG2RW
   urng2N5lhsU2gJuK8ucahlf5iEFavHiRJYxfK/a5CbhQhz0rG4L9vf8Yg
   Y+KqO9jmBItiEdA7+ODMY5VomrZvSWisngloRGrgOWBzDjJCQxgy8rvTL
   nLJGhcwB4ApQWgD1rihPkFFlXVpddVD9NQcYR0Px8/aJBgAYC24s6EFHu
   OQLuYC2hZv72TcPc+YzJOz9fknDoeKJhWi+w6bUtTA2MYtCRowgWNSkHh
   LKu6XYxgF4SY6SEZh34KfRM+Tg2MoGkIhzaAcdTddbMX4rFk9bvYEukVw
   Q==;
X-CSE-ConnectionGUID: y4wswUVQQmyiw8JWyq9nrg==
X-CSE-MsgGUID: iL7xKj86S06lVrFidrCREQ==
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="34016784"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Oct 2024 05:35:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 25 Oct 2024 05:35:50 -0700
Received: from valentina.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 25 Oct 2024 05:35:48 -0700
From: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
To: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<peterlin@andestech.com>, <conor.dooley@microchip.com>,
	<conor+dt@kernel.org>, <ycliang@andestech.com>, <dminus@andestech.com>,
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, <jassisinghbrar@gmail.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>,
	<valentina.fernandezalanis@microchip.com>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: mailbox: add binding for Microchip IPC mailbox controller
Date: Fri, 25 Oct 2024 13:51:09 +0100
Message-ID: <20241025125110.1347757-3-valentina.fernandezalanis@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025125110.1347757-1-valentina.fernandezalanis@microchip.com>
References: <20241025125110.1347757-1-valentina.fernandezalanis@microchip.com>
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
 .../bindings/mailbox/microchip,sbi-ipc.yaml   | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml b/Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml
new file mode 100644
index 000000000000..90a7932118b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml
@@ -0,0 +1,108 @@
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
+  This SBI interface is compatible with the Mi-V Inter-hart
+  Communication (IHC) IP.
+  The microchip,sbi-ipc compatible string is inteded for use by software
+  running in supervisor privileged mode (s-mode). The SoC-specific
+  compatibles are inteded for use by the SBI implementation in machine
+  mode (m-mode).
+
+properties:
+  compatible:
+    enum:
+      - microchip,sbi-ipc
+      - microchip,miv-ihc-rtl-v2
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
+    description:
+      For the SBI "device", the cell represents the global "logical" channel IDs.
+      The meaning of channel IDs are platform firmware dependent. The
+      SoC-specific compatibles are intended for use by the SBI implementation,
+      rather than s-mode software. There the cell would represent the physical
+      channel and do not vary depending on platform firmware.
+    const: 1
+
+  microchip,ihc-chan-disabled-mask:
+    description:
+      Represents the enable/disable state of the bi-directional IHC channels
+      within the MIV-IHC IP configuration. The mask is a 16-bit value, but only
+      the first 15 bits are utilized.Each of the bits corresponds to
+      one of the 15 IHC channels.
+      A bit set to '1' indicates that the corresponding channel is disabled,
+      and any read or write operations to that channel will return zero.
+      A bit set to '0' indicates that the corresponding channel is enabled
+      and will be accessible through its dedicated address range registers.
+      The remaining bit of the 16-bit mask is reserved and should be ignored.
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
+      microchip,ihc-chan-disabled-mask=  /bits/ 16 <0>;
+      reg = <0x50000000 0x1C000>;
+      interrupt-parent = <&plic>;
+      interrupts = <180>, <179>, <178>;
+      interrupt-names = "hart-1", "hart-2", "hart-3";
+      #mbox-cells = <1>;
+    };
-- 
2.34.1


