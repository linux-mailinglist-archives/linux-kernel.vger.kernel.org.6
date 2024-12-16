Return-Path: <linux-kernel+bounces-447420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 302999F31F7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2EAB1884C0A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D8920551E;
	Mon, 16 Dec 2024 13:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="WE6GlMRh"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760B729CA;
	Mon, 16 Dec 2024 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734357088; cv=none; b=b/fxsoNhKpz4VngBDOCuk1oGggB/mAQOh827Q8iYl8aeML9HU8J29oTtEJQj9Ul0gVsB6RUip3wRUDzNmE14g2zF2D70H2LTvaoV8e/k/Uq5orELbwnQ1shf5GXG4mj35jeBN7Fn1+tFbykXxGhxGnVOdC7Dr6L5hfm26lVqrbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734357088; c=relaxed/simple;
	bh=XzzoNb1ESFopZWcFseLs3MATF//u+lQ8bipQcHAFmn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UQ+qNMJvNQ8MJosXPVwKfkB2ZvwNEVP123d2nhW+uBlJJ7Cm9t3GSW75xMs883RlV9RmDJnkICwS5oF44VuSw2Pr+UbSqxY7rZSutZP/ehZUgMHP3bdekMdBGbEisD3Bj5320ysFpTjf1qNLA8YA817bN47Xl8mXxAIhn7u4xoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=WE6GlMRh; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=VvnIJ+8KBuKAzppK5VoGNaMAd+gil9Q97KXAPCROgYc=; b=WE6GlMRhIwO0fGWj
	QRLnNUG5SOEjdKp8DS7wskYo18ENn1IQGeFvq6q65QX3S0oJwsJW9EJD8EUgGnQe4jVWX5hny4McV
	SFZU2L6YBjAU8ZmGrE0esJuISEqE7P9AoXjl25edp3ID5NefK4InEAQBjoz+M6ve8ZM1yd246lNao
	k2Tm0B5Mp64v7Y/fTiAr7DP+PbUGyLojASUT0oEiCSoeLjgnFVKvz2gpQFSadDnnpWtSy46gwBGot
	l4nZRxGqtmVyYR69rVRXu0Rd6n+AOkWdBLDbddtt6krYVd889IOcK04gvEjb6uIocmULUfE1gua04
	VnuQOkxk3yRAZRkwVQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tNBV9-005cKY-1j;
	Mon, 16 Dec 2024 13:51:11 +0000
From: linux@treblig.org
To: oder_chiou@realtek.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] ASoC: rt715: Remove unused hda_to_sdw
Date: Mon, 16 Dec 2024 13:51:10 +0000
Message-ID: <20241216135110.53426-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

hda_to_sdw() has been unused since it was added in 2020 as part of the
commit d1ede0641b05 ("ASoC: rt715: add RT715 codec driver")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 sound/soc/codecs/rt715-sdw.c | 41 ------------------------------------
 sound/soc/codecs/rt715.h     |  3 ---
 2 files changed, 44 deletions(-)

diff --git a/sound/soc/codecs/rt715-sdw.c b/sound/soc/codecs/rt715-sdw.c
index ec255ada44e0..cd702574c84b 100644
--- a/sound/soc/codecs/rt715-sdw.c
+++ b/sound/soc/codecs/rt715-sdw.c
@@ -372,47 +372,6 @@ static const struct regmap_config rt715_sdw_regmap = {
 	.use_single_write = true,
 };
 
-int hda_to_sdw(unsigned int nid, unsigned int verb, unsigned int payload,
-	       unsigned int *sdw_addr_h, unsigned int *sdw_data_h,
-	       unsigned int *sdw_addr_l, unsigned int *sdw_data_l)
-{
-	unsigned int offset_h, offset_l, e_verb;
-
-	if (((verb & 0xff) != 0) || verb == 0xf00) { /* 12 bits command */
-		if (verb == 0x7ff) /* special case */
-			offset_h = 0;
-		else
-			offset_h = 0x3000;
-
-		if (verb & 0x800) /* get command */
-			e_verb = (verb - 0xf00) | 0x80;
-		else /* set command */
-			e_verb = (verb - 0x700);
-
-		*sdw_data_h = payload; /* 7 bits payload */
-		*sdw_addr_l = *sdw_data_l = 0;
-	} else { /* 4 bits command */
-		if ((verb & 0x800) == 0x800) { /* read */
-			offset_h = 0x9000;
-			offset_l = 0xa000;
-		} else { /* write */
-			offset_h = 0x7000;
-			offset_l = 0x8000;
-		}
-		e_verb = verb >> 8;
-		*sdw_data_h = (payload >> 8); /* 16 bits payload [15:8] */
-		*sdw_addr_l = (e_verb << 8) | nid | 0x80; /* 0x80: valid bit */
-		*sdw_addr_l += offset_l;
-		*sdw_data_l = payload & 0xff;
-	}
-
-	*sdw_addr_h = (e_verb << 8) | nid;
-	*sdw_addr_h += offset_h;
-
-	return 0;
-}
-EXPORT_SYMBOL(hda_to_sdw);
-
 static int rt715_update_status(struct sdw_slave *slave,
 				enum sdw_slave_status status)
 {
diff --git a/sound/soc/codecs/rt715.h b/sound/soc/codecs/rt715.h
index 6e37bf64e12f..a0c56aa1003a 100644
--- a/sound/soc/codecs/rt715.h
+++ b/sound/soc/codecs/rt715.h
@@ -220,8 +220,5 @@ int rt715_io_init(struct device *dev, struct sdw_slave *slave);
 int rt715_init(struct device *dev, struct regmap *sdw_regmap,
 	struct regmap *regmap, struct sdw_slave *slave);
 
-int hda_to_sdw(unsigned int nid, unsigned int verb, unsigned int payload,
-	       unsigned int *sdw_addr_h, unsigned int *sdw_data_h,
-	       unsigned int *sdw_addr_l, unsigned int *sdw_data_l);
 int rt715_clock_config(struct device *dev);
 #endif /* __RT715_H__ */
-- 
2.47.1


