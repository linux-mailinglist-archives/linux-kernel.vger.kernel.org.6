Return-Path: <linux-kernel+bounces-262161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B4F93C1BC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597981F260A0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC47319D06E;
	Thu, 25 Jul 2024 12:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aOVcbMe6"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E2A19A29A;
	Thu, 25 Jul 2024 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909842; cv=none; b=g/5UhvHUcmPmxK80bpNj7Obh2VkPZVuOIL5aCwsNBUNbns2PoiyXOAfg0Ou1TZnR5cKxShmCxNYZJ+VI7JX8gpTqgJeoIMDiwFbKAhqF6LLuumtE8etu9EGCjYmfmFOyopSupA5+oWAZVtWKXgREOx6NavPNO3DdngRdNzP9s38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909842; c=relaxed/simple;
	bh=Eiai/1UkJa0rSDWeeNuZu43ovReww3TviaxZDm3u3FM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K5WK05fuWKYPJRlA9G5vWMpTVLor9+hOCF8xNY6CLsockI1QJNDIGmCmV7c+ZZUcSb7dOJnxELFgtHu+UeZnMy51BQXUeISOIEhZrLDHe8/hIxHjS0Tg+iTzB4B8RIQ3bvgFJ7uL9IWy1zbcJP0WBYHnzZV8lLEe2Dc1Tm2jaP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=aOVcbMe6; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721909840; x=1753445840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Eiai/1UkJa0rSDWeeNuZu43ovReww3TviaxZDm3u3FM=;
  b=aOVcbMe6ABN0/fcNSUVko4IwB7V0k5TN4rHER5m11202GE6OtxMOQs86
   RvsZ2ccFVxgNB2H60b0l/+klUACHbfSKzQ3nWL+/sPumSBFxJOeTgv6AI
   PrDYDJXrEyEzjDpKxHHO8pgYiw9hcn0cgIyGG4JvXG2rq4J8/kkO3xQD4
   rPwN7QAl3uHIo4c3ImxbEEVeCCUcw35m5327qUw0X19BZ+hiYH9i6iI97
   TLbW++LSgtx0a+FdXn1Eb2KchNqmdf7UbUpdbiczF4IWsCfxddNzXh1J8
   KfJj5lYj9KFQpy7JnywHntLZrHeKQrw5aUhkx1bXhpf58wUZsdsXKeT6M
   w==;
X-CSE-ConnectionGUID: FjEJXt1iShuJypsmHj+1Bw==
X-CSE-MsgGUID: L0M9qhp7TDyXKu7xrW03tA==
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="29650442"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jul 2024 05:17:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jul 2024 05:17:00 -0700
Received: from ph-emdalo.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jul 2024 05:16:57 -0700
From: <pierre-henry.moussay@microchip.com>
To: Conor Dooley <conor.dooley@microchip.com>, Daire McNamara
	<daire.mcnamara@microchip.com>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
CC: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 16/17] dt-bindings: riscv: microchip: document the PIC64GX curiosity kit
Date: Thu, 25 Jul 2024 13:16:08 +0100
Message-ID: <20240725121609.13101-17-pierre-henry.moussay@microchip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240725121609.13101-1-pierre-henry.moussay@microchip.com>
References: <20240725121609.13101-1-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

Update devicetree bindings document with PIC64GX Curiosity Kit, known
by its "Curiosity-GX1000" product code.

Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
---
 Documentation/devicetree/bindings/riscv/microchip.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/microchip.yaml b/Documentation/devicetree/bindings/riscv/microchip.yaml
index 4a29c890619a..5e5f2676e6c0 100644
--- a/Documentation/devicetree/bindings/riscv/microchip.yaml
+++ b/Documentation/devicetree/bindings/riscv/microchip.yaml
@@ -4,14 +4,14 @@
 $id: http://devicetree.org/schemas/riscv/microchip.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Microchip PolarFire SoC-based boards
+title: Microchip SoC-based boards
 
 maintainers:
   - Conor Dooley <conor.dooley@microchip.com>
   - Daire McNamara <daire.mcnamara@microchip.com>
 
 description:
-  Microchip PolarFire SoC-based boards
+  Microchip SoC-based boards
 
 properties:
   $nodename:
@@ -32,6 +32,9 @@ properties:
               - microchip,mpfs-sev-kit
               - sundance,polarberry
           - const: microchip,mpfs
+      - items:
+          - const: microchip,pic64gx-curiosity-kit
+          - const: microchip,pic64gx
 
 additionalProperties: true
 
-- 
2.30.2


