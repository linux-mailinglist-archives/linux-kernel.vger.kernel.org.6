Return-Path: <linux-kernel+bounces-265221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 358A693EE19
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2499282A0D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A749012C460;
	Mon, 29 Jul 2024 07:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TGeH7k5g"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B8882D66;
	Mon, 29 Jul 2024 07:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236939; cv=none; b=SychX56+DOO++O4R/I1lNkmRzNivS7bpSV+8BpKYZ651P0HXGAdAnj7vZg1FUUemNrPWKnxgHIyHjSMmhwhiOoonywZ4+kx2bB0CkTlJswVlF6k+n1KN0ZN6qK8ldDF1qbMMR5tPHWH4kILDOiSMBVtmONC3zdI4FrTzq6MOaX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236939; c=relaxed/simple;
	bh=PkbeR8nMl2Je78nVLSik0CIhm+m2k0l233024j1jZ2A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MxXR6NIpLch2W6D0FwZkeAB91EpGb5O1imQzyneaDFPH7S2Hwnr9UlmOmUK88yeu8r2Euyql58LEkWACErbNjI9EAcOPYP76mjXiHMcwV6KSLgBrqd1TQLka8DxW1/JwFtx+f/dmi/FCpaWxd6I19eZLaYXyGP1uKbyw37CnKv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TGeH7k5g; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722236939; x=1753772939;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PkbeR8nMl2Je78nVLSik0CIhm+m2k0l233024j1jZ2A=;
  b=TGeH7k5g3jfKvzDauGqArZORcjloX2rpbxtI6R/qBhaOj/zp2inPsKaa
   3nwiohS/qr24fevzPG9O8gyamEScRm2dIGvqa3xK+KesQ/bhBSSJvNfG4
   6hqs2n2htabrO9bUfqYGuTWf0RmfpGRPZ5gQDQOr8+KpCLjbxSyrSP8Up
   +11Z4C3EqlZT2wu+uLUtVxFpkBiTUKtZq9ZmHLbaHO92ax6/NpyBDdVWT
   xS3zPXD2jF2EZSiSIA5MXaVfQ6qbYkxv3cg+RHs7gkddsnbHmiKGkzexi
   c0ike1QzfcQz4a22ZUOXuU1xVZceSyqtQWKnbSyH0Idigom8bRMsZJ6We
   A==;
X-CSE-ConnectionGUID: d7Ga9gurQMCZbHEbIOFBiA==
X-CSE-MsgGUID: dqJJv2T6SQ280dqbNSk48A==
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="260698357"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2024 00:08:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jul 2024 00:08:29 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jul 2024 00:08:24 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <tglx@linutronix.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<dharma.b@microchip.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v6 16/27] dt-bindings: interrupt-controller: Add support for sam9x7 aic
Date: Mon, 29 Jul 2024 12:38:18 +0530
Message-ID: <20240729070818.1991013-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
References: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Document the support added for the Advanced interrupt controller(AIC)
chip in the sam9x7 SoC family.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
Changes in v6:

 - Changed the compatible list to only sam9x7's. Removed the Acked-by
   tag as there is functional change in the patch.
---
 .../devicetree/bindings/interrupt-controller/atmel,aic.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
index d4658fe3867c..d671ed884c9e 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
@@ -23,6 +23,7 @@ properties:
       - atmel,sama5d3-aic
       - atmel,sama5d4-aic
       - microchip,sam9x60-aic
+      - microchip,sam9x7-aic
 
   reg:
     maxItems: 1
-- 
2.25.1


