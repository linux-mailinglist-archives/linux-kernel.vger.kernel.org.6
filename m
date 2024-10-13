Return-Path: <linux-kernel+bounces-362675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADC799B7ED
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 03:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005CD1F21F98
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 01:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECF8BA41;
	Sun, 13 Oct 2024 01:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="de/j69qd"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681E41876;
	Sun, 13 Oct 2024 01:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728784066; cv=pass; b=GmNM/FwGKjtpjjV0gSP6KuU3A4LVIDAOm0mp/lXNGwtYGFNpTyva88fN0dRB12Fg4C3agYKMW13i3TUgakQwVufYJfTLAT0tOj3Vh+LIsiBG29hWNhQIWQNjdCUZgPDzU38LdL857iW+WvE4z/qT/swyRVTKCoduydlT7mvDqOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728784066; c=relaxed/simple;
	bh=BbOxdWKhpLVzaYXvnM8PyOpEFG0kwbdh/Uc0c81WyqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNEtRBGO4dtj6JOWmAprWQXxNPLOlWFfvTMS8IRMTtktJqYXhM2TpqirE/qjcy7JnhohmjeHWBNpKe1vCHhh3QEOrUFLGIsbmRLoFRxpPvKkqza3C8YYePabr7eUnfFarXyq70L5qov14xInAbKdOTi8r3eMsG7xfpZv/dsUbXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=de/j69qd; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1728784058; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NRO3vf2rcxXnRP3nDngSxzzlP7HPphu9WLsxal3CQv/s3zh6QYT560Cn1JB9paiJ7AVp2FFLw+LTwch0YqvHAp2WH1vFE2yz5nnp0kcRKzC7pLp6qeoal5l+fSsxzILWP38ZKKHa4wHDB0RkmC4n15E/jRehdusWScvUWPN/fyQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1728784058; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CUYtkfv8mbtLw7Sh5EkronI+TRK5znHbED/xa2TUKFc=; 
	b=jCo95K744kYsZkb1ierupyYbyxQJ5LiUpf27qgIzuV/ua/2Ki+u4lX2FljrNGW01wsIPoC8rK2iUZnEYKuQLABy3G0tdq1ytk3lThXmGTPQEJY7CpM0anPsQjKmk9MF3ZAAIRkJAD5hqb+g8fU3HUpO7T0bUogqIUJiXdn1OXZk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728784058;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=CUYtkfv8mbtLw7Sh5EkronI+TRK5znHbED/xa2TUKFc=;
	b=de/j69qdONX9YBvP9R6TsHg+964XeNt2UmDkavj4Q+H4bCfpdMd0uAzY/CNE21nA
	eCkzALnSroJHIfVUF4LVMivbBjmSeDmZDz/ibTF04jTBZiopPLpfoClMjpBJ/Z2C/C6
	S5RUcxGPOZjrbkeavZqrmrr4WhHdiMCmzz0nP1OFo7LZRXefFgcyACX3ui9GAYpiIIw
	Jg9yIKCEeJurIPq8Evcp7VRalnCqzAXi/sQ8MlRX4L4UEvxutSgHoqmRUpRM0ErAHAj
	L6380cv4PeQ/BjslukxQnThIhFc+gxs6l5pryWWjO0x6VcSqfMYfBZyChQXLWW1hhGR
	e0q7qIVvxg==
Received: by mx.zohomail.com with SMTPS id 1728784056489318.16807738624493;
	Sat, 12 Oct 2024 18:47:36 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 1/2] ALSA: emu10k1: add a capability bit for no MIDI
Date: Sun, 13 Oct 2024 09:47:12 +0800
Message-ID: <20241013014714.7686-2-uwu@icenowy.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241013014714.7686-1-uwu@icenowy.me>
References: <20241013014714.7686-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Audigy Rx is a card born in the era that USB MIDI has been the
mainstream form of PC MIDI interface, and no external MIDI I/O is made
available on Audigy Rx.

Add a capability bit for emu10k1 driver to be able to hide the MPU-401
ports.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 include/sound/emu10k1.h     | 1 +
 sound/pci/emu10k1/emu10k1.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/sound/emu10k1.h b/include/sound/emu10k1.h
index 38db50b280eba..9172674838627 100644
--- a/include/sound/emu10k1.h
+++ b/include/sound/emu10k1.h
@@ -1673,6 +1673,7 @@ struct snd_emu_chip_details {
 	unsigned int i2c_adc:1;		/* I2C interface for ADC; requires ca0108_chip */
 	unsigned int adc_1361t:1;	/* Use Philips 1361T ADC */
 	unsigned int invert_shared_spdif:1;  /* analog/digital switch inverted */
+	unsigned int no_midi:1;		/* Has no MIDI */
 	const char *driver;
 	const char *name;
 	const char *id;		/* for backward compatibility - can be NULL if not needed */
diff --git a/sound/pci/emu10k1/emu10k1.c b/sound/pci/emu10k1/emu10k1.c
index dadeda7758cee..d323ebbc0368f 100644
--- a/sound/pci/emu10k1/emu10k1.c
+++ b/sound/pci/emu10k1/emu10k1.c
@@ -133,7 +133,9 @@ static int snd_card_emu10k1_probe(struct pci_dev *pci,
 		if (err < 0)
 			return err;
 	}
-	if (emu->audigy) {
+	if (emu->card_capabilities->no_midi) {
+		dev_info(emu->card->dev, "Card has no ext. MIDI ports.\n");
+	} else if (emu->audigy) {
 		err = snd_emu10k1_audigy_midi(emu);
 		if (err < 0)
 			return err;
-- 
2.47.0


