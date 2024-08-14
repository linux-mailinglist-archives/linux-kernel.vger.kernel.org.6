Return-Path: <linux-kernel+bounces-286307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FEA951965
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31E431C21D13
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7F61AE053;
	Wed, 14 Aug 2024 10:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GH0JWadW"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184C4137772;
	Wed, 14 Aug 2024 10:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723632798; cv=none; b=UA2VJHdP2smxkXsyqSvNanHG0KQqWleqZm196saqLWqzXMTb9wPCQo0a4f/BTC1CsaEMwLoHhB5f+jQBswopHpiex7/oXk1GlfremAMv06lKM6PUIWaOFwlOIeKAbw+a/bU5k/4eK6hbOW8K4+ojudibh35QeslMXYqtcwPDvjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723632798; c=relaxed/simple;
	bh=VyRNW0pzgu9hEM6RnCqtbn9/5EoXpw1bBfdoPlnadZY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cDygXL+qJ0vqpqM23MWaDGkJfaVvUJt6CEuc3YIBx6K0xbpgLpcAce1YYBZCpzPXsV2stcEtHApqWcaIgQuyFEyLOovZXQ+BHeJ9mBkNCU2vKUc/pOpL34jG7izZbbkTjEboLsifRHR3MdrO0yVrvLBR9Pa4aYG5lhK5x7cW+Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GH0JWadW; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723632796; x=1755168796;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VyRNW0pzgu9hEM6RnCqtbn9/5EoXpw1bBfdoPlnadZY=;
  b=GH0JWadW41sHwRouNrWgikI3yHo65F4cFxyokhmW6pkCAHFjzUhZqhuY
   c5ciugy0kC08eTSd4g/FjjMFpWBlWj7rhe5FNdrKOKmW7yRJeFX8YFO9M
   SNrnwgUGERSkFbx3WdKReRQdQat87FmGG/8jLFNIV4p2vD1f+EWRa4B0F
   YiL+TmSRJP9lfKCGLewKAxtjT/kKeqtn94I09IdRkXy8eB96C/3wzGEFo
   wzyU8i8y2Omt/s6rny6QHM8d3GfyhQIOl3Ija/zGMgjpp6YuxFlylQGNF
   5TY4ysIGCtLM1wra2zFNEcurNWXSD33cI8TUH6gN0ce0rd8dj7k0fTAeb
   w==;
X-CSE-ConnectionGUID: sQHlUQmPSH2YUYhfTgs5qg==
X-CSE-MsgGUID: 0o+XPgBAQA+Kf5HKyN+gjQ==
X-IronPort-AV: E=Sophos;i="6.09,145,1716274800"; 
   d="scan'208";a="31149057"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2024 03:53:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Aug 2024 03:53:09 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 14 Aug 2024 03:52:59 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
	<rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux@armlinux.org.uk>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <arnd@arndb.de>, <geert+renesas@glider.be>,
	<mpe@ellerman.id.au>, <rdunlap@infradead.org>, <dharma.b@microchip.com>,
	<dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v3 0/4] MIPI DSI Controller support for SAM9X75 series
Date: Wed, 14 Aug 2024 16:22:52 +0530
Message-ID: <20240814105256.177319-1-manikandan.m@microchip.com>
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

 .../bridge/microchip,sam9x75-mipi-dsi.yaml    | 116 ++++
 MAINTAINERS                                   |   7 +
 arch/arm/configs/at91_dt_defconfig            |   1 +
 drivers/gpu/drm/bridge/Kconfig                |   8 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/dw-mipi-dsi-mchp.c     | 544 ++++++++++++++++++
 6 files changed, 677 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-mipi-dsi.yaml
 create mode 100644 drivers/gpu/drm/bridge/dw-mipi-dsi-mchp.c

-- 
2.25.1


