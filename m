Return-Path: <linux-kernel+bounces-324760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE74975090
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8E00B222AE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0326F1865F3;
	Wed, 11 Sep 2024 11:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="TWjt3PZ5"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2021153BC7;
	Wed, 11 Sep 2024 11:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726053237; cv=pass; b=r7CmgoX4Ldvff0NOkoZtLTV/z0vEMYyGpny32oDdStN5j9QSBjZEpWMiYgV3SXTBzKJcWlgUpnmlEiT5oSituTGn0TjnlRPshtaZPbEgm8/fjSsiNaeBa91EF5arqdtIlB/KRGRfWIAve0gg1beq1qhcYvtrG2zK6UC8i+esbDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726053237; c=relaxed/simple;
	bh=vvzEceivxXAaeFVzoGBbeAyMq0q6mXIP5R+HYZaa088=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jn4x3gwAnIDo4bd+jjSZVCAzsVSHsktP1JBjHjlvp7F4JBVJnfxFnfLe3QcZN51jf56eduwcw+WhgOEx/Hjz6NkfYmVdUM7rEdMriNUBD0LSEe3ftxSdT4Rbi+2lZtI3SgQ2m+vJsT3ubIipFM4AK3ZR76MKrLJJm/DN+wNOd+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=TWjt3PZ5; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726053217; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RXB9/3oANY5nTUeolphJDyuqUgt03mS7Uq4DUnsoxe7U5olk6o4ZWLThGxe5T3XOSNkHMW/kHwThhpDWaiGte4uO8MNfvHujb243vVxytArDPmC+PvY8Gd5pjzy1+p0mm9V1bbGH8F+NR477QUZGtQVo2Jq6e+3J5TVmEfEYD5Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726053217; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rQ+frqDXoNXs+Oeh9kDBpS7St8Ho1h8ItxPVBeYZKW8=; 
	b=Up4g3P5wLsNcwIDOFxLh3UQH+mRQsJHxVWhco2ldwDWIEcPeHKGf8HZTBXGX+B+AdxM4iNko1Nw8lrzr2e02/eMTNJLNaXk+fbtqi5Q7NZ4Xc0G7pOw6z+nWUjpWUn5bYmUuZB+C26R4dtIVKLieJMMfia1EgQyjyN83phc/Icc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726053217;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=rQ+frqDXoNXs+Oeh9kDBpS7St8Ho1h8ItxPVBeYZKW8=;
	b=TWjt3PZ5wi/7j+PeO3vtvlayILucwkNp8pfzaw0X1+GATC6JLFBg/NBaok/SUhBT
	Kj7tKL9ijdsrFm+NDG5EaBhEQ3DMIUEhJ2tNQSTTyGR6DXzuGNVrB17Vf3SrDViYu/Q
	MVyKADz5TqgfIr1izxpAkKlEGk4SLZKsPdqjkBDs=
Received: by mx.zohomail.com with SMTPS id 1726053216304757.7800165796341;
	Wed, 11 Sep 2024 04:13:36 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] ASoC: mediatek: mt8365: check validity before usage of i2s_data
Date: Wed, 11 Sep 2024 16:13:07 +0500
Message-Id: <20240911111317.4072349-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

There may be a case where i2s_data may not get initialized by the for
loop which will cause the kernel crash. Initialize the i2s_data to NULL
and abort execute if it isn't found.

Fixes: 402bbb13a195 ("ASoC: mediatek: mt8365: Add I2S DAI support")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 sound/soc/mediatek/mt8365/mt8365-dai-i2s.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c b/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c
index 5003fe5e5ccfe..89ba891c2669b 100644
--- a/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c
+++ b/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c
@@ -465,13 +465,16 @@ void mt8365_afe_set_i2s_out_enable(struct mtk_base_afe *afe, bool enable)
 	int i;
 	unsigned long flags;
 	struct mt8365_afe_private *afe_priv = afe->platform_priv;
-	struct mtk_afe_i2s_priv *i2s_data;
+	struct mtk_afe_i2s_priv *i2s_data = NULL;
 
 	for (i = 0; i < DAI_I2S_NUM; i++) {
 		if (mt8365_i2s_priv[i].adda_link)
 			i2s_data = afe_priv->dai_priv[mt8365_i2s_priv[i].id];
 	}
 
+	if (!i2s_data)
+		return;
+
 	spin_lock_irqsave(&afe_priv->afe_ctrl_lock, flags);
 
 	if (enable) {
-- 
2.39.2


