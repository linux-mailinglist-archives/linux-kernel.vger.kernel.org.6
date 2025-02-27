Return-Path: <linux-kernel+bounces-535908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2C8A478EE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2CD97A260F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACC6227BAD;
	Thu, 27 Feb 2025 09:19:29 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96635226D06;
	Thu, 27 Feb 2025 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740647969; cv=none; b=WE0RYedcSOFRZmH6p5UbFc8QxaTz7l4yoDnTJGjM2j+5iRhh1E7an0QJEG8aDu2VBIWNYS3AgeeCoj6aYxXt9Js2RQQSPgsK750FZU1QAEbhjVjwb3yeEtnBGvxs5bp2hcUO2xZOkp2INB/tk2lLanZpNCX6S8w3J0ce3tPtIZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740647969; c=relaxed/simple;
	bh=PWMjBxWuSC0iIxfJFlQDQbGQfiYw7mI0un5V6Uhs49g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gQ5FLlXjIFmUN5nejb5V0zjS/0D3wlmxSGMZPDqO/ZaEsPrrdWSug/SQumXJlhEAepiczujYAof9GS/cd3zNY3M3KjTC6T1iH2/uuiEV1pCFcQOOrfcTrB/4YRE69ISkmC80QcvNc/xruv7sIy5woI3RkVs43bP2e9lLgbbpV98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201612.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202502271718100684;
        Thu, 27 Feb 2025 17:18:10 +0800
Received: from locahost.localdomain (10.94.4.82) by
 jtjnmail201612.home.langchao.com (10.100.2.12) with Microsoft SMTP Server id
 15.1.2507.39; Thu, 27 Feb 2025 17:18:12 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <perex@perex.cz>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Charles Han
	<hanchunchao@inspur.com>
Subject: [PATCH] ALSA: opti9xx: fix inconsistent indenting warning in snd_opti9xx_configure()
Date: Thu, 27 Feb 2025 17:18:10 +0800
Message-ID: <20250227091810.18847-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025227171810ebb21338f11e10fe33f6a7f69ed5be8a
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Fix below inconsistent indenting smatch warning.
smatch warnings:
sound/isa/opti9xx/opti92x-ad1848.c:489 snd_opti9xx_configure()
warn: inconsistent indenting

Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 sound/isa/opti9xx/opti92x-ad1848.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index 220ea1952c1e..a07a665d93dc 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -486,7 +486,7 @@ static int snd_opti9xx_configure(struct snd_opti9xx *chip,
 #endif	/* CS4231 || OPTi93X */
 
 #ifndef OPTi93X
-	 outb(irq_bits << 3 | dma_bits, chip->wss_base);
+	outb(irq_bits << 3 | dma_bits, chip->wss_base);
 #else /* OPTi93X */
 	snd_opti9xx_write(chip, OPTi9XX_MC_REG(3), (irq_bits << 3 | dma_bits));
 #endif /* OPTi93X */
-- 
2.43.0


