Return-Path: <linux-kernel+bounces-320932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B870971234
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09DDE283F16
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAE21B14ED;
	Mon,  9 Sep 2024 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JzXdjm7+"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0EF1AE03C;
	Mon,  9 Sep 2024 08:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725870967; cv=none; b=jBumipD8ZwJ8PNPwBDZVhSvTpFwRMmtOUuUMaKanx+nFuGd2TWcrSW7alUOWcRF7PVFQwXcD7HzqAFxreK2q4hpzwAQwdPNcTIoAVeFZHo/nsscVG3Hq6neyjulnyiE2IKx5I+8aUBfXnyejhWicTrwHi6tZO4pKZ0QZpIBN4kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725870967; c=relaxed/simple;
	bh=i9rGsPZXkd0oGN+TIi2etQvDC7JctZmfbf6HeGrXcZQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cu1g2aoX9vKGb569wz+ewQKLJZ0Jn91tafscJSAXCB1CVnBszztRCh2FS4eRGk9f+lo6t4oXmle1QSQ49gJOv/nAYRWH7loU7BUwBzhr0idh6iFaO33GZ9yW0NZPMI6gk363icn8M1G9QDyQQRoJ7w7g11s45QD/PMTnBvh3LxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JzXdjm7+; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725870966; x=1757406966;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i9rGsPZXkd0oGN+TIi2etQvDC7JctZmfbf6HeGrXcZQ=;
  b=JzXdjm7+izZCDlOMYBGUD+PSyTIZkmQEllpkYtGpH9EE0OQWJSdlX3Oq
   RSBsnv1xDCIjaCIVIssCj5zQLtsTzaiRu8XA+szwW9a8jgMY/9cry0QgR
   SQKScW2DTFrM3foK19c6cYCmKGlBp6dikefHk4+5rnx+1to3CXTnxOpyG
   zK6W0Z+M9qogd5C3JHyy00zJftH/qODqtWUW9pu3qxKhplVOTX5tm4FCI
   SjwLGGyoWJfe+jV4d2TRgvYBIOBPzO9yzmPWr30bJzdanPQqcftbY6/KJ
   tlHRAD8SpXqJ1HXQ6PNGmOPZzxZ86fF6LkfnTh2TR/Araf6k6UeHitZUY
   Q==;
X-CSE-ConnectionGUID: 3+qBZ8ypT7qJuXQunlVkIA==
X-CSE-MsgGUID: 8HHOJHwdRPe90Y2SLoTbTg==
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="198940343"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2024 01:36:05 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Sep 2024 01:35:41 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 9 Sep 2024 01:35:38 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<perex@perex.cz>, <tiwai@suse.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH 0/2] Adjust Stream Name and DT Bindings Updates
Date: Mon, 9 Sep 2024 11:35:28 +0300
Message-ID: <20240909083530.14695-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch set proposes the following changes to improve the flexibility
and configurability of the mchp-i2s-mcc driver by allowing the interface
name to be set through the device tree and by introducing a new property to
better manage multiple interfaces.

Codrin Ciubotariu (2):
  ASoC: atmel: mchp-i2s-mcc: Remove interface name from stream_name
  ASoC: dt-bindings: microchip,sama7g5-i2smcc: Add 'sound-name-prefix'
    property

 .../bindings/sound/microchip,sama7g5-i2smcc.yaml           | 7 +++++++
 sound/soc/atmel/mchp-i2s-mcc.c                             | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)


base-commit: 9aaeb87ce1e966169a57f53a02ba05b30880ffb8
-- 
2.34.1


