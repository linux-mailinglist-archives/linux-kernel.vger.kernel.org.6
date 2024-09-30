Return-Path: <linux-kernel+bounces-343732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9784B989ED6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF85F1C21A1A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1F918A921;
	Mon, 30 Sep 2024 09:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PvmAXhcK"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EE318A6AF;
	Mon, 30 Sep 2024 09:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727690147; cv=none; b=K4IeTJE14AghFWH1wE9iR/kDElezkJrixopp9svsBZmvRIRlCtgV4ebhMFpks+Fql+++aZAoXoVexygCuwtA+Mt43RGTI8No04l7v3oMwWp3HEUe/AoO+S1zAPORv6HS3VLN8DsqoEIY38GvBF6UjX+aSO7Df4R7OjtMQnFgJ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727690147; c=relaxed/simple;
	bh=YsY+gPj3wVsf1p021dBJwYC8DN5AHByNDpJbyROqouI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uk/NOy8bVbplr0/HLez+9XHkbqRSjB0Y+TgqRtXA6dFyfCLHWieih39d54nbxgqiNWktmmtlnS3p7tITUFw1v3y0YJUe3w6kXWcaDXKLkEi42AUDrHlUYctkuT2EfMykOc5DMy/oMCpL5YcveNB3iNjhT5RfJeAqXfNXd2x1DcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PvmAXhcK; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727690146; x=1759226146;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YsY+gPj3wVsf1p021dBJwYC8DN5AHByNDpJbyROqouI=;
  b=PvmAXhcKMjE7Z3cJUwVUp0R/8laypH52z3My3AcV6XiU/k7LBEvynd7Y
   YeCfLNyezyWyGyIOlqa1WpMcJ4rS+OupUxYIUn428dRv1hY8lNhJj8Xt2
   KfmyNR2m2zRLFV5p2nCl0kJlGLzYL/3+SEQ8VuVL8rULFpx2JELL4+66c
   YZQLywuMJhxZUPLxrd3WW5FVePmtmpJH0w5uLbu6X+iQ2dApBeW+Pj33U
   FM2LOcIzaPIkwqcp1rAqoJKuwa3rrgxU4ZLHXwAaZkUc88ts7IL4pD3dA
   1aAhDBfLhN3uap/AAqquQCvyZVlL7VK5si51/v6WUzejsZjkrQ8qmp5NC
   g==;
X-CSE-ConnectionGUID: VDfGPtv3TTmpuSmsWgS4Xg==
X-CSE-MsgGUID: gzY9/IQ+TOuosDlOklZ5YQ==
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="263420157"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2024 02:55:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 30 Sep 2024 02:55:04 -0700
Received: from ph-emdalo.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 30 Sep 2024 02:55:03 -0700
From: <pierre-henry.moussay@microchip.com>
To: <Linux4Microchip@microchip.com>, Conor Dooley
	<conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [linux][PATCH v2 03/20] dt-bindings: mbox: add PIC64GX mailbox compatibility to MPFS mailbox
Date: Mon, 30 Sep 2024 10:54:32 +0100
Message-ID: <20240930095449.1813195-4-pierre-henry.moussay@microchip.com>
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

PIC64GX mailbox is compatible with MPFS mailbox, just add fallback

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


