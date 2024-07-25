Return-Path: <linux-kernel+bounces-262148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EE293C195
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D63B1C204F6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9516199EBE;
	Thu, 25 Jul 2024 12:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="enCFLbBl"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832851993A7;
	Thu, 25 Jul 2024 12:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909789; cv=none; b=Lz4dgIOWToSEYObymsTQY7PG4ESb+skmtKn4Y+LPHiEKgJjWKGAyUChEEwNHk6m7VWdhK1dHukJ3taEBLlzoAjOk3O2S1crdWxp0+aE4qQCKwFhtJtirsIiCODf7b28qcAXsZPwchoKyR9e7vqPnnvTBXSFB3dZmYTtG2UHr3FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909789; c=relaxed/simple;
	bh=64IhmAs4hcahlJtSrL3eGxK7HYUcs5RdttPIEWaVbDc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V1DujWsMEd71qOJFh/QwXgidiHGljhI3E2OxfZonNUFZYH8aJ5hS3fDHee3I/+O5hG4lP0T6vJVaMT0/PAyP8V7ZsNK/YPCGFzGnELw+DfS9CAv1809siky9UqSmuE5GHhoJ2KEgtK++V5mMObS/NaAj6r4U2DW3y4na1F4mrS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=enCFLbBl; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721909788; x=1753445788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=64IhmAs4hcahlJtSrL3eGxK7HYUcs5RdttPIEWaVbDc=;
  b=enCFLbBlRq344GDYKkPzTj0p9aEE0DbV1GB/r9tZhsRu1GFcHwBLBsjQ
   v+Rkye11c+hXgm9OdxTAJclAaWEYkmhT5PSgydL00NQYwRdxZ3sTO3PTt
   f6hrOPgh34lRsGG2jTQVcCypagF+TAdbB14icib6Ul9ageQlA47Vq0hh2
   FodTG+rJ41jXnr9w8HNSgEH+eTV8Dcb3cNOSMROTPPtbfp2jeuxcG/tW/
   XNiql9TBBmwqUmhAlrMB41ks71JEwQ7NPp9LWT9C4ACeNwsygZsl59l0c
   Sdni1T3qBwCKzLrm6bOSjiYnhk8N+kTl4xj2MgHKl5QJG8LVTXSsbd1gw
   g==;
X-CSE-ConnectionGUID: 8P89o1u9RvODQlJQJtKtAA==
X-CSE-MsgGUID: c8ejOUDnQOqBzey5a9a0lw==
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="29678850"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jul 2024 05:16:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jul 2024 05:16:19 -0700
Received: from ph-emdalo.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jul 2024 05:16:17 -0700
From: <pierre-henry.moussay@microchip.com>
To: Conor Dooley <conor.dooley@microchip.com>, Daire McNamara
	<daire.mcnamara@microchip.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>
CC: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>,
	<linux-riscv@lists.infradead.org>, <linux-usb@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 02/17] dt-bindings: usb: add PIC64GX compatibility to mpfs-musb driver
Date: Thu, 25 Jul 2024 13:15:54 +0100
Message-ID: <20240725121609.13101-3-pierre-henry.moussay@microchip.com>
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

PIC64GX musb is compatible with mpfs-musb driver, just update compatibility

Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
---
 .../devicetree/bindings/usb/microchip,mpfs-musb.yaml       | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/microchip,mpfs-musb.yaml b/Documentation/devicetree/bindings/usb/microchip,mpfs-musb.yaml
index c5e9ce2e7bc2..c8785a6c893e 100644
--- a/Documentation/devicetree/bindings/usb/microchip,mpfs-musb.yaml
+++ b/Documentation/devicetree/bindings/usb/microchip,mpfs-musb.yaml
@@ -14,8 +14,11 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - microchip,mpfs-musb
+    oneOf:
+      - items:
+          - const: microchip,pic64gx-musb
+          - const: microchip,mpfs-musb
+      - const: microchip,mpfs-musb
 
   dr_mode: true
 
-- 
2.30.2


