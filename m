Return-Path: <linux-kernel+bounces-252343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB469311E1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A6C6280F0F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E488187354;
	Mon, 15 Jul 2024 09:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2YOedban"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17EF187335;
	Mon, 15 Jul 2024 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721037537; cv=none; b=Pn//lnvTKV5qxmzMcLHv33MCRNSGrmMey0JrNzh8u8JNNicE23rqKNACiQvQo9gAsvrthQHgvvm4jP07WYXTp/AlDRlN1aSSDVpNfbrWDhLkUZfJir7Qo7WvYu8Sai6z15kLdZvPBtuuZDug1V6l/mDMu682YWHzEWknr33tVQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721037537; c=relaxed/simple;
	bh=taELz09kemQcRTcnI5iQ5KPDeTeYJTdJK5+QS+mBmtQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A5zgpzC4pQrUtKOIwi1MwDZzy71zqSd7ryh7qQJFVdgWMR7iz+XPAGewdYCI9yhG+af4P0heOkdmiIQG92TJGcey6xKk2nwL/BsO4xgNAeiDUDbgKuvUEGsInR9bgBAncYTCIg7zSKriZd9NpZ2vzRo7ReJlOqrnWP9O9uZSxqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2YOedban; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721037535; x=1752573535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=taELz09kemQcRTcnI5iQ5KPDeTeYJTdJK5+QS+mBmtQ=;
  b=2YOedban0DIuDORALloeqxqfMEOQ/z/+5lZGvTtmJO7r6z2OTp0FY6+o
   GmvOqREodP/rDKetn46ct9XqEfzZDnqZjbWRvdOX4hvJNMd85LdZFwsNE
   t3l4NqZmODB4EBbUc87IDfxuSAy7Tv1JoOCqLYE2Nj1XzpLqBzP+osaac
   dnnv1BD8uZtTCCg04RSdscyOjwLxDweGBY4ZRintMor+oTMeimzLn49gF
   LzXENrlP85ISpCvhLFrC3ssFdW3omNVZpD8HxDlE5PAjCiRkcps4ywUZq
   DA40K4566k9yLh0HMpVADNSQNT9C7N0B1xQfJAEvPwamfkBTzXKnv9hV5
   Q==;
X-CSE-ConnectionGUID: rNvP4V1SRC+M8FmMinld8g==
X-CSE-MsgGUID: iLIcNudTT36iecIdOMxO3w==
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="29880289"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jul 2024 02:58:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Jul 2024 02:58:37 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 15 Jul 2024 02:58:26 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
	<rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux@armlinux.org.uk>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <arnd@arndb.de>, <Jason@zx2c4.com>,
	<rdunlap@infradead.org>, <akpm@linux-foundation.org>,
	<geert+renesas@glider.be>, <dri-devel@lists.freedesktop.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <manikandan.m@microchip.com>, <Hari.PrasathGE@microchip.com>,
	<Nicolas.Ferre@microchip.com>
Subject: [PATCH v2 4/4] ARM: configs: at91: Enable Microchip's MIPI DSI Host Controller support
Date: Mon, 15 Jul 2024 15:27:36 +0530
Message-ID: <20240715095736.618246-5-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240715095736.618246-1-manikandan.m@microchip.com>
References: <20240715095736.618246-1-manikandan.m@microchip.com>
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
index 1d53aec4c836..c5c8623f1075 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -143,6 +143,7 @@ CONFIG_VIDEO_OV2640=m
 CONFIG_VIDEO_OV7740=m
 CONFIG_DRM=y
 CONFIG_DRM_ATMEL_HLCDC=y
+CONFIG_DRM_MICROCHIP_DW_MIPI_DSI=y
 CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_PANEL_EDP=y
 CONFIG_FB_ATMEL=y
-- 
2.25.1


