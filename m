Return-Path: <linux-kernel+bounces-315482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EA896C32D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2A61C2441F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FC81E2023;
	Wed,  4 Sep 2024 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MYXrr+Pq"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523421E1A1C;
	Wed,  4 Sep 2024 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465356; cv=none; b=eZmNxK9bfFsmf4D4xPuEVKrCynQLigHevVTor91B3KI3wX/lLkZynbS2s9/QxaU9znzRjkQomNvcwZiCyvF3cEt8XS38B3YolLCbmj6Kwbmq5xN0N2srhvnQcc9m93z4bVDFjRYvk9ZKut8VMedxThtP/XM2DfjL1cHvhIVOLJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465356; c=relaxed/simple;
	bh=xmyur0FkYgY5gh9dMIyysY3g10OJ0MeyuI9J1sVCvMk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WiV5OtnldnSPkiUTIuUgrL7evamEKnSXJQfRwrH1qlqgiUBQgPH2odH+NCxbTQboY0V5dWkib4M70YKMbIvfWLi2pZrE8x+JflRwUlQ3ra7o8yFdIEnenZ3JCHoo2zPRzPHrJv9nmdhInWzov7Aesd1jPbAo4IsXew2GVsARkYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MYXrr+Pq; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725465354; x=1757001354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xmyur0FkYgY5gh9dMIyysY3g10OJ0MeyuI9J1sVCvMk=;
  b=MYXrr+PqghRhYN1soymOoayJPETesTWcrE8IUmPlLpBmYuj9uJM9/Jt3
   G6lpd7dDfkFZ0+ZcoNr3ERHPwtHJNBYLyxck6vXiPellWJO4zGYcaw1Lj
   vCZBzitHLJz/o4mJj+900P5lwKf6v7I8vlwXgXBfZNeKiI4T8QCoM9lI+
   NshaKLBDW15Ztb4nZBNbZTsz+dnvWK0GS7W/ugeTd3t5o+x8qS0enOr5X
   JssOrUOGytUe2GnXZRlzgvE7lXsH3sJ/0tCS/6w4ss+6Oy1ZzES6dDFNg
   g/RW02/qxPdAKVpl7R9Zfcx5FNMXBW15vpAPPgf+sr99aaYnJrVobNA7I
   w==;
X-CSE-ConnectionGUID: FgHlL0c1TiaTv48FEqzF2g==
X-CSE-MsgGUID: NceNVj6cTyumBAX8Ow4PoA==
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="31232732"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2024 08:55:50 -0700
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
Subject: [PATCH v2 1/3] clk: at91: clk-master: increase maximum number of clocks
Date: Wed, 4 Sep 2024 08:54:11 -0700
Message-ID: <caca5fa16e5800bb933e37dfb6df8cad4491624f.1725392645.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725392645.git.Ryan.Wanner@microchip.com>
References: <cover.1725392645.git.Ryan.Wanner@microchip.com>
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


