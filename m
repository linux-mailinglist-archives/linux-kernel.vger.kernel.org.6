Return-Path: <linux-kernel+bounces-240750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2B7927215
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F51D28788F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1985E1AAE15;
	Thu,  4 Jul 2024 08:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zbMOtq5w"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDED1A2554;
	Thu,  4 Jul 2024 08:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083004; cv=none; b=AlvHzxCh6URlCf/JH27KXhytTt5+RmlfrPVj368pB6XyRE5tn57UTF7teYNGEmjfWCkkAulzczo/nDJA+TInvS9WrLoq2zZ7BT3mtMmhC+0DbYOEbLxOHRL/ai4W7IapVLWNZof2zTrdiMdFvQxE/WxwEXozp23xlmq2IBsdka8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083004; c=relaxed/simple;
	bh=taELz09kemQcRTcnI5iQ5KPDeTeYJTdJK5+QS+mBmtQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h2hcdTyRpaMEH3j2uHbUL/NtD9c7ejkAiS8YJwS8IwDE/KZZjZXBVhVzlKAxKv9Bi7NWedRXV3ZVxLxZpKKcjYQxjGxK5ZkmS/eY3LOBWDQq8dx8q7od4fJJzzaQf0sj3NRZKsSckDLA3TNccEdzYat4XuYIycuIMGFlqgsVW0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zbMOtq5w; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720083002; x=1751619002;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=taELz09kemQcRTcnI5iQ5KPDeTeYJTdJK5+QS+mBmtQ=;
  b=zbMOtq5wxHblZWbmSzYvx47wqcdqUvA6a+IgILuVlgvMwn1ezJquKR0y
   Lb8N9BuZzI+ibVKgVcOdP3b7TVTQLeE2gKL0J2HYbxAfXYP+meGKwXOTf
   1K6NV3YiQAXpCab01LygKM/snEBGUNuSHWiHixAcjkwo9exgGQfFJVmWC
   M9eqim61P7DbQu+ZhUDbgroyySkA8MF8ju7DU5oPxiw27AwhrPrpkzmHX
   t5p72pJPfe/eBOjZJwJ2I5ZL9+FuG9agMyYZUPdmTTMrdTdwFOBFTtARj
   g+NBwfkEKFIg45UagHGw0nJWKHpTbc8urXPLDD78LmfoeOLV8ZdoZYAxG
   g==;
X-CSE-ConnectionGUID: kCPvKpFuTFyELXI+0A+2CQ==
X-CSE-MsgGUID: 6Zy3XaIjSHW4BIiCUH1q7w==
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="28816296"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2024 01:50:01 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jul 2024 01:49:21 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jul 2024 01:49:10 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
	<rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux@armlinux.org.uk>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <arnd@arndb.de>, <Jason@zx2c4.com>,
	<palmer@rivosinc.com>, <mpe@ellerman.id.au>, <rdunlap@infradead.org>,
	<dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <manikandan.m@microchip.com>, <Hari.PrasathGE@microchip.com>,
	<Nicolas.Ferre@microchip.com>
Subject: [PATCH 4/4] ARM: configs: at91: Enable Microchip's MIPI DSI Host Controller support
Date: Thu, 4 Jul 2024 14:18:37 +0530
Message-ID: <20240704084837.168075-5-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240704084837.168075-1-manikandan.m@microchip.com>
References: <20240704084837.168075-1-manikandan.m@microchip.com>
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


