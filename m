Return-Path: <linux-kernel+bounces-343737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EB6989EE5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 772901C204F7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF0E18E762;
	Mon, 30 Sep 2024 09:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="I2jG9pMc"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427EB18E047;
	Mon, 30 Sep 2024 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727690150; cv=none; b=VArHps0d5ZVF+g9yr+Jvw6WV+KmniZBbFRSdg2bd8KlI1S0dFi1UiXgvZEYwYn5/MDjm1GuqpBr6R3b+sioeji7HC+eLbUdelyjtqzCGbyNYSZL87fkBfcOOsi5Q3G/H4oEzz83IObPzLXXquKYacgJjXW3dPnXXteD04flFW6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727690150; c=relaxed/simple;
	bh=13pBX7HrqyQLqJez8Tn1NpNnpK0lqqwZHVuFDqzCnWU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q/oEzRKAxd27YyU42o/bcC7CmEYNSb6OgEnsjMbd6gV4urOgbbCIOBfjV3l9cDAilz24ddFy7AtQrKzz7wkFyQMgGYkGNv87Qpp1Z2mdk+emKcdRPMW4S0sQ3J6t0rXFg7dc77QVy4AhwFOBjuHfm004C1IF4z+4ObQs77/Wgxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=I2jG9pMc; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727690150; x=1759226150;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=13pBX7HrqyQLqJez8Tn1NpNnpK0lqqwZHVuFDqzCnWU=;
  b=I2jG9pMcdF14oyEg4cOBCj/TCkFnhm7YjXbnDpW1su8n9unNUrzupIlZ
   32k9vTcgdNTqHiUW0Rg94I1kHqbokFACkabPLWecK1Lk7SW6XfWWDjiwm
   XL5+tNRDprLDl5ZgftFpd+ki+id9D2wFe54EsZzSchviQGzHI88iCRXkl
   xqn3/kJoqLhXaa5EaionJjj7ieOqOWwE++vhl/ndXKrdkZTNx1w+dMDpj
   Vaq/oO7phHUHs4m43vIEY27nCa8hzWpP866oSqjXGS10LIvOTLIUEXJjR
   8chJB6YEdK4rBukCVvwopvp/PyQTUAn/UOU6OedxbgHEwmBI9sKK/u3Cq
   Q==;
X-CSE-ConnectionGUID: VDfGPtv3TTmpuSmsWgS4Xg==
X-CSE-MsgGUID: bd9PbxwtSRKfnEpKsHOGMA==
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="263420166"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2024 02:55:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 30 Sep 2024 02:55:19 -0700
Received: from ph-emdalo.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 30 Sep 2024 02:55:17 -0700
From: <pierre-henry.moussay@microchip.com>
To: <Linux4Microchip@microchip.com>, Conor Dooley
	<conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>,
	<linux-riscv@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [linux][PATCH v2 08/20] dt-bindings: clock: mpfs-clkcfg: Add PIC64GX compatibility
Date: Mon, 30 Sep 2024 10:54:37 +0100
Message-ID: <20240930095449.1813195-9-pierre-henry.moussay@microchip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
References: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

PIC64GX has a clock controller compatible whith mpfs-clkcfg

Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
---
 .../devicetree/bindings/clock/microchip,mpfs-clkcfg.yaml    | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.yaml b/Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.yaml
index e4e1c31267d2..ca889f5df87a 100644
--- a/Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.yaml
+++ b/Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.yaml
@@ -19,7 +19,11 @@ description: |
 
 properties:
   compatible:
-    const: microchip,mpfs-clkcfg
+    oneOf:
+      - items:
+          - const: microchip,pic64gx-clkcfg
+          - const: microchip,mpfs-clkcfg
+      - const: microchip,mpfs-clkcfg
 
   reg:
     items:
-- 
2.30.2


