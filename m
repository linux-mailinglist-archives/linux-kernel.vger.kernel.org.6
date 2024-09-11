Return-Path: <linux-kernel+bounces-324769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04429750A2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38121C220A2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C821862AE;
	Wed, 11 Sep 2024 11:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="BV1MDXxP"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D97C14F100;
	Wed, 11 Sep 2024 11:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726053600; cv=pass; b=XM35IIEhcuXk5ywm2rPFAWrtlT9bJMTaUKPbriO9GJTqgCPj8GNHROlTkBURBQRVhZ64n7nk/l2s69xggZu24KhE2pBH0jXDK/J1ooSenPhBi4/Ivr6t1WaMteSGPNsd4rWviqn8iLqARuMCLq9klWESn97geehyNLoNBapohg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726053600; c=relaxed/simple;
	bh=IU+R0CDTCyZqNwl1hdQaiSBG4BL59OeQElu9XV83p/M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YKV4W2lIwSieIppEl4UdZCK2nFCbchFwtzLZ5rQM/C+ZxQXLiR8/ykdPNPKt6MM5Uk0AYPx476ZWZ8Q82KCq5Y928L+umSQsh1arFITggXZf5rgVKieMHuppE9CB/SJrecegDm28oCfm+/H+zZ4vAOP+xGtMa6qkbH8fxPncvUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=BV1MDXxP; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726053582; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gtHCduAs0xH/UsmlvJTZxWSwcDh7rvNe8NLgCwDIT0HGhB4ElFNDTM1KXskMXPiSsI/pIOMcw8zuh4zTQNO17QbvugHwIZBXrg5YQO1ZEH2jszG/4GheGr6ULF2Ozq79eD95YBO4VxoxBDXuqnRrQ7aXEwUNAEw86GooK6VIhDk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726053582; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4MMnUNTpU/jZwAUKT3bq/cNuDEDn9rEShm45TOlyucU=; 
	b=YuS3YpBAuK1iBJck3lxKKLPXS0CFUMRN2pNGxnRdImR0ShEMe8fXqOglUBysF0CRHGnRblqAHtvGuWwMnRRxCyYFHZZnPhLXQYhIK6AXaiftRusxlPPhz7LR8etHwh8GpYaa9/JGbnfWy5G6XJooIXhAtdOp1ieNj6rVY1YG0/0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726053582;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=4MMnUNTpU/jZwAUKT3bq/cNuDEDn9rEShm45TOlyucU=;
	b=BV1MDXxPk0aQrE6zjowsc+fpQiJVfBR4Mc0mEc+d0mXyfCaoaUD22CuD1W2BTGN3
	bNj7r6OWWjTpo3Ox9Yi0GcdQni/NqJ8hDKxYaXeDKhjtGLUfGlDTpiPncGlV6EuttoQ
	H42PWjKb37oBNV48M4fsmvYPWz4yviPc4DkGetko=
Received: by mx.zohomail.com with SMTPS id 1726053580250115.83142773790291;
	Wed, 11 Sep 2024 04:19:40 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Nicolas Belin <nbelin@baylibre.com>
Cc: kernel@collabora.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] ASoc: mediatek: mt8365: Print the ret value
Date: Wed, 11 Sep 2024 16:19:09 +0500
Message-Id: <20240911111917.4091809-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Print the ret value otherwise it is just being set without ever getting
used. The author may have missed printing it.

Fixes: 1bf6dbd75f76 ("ASoc: mediatek: mt8365: Add a specific soundcard for EVK")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
If it isn't useful, the ret value assignment statement can be removed.
---
 sound/soc/mediatek/mt8365/mt8365-mt6357.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8365/mt8365-mt6357.c b/sound/soc/mediatek/mt8365/mt8365-mt6357.c
index fef76118f8010..412f5fdd8fc52 100644
--- a/sound/soc/mediatek/mt8365/mt8365-mt6357.c
+++ b/sound/soc/mediatek/mt8365/mt8365-mt6357.c
@@ -258,8 +258,8 @@ static int mt8365_mt6357_gpio_probe(struct snd_soc_card *card)
 							   mt8365_mt6357_pin_str[i]);
 		if (IS_ERR(priv->pin_states[i])) {
 			ret = PTR_ERR(priv->pin_states[i]);
-			dev_warn(card->dev, "No pin state for %s\n",
-				 mt8365_mt6357_pin_str[i]);
+			dev_warn(card->dev, "No pin state(%d) for %s\n",
+				 ret, mt8365_mt6357_pin_str[i]);
 		} else {
 			ret = pinctrl_select_state(priv->pinctrl,
 						   priv->pin_states[i]);
-- 
2.39.2


