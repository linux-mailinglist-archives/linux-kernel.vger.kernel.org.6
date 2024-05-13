Return-Path: <linux-kernel+bounces-177919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA7D8C463A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B831F2188E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF9222EF4;
	Mon, 13 May 2024 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="gD8obcW1"
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4871528371;
	Mon, 13 May 2024 17:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621869; cv=none; b=YPH0XydVavauXcL1GxRAxGcxDxS7RUm0UkNkGFBc6DfUL1QVJFbxpRV6PW7bpjpX9w8iFh5OyckmDkheNnDl/rWgwU06MJAExQQnzjriKa/Exwq2Kbtxtz3H8ecxYPF0OXd5viorOhoAVlX7M9OZgWTituVoJMchqtEhSkJA5MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621869; c=relaxed/simple;
	bh=9OE/14Txm8aXh36Jq+hSFTjslOY8o75MZHgMuNfCtzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iN9Dzscn2YV2ZWgsKbTk/oYIyPtwknL2RIMEf7G3+pZ9TYQZK4m9WYgH3KxM8wUjxusZsDk5F9NG8w2YLckqCBBHUMfOT6v/yCM+tyy4nqpkIsHOqTMxpQ2nIOS7dVbqc3Rng4uqXNq8eAVRnWkg1rE+ULvLh6z0oM8jSM9Mx+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=gD8obcW1; arc=none smtp.client-ip=80.12.242.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 6ZcDs0lh7ME2z6ZcPsL82R; Mon, 13 May 2024 19:37:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1715621865;
	bh=gwrzcGjxkeip9bzIrX/+Ukodp6IKjva1jKsX16KOX4Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=gD8obcW16mCMoDFz7RHcqZs7l87rOrifGN6K+j5KMXrj9kPV7yPVGw7fCKw8G2+vu
	 p8Q9MUoLJoW6bv/CU2Cpz2KjWbbM7UApwJTa17j5I6BKlr1naAOAzi6Kr0aGoMvjxX
	 kGqUU7uoQ2rewDsEnUHUWNoHAIk/7KTHcDceLosN5iW9EBl0hp3TedYZRsNOXGh1lq
	 GrzDeqBOxx99uIXvMLZmYZP6QFZBAqeF6bxW1AVjsHrtvIfGCnBiAuAvFgnVUJuLC0
	 8tiv0RNEM+pd6RHnaYwbQJr5hHVRCvkrwr0+CKHV3dZ0JFLqIFLFhyAdu0r4N4AxuY
	 ipu2cmYzo+OhQ==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 13 May 2024 19:37:45 +0200
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
Subject: [PATCH 6/6] const_structs.checkpatch: add snd_soc_tplg_ops
Date: Mon, 13 May 2024 19:37:25 +0200
Message-ID: <6936369a414077265c11115c98364ae21e3cbdda.1715526069.git.christophe.jaillet@wanadoo.fr>
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

Now that the soc-topology can handle "const struct snd_soc_tplg_ops" make
sure that new usages of the struct already enter the tree as const.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 scripts/const_structs.checkpatch | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/const_structs.checkpatch b/scripts/const_structs.checkpatch
index fa96cfd16e99..bae41780bd39 100644
--- a/scripts/const_structs.checkpatch
+++ b/scripts/const_structs.checkpatch
@@ -78,6 +78,7 @@ snd_rawmidi_ops
 snd_soc_component_driver
 snd_soc_dai_ops
 snd_soc_ops
+snd_soc_tplg_ops
 soc_pcmcia_socket_ops
 stacktrace_ops
 sysfs_ops
-- 
2.45.0


