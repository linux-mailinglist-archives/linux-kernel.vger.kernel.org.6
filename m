Return-Path: <linux-kernel+bounces-324917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A90BB975295
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E391A1F28570
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA81187352;
	Wed, 11 Sep 2024 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="N4dDIJCj"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87C3770E8;
	Wed, 11 Sep 2024 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726058226; cv=pass; b=c9kFFWd0W+8ScNS6BY01FyCCv4TSaweZOksu3EXX6h8dcIbGXK7TTlkfMQi2EHrSlvVYPsycufhdJg93Rve8myVB+wrsg3Ovwv5TLmR+cykR8xXR/fSCZmWiKBGijVZ0hbIHdl4u2Ityz2xD5g7usK6CFkDMFOdLEZypShZCAg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726058226; c=relaxed/simple;
	bh=E1QDy28SD67lFSruQz0QIO71NgJFr7saJn6qdrlNhMY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u0Y1tardQ2T9ub0AngjxL9pOuK7G4cZA8x+bF2BmiAeL5aCKenOOAO43ZQz327H0sm/zGeWY+n7Oc+XKhKjDp8P9zw5hB3UmxySTQrQxsSeMh9qUfaBYUwGgKTGutOxyNzykuRsr8hWTP3exZ2UMLFvaHc1Ped/uXqiJz1/hlUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=N4dDIJCj; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726058207; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XKH01/pTkXVrkiamXwZB0QhAi9U9rKL7kIEy2NmWvEFXQHci1eXBhPTpOSARXgUcTyJ3c5zYP0gXD32cUix3fFW8i7XLnLIzQql4eETJBIaL07RHce8K/SMTEYDki0Fud9OTiYXgZGglRg6ES8KfnQaHly1Y1euBemae+gUuOMA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726058207; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+e+eF+lZBrbrHlH5HB0DniuCeWtZvG3d4ENpfJP76ww=; 
	b=LOPGTK2jBO3I9Xo/uyC+/9YHUmWpPPYZMAi6Ra8BIn/O/n2JJ5u/sgmGaspqt9cP8rtfzRljp4BS8txHafbYrGKCoYxUq2g1a1c62+JuduabvQ/y6EQ342kWdUFJrJzICK00d6foPtNi+hhi/a/y2wPXpxPpWrULnpuG/jchywk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726058207;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=+e+eF+lZBrbrHlH5HB0DniuCeWtZvG3d4ENpfJP76ww=;
	b=N4dDIJCjIMhiPJAMwY8d1kd84/jOh0zof3oJ+Zr6XcFdk8wC9e1m2JQCFGYkYRMs
	UBDzquwJWRbWDoCjTOQtNxuA9+MpNQ4pbNEzc+N5Ezqe4bitnWULYkog84l5kVXCQDf
	2BnoLUN6x8+t+9i/AHYo74zbI2DgGE+8EwJYIDvM=
Received: by mx.zohomail.com with SMTPS id 1726058206065221.86180204145148;
	Wed, 11 Sep 2024 05:36:46 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Nicolas Belin <nbelin@baylibre.com>,
	Alexandre Mergnat <amergnat@baylibre.com>
Cc: kernel@collabora.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2] ASoc: mediatek: mt8365: Remove unneeded assignment
Date: Wed, 11 Sep 2024 17:36:22 +0500
Message-Id: <20240911123629.125686-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The ret is being assigned, but not being used. Remove the assignment.
One of the reviewer mentioned that dev_warn should be replaced with
dev_info. Make this change as well.

Fixes: 1bf6dbd75f76 ("ASoc: mediatek: mt8365: Add a specific soundcard for EVK")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v1:
- Remove assignment to ret and don't print it from dev_warn
- Change dev_warn to dev_info on request of reviewer
---
 sound/soc/mediatek/mt8365/mt8365-mt6357.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8365/mt8365-mt6357.c b/sound/soc/mediatek/mt8365/mt8365-mt6357.c
index fef76118f8010..577f3b1e20a18 100644
--- a/sound/soc/mediatek/mt8365/mt8365-mt6357.c
+++ b/sound/soc/mediatek/mt8365/mt8365-mt6357.c
@@ -257,8 +257,7 @@ static int mt8365_mt6357_gpio_probe(struct snd_soc_card *card)
 		priv->pin_states[i] = pinctrl_lookup_state(priv->pinctrl,
 							   mt8365_mt6357_pin_str[i]);
 		if (IS_ERR(priv->pin_states[i])) {
-			ret = PTR_ERR(priv->pin_states[i]);
-			dev_warn(card->dev, "No pin state for %s\n",
+			dev_info(card->dev, "No pin state for %s\n",
 				 mt8365_mt6357_pin_str[i]);
 		} else {
 			ret = pinctrl_select_state(priv->pinctrl,
-- 
2.39.2


