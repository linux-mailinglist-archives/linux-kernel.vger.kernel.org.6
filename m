Return-Path: <linux-kernel+bounces-332532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E169997BAE6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92B3282F50
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9622C1891D1;
	Wed, 18 Sep 2024 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Iuj5aQTm"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B9E17E44F;
	Wed, 18 Sep 2024 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726655544; cv=none; b=twpBsvXClgG5LZP5DgRx/1wI0Z8lhQo2H48jpTsJGssPGxEwAu6d1nlaG0GYMtFEDyEqAiVxws4PM4o4Qw41437gnVNIhuWNSIKVJE0ZpC8ircs+MzCGLwFcuf9SruEH+6xC3NaKZ5Qh+rWjWIz0Sf4a553k3AH4TMqg9oDrGZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726655544; c=relaxed/simple;
	bh=wvyHmjI+aAqhTfrRSAqnJLQFzafV4/TL9UG+yqpNN24=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fYh5A37GQrSXL8Vp0Zpc8qlEAGoTpdP5bhiWxypPRghxE99DOSc5wNKcQ+TefcDILp54ETz93ABsbx8PVSpPSyNOyJIjNIHJNS6H5xBMFMFZmj8wDZ0Wpj46iVTP0mExg/UUCl9cZjLR6aC7Sljz+H7xQAq1IrQI3OZSFkUj+40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Iuj5aQTm; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726655542; x=1758191542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wvyHmjI+aAqhTfrRSAqnJLQFzafV4/TL9UG+yqpNN24=;
  b=Iuj5aQTmyXpyrcLQHIyrunjfgBSRbUe6/0phAGjz6Ft2tBl18MBJXDjl
   GXch88Le3q/NdtppeFo1Ctr/uai0RQoBRUzKoFKaHsmJ64B+f1gO293Cn
   ZP7OVAhN/o0nTJ7sBCkvYzjPkOvyk5XU56gvfgL8nnLmPfcRYn53ShLrR
   qTbt4fFefdtHZ70CUfqa+ymUJfgypcjXBL+wNvZ3OvhJBV9fjNkLRkzMN
   FlfScZEvEQT4fjAkdwkVP4GiQF5Xt4sleG6pFPe5YJTkUKUIijDrNF3Pw
   8FzLAKZBNIgU755aKocX7SOy7E3OMGwK5pnXc2XL5OACVcBZYNqiBQ06X
   A==;
X-CSE-ConnectionGUID: u1rM2jTbQye/0AWlcIXYhg==
X-CSE-MsgGUID: O24Xg+zoSa2sxbU5TcEbzg==
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="32558785"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2024 03:32:19 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 18 Sep 2024 03:32:00 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 18 Sep 2024 03:31:53 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
	<rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux@armlinux.org.uk>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <dharma.b@microchip.com>, <arnd@arndb.de>,
	<hari.prasathge@microchip.com>, <dri-devel@lists.freedesktop.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v4 4/4] ARM: configs: at91: Enable Microchip's MIPI DSI Host Controller support
Date: Wed, 18 Sep 2024 16:01:19 +0530
Message-ID: <20240918103119.385597-5-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240918103119.385597-1-manikandan.m@microchip.com>
References: <20240918103119.385597-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Enable the Microchip's DSI controller wrapper driver that uses
the Synopsys DesignWare MIPI DSI host controller bridge.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 arch/arm/configs/at91_dt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 6eabe2313c9a..beb29c4832ce 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -144,6 +144,7 @@ CONFIG_VIDEO_OV7740=m
 CONFIG_DRM=y
 CONFIG_DRM_ATMEL_HLCDC=y
 CONFIG_DRM_MICROCHIP_LVDS_SERIALIZER=y
+CONFIG_DRM_MICROCHIP_DW_MIPI_DSI=y
 CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_PANEL_EDP=y
 CONFIG_FB_ATMEL=y
-- 
2.25.1


