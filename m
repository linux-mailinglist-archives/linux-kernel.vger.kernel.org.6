Return-Path: <linux-kernel+bounces-343743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21880989EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D3F281D2C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C057E19047E;
	Mon, 30 Sep 2024 09:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AU7OIYa2"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B571E18FC8F;
	Mon, 30 Sep 2024 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727690162; cv=none; b=J7s9mAxyni6JLKa5XLtmcZO5lyOTTLUxUe9acm6PHRg0PhEzYt/0aeBcsDVs3KKInWpWEQ9OrQMpAdJBIjaq6gW9zIuINmPbDrjItD2dE7sfO92QXB90AFIsQ6zby68YwQF8dmjLaQi2EwIk4pMLnu09TWqQmYk9Y34PR4v3+/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727690162; c=relaxed/simple;
	bh=2ZRkGoHJzGrFCvWkFUcZJD3opW6vCmsySFXJcbpAtNk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bh2/u/EdBdGDNK1p5YlVuC9EJIiDq0JDgckAp3zidUNYT7PssTjzm/feK+Fda9MivbJ5al/DJFwesEGE+h41yWa1GKnm+49iVwtE/8UG7YLLEvKQ7lt1qqncUc1V5YQgOTVP51Z9UJhK4+Wxp5PrjQms1dVFhPBty5pw94ENCS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AU7OIYa2; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727690160; x=1759226160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2ZRkGoHJzGrFCvWkFUcZJD3opW6vCmsySFXJcbpAtNk=;
  b=AU7OIYa2VpAbGoBNj3N2VUKnWSsGZ2wkuH+CC4Z0UcyE+k6hETwQE6Gy
   NqsqglP/zTIGCCrhr1FkLNlUhk3eK6fzJv+TOOQ32FhAJnzGK8+h+6dYJ
   +hrWuTFigZEN5DKsyaibXSdbVwM9R5Me2v7sS1ujINXerH8xodTQcC7vQ
   exYSnTCQLmqNLcY6Jf1zyhhXwphd3aqtWgYH37/AYEBir7Wm84BZehcD9
   TbZnpcDHJFOROXly+eLP91S2L0Gx0SY2Sep8P///4gAvTeCqLVtU6T4f7
   lGzc6nV4vtWVeCgSVYfP4YL4ONfv9dKhceqhalWLM5/U+72V6Ksx8qQub
   Q==;
X-CSE-ConnectionGUID: jBRUFo6rTUOCd1OoCerG2A==
X-CSE-MsgGUID: RrHbUsdYQlKB4y5cHQBi9A==
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="32997921"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2024 02:55:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 30 Sep 2024 02:55:41 -0700
Received: from ph-emdalo.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 30 Sep 2024 02:55:38 -0700
From: <pierre-henry.moussay@microchip.com>
To: <Linux4Microchip@microchip.com>, Conor Dooley
	<conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"Paul Walmsley" <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
CC: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [linux][PATCH v2 15/20] dt-bindings: riscv: microchip: document the PIC64GX curiosity kit
Date: Mon, 30 Sep 2024 10:54:44 +0100
Message-ID: <20240930095449.1813195-16-pierre-henry.moussay@microchip.com>
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

Update devicetree bindings document with PIC64GX Curiosity Kit, known
by its "Curiosity-GX1000" product code.

Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
---
 Documentation/devicetree/bindings/riscv/microchip.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/microchip.yaml b/Documentation/devicetree/bindings/riscv/microchip.yaml
index 78ce76ae1b6d..8fe9a2c7c949 100644
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
@@ -33,6 +33,9 @@ properties:
               - microchip,mpfs-sev-kit
               - sundance,polarberry
           - const: microchip,mpfs
+      - items:
+          - const: microchip,pic64gx-curiosity-kit
+          - const: microchip,pic64gx
 
 additionalProperties: true
 
-- 
2.30.2


