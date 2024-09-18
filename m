Return-Path: <linux-kernel+bounces-332526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31ED497BAD8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8C2282FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F8A17B401;
	Wed, 18 Sep 2024 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SlVi7rjt"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EDB178363;
	Wed, 18 Sep 2024 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726655497; cv=none; b=SzzjuedS6LSVCsohiC/j3pitvfM8bQIkS1lwjcWVsjEoe4QqSe2aFEZuKHsxwJSKL4tu8FCJOP775C6zN8sGyddzvYvD0EPhMAJ3G3x+zJ2OXX2j8H4o5bSnwbUzRA38rsTblNDzkLpmh/1u+uSjs0ussO2b9d2qCik8XaK53qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726655497; c=relaxed/simple;
	bh=zRwVKxY/ljPw+PWBx03TIerZJoDRcw2Ws1V9+SjbY18=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V+L28qczhmI972jLo26/N2mzt38PEr3hxuocjA43oTf9JfNgEY48Cn2bSx11G+1afitguTMyas9f+itXA+rpHAm7cZbd5OaA1bh/b/yHIifNStn2ozojMLxVC1jbSGrWQ0rGogzPH3t3iYF5PDUxC8E62u7EEJTlWg2HXJC9sxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SlVi7rjt; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726655495; x=1758191495;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zRwVKxY/ljPw+PWBx03TIerZJoDRcw2Ws1V9+SjbY18=;
  b=SlVi7rjt2LjmrxKFXITZksUbCvPefOteT1ZzTof3vcj1nRGhwySv7CNJ
   tKtfG4+HW2L3dRBXGrlWjqjZOH4ZGdiEX4uIpEQwG4Gkx9Pz11XBz89kU
   xsM6yQF4AfRSAkOtP/Vrq3Ceux2dWG4HjRRA8ZwVf45mAKpTj4olnoDgN
   m4u8yaSwiuGhKZKTKlPml2aU78/otJNEL23CWvALN/Rq4+XrWkuDWqvtT
   mhKkVordN7Gi7LmzXN7MU9qL6bxoJtOTTE/39sRWoZnFp+mxwBTolwUmk
   lRlGpeChFt/J+7A/Tit63RsF1q8ewuJdECr84ZLgG2w5nvi4AJPZqntbn
   Q==;
X-CSE-ConnectionGUID: XkM55Ki9SVKEk/iYTQx3pQ==
X-CSE-MsgGUID: GsVaWKZST8K4Wl0q9UIIhw==
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="35129244"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2024 03:31:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 18 Sep 2024 03:31:29 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 18 Sep 2024 03:31:21 -0700
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
Subject: [PATCH v4 0/4] MIPI DSI Controller support for SAM9X75 series
Date: Wed, 18 Sep 2024 16:01:15 +0530
Message-ID: <20240918103119.385597-1-manikandan.m@microchip.com>
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


