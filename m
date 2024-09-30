Return-Path: <linux-kernel+bounces-343747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC78989F01
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD5F1C22280
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22FC18CC18;
	Mon, 30 Sep 2024 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RmBs1mvF"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0729B18C91F;
	Mon, 30 Sep 2024 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727690183; cv=none; b=Xl3fSlUqmHYcTjlfNIYSFEWjB5V2+Y8PtlPwZzKQemCT2J6Pn9/1u0lXMJtWZ7bBX8zIwUbiOmNnWhS3bI2ABqMuZsfIARH/vWZII8baSDhAdoA4xXduluqJiJIyWjWAA/GMkPdKqp7xOVwOMN1bNQnEe8H7NRlSTy3rn36j4H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727690183; c=relaxed/simple;
	bh=JwQg6M+ID4S53UTp8pzEQml2wbcZO+V6r5rXfWfGpoM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBHKsdI7iYnKjJ4IrNwVPnjBNfAAcxdMuczOoX3aOes+l1p04Ttf7Fp8DhjD0HAe9GTzPmBHVL0lN/5qy7A6e7RFmLS9iotuorfGH4pQMYVcQ0lm7VaStZXKeouf7PFPwjXnfHl5zYa3o4TLgpj/sSbMrHLzVP55W6r+Axzhkj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RmBs1mvF; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727690182; x=1759226182;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JwQg6M+ID4S53UTp8pzEQml2wbcZO+V6r5rXfWfGpoM=;
  b=RmBs1mvFxoZnPe5X7Ng+mQ0I5bVwCbeqWB+xeKlOmOcx6Rpdux3S0uUg
   sNQC021dTqVx1qGk0ffQfBmWBYPKbfkVyuDzpJriXtnqNQ4/+L71qbJCV
   +wVRkExGXmfy/wIPEfpx2OkFxwC+NVjDFwwB2FP5AGc4PuPdaJV88+ERJ
   WieFJz+VTQDlLFj+L1DaPbMaLhyy5wmz7sdKNC+kmsMj3dqX3XzweEIf/
   NvdyFOv7T1qkmJKpqnwbUiXhCl4zPOJy91hMk3M3MLf4FbaCFIGBUeVLs
   zQudO7xSt18FF/sLsFPcJn6OZ0xWu36tLdnBVo3dWSNaWJCv11iOBRam3
   Q==;
X-CSE-ConnectionGUID: 05QWoWIkRFGrt6egQKNmgw==
X-CSE-MsgGUID: TB6X3e73RsmkoPvG3qAjaQ==
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="32388027"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2024 02:56:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 30 Sep 2024 02:55:51 -0700
Received: from ph-emdalo.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 30 Sep 2024 02:55:48 -0700
From: <pierre-henry.moussay@microchip.com>
To: <Linux4Microchip@microchip.com>, Thomas Gleixner <tglx@linutronix.de>,
	"Rob Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"Conor Dooley" <conor+dt@kernel.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>
CC: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>
Subject: [linux][PATCH v2 18/20] dt-bindings: interrupt-controller: sifive,plic: Add PIC64GX compatibility
Date: Mon, 30 Sep 2024 10:54:47 +0100
Message-ID: <20240930095449.1813195-19-pierre-henry.moussay@microchip.com>
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

As mention in sifive,plic-1.0.0.yaml, a specific compatible should be used
for PIC64GX, so here it is.

Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
---
 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 709b2211276b..44668318a8e6 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -58,6 +58,7 @@ properties:
       - items:
           - enum:
               - canaan,k210-plic
+              - microchip,pic64gx-plic
               - sifive,fu540-c000-plic
               - starfive,jh7100-plic
               - starfive,jh7110-plic
-- 
2.30.2


