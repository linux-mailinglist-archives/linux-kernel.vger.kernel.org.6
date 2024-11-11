Return-Path: <linux-kernel+bounces-403660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE459C38C0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 07:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3CA7B21A38
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 06:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0886B156230;
	Mon, 11 Nov 2024 06:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PFgcds0F"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0393156997;
	Mon, 11 Nov 2024 06:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731308197; cv=none; b=Xtf4vYJllegk5pshlF+OMw2Y4pITlulfymViIDxAQQB4kOk15CkYslFUSw4FWfvtf7oV4yZ7vIrgZiOKB2WZShTxlGB35w3M7v28U0bgArljjavv0Ylqpa98h0NAo3rPQ9N8QUckjOE4yBCH0pbSJaTiYxD0WesM1ReoLQRL4hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731308197; c=relaxed/simple;
	bh=Fi00+RpncPzVAuACaU69mwSsQhQappFQ26XGuBF9PQk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bMlyNMbkFj09TjAc4sCvpTVGPduQKoggfKkKvAYQWgZQ0sBa2nK89CV+HAlvqE2WsThFDMkKUbH1Y8Glei385VQE7py9KJ0y4KKVw102Xq/vjzry74qhdt1vpXkDsSqrViv/rknMTSfLSV2RcmnJ9hx9dedSGYa2NefJ6S4oauA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PFgcds0F; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731308195; x=1762844195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fi00+RpncPzVAuACaU69mwSsQhQappFQ26XGuBF9PQk=;
  b=PFgcds0FRzt4zFj+lLyA+0j/jaQGOJpfZ2Zr7Btq+k3VhEPxQ/O335EW
   g9jy7UzIRRabyLfXlxg6V5r8QH2YfOXuQQ75Dn5l1j2dFhff/HnKwIBYt
   L929qrgOW6z1v0X8TaGo31auv5MJZ9n+OsjuK7yqNjnXp96Ek9UlTsQVA
   HfQHgkhH18WD8fR3S2Uk/Xzg1l3orq77qxPgMlJCJMVAy4A8Bchg81/LF
   +PeNO4AK6Mf5SimnLwcg6ZEqHxDffMqvrQ6cEix8WHeA88xMxvn0Is1XX
   unMcTcFmGwk6QTJwCFwL/NUvVNx+nCAEwZJqswPwuK5qb8tQkq5DVUk2y
   w==;
X-CSE-ConnectionGUID: lT75xDi8RYiILIE+dkdmKg==
X-CSE-MsgGUID: 6Y6sTHuZRt2Lu/MYse8nCg==
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="201566528"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Nov 2024 23:56:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Nov 2024 23:55:54 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 10 Nov 2024 23:55:45 -0700
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
Subject: [PATCH v6 4/4] ARM: configs: at91: Enable Microchip's MIPI DSI Host Controller support
Date: Mon, 11 Nov 2024 12:25:02 +0530
Message-ID: <20241111065502.411710-5-manikandan.m@microchip.com>
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

Enable the Microchip's DSI controller wrapper driver that uses
the Synopsys DesignWare MIPI DSI host controller bridge for
sam9x7 SoC family.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
changes in v6:
- Rewrite commit message
---
 arch/arm/configs/at91_dt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 2022a7fca0f9..3ff89e27e770 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -145,6 +145,7 @@ CONFIG_VIDEO_OV7740=m
 CONFIG_DRM=y
 CONFIG_DRM_ATMEL_HLCDC=y
 CONFIG_DRM_MICROCHIP_LVDS_SERIALIZER=y
+CONFIG_DRM_MICROCHIP_DW_MIPI_DSI=y
 CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_PANEL_EDP=y
 CONFIG_FB_ATMEL=y
-- 
2.25.1


