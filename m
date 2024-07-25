Return-Path: <linux-kernel+bounces-262149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1006893C197
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61E15B21263
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A8A19A295;
	Thu, 25 Jul 2024 12:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="O/DRp3AA"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A50199E8B;
	Thu, 25 Jul 2024 12:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909789; cv=none; b=hBVyJYgCXuudsPnoY55ESsemBmY5ZX2M/ZpRsiPsCGFw5xNx1iQGy0i03aP/zIssLVVcqybXV9qgLVs83XCpC0kUsve7IYwozfcHIB7RibFRj1jL6Eo6MsWI6grEKWavpj+nLJZIZg9xx/aitqlDRQVTT7KTUdLAOrl8joXY5/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909789; c=relaxed/simple;
	bh=XzjG9bHDj2XGvDX2rSYcXKaSRCzWvkUE4SOtIiB8c3U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iWBq8iHgMx/EGy5MYpbMDSwNG47hw6yqnynRCG9rI2GGIKjbuiWYm+gEJBeRyKjwJBCqnePNWEesTKzmrwHSQYmhaPfymQybcIEfKq4tb3JJaX9ISnSeU7bwqQnJf7sttlEdJcxR9bp2x1cnks8cR/uP7uNOFOpJX2VhtZwLuu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=O/DRp3AA; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721909788; x=1753445788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XzjG9bHDj2XGvDX2rSYcXKaSRCzWvkUE4SOtIiB8c3U=;
  b=O/DRp3AAjfUAWR+UGMehr5kVb/hSaq8YQbfhWWcZySPNWl5gYgwfgMzM
   MqOLw5G0DCjwBbOhDyidLfPliE6S2X0p8fvKDN/qolBM1YIdN/Z/IoF+H
   hPQAJK3AjjhyLJp46FmB+YDEghoUoevYlH9X+R33ZwVnulfH/Lqmkn68g
   Oscuvs19HdNZKGzemRfEETNaNJHpeYYXoPpduzO+yE073UlpUwgyLXf/F
   JevIIpR64yUvDPlTrjXu+V/5gQIJBkrFkEYlt5Rz4yA4K2EVfGp1QvIce
   APJ6XcObbJtcmQMSdqqa7PcyHggw3dxXNc5BoAvZgZx9gLB9EnQ6Kpd3I
   Q==;
X-CSE-ConnectionGUID: 8P89o1u9RvODQlJQJtKtAA==
X-CSE-MsgGUID: 4/2QY4n7RbqixZCSIDOEhw==
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="29678852"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jul 2024 05:16:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jul 2024 05:16:22 -0700
Received: from ph-emdalo.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jul 2024 05:16:20 -0700
From: <pierre-henry.moussay@microchip.com>
To: Conor Dooley <conor.dooley@microchip.com>, Daire McNamara
	<daire.mcnamara@microchip.com>, Jassi Brar <jassisinghbrar@gmail.com>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH 03/17] dt-bindings: mbox: add PIC64GX mailbox compatibility to MPFS mailbox
Date: Thu, 25 Jul 2024 13:15:55 +0100
Message-ID: <20240725121609.13101-4-pierre-henry.moussay@microchip.com>
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

PIC64GX mailbox is compatible with MPFS mailbox driver

Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
---
 .../devicetree/bindings/mailbox/microchip,mpfs-mailbox.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbox.yaml
index 404477910f02..9e45112e185a 100644
--- a/Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbox.yaml
@@ -11,7 +11,11 @@ maintainers:
 
 properties:
   compatible:
-    const: microchip,mpfs-mailbox
+    oneOf:
+      - items:
+          - const: microchip,pic64gx-mailbox
+          - const: microchip,mpfs-mailbox
+      - const: microchip,mpfs-mailbox
 
   reg:
     oneOf:
-- 
2.30.2


