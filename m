Return-Path: <linux-kernel+bounces-262163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7387D93C1C3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4D8286E21
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A465C19D8BC;
	Thu, 25 Jul 2024 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="THQHJ9H4"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DC919D89F;
	Thu, 25 Jul 2024 12:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909849; cv=none; b=WbNZ9eOFNwyVbumC+INMozQqpZ5e7S3UlNBY0m47phmpYE8zG+d8fUiiGJYKWddaeHBlQGXaO+QZdMVOSXbrl0n5VlO3b+CKhu0frI5yRKgdFWgo1R9/ZmzK+hEqpEFT61VpELjW8E1c6Fou+WwT030O48UWmNI8go/BFHbbTUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909849; c=relaxed/simple;
	bh=mY+VBekkdvm3m8aKNmi+5EnKvkkTMNNxWaHfQKqjgA8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XX75h+nLyJOpg8PlDfsKSrRI3qgstHY7/hU2QHcVgx+0h5BD4z0tIe6lfKPU/HmzJX6G5Lm7A3ACs8IrJHmINudjrf8PAz7nNNWb7A5FNgFl9ooD04HbDk6ekXBO+1RtOSPsL1S3dAFz35D4d4GukNt7ZC/P3IJ2z0HYniqHFms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=THQHJ9H4; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721909847; x=1753445847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mY+VBekkdvm3m8aKNmi+5EnKvkkTMNNxWaHfQKqjgA8=;
  b=THQHJ9H4Sh48tzYnq7mCM5RJefnLm5uAN6ChF7Gf22vrwW/cvJWLlZQ+
   YC8jeJ07OrqaahkpkLOlMeJH3sC7UoNkHM4SXCQgiBA7ZQtbxQ2Wcqe16
   OkqIQKR0AQRjioBfsR5YAZnj4Tp0JrO8E2fz4ezACgnvW1y8bQMvd5bh9
   +LNPYt3AZppnM4LPvgDQBV4mPWF7yZ3KqWsT/tJ5Jb+5cXBeHq3Yh6J3I
   vPP1Zxn+rFx15fSMFBobLE1LrEv1IZd7Bl5rDCeSNDXWCb4kLF3Yv0Md1
   FE7Z/JdjB1nGvFaImBm8K5KBROMk1pW+kCiDVXKPRFeP5qLd7gEHplHhJ
   Q==;
X-CSE-ConnectionGUID: Ik2C1p0ARZK1eWHd58n+Yg==
X-CSE-MsgGUID: 39dLW3JoSpiXV3qQ258VjQ==
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="32460679"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jul 2024 05:17:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jul 2024 05:16:54 -0700
Received: from ph-emdalo.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jul 2024 05:16:52 -0700
From: <pierre-henry.moussay@microchip.com>
To: Conor Dooley <conor.dooley@microchip.com>, Daire McNamara
	<daire.mcnamara@microchip.com>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>
CC: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 14/17] dt-bindings: soc: microchip: mpfs-sys-controller: Add PIC64GX compatibility
Date: Thu, 25 Jul 2024 13:16:06 +0100
Message-ID: <20240725121609.13101-15-pierre-henry.moussay@microchip.com>
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

PIC64GX is compatible with mpfs-sys-controller driver without additional
feature

Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
---
 .../soc/microchip/microchip,mpfs-sys-controller.yaml        | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-controller.yaml b/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-controller.yaml
index a3fa04f3a1bd..af89d5959747 100644
--- a/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-controller.yaml
+++ b/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-controller.yaml
@@ -24,7 +24,11 @@ properties:
     maxItems: 1
 
   compatible:
-    const: microchip,mpfs-sys-controller
+    oneOf:
+      - items:
+          - const: microchip,pic64gx-sys-controller
+          - const: microchip,mpfs-sys-controller
+      - const: microchip,mpfs-sys-controller
 
   microchip,bitstream-flash:
     $ref: /schemas/types.yaml#/definitions/phandle
-- 
2.30.2


