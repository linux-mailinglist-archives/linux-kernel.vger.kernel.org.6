Return-Path: <linux-kernel+bounces-330694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1BB97A2D2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FDD61F21AFE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 13:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC70156228;
	Mon, 16 Sep 2024 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jjCVpIhQ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C189153BEE;
	Mon, 16 Sep 2024 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726492795; cv=none; b=Wbwj7ABEPri6jkQbsaOK4R33VrPoE49enHIIAZBKEgnoBzlHone3CYdMR21oeT6zC6TQL0+NjEYX6evgBJfpief2L4AV0ifL5REs6Y0fDqEsL4G5B1QdE3Vudr4e0fXFbzYldHotuvwuiRHQSxmG8ph+dcbhLMfTwKBXyeXNipw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726492795; c=relaxed/simple;
	bh=ERdIfMR2uvWrz1IUsYwPvNndgl85YW06MtCLXaZa2bA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WI/jD28bkMCOFjcSeOkf+nUEv86Xuw5+K5WpxVD/5Q9rZkj4sjQKMIM8IHlmZY1EI1UXUsr9Dqr7YQDBbOBjXOO4sE8+G1+brFMjkOU6pCr8rOBxZszGhyb+DsWpZsBkmyW8w67wk7Kiox4prJG39RuZSCEF8SRpI8iqrTs3AeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jjCVpIhQ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726492793; x=1758028793;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ERdIfMR2uvWrz1IUsYwPvNndgl85YW06MtCLXaZa2bA=;
  b=jjCVpIhQegne2sWTCnoFUZ7l0abrZaLsna77zmM10NiRMdkMycQuR5Xn
   Yf4HaXIJd8F9AUS7fa13whZNyLqqXNIkmki7nafwIXFdN9TrA1fKo34AE
   +gUQvTQcefZWz6lObXVN7CTPZVyxkS1f3AJbE6Xuxi+10MyX7zttxHtob
   R+NvfzBw9y7m+zuhWZU1O/sUlpMXEPgjUmojrD2YEvhkfYXWki2KCXRxV
   n4nak6qxJR7hdpXh1WbEaueMO4Y/kA118cvWdyz5AEX6C6TJcxrm+Ir2z
   uh4IcW9CaH+whzqPLqmYVO4Yr1yEphJKn/VKtaVZ56o4Ith7pp6uX148M
   g==;
X-CSE-ConnectionGUID: oIAdU8ucQc2W5w/WcMunEw==
X-CSE-MsgGUID: UzSuz8qSS7G2B7V5/I5gkQ==
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="31717729"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2024 06:19:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 16 Sep 2024 06:19:29 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 16 Sep 2024 06:19:26 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH v2 0/2] Updates for Atmel SSC DAI
Date: Mon, 16 Sep 2024 16:19:08 +0300
Message-ID: <20240916131910.22680-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch set includes two updates for the Atmel SSC DAI driver:
- Address the limitation with the S24_LE format.
- Add stream names for DPCM and future use-cases.

Codrin Ciubotariu (2):
  ASoC: atmel: atmel_ssc_dai: Add stream names
  ASoC: atmel: atmel_ssc_dai: Drop S24_LE support due to single channel
    limitation

 sound/soc/atmel/atmel_ssc_dai.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)


base-commit: 7083504315d64199a329de322fce989e1e10f4f7
-- 
2.34.1


