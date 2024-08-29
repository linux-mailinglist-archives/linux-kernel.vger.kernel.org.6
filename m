Return-Path: <linux-kernel+bounces-307327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E96964BDD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D655FB21945
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715BA1B5811;
	Thu, 29 Aug 2024 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LjUM8rdz"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F3B1B0132;
	Thu, 29 Aug 2024 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724949824; cv=none; b=pyYJ/j4nEzAdndMrN4TE3B/CT0Mufv7HVzBSj9KVUwds3f/aA6H7nrjyllYtwFbz5nBeYgIDOWMAMuqx1vQjeNBIEGbGId2Dobe6ifVIHtscDjlSSd4JDlAULeWni/gG8vHZeld3TARWx9bsyxyl8sbWp/HsuTbar/d3cL/8SuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724949824; c=relaxed/simple;
	bh=NjJkt4vXF4NIDFPbFvPvLne8R7TXTIItEN5lI5RXWKU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ldkf6Th9QOYtgHeocDtXnZVwULm5L8Ps4VakyMHzIgzoZrlC1uDhiXUCIY5EhmP7MoEHQrDeW0eBJbT5OLWFkxO9Uanwelilugv+7Uyr8qCtsTA6fTJoNoe+sw55/Cs9RnzKIDKmLkbwmfOgeVMiO4c9H2guaWeBPHxNhhM9BwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LjUM8rdz; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1724949822; x=1756485822;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NjJkt4vXF4NIDFPbFvPvLne8R7TXTIItEN5lI5RXWKU=;
  b=LjUM8rdz5iVs1avo6c4zSIH23yGUg5FYPZ87ocSpJz0V+9SeDWB/Fvaw
   YT5qQUoKXQZNoVY6wxxLTgIVeXJuLUgdqMfK6qRTamRLUwr835o++anom
   LHVGFeNabyzODwuTljbTQZUeOlbM3IZNWPl/Z0aOwqwHykGLpoY0NhCW/
   t3XYeUA5sMIAVLdjTbIw66CgZt4Qgsg386vEkZgrkEONOLN+qJd4ltRIZ
   +4BslBMMgg+i8dlS5eB0O4XlppXne1+eT4If92+wkQa052CgA8Iq6twxA
   wmGuDHNWlDpiFTXb/pGPg7p9PJRPObr8EqrsWQx9M5gs0eRuR964Py7JS
   g==;
X-CSE-ConnectionGUID: lTG1XX2gTL2f2PJAf78vQA==
X-CSE-MsgGUID: YuSZDGyoSzW0P0bf1EDvXQ==
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="30998141"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Aug 2024 09:43:41 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Aug 2024 09:42:51 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 29 Aug 2024 09:42:51 -0700
From: <Ryan.Wanner@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH 0/3] clk: at91: add sama7d65 clock support
Date: Thu, 29 Aug 2024 09:42:24 -0700
Message-ID: <cover.1724948760.git.Ryan.Wanner@microchip.com>
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

Ryan Wanner (3):
  clk: at91: sama7d65: add sama7d65 pmc driver
  clk: at91: clk-master: increase maximum number of clocks
  clk: at91: clk-sam9x60-pll: increase maximum amount of plls

 drivers/clk/at91/Makefile          |    1 +
 drivers/clk/at91/clk-master.c      |    2 +-
 drivers/clk/at91/clk-sam9x60-pll.c |    2 +-
 drivers/clk/at91/pmc.c             |    1 +
 drivers/clk/at91/sama7d65.c        | 1372 ++++++++++++++++++++++++++++
 5 files changed, 1376 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/at91/sama7d65.c

-- 
2.43.0


