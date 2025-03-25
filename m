Return-Path: <linux-kernel+bounces-575676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C91A705AE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08EF83A6091
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFB325487B;
	Tue, 25 Mar 2025 15:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vgd4XF02"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AAF209F40;
	Tue, 25 Mar 2025 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742918194; cv=none; b=X8MBGGgw47a+VdxzzMFlZmU1IBy6hL8c8M2Q309xtkJTasVvkLbNZ1l85Q3AP8wPLTtKwSyB8vMRXlnXv1AW0ug5zHBlx4y/Is9m+1ZKs3tLWUEPY2s+T/08BW08KQ3qCIbA38EoTgmk1wlWaQBJb+pNpWFJFSwynsHKadnpOSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742918194; c=relaxed/simple;
	bh=RjnIcXoOqxE+zxLIlZuGZ3NgudIunxk4QATpRpSyCrI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lTJvD4McnJ17uXU76t9K5uQzlVaFdhWbZqeUyDXhZwqtbhJRFCLWVNdpb4Y6IagSTsKKEn5zILfz51srU+ekFpfr1SQaIQoKvulXla5J6N8RSKFNhU409dZYxKP3YCH7I4THQmvqpFo99+rauK9Nv6hXShrcQ2TkChschQsG+DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vgd4XF02; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1742918193; x=1774454193;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RjnIcXoOqxE+zxLIlZuGZ3NgudIunxk4QATpRpSyCrI=;
  b=vgd4XF026wWpYpbt+hKlcSBS86uqo1ISRAQvvKhlpIenh6T+BOHKsi5j
   YP65BBXKZnzGQ8waDziZAgrRy9qj5dAVCHLEasznpSV88zXNxcwRyYae4
   fZj130iIE/5syaIOwwocV+ExwPwVZsIqkw/AKHT90HaGOFFpZ1Yeqp7N3
   PkWC/bhlrYR3N3QaFfx9jtqe9JYRsx18+0pFAqpeERR14fyF/3RnNx5Cc
   UzRxUMmUcBKd8Xh3/muMoC+MO99B6nPg5dRqXWXOEkTDCFk/aDAzJ3w8y
   H87OPB2g8KSo1lAYMcifOCDeiCdgq/jhzVPFzZfsq5q1/pBiElQOUE0p3
   A==;
X-CSE-ConnectionGUID: 5ZRRXf5LQVCIU2dRAgtdWw==
X-CSE-MsgGUID: 6hQuaWmuSxy8lOAwfp4MQQ==
X-IronPort-AV: E=Sophos;i="6.14,275,1736838000"; 
   d="scan'208";a="40152225"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Mar 2025 08:55:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Mar 2025 08:54:53 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 25 Mar 2025 08:54:53 -0700
From: <Ryan.Wanner@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <mturquette@baylibre.com>
CC: <sboyd@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-clk@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH v2 0/4] AT91 SAMA7 SoC Clock Adjustments
Date: Tue, 25 Mar 2025 08:55:06 -0700
Message-ID: <cover.1742916867.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

This set has clock system adjustments for the AT91 clock system for
sama7 SoC family.

The first is to adjust the slow clock driver to account for the updated
DT node-naming for clocks and xtals and ensuring the driver is still
backwards compatible.

The second and third are adding a missing clk_hw struct that are not added into
parent_data struct causing a incorrect parent for main_osc for both
sama7d65 and sama7g54 SoCs.

The last patch updates the device tree phandle formatting for the
sama7g54 SoC.

Changes v1 -> v2:
- Add clk_hw struct to parent_data adjustment for the sama7g5.c driver.
- Add correction to sama7g54 dtsi main xtal phandles.

Ryan Wanner (4):
  clk: at91: sckc: Fix parent_data struct for slow osc
  clk: at91: sama7d65: Add missing clk_hw to parent_data
  clk: at91: sama7g5: Add missing clk_hw to parent_data
  ARM: dts: microchip: sama7g5: Adjust clock xtal phandle

 arch/arm/boot/dts/microchip/at91-sama7g5ek.dts | 18 ++++++++----------
 arch/arm/boot/dts/microchip/sama7g5.dtsi       |  4 ++--
 drivers/clk/at91/sama7d65.c                    |  1 +
 drivers/clk/at91/sama7g5.c                     |  1 +
 drivers/clk/at91/sckc.c                        | 12 ++++++------
 5 files changed, 18 insertions(+), 18 deletions(-)

-- 
2.43.0


