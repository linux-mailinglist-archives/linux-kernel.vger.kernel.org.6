Return-Path: <linux-kernel+bounces-330404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8CF979E0D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85A1F28411C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241C814B07A;
	Mon, 16 Sep 2024 09:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Gzjr1ACe"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3BA1494B2;
	Mon, 16 Sep 2024 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726477906; cv=none; b=dZDRHmE+dK6cVfbaWmFi8oH6DJIc+WIDPawcEXa32N+wgdw+XV0RoXrFvylX4vWdQMul4MVTjoIR0hxrM6sj/4igB+eewlPqf4PYjZUYKYiA+lxWdydpTZF/iNgRCg8IAi4Utu6L4EedPJKJHLfTZqAVXASMz9Ftk2Jp2NRkq8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726477906; c=relaxed/simple;
	bh=yUY2mwNXerJkwLgbRFEiCz35UZmfMk8zFAqn458H3Bo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gaW1qWDGUENsPIvUHXZLimtfQUvmPizBJBxzyowP6ubuTYf46Rmz5X3r++x09oCsrIvuvLxZEDvIgKISpvw8OFnu1MLksajlxH4T2szJJH9x4gqSWHOXPOku0yrQ0oZatEoiNyN4ftc3/CyJ4EUZInQtL/34R/T84iyv5MMCiVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Gzjr1ACe; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726477904; x=1758013904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yUY2mwNXerJkwLgbRFEiCz35UZmfMk8zFAqn458H3Bo=;
  b=Gzjr1ACeimxXDM2oeXrfsSET/c0a9X/kYcuJ9UECRd3j1LU1sUZEb/qV
   A9vVxRI/GyvLmj/WdFjVxnLYYpUF/p92kOj/0mtb6Pi7QV4bf5Rs3CVwS
   i8XoaOgRvxt6YaG8uj/ZR+e5NeOR+ps1BY+EcccTAaQbLiOPhDaPtM57l
   Sr12dVFS2wr5nSCZImMPAUBmbCdPdb6gL7rHP6k7CqqUK84bEYMVRHUGH
   sEXCP6oVEJuQqS7auZz1oe5NS6bS/NnpVInkSakQET2W0e1OPrpqPj6I4
   Hm42RCNCjz9LLYjMVMJ9wB8tS/asHj3yc3AV09pp7+ZVmoLYPR5ZLG0ug
   Q==;
X-CSE-ConnectionGUID: zBJi05dESDObnv88EXzWcg==
X-CSE-MsgGUID: X74qlIngRCeLSFQLyaNv/Q==
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="34997190"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2024 02:11:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 16 Sep 2024 02:11:26 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 16 Sep 2024 02:11:23 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, Andrei Simion
	<andrei.simion@microchip.com>
Subject: [PATCH 1/2] ASoC: atmel: mchp-spdiftx: Remove interface name from stream_name
Date: Mon, 16 Sep 2024 12:10:56 +0300
Message-ID: <20240916091056.11910-2-andrei.simion@microchip.com>
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
 sound/soc/atmel/mchp-spdiftx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/mchp-spdiftx.c b/sound/soc/atmel/mchp-spdiftx.c
index 4c60ea652896..245c0352c141 100644
--- a/sound/soc/atmel/mchp-spdiftx.c
+++ b/sound/soc/atmel/mchp-spdiftx.c
@@ -707,7 +707,7 @@ static const struct snd_soc_dai_ops mchp_spdiftx_dai_ops = {
 static struct snd_soc_dai_driver mchp_spdiftx_dai = {
 	.name = "mchp-spdiftx",
 	.playback = {
-		.stream_name = "S/PDIF Playback",
+		.stream_name = "Playback",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = MCHP_SPDIFTX_RATES,
-- 
2.34.1


