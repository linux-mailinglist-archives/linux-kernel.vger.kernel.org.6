Return-Path: <linux-kernel+bounces-403658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D62F9C38BB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 07:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33671F21256
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 06:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4318158845;
	Mon, 11 Nov 2024 06:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="u0Gq3tSR"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27A21514EE;
	Mon, 11 Nov 2024 06:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731308158; cv=none; b=qE2TTrnmqlZguo56lHUDsemGKffMOukApedZvALqxdja7Eig0cClwgbHWVS8Ax48KsRuzzqoujVCL6hRJw4XaxcXJk2L2xFPU3M5q9mG2hIaB/rJV/qmpI94tW2/lF5VGZPsuw6Sz2G7aJjBYSnXR+PfQUNEZ3UoWcHYt7zsh1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731308158; c=relaxed/simple;
	bh=to+XTp4IW8kAmb6A0rvJQ9ZF113lclX2U2Y8R7lLOIE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t0Dise+tkwwoNvo0q9gDW3bltHLl858RnghxxIIPRmIBECIR0m5GbaBrrw9O7hr6zarzXztiFniiW0hk/x+4pwRK/Pdstl3SMoHQVxoQHXqBQKKIEBWVFJgRwJBoZus4OqT4gXxswCyhYA+N55wYQseZRp2KUb5fjdOVGZ/v4NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=u0Gq3tSR; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731308157; x=1762844157;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=to+XTp4IW8kAmb6A0rvJQ9ZF113lclX2U2Y8R7lLOIE=;
  b=u0Gq3tSRSAsdu0Oso1kPLMPLXF97MlZKkW+GliL0uMHK6Kr3INB+dYCp
   MpMjRQ8MSdhdl30BTl7kQk0k63LhOt5nKiH2DaCj2T7SfKtA6+m3H0ISb
   za2j5vuQdcLzRkt9bufsdl3linE5e/4JRodo1K0+XGBnm2P2foTfB+OML
   T1BkYIYtCNmT4EEWL8aVD1DNKo1zthtlme7KRmgqwzBr9SwkkcnCo33q8
   6V4HLrBycjFcVTzzh6K1kO0OgkJYe/dq5lqqFtlTz6/iDtN6GxhIn2nxW
   Bxi5iUBz4nUjqLP/mS6E0lFHbdPXKLks2bBfpMYRYBFTeZPUii3B/TH0j
   w==;
X-CSE-ConnectionGUID: ep4875LgSx6tm9VmeD6HJQ==
X-CSE-MsgGUID: rkveuh0RQainZYLgjezJmg==
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="265270148"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Nov 2024 23:55:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Nov 2024 23:55:44 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 10 Nov 2024 23:55:35 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
	<rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux@armlinux.org.uk>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <dharma.b@microchip.com>,
	<hari.prasathge@microchip.com>, <varshini.rajendran@microchip.com>,
	<arnd@arndb.de>, <dri-devel@lists.freedesktop.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v6 3/4] MAINTAINERS: add SAM9X7 SoC's Microchip's MIPI DSI host wrapper driver
Date: Mon, 11 Nov 2024 12:25:01 +0530
Message-ID: <20241111065502.411710-4-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241111065502.411710-1-manikandan.m@microchip.com>
References: <20241111065502.411710-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add the Microchip's DSI controller wrapper driver that uses the
Synopsys DesignWare MIPI DSI host controller bridge for the SAM9X7
SoC series to the MAINTAINERS entry.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
changes in v3:
- Drop T: section
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f5dc00438ba3..77228b16425a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15272,6 +15272,13 @@ S:	Supported
 F:	Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-lvds.yaml
 F:	drivers/gpu/drm/bridge/microchip-lvds.c
 
+DRM DRIVER FOR MICROCHIP SAM9X7-COMPATIBLE MIPI DSI HOST CONTROLLER
+M:	Manikandan Muralidharan <manikandan.m@microchip.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Supported
+F:	Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-mipi-dsi.yaml
+F:	drivers/gpu/drm/bridge/dw-mipi-dsi-mchp.c
+
 MICROCHIP SAMA5D2-COMPATIBLE ADC DRIVER
 M:	Eugen Hristev <eugen.hristev@microchip.com>
 L:	linux-iio@vger.kernel.org
-- 
2.25.1


