Return-Path: <linux-kernel+bounces-534486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EA6A46789
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B981E189445E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D025E224B0C;
	Wed, 26 Feb 2025 17:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjSSZNTu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27820224898;
	Wed, 26 Feb 2025 17:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589308; cv=none; b=eU/84yFvoT5ntFwfn64rs6fQ0540GILTSKbkWmm69LncNf2YoIaD78izqL91BNhIYzgnaAsp0Eh0LqelfQm5QXxip5QO8DirZQ8aix3Xf9Y5XFi9Au6sasRUoqrpWIyigV0R/0Gaih4E3NLwGOt+1/Nkkco0koFs78bmqovkj/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589308; c=relaxed/simple;
	bh=LeKsNo2NfWVXxRjT54xweYUrvhD0ogZ4MMk7ujoSXro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pHsCwLaGj69itz+B12NmwE1eWEQ9r7PN+Tj6c/+LiDbGJdFUHQ1drtLnn2sNIJk/2AGj0M6fRlzRR0DIpzYCUDayo3JLQeKUy3zQoUNL7MFU/XLQ6Rq8LaS0OkdlN6d9J5BsqNCQiSM0W0ZgXwXMvr83eHlFBt6B52lxEnDIzoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjSSZNTu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D9B3C4CEE8;
	Wed, 26 Feb 2025 17:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740589307;
	bh=LeKsNo2NfWVXxRjT54xweYUrvhD0ogZ4MMk7ujoSXro=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jjSSZNTushNhFKrhTCVil2I2mO5OvNDQrugasDfbFqP9Dp0kNfXuge+vmXPdnqlv2
	 tzxK9Hm2pPJmRodD6q/2EsKVzpgdrqCgFMp2teixEWOXulUDc/rK44mR+Ol3Xj2ORX
	 jXHyL2KjM5fTH4yeuX+VhDjHp0xUQc0WGJjeHb8MfPXO8mmt/pT2wZZ0XqqfLTx7nd
	 htKCwq0azN1fUcO31/USFG8trLQWoGFNwzHTcSwPbQw05dDUiqFNlT73miY02X31Ld
	 NCVBDpl/pTSxBi0isHwISRGKErUTIGDqbWzZn0rcspoyL0LrTaQ5gdZ5tqwvo0J68b
	 nYbotQm6PnDOA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D2EC19F2E;
	Wed, 26 Feb 2025 17:01:47 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Wed, 26 Feb 2025 18:01:40 +0100
Subject: [PATCH v3 1/3] dt-bindings: memory-controllers: Add
 fsl,elbc-gpcm-uio
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-ppcyaml-elbc-v3-1-a90ed71da838@posteo.net>
References: <20250226-ppcyaml-elbc-v3-0-a90ed71da838@posteo.net>
In-Reply-To: <20250226-ppcyaml-elbc-v3-0-a90ed71da838@posteo.net>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Crystal Wood <oss@buserror.net>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740589304; l=2445;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=GvQhsrPLWmFseUJFQhIZZwPwr6QXxocmbC1FYpGExKA=;
 b=YTwN5WQsNt52pc+y19dW1o/2SJ407WY+kh68sINzXUXyxhcCylgHBz+OmYFDp7nOrjCrHgnut
 mMD/P+eIHSiCesKvovALmOyS//8Bpgc8VhwkENiFkyB32Ho5ErF7eTH
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

Formalize the binding already supported by the uio_fsl_elbc_gpcm.c
driver.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---

V3:
- add review tags

V2:
- split out from fsl,elbc patch
- add description
- remove "device_type" property
- move to bindings/memory-controllers
---
 .../memory-controllers/fsl,elbc-gpcm-uio.yaml      | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl,elbc-gpcm-uio.yaml b/Documentation/devicetree/bindings/memory-controllers/fsl,elbc-gpcm-uio.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..381584b400a0ad98c6d9e0b38f2877d44603ed84
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/fsl,elbc-gpcm-uio.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/fsl,elbc-gpcm-uio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Userspace I/O interface for Freescale eLBC devices
+
+description:
+  The Freescale Enhanced Local Bus controller (eLBC) supports flexible access
+  to memory devices, through the General-Purpose Chip-select Machine (GPCM).
+  The purpose of this binding is to designate devices attached to eLBC/GPMC for
+  use by userspace.
+
+maintainers:
+  - J. Neuschäfer <j.ne@posteo.net>
+
+properties:
+  compatible:
+    const: fsl,elbc-gpcm-uio
+
+  reg:
+    maxItems: 1
+
+  elbc-gpcm-br:
+    description: Base Register (BR) value to set
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  elbc-gpcm-or:
+    description: Option Register (OR) value to set
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  interrupts:
+    maxItems: 1
+
+  uio_name:
+    $ref: /schemas/types.yaml#/definitions/string
+
+required:
+  - compatible
+  - reg
+  - elbc-gpcm-br
+  - elbc-gpcm-or
+
+additionalProperties: false
+
+examples:
+  - |
+    localbus {
+        #address-cells = <2>;
+        #size-cells = <1>;
+
+        simple-periph@2,0 {
+            compatible = "fsl,elbc-gpcm-uio";
+            reg = <0x2 0x0 0x10000>;
+            elbc-gpcm-br = <0xfd810800>;
+            elbc-gpcm-or = <0xffff09f7>;
+        };
+    };

-- 
2.48.0.rc1.219.gb6b6757d772



