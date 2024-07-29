Return-Path: <linux-kernel+bounces-265212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A11E93EE08
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03C8CB20423
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACDE129E93;
	Mon, 29 Jul 2024 07:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ufcfvTrR"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF4D84DEB;
	Mon, 29 Jul 2024 07:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236866; cv=none; b=CLyxIuqOcNpP8TIR6RVhfyC2r6dQUD+jSKVeDMD3ynAclzZqxZiM78hYL0gQOsSlEFPIyWmHMjYa0GEtwAXm+2oxZB4dzmeq3UGFUnFzAvlgCoAJ5DmmG89Nf0aShvApXuWOkNpzyMeC8CNA5n/xTds4OxM+pEsGWE7UVHOPHgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236866; c=relaxed/simple;
	bh=fDqE0tBeSlSB34dZ9C+ua0ag8uXX5Nqi4XoXWGufPtw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CUaJB/7V4GCrtmzUA1P3BAk0fl9qz6SiEyelZaDM8WfHtaXUkvTS/eWDf3FP7+ivruKJjqJGMs5lr0bh6JzSUsgnnaUbLPd57zJQ6nPSN/eFNO9ZxT8JNDlACFPNPJvF5Ph19r953+/llgPtXVaNcQfmEaCcHkTiIiTsObj2ses=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ufcfvTrR; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722236864; x=1753772864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fDqE0tBeSlSB34dZ9C+ua0ag8uXX5Nqi4XoXWGufPtw=;
  b=ufcfvTrRbEju8QF/hrMAiG8GDaUE9bGN12e5g4+D/emGoKar1t+7PG+e
   mtWw6DMWgpqpxhu2gERjek/PG8tIxPe7Q36s+UCIQgUBC9jpxcMiwAE8c
   xbZYYJYMXsR1yR10lgt1+LOIndle8u7Am/CKgYIBrW7eI3kPEAI/I50qh
   pOTSAom2PK7vZEq13IU/dipYpJ+EhUTMJsHY5Li+iWIJQzKjKDaYbeDot
   GOU53e6qKDj32eHcAQfysF2aoavUl20RoBpIR2xgwp2h63QedEYi7YSOW
   8BCPymepg2fePNIfGZJACB24mWAytJ6mnbG509RbQWKsbvD3Z90isQioE
   w==;
X-CSE-ConnectionGUID: qXa6hTCZRDuoKzAisfRBPw==
X-CSE-MsgGUID: LdKhooi9QLqydwfPPztv2w==
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="197213861"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2024 00:07:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jul 2024 00:07:37 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jul 2024 00:07:32 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v6 10/27] dt-bindings: clocks: atmel,at91rm9200-pmc: add sam9x7 clock controller
Date: Mon, 29 Jul 2024 12:37:26 +0530
Message-ID: <20240729070726.1990705-1-varshini.rajendran@microchip.com>
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

Add bindings for SAM9X7's pmc.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v6:

 - Corrected the subject line
 - Updated Reviewed-by tag
---
 .../devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
index c1bdcd9058ed..c9eb60776b4d 100644
--- a/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
+++ b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
@@ -42,6 +42,7 @@ properties:
               - atmel,sama5d3-pmc
               - atmel,sama5d4-pmc
               - microchip,sam9x60-pmc
+              - microchip,sam9x7-pmc
               - microchip,sama7g5-pmc
           - const: syscon
 
@@ -88,6 +89,7 @@ allOf:
           contains:
             enum:
               - microchip,sam9x60-pmc
+              - microchip,sam9x7-pmc
               - microchip,sama7g5-pmc
     then:
       properties:
-- 
2.25.1


