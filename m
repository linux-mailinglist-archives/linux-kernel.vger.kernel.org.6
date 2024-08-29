Return-Path: <linux-kernel+bounces-307328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F754964BDF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1A9D1C22A97
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310FB1B5EB3;
	Thu, 29 Aug 2024 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EVYHfWik"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7661B5806;
	Thu, 29 Aug 2024 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724949826; cv=none; b=WHLcO6j84X/uH8HNtIREdha3gsOhcZTrQf0YV85pgD+ntCmi6cW5ICigaiTh6PSQgzGxbFkg5PzlRHCOUaG7ab5bw50bG16hIdjSioGyBwoc2UO2yZyRoONN7pVmNQ/Vbol8pQ+PH1Onp0LFOvPJtFc+3e6SHZ2uUX12q2oyZ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724949826; c=relaxed/simple;
	bh=xmyur0FkYgY5gh9dMIyysY3g10OJ0MeyuI9J1sVCvMk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jYoG7fJhE3QK7vzNxgaffvN9zB23tzzSIQWiMI+G1wz2oPpLVQv4jg5eGlGJHjRFyvYAm/NAQSBR5VQcgdk7waetvW0YlcQfq1U4h3Tj/2sKHZc4Z8Fcvo2JRVcnP5lMk6C5XRTkg7t81LhVUulL/d7xdnqufy68goBPcE97+U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EVYHfWik; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1724949824; x=1756485824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xmyur0FkYgY5gh9dMIyysY3g10OJ0MeyuI9J1sVCvMk=;
  b=EVYHfWikgLPEc/dv5nAU4G3rim/iHh64HyTzi66Z1oRy9lBGBsb/f5iA
   AkZuWxxBx1NJSDWV5swXDCmr/EAEXebNZ9xU+WkHd6nGGrWc1ATVvISnw
   2ivAtq/h4xokH0Oc85sHct/VMxJTTicjTR5a6X5GWK26wamSskMHRhuSK
   bAAJR/rtkYQvjkNI2SvzGsMvC59wqnbkHr0yXrLXfdtkV5pn+db+5Qull
   skCD/SgOhh3zs/9DHSSosFY4c7y9M9uPywiV/xzszJbML6Dlzhnv78tnS
   Kctl8srA2R3UyupiZulEKN/w2gR9gM7J0VD/TNn9vgud9t0lzc7qHIb/1
   g==;
X-CSE-ConnectionGUID: lTG1XX2gTL2f2PJAf78vQA==
X-CSE-MsgGUID: uRg0VkoQRKmHonahkydx9Q==
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="30998143"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Aug 2024 09:43:41 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Aug 2024 09:42:52 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 29 Aug 2024 09:42:51 -0700
From: <Ryan.Wanner@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH 2/3] clk: at91: clk-master: increase maximum number of clocks
Date: Thu, 29 Aug 2024 09:42:26 -0700
Message-ID: <677567f08ae588bdd9f919c6501c23be075c0efb.1724948760.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724948760.git.Ryan.Wanner@microchip.com>
References: <cover.1724948760.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Increase maximum number of vaild master clocks. The PMC for the SAMA7D65
requires 9 master clocks.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/clk/at91/clk-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
index 15c46489ba85..7a544e429d34 100644
--- a/drivers/clk/at91/clk-master.c
+++ b/drivers/clk/at91/clk-master.c
@@ -20,7 +20,7 @@
 
 #define PMC_MCR_CSS_SHIFT	(16)
 
-#define MASTER_MAX_ID		4
+#define MASTER_MAX_ID		9
 
 #define to_clk_master(hw) container_of(hw, struct clk_master, hw)
 
-- 
2.43.0


