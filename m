Return-Path: <linux-kernel+bounces-576569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0F7A7113A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E49170A20
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A9F199FAF;
	Wed, 26 Mar 2025 07:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ukCZcgiS"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E0442069;
	Wed, 26 Mar 2025 07:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742973744; cv=none; b=KKlK2yu2/sjObXvcu+x1KxzmLeusCA+PFhA9GkN7mcpUx5rnDT984zx3OFr2G+ou/MRIZG8WTfo4n8ajSvCzLNFkHVcVRs5BcUbLtiAHUGke57kTi/jrZqoCVYxOrKzUNiB8uMQ3EmUNSTsoHYod5L0O6G/4/FewMR4FdUwbyzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742973744; c=relaxed/simple;
	bh=LkdvidHwFI1XZ/fCNSF3hN2TCT+VGgb2P8S9pghKT6c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=peDc++iCjX6su0w+7QMRSIIvCUU+8Ls1Syy7LFQpyC60yuwvwKZouiiG9CjR01rb7JxXrWI0kjoRstoXNPsp5oUX6E5k/2zWX/WNalW8m916AQhfJotBRCnzB4q3CpaVDp9Oyv6GDaWuoWTOQxYx65m/8RQ2+E8JMNhTXubBP+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ukCZcgiS; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1742973743; x=1774509743;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LkdvidHwFI1XZ/fCNSF3hN2TCT+VGgb2P8S9pghKT6c=;
  b=ukCZcgiS0ex4Xak7pqmacCs/KUnzVPiwkp1Qxo6vWkXxxh3xRIC1UCaE
   +d39loPl8z+YnqLYqE60ZBDa2o1DURXYLO1UjJ1aj1XwyFU2QCfYZCGKI
   6Q0i+cQSA8CFKSh8dwyQOpLcrfHuWBTEmcT5+CC8geOFYt+GZ7IRxLH4r
   mCiweBd3DCC9XwUEkga2GjLkDHmk7GoHuLzRQQYiZDTQCBUp4UH2rh+03
   UNS+hEPApmx8CxNJzvRO+dWFd0bDZoRRE/xn5I4KipUQhZg/JY+2DA9GW
   laNxUWN/s7KHBW2hVaZLIEWIA93eTBCzk2xzfri1Y1TPZowPXE4jFowye
   g==;
X-CSE-ConnectionGUID: QApF+UAWRZutY2upgn7tGQ==
X-CSE-MsgGUID: rG3UIBc2SbONS57bMchvBg==
X-IronPort-AV: E=Sophos;i="6.14,277,1736838000"; 
   d="scan'208";a="271100162"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Mar 2025 00:22:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Mar 2025 00:21:51 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Wed, 26 Mar 2025 00:21:44 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <tudor.ambarus@linaro.org>,
	<pratyush@kernel.org>, <mwalle@kernel.org>, <miquel.raynal@bootlin.com>,
	<richard@nod.at>, <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mtd@lists.infradead.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v2 0/3] Read MAC Address from SST vendor specific SFDP region
Date: Wed, 26 Mar 2025 12:51:37 +0530
Message-ID: <20250326072140.172244-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series adds support to parse the SFDP SST vendor map, read and
store the EUI-48 and EUI-64 Address (if its programmed) using the
resource-managed devm_kcalloc which will be freed on driver detach.
Register EUI addresses into NVMEM framework for the net drivers to access
them using nvmem properties.
This change ensures consistent and reliable MAC address retrieval
from QSPI benefiting boards like the sama5d29 curiosity and
sam9x75 curiosity.

--------
changes in v2:

- 1/3 - parse the SST vendor table, read and store the addresses
	into a resource - managed space. Register the addresses
	into NVMEM framework
- 2/3 - add support to update the QSPI partition into 'fixed-partition'
	binding
--------

Manikandan Muralidharan (3):
  mtd: spi-nor: sfdp: parse SFDP SST vendor map and register EUI
    addresses into NVMEM framework
  ARM: dts: microchip: sama5d29_curiosity: update the QSPI partitions
    using "fixed-partition" binding
  ARM: dts: microchip: sama5d29_curiosity: Add nvmem-layout in QSPI for
    EUI48 MAC Address

 .../dts/microchip/at91-sama5d29_curiosity.dts |  62 ++++---
 drivers/mtd/spi-nor/sfdp.c                    | 161 ++++++++++++++++++
 include/linux/mtd/spi-nor.h                   |   7 +
 3 files changed, 206 insertions(+), 24 deletions(-)

-- 
2.25.1


