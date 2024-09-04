Return-Path: <linux-kernel+bounces-315484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D595F96C332
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D1ACB2920A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107521E4122;
	Wed,  4 Sep 2024 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0WBcAg8h"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C551DEFDA;
	Wed,  4 Sep 2024 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465373; cv=none; b=Ee1pFObCkjUMF4IulB27FWt84Qv1BTg4a0Wk5U/SrgBl+ITJ5Q7VuXW8iM4M4a6fRD4abnbr08HD/gY+siMWgpz/hrmj2V50OB4EG/O5mpx3AoCYQmvdnB2ZJn+aElUfYDZ3KcBXwxi0gEUoigDuHAeLf/Qdo0Nyn8AFC76EZoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465373; c=relaxed/simple;
	bh=Tw80biEmlc7MhNm0KldhbZux/hsIdgselZFFWjggA+E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kmGFQCk6AEs9sit8f7kXP1Qj3lzrZyZ7WH+ijzE+ydcqosRBW+Uqvp0tRVl6G3HQmUiyvn4WnLMHqojswVrEXVVm47aypYyBZnn9/zvls+oJ2SCOPS54gTyXoauJ1YXPouRQxQoTjM5D8N2RP0l6s7WcslI10pe06rtd68kY2Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0WBcAg8h; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725465371; x=1757001371;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Tw80biEmlc7MhNm0KldhbZux/hsIdgselZFFWjggA+E=;
  b=0WBcAg8h2H3146yZtpTBYv9PMFWPQFPBA/PrHntpj+SRPTeY4ebPuK0E
   Nf9zM/hwv5WsZGWcYRR5/47IWY8gI4CDzHMhs5AaizfIwIMmxWwNDRydK
   bHoC9MRhL/sDNFqfu97J5qce64XuhdJsS6HjhL+mTPOXCZahQmQ5mY31a
   +svtFaMUIWXjbTwQ38b5bQfc0AMlyyf/+oF0RE5ptwXTh0dTlQ0NnieDC
   IixOcK6gV1OzzLWva9LBOH11NKxMBTzbH+r/K9oVHMAslq6jQ3K0x7YVc
   KoDPJ9HN2h21DPNh9+y4w6o242LNpdTBRBQnbKpq61D4wrX7huTusxaA3
   w==;
X-CSE-ConnectionGUID: Zt8KU6Y2SmuNhR5My1yuzQ==
X-CSE-MsgGUID: K6B+fxm4SZ66HsY6SdA+Ew==
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="198747136"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2024 08:56:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 4 Sep 2024 08:55:17 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 4 Sep 2024 08:55:17 -0700
From: <Ryan.Wanner@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <varshini.rajendran@microchip.com>, <linux-kernel@vger.kernel.org>,
	<linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, "Ryan
 Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH v2 0/3]clk: at91: add sama7d65 clock support
Date: Wed, 4 Sep 2024 08:54:10 -0700
Message-ID: <cover.1725392645.git.Ryan.Wanner@microchip.com>
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

Hello,

This series adds clock support for the SAMA7D65 SoC. There are also
changes to the master clock driver and PLL driver in order to account for
the increased amount of clocks being supported in this new SoC.

Trying to account for all the updates happening in this system, this
patch set is based off of the most recent updates to at91-next branch.

Changes in v2:
- Correct PLL ID from PLL_ID_IMG to PLL_ID_GPU in the description.
- Adjust master clock description to match amount of master clocks 0-9.
- Correct bad spacing and bad alignment.
- Remove double variable definition.
- Add missing kfree() at end of function.
- Reorganize clk and pll driver changes in patch set.


Ryan Wanner (3):
  clk: at91: clk-master: increase maximum number of clocks
  clk: at91: clk-sam9x60-pll: increase maximum amount of plls
  clk: at91: sama7d65: add sama7d65 pmc driver

 drivers/clk/at91/Makefile          |    1 +
 drivers/clk/at91/clk-master.c      |    2 +-
 drivers/clk/at91/clk-sam9x60-pll.c |    2 +-
 drivers/clk/at91/pmc.c             |    1 +
 drivers/clk/at91/sama7d65.c        | 1373 ++++++++++++++++++++++++++++
 5 files changed, 1377 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/at91/sama7d65.c

-- 
2.43.0


