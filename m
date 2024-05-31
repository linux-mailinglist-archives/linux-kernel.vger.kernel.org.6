Return-Path: <linux-kernel+bounces-196393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD078D5B32
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 839291F25964
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 07:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56A781AC3;
	Fri, 31 May 2024 07:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bkaEMboc"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B6480C15;
	Fri, 31 May 2024 07:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717139151; cv=none; b=Tlhe682JmmGl3c4fkVzHeENOpEH2eD6+B+lt7UKanB9o1yNFH8TSXMCQDcLAe3qY8XY+h4VPSA64Pw+HQzPbs6LfWPonOYtVO7j/ZslW+jtXLjWAc/tGhuhccat6oyCdYSPFGWbxXjgbkrbG8tV3XnTjXOG/SNRj3fcHh9kUHmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717139151; c=relaxed/simple;
	bh=G3Q+DafgQZOA4SgNWtOQ3VvYVuxk4kHrwKu95UhwRjM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MQ5hltsS4dibrkO7iiQwYNBO5+5uS1PLvbop/OABvKOH0KiMZI1uysB52EF6Vo6OfNMdTUNQ3t23c4Io1y6nmo2d2sRFI/suNGUimMiL0+R7+J3Q+FQZD9Do8tgaieNpDQ4OwBlqypHT83h7SnyBACFiZf4wBw9QHwihU4ODrAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bkaEMboc; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717139149; x=1748675149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G3Q+DafgQZOA4SgNWtOQ3VvYVuxk4kHrwKu95UhwRjM=;
  b=bkaEMbocBFD+9AviF3iTa/7V/UHPt6ytb0KtOsOzyFIkTB/eKeTA8aRj
   iMsdutTQPl2WKDSxq6JebJeto7TOUx7Ptu4cf57vXwVjaBQSr+zbHgMor
   oZGrPMpUP73cyVoKpAGXyYmT9PynPLhGGIuBW7C8KhqjOoSHI5U9YQU9t
   sGoF2i4TEIHeRfoTQG4XtZgJk+kYEB8tiK1C4k3tJVWG+2f00Qmug4oFy
   4NKElwRj/Eq3OSHQtug7aHsLJRmXW8cGilpwxpTHEaWTRszoGtRBKjMMo
   +D4ETrrf+c72FzoVuDhxBvMGgGd2Rtbkt625gK5iAjFsULO2BYg972uWC
   Q==;
X-CSE-ConnectionGUID: wTY4LIfiQwGiNFVRU5C2dQ==
X-CSE-MsgGUID: k9TrmQQaQdmMkLexubCwiA==
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="26795680"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2024 00:05:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 31 May 2024 00:05:25 -0700
Received: from wendy.microchip.com (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 31 May 2024 00:05:23 -0700
From: Conor Dooley <conor.dooley@microchip.com>
To: <linux-usb@vger.kernel.org>
CC: <conor@kernel.org>, <conor.dooley@microchip.com>, Daire McNamara
	<daire.mcnamara@microchip.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Bin Liu <b-liu@ti.com>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/2] dt-bindings: musb: mpfs: add ULPI external vbus support
Date: Fri, 31 May 2024 08:04:31 +0100
Message-ID: <20240531-fountain-plating-1d3739422a26@wendy>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240531-citable-copier-188d32c108ff@wendy>
References: <20240531-citable-copier-188d32c108ff@wendy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1013; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=G3Q+DafgQZOA4SgNWtOQ3VvYVuxk4kHrwKu95UhwRjM=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGmRZU0ZO+v5P2xXYNYM7teUcGx6VXf6/4uqqCVTr0tFczw4 +PRfRykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACZy9SYjw9bYL0s1X2rbPfmooqaxLX qzT9XjJ/ZPiu+dlVodOa2+rIKRYRrT6o963xue65rJ773y4tyShkN7W30PtIgd83PNeztNjx8A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add a property to allow configuring the musb controller on PolarFire SoC
to use an external vbus for ULPI PHYs.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/usb/microchip,mpfs-musb.yaml       | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/microchip,mpfs-musb.yaml b/Documentation/devicetree/bindings/usb/microchip,mpfs-musb.yaml
index c5e9ce2e7bc2a..27b909de49922 100644
--- a/Documentation/devicetree/bindings/usb/microchip,mpfs-musb.yaml
+++ b/Documentation/devicetree/bindings/usb/microchip,mpfs-musb.yaml
@@ -34,6 +34,13 @@ properties:
   clocks:
     maxItems: 1
 
+  microchip,ext-vbus-drv:
+    description:
+      Some ULPI USB PHYs do not support an internal VBUS supply and driving
+      the CPEN pin requires the configuration of the UPLI_USE__EXTVBUS
+      bit in ULPI_BUSCONTROL.
+    $ref: /schemas/types.yaml#/definitions/flag
+
 required:
   - compatible
   - reg
-- 
2.43.2


