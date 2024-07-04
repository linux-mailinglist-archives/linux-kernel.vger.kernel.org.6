Return-Path: <linux-kernel+bounces-240745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A84927204
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0211F2266A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8CE1A4F0F;
	Thu,  4 Jul 2024 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dMzgiVrc"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A011370;
	Thu,  4 Jul 2024 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720082943; cv=none; b=aFACm4PVi41qg8yEiFsQaVnzBA1aC8UrXQkJk2ObdBfg00/U639i8rBGH3uTi2ruDWnpK0DF6PMZcfQJXV3XY3qw++3wFuDKJXCMkiR5PVO/jGEttEs8iOz19lNkW+Z0locBurrubWy65GDpEDS0O5ZA5/1Wsvacfy24mrpIfzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720082943; c=relaxed/simple;
	bh=6OGaUirB1Zx4+PAf2XdQDYv7eDir1lsj51DFM/Dy5uc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=caLHwtdJkjz7/tQNe/c/ZW9xd3eTdl/g+fV3cFlbyKhkfTgSIGgcRCfE0l8gLZ2Cj0DH69mqMHa+AkgJpduqkcnjbqnjabSUGr/LibLyq5Y0Canrsu86/uGpaXV9sZohJ1srp6toD/BulV2LFVV0q08ynkSWmPsubfLlJ1LuA1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dMzgiVrc; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720082942; x=1751618942;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6OGaUirB1Zx4+PAf2XdQDYv7eDir1lsj51DFM/Dy5uc=;
  b=dMzgiVrc++c1UqxpWsXf2+fbG1ntSK6pNQJb5Wa00gzQQDSpkPjxW+Y0
   KEDbuqQNX/rSsowYwsZPUP4n7SsREdtaB3wdwqHN6JQPZq190HKkMTian
   12/p8StKBjU7VYcX3/l7Jcg5r5Sn2/856nKtE/+lpci/hIC8tfTDqVUvg
   p4fM8rc0S9O2AXecYciFZvoyyVIpOXXl8DunlBLkYCs/BmEyY/DETvm6M
   +Hl/PnLY6khlHS1DQ7WbBRgupKPCfWeL9Vhj7PWZbiwP8Kcwx1PiHpFy6
   dsa8c6IYHwfzVtzv3aicCRMgzmv29ofUe91Kh+gUQsHR7f59OQajL8DA4
   A==;
X-CSE-ConnectionGUID: P8oC09iYTbiC6zlrCMbj5A==
X-CSE-MsgGUID: w5iYUbmBQ2Gflk7jBCv1Rw==
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="29486309"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2024 01:48:54 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jul 2024 01:48:32 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jul 2024 01:48:21 -0700
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
Subject: [PATCH 0/4] MIPI DSI Controller support for SAM9X75 series
Date: Thu, 4 Jul 2024 14:18:33 +0530
Message-ID: <20240704084837.168075-1-manikandan.m@microchip.com>
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

Manikandan Muralidharan (4):
  dt-bindings: display: bridge: add sam9x75-mipi-dsi binding
  drm/bridge: add Microchip DSI controller support for sam9x7 SoC series
  MAINTAINERS: add SAM9X7 SoC's Microchip's MIPI DSI host wrapper driver
  ARM: configs: at91: Enable Microchip's MIPI DSI Host Controller
    support

 .../bridge/microchip,sam9x75-mipi-dsi.yaml    | 135 +++++
 MAINTAINERS                                   |   8 +
 arch/arm/configs/at91_dt_defconfig            |   1 +
 drivers/gpu/drm/bridge/Kconfig                |   8 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/dw-mipi-dsi-mchp.c     | 544 ++++++++++++++++++
 6 files changed, 697 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-mipi-dsi.yaml
 create mode 100644 drivers/gpu/drm/bridge/dw-mipi-dsi-mchp.c

-- 
2.25.1


