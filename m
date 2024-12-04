Return-Path: <linux-kernel+bounces-431598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FF89E3F79
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B8EDB32666
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060CB20D4FB;
	Wed,  4 Dec 2024 16:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAQHGcD+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485FE1885A0;
	Wed,  4 Dec 2024 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733328394; cv=none; b=mtlGQ306omrAHNJMS7ea4ZonQaBNvOIEKX39pdkDhsbQJRJcodjev4nczH2MZZf1v/FGGNfsQMhLfRxrT3RN9R4X0esEVv9cWHFFRDlg1XC/HdO6+dYVu5F/JzZsDsIdm1/vznDzMULfFlnr8NrSOEcTCVzjRo6hvMDo2Ey1u+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733328394; c=relaxed/simple;
	bh=3JhEAbqjaIpg38TjTLzxVnmiyUVlm2z5VLfTs/oY8h4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eVlrPi157iQwpyuR4pJQ+oXYWrsuFhMRGCuBxpU0ROwYInk6oA9hJ5mrRdSaQ6pVhsn7/aelG9tN+EcQN4gZB+sOGC88uItYCHupvHuiygVfXhL85sj0mo1EtXDcgwE4FeivknzGS5AbZqXpwi2cvV4ZDWDIOmudPRdPzIZyH70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAQHGcD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD007C4CEE3;
	Wed,  4 Dec 2024 16:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733328393;
	bh=3JhEAbqjaIpg38TjTLzxVnmiyUVlm2z5VLfTs/oY8h4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dAQHGcD+ocNBc1lNCJzUhY1zBqxA+tNzqaKkl0DRB85yss+bhT9+6DgfN0tvD+mfT
	 OF+OwXLBLem1u7gpjvY0VGEoEr9zk63r2+5v0pJh/lccfBPataK9Pw9b8l7O4Avf50
	 K1qgf7k0juBP9kxKYg0ziN3dGKSDm4S8wmpyKB4mTXMM2sye4b89YU0IYvH5v7dnSf
	 Gjs93gLAX3lj70w15lFedMnCxO6CV69MpBOcltDn8MHKenEGJemCwtPo+TN5FOUegy
	 aDc/eLDFtm+gvRZZsrIqNswk8vDujh0HcvzC9rH/HUmNOwcfwZ28IFHoKeYOjrr/TK
	 JdTfIq5n4Xjdw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C909CE77170;
	Wed,  4 Dec 2024 16:06:33 +0000 (UTC)
From: Nikolaos Pasaloukos via B4 Relay <devnull+nikolaos.pasaloukos.blaize.com@kernel.org>
Date: Wed, 04 Dec 2024 16:05:25 +0000
Subject: [PATCH v5 2/6] dt-bindings: arm: blaize: Add Blaize BLZP1600 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-blaize-blzp1600_init_board_support-v5-2-b642bcc49307@blaize.com>
References: <20241204-blaize-blzp1600_init_board_support-v5-0-b642bcc49307@blaize.com>
In-Reply-To: <20241204-blaize-blzp1600_init_board_support-v5-0-b642bcc49307@blaize.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 James Cowgill <james.cowgill@blaize.com>, 
 Matt Redfearn <matt.redfearn@blaize.com>, 
 Neil Jones <neil.jones@blaize.com>, 
 Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733328392; l=2168;
 i=nikolaos.pasaloukos@blaize.com; s=20241111; h=from:subject:message-id;
 bh=nZrtoLEBx9eSJm+LA7iUVDlX7hTZ20Riw/HSYwpf1yo=;
 b=X+HoK8cBDfO3U5Zsc18jHTANKsInOutc6BStS8FgN09ozvbyIvQsF4cWbAHf1H0/ys2VyGzZs
 MEqNXCeh3ECCUh+oeImi+YskXlmmc61MBXXt0Mcx7A0fCfy40+y9ShU
X-Developer-Key: i=nikolaos.pasaloukos@blaize.com; a=ed25519;
 pk=gGEjGCXdSuvCJPIiu0p0UeiPcW5LC710Z6KGN/dzo3g=
X-Endpoint-Received: by B4 Relay for
 nikolaos.pasaloukos@blaize.com/20241111 with auth_id=274
X-Original-From: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
Reply-To: nikolaos.pasaloukos@blaize.com

From: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>

Add device tree bindings for the Blaize BLZP1600 CB2 development
board (carrier board). This board integrates a Blaize BLZP1600
SoM (System on Module) which is based on the Blaize BLZP1600 SoC.

The Blaize BLZP1600 SoC integrates a dual core ARM Cortex A53
cluster and a Blaize Graph Streaming Processor for AI and ML
workloads, plus a suite of connectivity and other peripherals.

Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
Reviewed-by: Matt Redfearn <matt.redfearn@blaize.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/blaize.yaml | 40 +++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/blaize.yaml b/Documentation/devicetree/bindings/arm/blaize.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..af39e2756407baacee3030f6909cf2aa7dc5776c
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/blaize.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/blaize.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Blaize Platforms
+
+maintainers:
+  - James Cowgill <james.cowgill@blaize.com>
+  - Matt Redfearn <matt.redfearn@blaize.com>
+  - Neil Jones <neil.jones@blaize.com>
+  - Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
+
+description: |
+  Blaize Platforms using SoCs designed by Blaize Inc.
+
+  The products based on the BLZP1600 SoC:
+
+  - BLZP1600-SoM: SoM (System on Module)
+  - BLZP1600-CB2: Development board CB2 based on BLZP1600-SoM
+
+  BLZP1600 SoC integrates a dual core ARM Cortex A53 cluster
+  and a Blaize Graph Streaming Processor for AI and ML workloads,
+  plus a suite of connectivity and other peripherals.
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: Blaize BLZP1600 based boards
+        items:
+          - enum:
+              - blaize,blzp1600-cb2
+          - const: blaize,blzp1600
+
+additionalProperties: true
+
+...

-- 
2.43.0



