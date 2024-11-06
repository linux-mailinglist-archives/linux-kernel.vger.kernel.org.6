Return-Path: <linux-kernel+bounces-397940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7379BE2BC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDAE41C233A2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC10C1DBB0C;
	Wed,  6 Nov 2024 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fz2bOWhY"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF85C1D63D2;
	Wed,  6 Nov 2024 09:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730885798; cv=none; b=GnK3b+hl6swZvNtMOfR/pbjLa9EIwVnzFL1k9aBQxKMp4p65QDuteZ8WAOcDq4rvNbrSMg7kMmz/H0MrXLoalgCkwx11kaS4n1V2HLmZTuCmcQdMb/HSPvMVRmaxnkVNVvARoqClc54a4lxZfRCWtbASdoslLebCOBiRqw58RRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730885798; c=relaxed/simple;
	bh=zRwVKxY/ljPw+PWBx03TIerZJoDRcw2Ws1V9+SjbY18=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VszifhCJgKXEAfRXrMeRayOQPPiFKV2OSQUjNyrx7b327XfotCSEQjPaTewkPURgMlBqk65YB2kIxlElku6VmEdViAkQZXTQ/h528v8NLKv4xAEk7QrXgloA/kKKZs1VrhI7565s0gCaHCT6f05iTqaDhtsb3jLfUmYSM0e3ZFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fz2bOWhY; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1730885797; x=1762421797;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zRwVKxY/ljPw+PWBx03TIerZJoDRcw2Ws1V9+SjbY18=;
  b=fz2bOWhYFTVltKsdHA2qPmJSw9tHh0go70chempm+1Z4q4V5Np/ySskj
   ZAag7Yzvzd5iZZqYC8BzifUlDzHd89XN+1ESWkzyI39KoIAcJCk7sod5S
   IIEzMGfnueGlFeL12+CGGLL4qeOzQwfcyhAXWA17vqajdqTRpkFeMsDbr
   /P5+srSTOZaw0ygcsS2RPVI4rvEVD9JsfRTLSUTHYrcqavFrkOtI8Ozey
   hpE2VWPvfuj6CIRpVLwLWOTV4ZpYu4/aKa3/W3higYZw0LKccienoHNiE
   Rpo0uF4Vy2ZKKBOfzqy1BelGqweYlsv3ex/caviDDBEWo+JsGYqtxdwfe
   Q==;
X-CSE-ConnectionGUID: 0kVQr9qhRguhY/PD4s+80w==
X-CSE-MsgGUID: 0myGpt/KRoWHTHzzZOyhBQ==
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="33940994"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Nov 2024 02:35:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Nov 2024 02:34:53 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 6 Nov 2024 02:34:44 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
	<rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux@armlinux.org.uk>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <varshini.rajendran@microchip.com>,
	<dharma.b@microchip.com>, <arnd@arndb.de>, <dri-devel@lists.freedesktop.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v5 0/4] MIPI DSI Controller support for SAM9X75 series
Date: Wed, 6 Nov 2024 15:04:25 +0530
Message-ID: <20241106093429.157131-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series adds support for the Microchip's MIPI DSI Controller
wrapper driver that uses the Synopsys DesignWare MIPI DSI host controller
bridge for SAM9X75 SoC series.

Changelogs are available in respective patches.

Manikandan Muralidharan (4):
  dt-bindings: display: bridge: add sam9x75-mipi-dsi binding
  drm/bridge: add Microchip DSI controller support for sam9x7 SoC series
  MAINTAINERS: add SAM9X7 SoC's Microchip's MIPI DSI host wrapper driver
  ARM: configs: at91: Enable Microchip's MIPI DSI Host Controller
    support

 .../bridge/microchip,sam9x75-mipi-dsi.yaml    | 109 ++++
 MAINTAINERS                                   |   7 +
 arch/arm/configs/at91_dt_defconfig            |   1 +
 drivers/gpu/drm/bridge/Kconfig                |   8 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/dw-mipi-dsi-mchp.c     | 545 ++++++++++++++++++
 6 files changed, 671 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-mipi-dsi.yaml
 create mode 100644 drivers/gpu/drm/bridge/dw-mipi-dsi-mchp.c

-- 
2.25.1


