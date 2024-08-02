Return-Path: <linux-kernel+bounces-272315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B6F945A32
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70551285BAE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DCC1C37AD;
	Fri,  2 Aug 2024 08:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DNS5vdWG"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870291C3793;
	Fri,  2 Aug 2024 08:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722588304; cv=none; b=YWB7ntyydqPsffvrXo2S4D+67Mle1ogQcN3p0so1guqxvFI/RCpYSFWgWFlbpeUbHAUC0S2zx8bum9V9Et1nfT9A76tOJLtwmNwUSXaw0Dh4g60Ho8pKNiTtjo8Dm82rXs+WYYcYRNEF5x+9oUvT6X+9XqW9t1TeOINB0A6UGGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722588304; c=relaxed/simple;
	bh=RzA9EAC+zlXRtUH3OSMIWI1zKwAxArhQ4+AfIrzFlWk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qPMKvoKoJzmc0aIa8N0EgEAbJDvImihUbUx0rbFZ7IdICEKZ6AS6K1c5iPeHBSYtjAnfM1bm4J7f6e1iEboJdwRX3N206TeOO5prt3l88NMyldGQGAIRALhsJ4ARKRafCBRRCVMMptuQSkEn3sdcsrG0z3U7Fjkhb03429bWd4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DNS5vdWG; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722588302; x=1754124302;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RzA9EAC+zlXRtUH3OSMIWI1zKwAxArhQ4+AfIrzFlWk=;
  b=DNS5vdWG+XmvGnEpqISpeGw/XbJUE9DKkQozmGSW6I3LiRnd0xI0CBbu
   K222WzZ3ybVuoPnYerR6INtFachBmsb1caZo+qdk5ra09NdZAPo58ZT2R
   Qd2Azb35eaqu41/+FCwftXpptZwozDKgr+y+H7Pm44yvG0sLnlWa/NfO1
   8ugf1dBH//lunJLpuTiTh/eNYV/BQWHaKdNq3EWpRmRs+iA4bub0cCG4T
   4hbqyXuAzrR2vLOshD5ToEBZCWmZ7d1GNBuMsBBF0u0lbz/qDSuWIYLNT
   Sfcp4skbhXPGsX6JC2VpCoXXiYoXTbue4pVqCRH1jeif8A3x2duljwWsS
   w==;
X-CSE-ConnectionGUID: bDN14xVARKiI6VnRY/1j6Q==
X-CSE-MsgGUID: EYLwDr7YRqi2SpYb9oVYRQ==
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="30677931"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Aug 2024 01:45:01 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Aug 2024 01:44:44 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 2 Aug 2024 01:44:41 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>, <claudiu.beznea@tuxon.dev>,
	<nicolas.ferre@microchip.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<robh@kernel.org>, <alexandre.belloni@bootlin.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH 0/6] Add input voltage suppliers for PMIC MCP16502 regulators
Date: Fri, 2 Aug 2024 11:44:27 +0300
Message-ID: <20240802084433.20958-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

In this series of patches, support for the *-supply property [1]  is added
(correlated with supply_name [2]) from the core regulator.
Link [1]: https://github.com/torvalds/linux/blob/master/drivers/regulator/core.c#L471
Link [2]: https://github.com/torvalds/linux/blob/master/drivers/regulator/core.c#L2064

I modified the mcp16502.c driver and the dts that use this PMIC.
We added these improvements to provide a complete description of the board power scheme.

Snippet (as an example) from /sys/kernel/debug/regulator/regulator_summary
(for at91-sama7g5ek):
# cat regulator_summary
 regulator                      use open bypass  opmode voltage current     min     max
---------------------------------------------------------------------------------------
 regulator-dummy                  1    0      0 unknown     0mV     0mA     0mV     0mV
 5V_MAIN                          6    6      0 unknown  5000mV     0mA  5000mV  5000mV
    VDD_IO                        5    4      0  normal  3300mV     0mA  3300mV  3300mV
       e1208000.mmc-vqmmc         1                                 0mA     0mV     0mV
       e1208000.mmc-vmmc          1                                 0mA  3300mV  3400mV
       e1204000.mmc-vmmc          1                                 0mA  3300mV  3400mV
       VDDOUT25                   3    2      0 unknown  2500mV     0mA  2500mV  2500mV
          e1000000.adc-vref       1                                 0mA     0mV     0mV
          e1000000.adc-vddana     1                                 0mA     0mV     0mV
    VDD_DDR                       1    0      0  normal  1350mV     0mA  1350mV  1350mV
    VDD_CORE                      1    0      0  normal  1150mV     0mA  1150mV  1150mV
    VDD_OTHER                     2    1      0  normal  1050mV     0mA  1050mV  1250mV
       cpu0-cpu                   1                                 0mA  1050mV  1225mV
    LDO1                          2    1      0 unknown  1800mV     0mA  1800mV  1800mV
       e1204000.mmc-vqmmc         1                                 0mA     0mV     0mV
    LDO2

-------------------------------------------------------------------------------------------
Andrei Simion (6):
  regulator: mcp16502: Add supplier for regulators
  ARM: dts: microchip: at91-sama7g5ek: Add reg_5v to supply PMIC nodes
  ARM: dts: microchip: at91-sama7g54_curiosity: Add reg_5v to supply
    PMIC nodes
  ARM: dts: microchip: at91-sama5d2_icp: Add reg_5v to supply PMIC nodes
  ARM: dts: microchip: at91-sama5d27_wlsom1: Add reg_5v to supply PMIC
    nodes
  ARM: dts: microchip: sama5d29_curiosity: Add reg_5v to supply PMIC
    nodes

 .../dts/microchip/at91-sama5d27_wlsom1.dtsi     | 14 ++++++++++++++
 .../dts/microchip/at91-sama5d29_curiosity.dts   | 14 ++++++++++++++
 .../arm/boot/dts/microchip/at91-sama5d2_icp.dts | 14 ++++++++++++++
 .../dts/microchip/at91-sama7g54_curiosity.dts   | 14 ++++++++++++++
 arch/arm/boot/dts/microchip/at91-sama7g5ek.dts  | 14 ++++++++++++++
 drivers/regulator/mcp16502.c                    | 17 +++++++++--------
 6 files changed, 79 insertions(+), 8 deletions(-)


base-commit: f524a5e4dfb75b277c9a5ad819ca5f035f490f14
-- 
2.34.1


