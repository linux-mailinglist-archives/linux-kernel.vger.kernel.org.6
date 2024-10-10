Return-Path: <linux-kernel+bounces-358938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0228899858C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C3C1C24069
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E641C57A3;
	Thu, 10 Oct 2024 12:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="S6pBZYyX"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E621C4635;
	Thu, 10 Oct 2024 12:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728561903; cv=none; b=bUKsi1gT+LJ6/ILHbbY4Cxx6uO/+mm4zpPVY6+UAFB2NmeK/Fm+zU4ILRgysm9gqAouD+5TzUd5os1IURGDx/Iz/QMCoNpHoByiirRUlS+KAjcRaSCJ8cXqHoHS5jXsw3xFLHR5hVOLnuKy2vr1HtzjNwBSn3zk+oFsIx2XSigY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728561903; c=relaxed/simple;
	bh=wzt+7xEp4j4/tSfm3TSZdLJYo6wZBtfgRWT/y1EebeY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pZTpg5yFhNzgPvOutGqfPPIbIzrWM0awN7HPYDxh5ze5m0gy4DtPfS8afhkSvDBF0AI1wrF3Uu9XeTdgb6XlulZRDo8O3ZtFxtH/7jn2hylIdhejmWDsxuFtJtemWft5DdH4z2CPC4stVhCJsIkDcK2Toii4FK/k0lF1W/yFx1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=S6pBZYyX; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728561901; x=1760097901;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=wzt+7xEp4j4/tSfm3TSZdLJYo6wZBtfgRWT/y1EebeY=;
  b=S6pBZYyXnj3v0fQDClEVPDmnZ1Aw1ZGOy3LZT4vpv8ihO3Wxet31aEU4
   yHsmJ0EW7Tic0oouTqamuzIIt309g3MXmvzk6/lHDEi0hr7z3BhT9JsHv
   tuH+1D2TLsZnd7ZLR0Hyew7pxxgnj/rKsVdAAu5OAFEn0N1jMs86ehQm8
   Ku2y2hn3KhGBy6ey+46gR5ULi/AL3XnpQEaj8SbdFK/ZJH50k/BePnnYn
   Cm8GjANxR5fB4I1ESsBSi7BnaF6k3eN3A7ebr7RCWJmhxLEqK16kUxZ9A
   c6m04ttFx/zOXSidYKDM5uX6uS4qIHpTUs8EFclXpQxgS6+oMLCsEzCNn
   g==;
X-CSE-ConnectionGUID: gR3ImswTTSW4aIPxRveY+Q==
X-CSE-MsgGUID: prSZQQY3RWWkOFC2NywmDA==
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="32664376"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Oct 2024 05:04:59 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 10 Oct 2024 05:04:43 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 10 Oct 2024 05:04:40 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <varshini.rajendran@microchip.com>,
	<mihai.sain@microchip.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 8/9] dt-bindings: arm: add sam9x75 curiosity board
Date: Thu, 10 Oct 2024 17:34:38 +0530
Message-ID: <20241010120438.93201-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241010120142.92057-1-varshini.rajendran@microchip.com>
References: <20241010120142.92057-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add documentation for SAM9X75 Curiosity board.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index 82f37328cc69..7160ec80ac1b 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -106,6 +106,12 @@ properties:
           - const: microchip,sam9x60
           - const: atmel,at91sam9
 
+      - description: Microchip SAM9X7 Evaluation Boards
+        items:
+          - const: microchip,sam9x75-curiosity
+          - const: microchip,sam9x7
+          - const: atmel,at91sam9
+
       - description: Nattis v2 board with Natte v2 power board
         items:
           - const: axentia,nattis-2
-- 
2.25.1


