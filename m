Return-Path: <linux-kernel+bounces-177920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D7C8C463B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C201C22D95
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802642C69D;
	Mon, 13 May 2024 17:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="m90FUVvG"
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487372837D;
	Mon, 13 May 2024 17:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621869; cv=none; b=G4r+Jt4DEJfDgGQHVibQE6cbFkm3/IHLcbnMiifCYDl6mENf/8xFOVHufD4I47KtsXHEhUnqXXCcjM9dyHtrbXHZQGw5wBehrLOb5Rj1Dex4TWeikWjIEtWvpJuBlsW32WTmTCOXAc9tRoMSdHOgVWsOLCy+Ol/Kr6oJm3jJ1Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621869; c=relaxed/simple;
	bh=a0hGDqbnr8QfjOn4UWdQQVFTsm1YKoftP6R8ds04QtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXPyHyljk3K9np+kop+2iN6QmUJmvuXV+Gq2aW92oZiRlaR56fJH/dHVV6i5nb4RaS9ehtC7uJ16kGU5TAL536h/5GK4UstXBlbwg0ydcYE6zhHYEHvA7ZkvSWFm9eMNQQKPtRsCOw6jkV0Vy/CW4uHyLyuseAs+TEuYXzLExhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=m90FUVvG; arc=none smtp.client-ip=80.12.242.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 6ZcDs0lh7ME2z6ZcKsL81A; Mon, 13 May 2024 19:37:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1715621860;
	bh=vPx09WkVDSPEOpN7HAXVn6S1kGIy/0oMa/odUP4ITxc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=m90FUVvGUYAng9KWUEjKYM1eIH1fEklPDwdWolN/ZVlGtl+EpR9oNiMZT/sXgwwhJ
	 oEH/6thb5Alo3o7a9uzF/JMtkmqmrnJm75rObyvke+qoOfymnHbV1IBuD2miuuY4UJ
	 +YzXUW56a9zUu0SMrd5qUoGnbk4iTh3qv6lLA1l6jz6TE5ipLRdqWkp64+byy34C22
	 yKngk6yqD/8ThHFwNaxSKJbUPiaYoGhj146tVS80EsfD2P3kWMJdHiT/7gOZrUvSKG
	 YDFbRkJkbW0qdW3Z0LbubPyPtgvp3qTmP0AjaUrCgXYh40/5PH7mDpr/wz1y+fW5nd
	 zc0rz5ydwA+ew==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 13 May 2024 19:37:40 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	cezary.rojewski@intel.com,
	pierre-louis.bossart@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	srinivas.kandagatla@linaro.org,
	bgoswami@quicinc.com,
	daniel.baluta@nxp.com
Cc: linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org,
	sound-open-firmware@alsa-project.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 3/6] ASoC: qdsp6: audioreach: Constify struct snd_soc_tplg_ops
Date: Mon, 13 May 2024 19:37:22 +0200
Message-ID: <a5ae843dd8aaacbc1148aea7a3b1d03f11495872.1715526069.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <f2f983e791d7f941a95556bb147f426a345d84d4.1715526069.git.christophe.jaillet@wanadoo.fr>
References: <f2f983e791d7f941a95556bb147f426a345d84d4.1715526069.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Constifying "struct snd_soc_tplg_ops" moves some data to a read-only
section, so increase overall security.

On a x86_64, with allmodconfig:
Before:
   text	   data	    bss	    dec	    hex	filename
  19942	    832	      0	  20774	   5126	sound/soc/qcom/qdsp6/topology.o

After:
   text	   data	    bss	    dec	    hex	filename
  20102	    652	      0	  20754	   5112	sound/soc/qcom/qdsp6/topology.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 sound/soc/qcom/qdsp6/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/topology.c b/sound/soc/qcom/qdsp6/topology.c
index 70572c83e101..c15d1a2b6dbf 100644
--- a/sound/soc/qcom/qdsp6/topology.c
+++ b/sound/soc/qcom/qdsp6/topology.c
@@ -1240,7 +1240,7 @@ static const struct snd_soc_tplg_kcontrol_ops audioreach_io_ops[] = {
 		audioreach_put_vol_ctrl_audio_mixer, snd_soc_info_volsw},
 };
 
-static struct snd_soc_tplg_ops audioreach_tplg_ops  = {
+static const struct snd_soc_tplg_ops audioreach_tplg_ops = {
 	.io_ops = audioreach_io_ops,
 	.io_ops_count = ARRAY_SIZE(audioreach_io_ops),
 
-- 
2.45.0


