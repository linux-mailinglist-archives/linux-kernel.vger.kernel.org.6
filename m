Return-Path: <linux-kernel+bounces-534483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEDCA4674B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9026A7A3A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F7F224B15;
	Wed, 26 Feb 2025 17:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzK+yIvj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277C1224893;
	Wed, 26 Feb 2025 17:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589308; cv=none; b=p1ghX0R0xgmIGIiOLM/MWnVl7fhh3HeRTVj7GY9qUqs6d1rj2cq5JfmBDKhsEqmyUIbHRQCA5X3GMf5vub4siJd6diMUIpcBAdf0pEJK5sfiytY1Pem9LMfTsJxdi8pZBik3A/Wvizoymflp5ECnSA8yn3b14PkSddskDohVOgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589308; c=relaxed/simple;
	bh=mR8X2x+4upIZjxcvX9fZdAr30Xa5cx+18eEK9yFm0bk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a/RxyJrZgh4zBiCy/ckHitFxsLDzdoYxjIlIY9sW6zja9zCjS+/NfzuOAhY4qXIGHsUvnXLDHhNmdlX4827BdtkAo1Y3yWQ/jqF8bY+CeAYF/9Chl6Rfnz4eG108CF6gmxhJB18UyKtFyiTbXfVr9urCds1qAUn/VoE7xtEYvzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzK+yIvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE6ECC4CEE9;
	Wed, 26 Feb 2025 17:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740589307;
	bh=mR8X2x+4upIZjxcvX9fZdAr30Xa5cx+18eEK9yFm0bk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IzK+yIvjtGcpCAWuhQPuFuWYDw3PRuP/iopY5U/F91CkdhnH563bOWE6iKnAXkWBu
	 u0Adw8tGsxCHpQcFaG+XePcavBbxZRWD/zQohOnm6luTDE/iXjwGzHthoTWeB78sz9
	 eEjT7ETFLsxo+zqR+CGyQCrF+1C5ii+UGNP6WJawz4iFlo3jR7TOsNQBbr4drAS1SE
	 hULTyaRyDEyj1yQrmzfYJErPCtiIg/zBo/UcUh4beAr4v4McIid2ODZlnY4Fa8aObv
	 6HWFa36OGGNPM4Zykpab8b+TICi2RFa4g/eKTcJKfVmRcX5v08XqWSsKUYe3suR3dQ
	 ffWRnEmFq1h7Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFD0C19F38;
	Wed, 26 Feb 2025 17:01:47 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Wed, 26 Feb 2025 18:01:41 +0100
Subject: [PATCH v3 2/3] dt-bindings: nand: Add fsl,elbc-fcm-nand
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-ppcyaml-elbc-v3-2-a90ed71da838@posteo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740589304; l=3338;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=CdXw6dR5bMVKNz3tQ2ZajhBrMGlazf+TPLV0IfPcsxQ=;
 b=ou0k0jl7pEz6u2l1Bp+HZXK2i2t4d4INlycakDeN/WIBbhWASIzDsh/9ARllj6+TJrAUIobNt
 PBZYX405vpjBssaH+g2YrR27om7vZv3GVW9RzROoCOA95mWOs191kqO
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

Formalize the binding already supported by the fsl_elbc_nand.c driver
and used in several device trees in arch/powerpc/boot/dts/.

raw-nand-chip.yaml is referenced in order to accommodate situations in
which the ECC parameters settings are set in the device tree. One such
example is in arch/powerpc/boot/dts/turris1x.dts:

	/* MT29F2G08ABAEAWP:E NAND */
	nand@1,0 {
		compatible = "fsl,p2020-fcm-nand", "fsl,elbc-fcm-nand";
		reg = <0x1 0x0 0x00040000>;
		nand-ecc-mode = "soft";
		nand-ecc-algo = "bch";

		partitions { ... };
	};

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---

V3:
- remove unnecessary #address/size-cells from nand node in example
- add Frank Li's review tag
- add missing end of document marker (...)
- explain choice to reference raw-nand-chip.yaml

V2:
- split out from fsl,elbc binding patch
- constrain #address-cells and #size-cells
- add a general description
- use unevaluatedProperties=false instead of additionalProperties=false
- fix property order to comply with dts coding style
- include raw-nand-chip.yaml instead of nand-chip.yaml
---
 .../devicetree/bindings/mtd/fsl,elbc-fcm-nand.yaml | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/fsl,elbc-fcm-nand.yaml b/Documentation/devicetree/bindings/mtd/fsl,elbc-fcm-nand.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..91e8f2f9ff26da0f5a3f9bf276955ed32e9e7bc6
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/fsl,elbc-fcm-nand.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/fsl,elbc-fcm-nand.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NAND flash attached to Freescale eLBC
+
+description:
+  The Freescale Enhanced Local Bus controller (eLBC) contains logic to
+  interface with NAND flash, called the NAND Flash Control Machine (FCM).
+  This binding describes flash attached to an eLBC using the FCM.
+
+maintainers:
+  - J. Neuschäfer <j.ne@posteo.net>
+
+allOf:
+  - $ref: raw-nand-chip.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,mpc8313-fcm-nand
+              - fsl,mpc8315-fcm-nand
+              - fsl,mpc8377-fcm-nand
+              - fsl,mpc8378-fcm-nand
+              - fsl,mpc8379-fcm-nand
+              - fsl,mpc8536-fcm-nand
+              - fsl,mpc8569-fcm-nand
+              - fsl,mpc8572-fcm-nand
+              - fsl,p1020-fcm-nand
+              - fsl,p1021-fcm-nand
+              - fsl,p1025-fcm-nand
+              - fsl,p2020-fcm-nand
+          - const: fsl,elbc-fcm-nand
+      - const: fsl,elbc-fcm-nand
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    localbus {
+        #address-cells = <2>;
+        #size-cells = <1>;
+
+        nand@1,0 {
+            compatible = "fsl,mpc8315-fcm-nand",
+                         "fsl,elbc-fcm-nand";
+            reg = <0x1 0x0 0x2000>;
+        };
+    };
+
+...

-- 
2.48.0.rc1.219.gb6b6757d772



