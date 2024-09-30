Return-Path: <linux-kernel+bounces-343742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BF8989EF5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6DEE1C21CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A203118BC36;
	Mon, 30 Sep 2024 09:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tvmejZf0"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A20F18FC80;
	Mon, 30 Sep 2024 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727690162; cv=none; b=LSSeatyqsq72Nj41TG+/HCxvt3U+C22/+6l8tsteGuBBFjCIIrhYhdKMtthAGH1x8V4fFRoYomiR878Hdb3sKB2SMMnWeCUTaTJMouoBVnbP6jS5B/67NCNEM/CS92Fp7kuF4e3wBd0KTx/Rgzq0CT6AJk7qDs2aYmn8TBcNWz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727690162; c=relaxed/simple;
	bh=+gnY2BBXCWp24vDJrcKppIVkfz801MuXVXF0BOx/W6E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iH9nh6/39ip4SkiqKfKy9NN+CSR5lRs2SzYHsdfLCLawIM46t+Ly7zeBwmLSW9vrKapJaO75REmk/pBrS0wLDrNl62ih2AlYXiI4JBQ6JXaG2nvKU8qmnzQNgpjzdFye6WPeb/cuakJICl5ftKYHjB1JSAuEgZmDJih1cJMAMJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tvmejZf0; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727690160; x=1759226160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+gnY2BBXCWp24vDJrcKppIVkfz801MuXVXF0BOx/W6E=;
  b=tvmejZf0ynFkg8sd82JbnhgNTA+dAeldWHBbjp2YZKPvuNJMzZPAqLje
   qjklVd1hzOIbZqwRjxP0qwy5a54UBINb+IcuSX78zLBHb5pSpdV+CHhKs
   718/ELH94ERf7WlyRIC893T7jbFi/l4QFcknvFuPufRXN9jFvC7bznJgS
   9q3pq+zSF9+bs73Q7HlFnWq1il+VcmenQvoJYr6ViKw9wzevDKnh4AXRi
   zkmHZUMVGIP+4CSBXFaEobYmQe4NHy+oXcftFXqmuE/6DvDjbP0jNIWL0
   LFOI0sCtfX6vZCtusioP+tKnAGrXj+amVj8B/kCplhWF6tb6JaJKEeoxx
   w==;
X-CSE-ConnectionGUID: jBRUFo6rTUOCd1OoCerG2A==
X-CSE-MsgGUID: 5T27A0QYRquAGZjxZbdLLQ==
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="32997919"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2024 02:55:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 30 Sep 2024 02:55:38 -0700
Received: from ph-emdalo.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 30 Sep 2024 02:55:36 -0700
From: <pierre-henry.moussay@microchip.com>
To: <Linux4Microchip@microchip.com>, Conor Dooley
	<conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [linux][PATCH v2 14/20] dt-bindings: soc: microchip: mpfs-sys-controller: Add PIC64GX compatibility
Date: Mon, 30 Sep 2024 10:54:43 +0100
Message-ID: <20240930095449.1813195-15-pierre-henry.moussay@microchip.com>
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

PIC64GX is compatible with mpfs-sys-controller, without additional
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


