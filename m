Return-Path: <linux-kernel+bounces-330405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7295D979E0E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CCC5283F28
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB2B14B946;
	Mon, 16 Sep 2024 09:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ql+hKkx8"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6248D14A4F5;
	Mon, 16 Sep 2024 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726477906; cv=none; b=VBC2cr1oJIbban9MCia2tyCFpzVn/rDsEQrG5RBuClQ0sdQbIgK1QWld1NZ7AK2VwH4kQwhx8YGAcNXYlY6eg+cERElQGdvHw7RMDK7dEWTH2wiHJX/40SiqZYsaAJys4t5uTmOKXo9cZ7w+GnIvTMPScG3h4hnAnfU2NHo+NKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726477906; c=relaxed/simple;
	bh=WzMOI6uVh9ZS7Z0+9PLGOHkUmsJPm9EqL/liuVJiUEo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=avIPo4pKTZfSjMi18J28S+leSj05IYnkJFPYty5J//Vl3lxBCnQcnlox71wH8dIgL66dTD2GLUoVgy+kXlgvJ/CMmyGubiacpxa4dO4DajFcFLh1SafIVZuk0QUSpRllNhIxErd3Pbp3buZo3vV6osz/wu6I9cEuiNOUd82SJvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ql+hKkx8; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726477905; x=1758013905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WzMOI6uVh9ZS7Z0+9PLGOHkUmsJPm9EqL/liuVJiUEo=;
  b=Ql+hKkx8TKRRy4lyKD7iWD0ibn0EU1knxHxUOTa3LhJkG4IPNZ3yX2Kc
   TgtV/4tdMkKhve3kqMTlmOzsWb095Zu+1uli6twV2M5VtmEqBXM/7sjYJ
   0YPWJR8SjEIH4TafJ/e+EjFYxjFeaKgMMlBfWzZ1lZHcOwIM0Tp/nWM6E
   SsKGkYlbLCeIGODHpYWdbOzImL6p5vk6Y+Sf0Oe7eW+5ZPVl/KQMWxbNT
   Bq4v1XJkztHAs2kAnRqlDkeN4zcbDoZk5OMP9V4ezJFRG6wiqcd4gyNTD
   3yRurGd0JbKXIa56fWugTYXr9jCPwl8JOLnXIZqSKBWEWPgqhSThfSwde
   g==;
X-CSE-ConnectionGUID: zBJi05dESDObnv88EXzWcg==
X-CSE-MsgGUID: rrPzMFViSc+h7i4e4hYxVA==
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="34997192"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2024 02:11:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 16 Sep 2024 02:11:29 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 16 Sep 2024 02:11:26 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, Andrei Simion
	<andrei.simion@microchip.com>
Subject: [PATCH 2/2] ASoC: atmel: mchp-spdifrx: Remove interface name from stream_name
Date: Mon, 16 Sep 2024 12:10:57 +0300
Message-ID: <20240916091056.11910-3-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916091056.11910-1-andrei.simion@microchip.com>
References: <20240916091056.11910-1-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

Remove the interface name from the stream_name. The interface name (and the
index of the interface) can be set in DT using the sound-name-prefix string
property.

[andrei.simion@microchip.com: Adjust the commit title.]

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
 sound/soc/atmel/mchp-spdifrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/mchp-spdifrx.c b/sound/soc/atmel/mchp-spdifrx.c
index b2507a1491b7..fb820609c043 100644
--- a/sound/soc/atmel/mchp-spdifrx.c
+++ b/sound/soc/atmel/mchp-spdifrx.c
@@ -1014,7 +1014,7 @@ static const struct snd_soc_dai_ops mchp_spdifrx_dai_ops = {
 static struct snd_soc_dai_driver mchp_spdifrx_dai = {
 	.name = "mchp-spdifrx",
 	.capture = {
-		.stream_name = "S/PDIF Capture",
+		.stream_name = "Capture",
 		.channels_min = SPDIFRX_CHANNELS,
 		.channels_max = SPDIFRX_CHANNELS,
 		.rates = MCHP_SPDIF_RATES,
-- 
2.34.1


