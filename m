Return-Path: <linux-kernel+bounces-196394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FB48D5B34
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C7C2884D5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 07:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A6D823C8;
	Fri, 31 May 2024 07:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QMtRYPN4"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BC48120F;
	Fri, 31 May 2024 07:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717139151; cv=none; b=OngqeO1p3ci7RFUGLbW8z/teIVWF+F5g7zj0YE7M9rVI3aCwPCJE9YNLpxxjB+U9d4WF/lbGEotvbHEDXpiwqRGHKzAF9/NXVpe9wGY/uu6bUHKGNJG+VLzfd3CbiCihbIcX/XmlflSqal5C9XkH1tlRz1FkJ6l0sLATYWoZ6xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717139151; c=relaxed/simple;
	bh=uQRwfODC5iTuvYyr2nM4AkwurG3nP5PWSj482gaZt9s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k1p0IM3O1nQERMAL4oUydYX65icmrDChCbDihuUgUSaUOgJIRrsfeM0soMdrepggXm3s9ANyG/DD338niQG1Zj3CnTmj5sJYBTdcftfB36zJQEv6iryMxUMdA8Hqnju4hou30h04XOIBVXtfW2of1XQbG8sJMQ3kUacmcuoeQJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QMtRYPN4; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717139149; x=1748675149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uQRwfODC5iTuvYyr2nM4AkwurG3nP5PWSj482gaZt9s=;
  b=QMtRYPN4mz3hkLzuCzv9FSjW5RS1xcdiaw0TO2QlzO71WJmBoykgfLve
   j7cPHiwgoavTnlCv9UhUBJRyDg++ZLJzxGpblOhsv4Egvq+co0s+U9CKg
   XkC0WE9W6/CLc1Bk5q3RwLDcKOSiVqCOu3V/1Pq7Qaji10GiwSnZ2+jRs
   5FijGDPl22vaaLIcMvZKMPcImYg51rF75ldpsOm7KEM1d+xqzXmb4Om0k
   UdqBv6y1zN/W7FZ+2Tfq23/A4VxmrMZSUHAR/VbN9kiAa6gdpcz4QtfJo
   d7JB/yG0QSAsUtVUQE/Eaz+qUht1QrEOOlJSbojOdMrwiwNKQPOdb7CMD
   A==;
X-CSE-ConnectionGUID: YBLIF/bfSzSBNqzeook+qQ==
X-CSE-MsgGUID: qlSQJNvdSiSJKfZJ951vyw==
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="26795688"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2024 00:05:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 31 May 2024 00:05:29 -0700
Received: from wendy.microchip.com (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 31 May 2024 00:05:26 -0700
From: Conor Dooley <conor.dooley@microchip.com>
To: <linux-usb@vger.kernel.org>
CC: <conor@kernel.org>, <conor.dooley@microchip.com>, Daire McNamara
	<daire.mcnamara@microchip.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Bin Liu <b-liu@ti.com>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/2] usb: musb: mpfs: detect UPLI external vbus control requirement from DT
Date: Fri, 31 May 2024 08:04:32 +0100
Message-ID: <20240531-spilt-garage-ed2113d628e8@wendy>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240531-citable-copier-188d32c108ff@wendy>
References: <20240531-citable-copier-188d32c108ff@wendy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=988; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=uQRwfODC5iTuvYyr2nM4AkwurG3nP5PWSj482gaZt9s=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGmRZU0N1gXVX+7MDY77Y5XF/zXHL/ZV8Uy2PpcPui7WnyLP v3bsKGVhEONgkBVTZEm83dcitf6Pyw7nnrcwc1iZQIYwcHEKwESWhDL8T/Y0NCt99u+QUUHy3f9xrz 98Ubib935+TeK/1RF71r584cfwV7ayIHt9at/b0BYhxSmrLhyXFVLJmuI/6U6YwYZ8v++ZTAA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The musb driver core already supports external vbus control for ULPI
PHYs, but none of the drivers actually enable it. A customer reported
needing this for their device, and now that a DT property for detecting
this configuration exists, read the property to enable the feature.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/usb/musb/mpfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/musb/mpfs.c b/drivers/usb/musb/mpfs.c
index f0f56df388355..29c7e5cdb230e 100644
--- a/drivers/usb/musb/mpfs.c
+++ b/drivers/usb/musb/mpfs.c
@@ -190,6 +190,8 @@ static int mpfs_probe(struct platform_device *pdev)
 	pdata->config = &mpfs_musb_hdrc_config;
 	pdata->platform_ops = &mpfs_ops;
 
+	pdata->extvbus = device_property_read_bool(dev, "microchip,ext-vbus-drv");
+
 	pdata->mode = usb_get_dr_mode(dev);
 	if (pdata->mode == USB_DR_MODE_UNKNOWN) {
 		dev_info(dev, "No dr_mode property found, defaulting to otg\n");
-- 
2.43.2


