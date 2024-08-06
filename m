Return-Path: <linux-kernel+bounces-276299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082329491DA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B23A52863A5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98A91D54D3;
	Tue,  6 Aug 2024 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Cdn64Utg"
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC3F1D54CB;
	Tue,  6 Aug 2024 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951799; cv=none; b=h8yQh7J34WD2pHvVaRrrf1LxJYiJRCJ4ZnncTuDGy4yrOrQKG1zagfLlukOUVrI++GdieuY2BgbtZDUuWhAa2VAJzcTnP/TZI8Sej+csPHRP1TtwzpjwbxY/YTsMLy3457jKhnk0KZvceL7Z4TBfMMRvbmvJNKyV//Sj96mNpHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951799; c=relaxed/simple;
	bh=5a1X9wFrWBvpAQTBrO/UprB7XAg2K7Y8ijJUSSEGM4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rChdG0tOCqwgbp33Q8+tUP0ybDJIufAsBFFMAjs7UzLVY0VrQXkh1KUpb4l/xADZ0qVAWrareJ2tkVd1/YZugnfk8F9Kjohj4Tc+mMvHfLCpbg0AZMlzfrbV1Q/b1yFoPMUVBmDWAJTtrNul93nCHj3CaNZqxSArtaOSJccZHFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Cdn64Utg; arc=none smtp.client-ip=80.12.242.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id bKSxsQhrDrWkDbKSxsiUeV; Tue, 06 Aug 2024 15:43:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722951789;
	bh=/3TrRDY1xrq9A6NvQnziOhi0PcSU3SG4UHNJJeoANis=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Cdn64UtgloRvBi5reaIPWOGLqOKXMxxD82CJboKK9NuwhH6HxHJvU8OqmvsP2jMDg
	 KR3gAPfsvJopnBlZpdNDtx6kSA0rLGRdr2sGBFELjcDDQeU+C9xVz/Z8ui0I+FukQJ
	 iWwAu7h4L010vJiLL75PmkB9tGYZgqoaXDIQSNW2L0gQ5FJzNL23bi6NcDx8nNrfTZ
	 D0tSL4t1XPVSAxqWUBKuAwWUq3Z4j6UAeQTumXnbYn3xDO4v2SZcradoPEiiKDYdyu
	 FXybXzG2rBk9sUDMBvYeQWIRr2x7y29zvPTdUteLSdpBOQtDbNEws4Eu3hXEuLv5E5
	 r7QWsiaGxjQXg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 06 Aug 2024 15:43:08 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH] ASoC: cs43130: Constify struct reg_sequence and reg_sequences
Date: Tue,  6 Aug 2024 15:43:00 +0200
Message-ID: <5b906a0cc9b7be15d0d6310069f54254a75ea767.1722951770.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct reg_sequence' and 'struct reg_sequences' are not modified in this
drivers.

Constifying these structures moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  54409	   7881	     64	  62354	   f392	sound/soc/codecs/cs43130.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  55562	   6729	     64	  62355	   f393	sound/soc/codecs/cs43130.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 sound/soc/codecs/cs43130.c | 40 +++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index cb4ca80f36d2..f8e2fb69ada2 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -1805,7 +1805,7 @@ static struct attribute *hpload_attrs[] = {
 };
 ATTRIBUTE_GROUPS(hpload);
 
-static struct reg_sequence hp_en_cal_seq[] = {
+static const struct reg_sequence hp_en_cal_seq[] = {
 	{CS43130_INT_MASK_4, CS43130_INT_MASK_ALL},
 	{CS43130_HP_MEAS_LOAD_1, 0},
 	{CS43130_HP_MEAS_LOAD_2, 0},
@@ -1820,7 +1820,7 @@ static struct reg_sequence hp_en_cal_seq[] = {
 	{CS43130_HP_LOAD_1, 0x80},
 };
 
-static struct reg_sequence hp_en_cal_seq2[] = {
+static const struct reg_sequence hp_en_cal_seq2[] = {
 	{CS43130_INT_MASK_4, CS43130_INT_MASK_ALL},
 	{CS43130_HP_MEAS_LOAD_1, 0},
 	{CS43130_HP_MEAS_LOAD_2, 0},
@@ -1828,7 +1828,7 @@ static struct reg_sequence hp_en_cal_seq2[] = {
 	{CS43130_HP_LOAD_1, 0x80},
 };
 
-static struct reg_sequence hp_dis_cal_seq[] = {
+static const struct reg_sequence hp_dis_cal_seq[] = {
 	{CS43130_HP_LOAD_1, 0x80},
 	{CS43130_DXD1, 0x99},
 	{CS43130_DXD12, 0},
@@ -1836,12 +1836,12 @@ static struct reg_sequence hp_dis_cal_seq[] = {
 	{CS43130_HP_LOAD_1, 0},
 };
 
-static struct reg_sequence hp_dis_cal_seq2[] = {
+static const struct reg_sequence hp_dis_cal_seq2[] = {
 	{CS43130_HP_LOAD_1, 0x80},
 	{CS43130_HP_LOAD_1, 0},
 };
 
-static struct reg_sequence hp_dc_ch_l_seq[] = {
+static const struct reg_sequence hp_dc_ch_l_seq[] = {
 	{CS43130_DXD1, 0x99},
 	{CS43130_DXD19, 0x0A},
 	{CS43130_DXD17, 0x93},
@@ -1851,12 +1851,12 @@ static struct reg_sequence hp_dc_ch_l_seq[] = {
 	{CS43130_HP_LOAD_1, 0x81},
 };
 
-static struct reg_sequence hp_dc_ch_l_seq2[] = {
+static const struct reg_sequence hp_dc_ch_l_seq2[] = {
 	{CS43130_HP_LOAD_1, 0x80},
 	{CS43130_HP_LOAD_1, 0x81},
 };
 
-static struct reg_sequence hp_dc_ch_r_seq[] = {
+static const struct reg_sequence hp_dc_ch_r_seq[] = {
 	{CS43130_DXD1, 0x99},
 	{CS43130_DXD19, 0x8A},
 	{CS43130_DXD17, 0x15},
@@ -1866,12 +1866,12 @@ static struct reg_sequence hp_dc_ch_r_seq[] = {
 	{CS43130_HP_LOAD_1, 0x91},
 };
 
-static struct reg_sequence hp_dc_ch_r_seq2[] = {
+static const struct reg_sequence hp_dc_ch_r_seq2[] = {
 	{CS43130_HP_LOAD_1, 0x90},
 	{CS43130_HP_LOAD_1, 0x91},
 };
 
-static struct reg_sequence hp_ac_ch_l_seq[] = {
+static const struct reg_sequence hp_ac_ch_l_seq[] = {
 	{CS43130_DXD1, 0x99},
 	{CS43130_DXD19, 0x0A},
 	{CS43130_DXD17, 0x93},
@@ -1881,12 +1881,12 @@ static struct reg_sequence hp_ac_ch_l_seq[] = {
 	{CS43130_HP_LOAD_1, 0x82},
 };
 
-static struct reg_sequence hp_ac_ch_l_seq2[] = {
+static const struct reg_sequence hp_ac_ch_l_seq2[] = {
 	{CS43130_HP_LOAD_1, 0x80},
 	{CS43130_HP_LOAD_1, 0x82},
 };
 
-static struct reg_sequence hp_ac_ch_r_seq[] = {
+static const struct reg_sequence hp_ac_ch_r_seq[] = {
 	{CS43130_DXD1, 0x99},
 	{CS43130_DXD19, 0x8A},
 	{CS43130_DXD17, 0x15},
@@ -1896,24 +1896,24 @@ static struct reg_sequence hp_ac_ch_r_seq[] = {
 	{CS43130_HP_LOAD_1, 0x92},
 };
 
-static struct reg_sequence hp_ac_ch_r_seq2[] = {
+static const struct reg_sequence hp_ac_ch_r_seq2[] = {
 	{CS43130_HP_LOAD_1, 0x90},
 	{CS43130_HP_LOAD_1, 0x92},
 };
 
-static struct reg_sequence hp_cln_seq[] = {
+static const struct reg_sequence hp_cln_seq[] = {
 	{CS43130_INT_MASK_4, CS43130_INT_MASK_ALL},
 	{CS43130_HP_MEAS_LOAD_1, 0},
 	{CS43130_HP_MEAS_LOAD_2, 0},
 };
 
 struct reg_sequences {
-	struct reg_sequence	*seq;
-	int			size;
-	unsigned int		msk;
+	const struct reg_sequence	*seq;
+	int				size;
+	unsigned int			msk;
 };
 
-static struct reg_sequences hpload_seq1[] = {
+static const struct reg_sequences hpload_seq1[] = {
 	{
 		.seq	= hp_en_cal_seq,
 		.size	= ARRAY_SIZE(hp_en_cal_seq),
@@ -1951,7 +1951,7 @@ static struct reg_sequences hpload_seq1[] = {
 	},
 };
 
-static struct reg_sequences hpload_seq2[] = {
+static const struct reg_sequences hpload_seq2[] = {
 	{
 		.seq	= hp_en_cal_seq2,
 		.size	= ARRAY_SIZE(hp_en_cal_seq2),
@@ -2041,7 +2041,7 @@ static int cs43130_update_hpload(unsigned int msk, int ac_idx,
 }
 
 static int cs43130_hpload_proc(struct cs43130_private *cs43130,
-			       struct reg_sequence *seq, int seq_size,
+			       const struct reg_sequence *seq, int seq_size,
 			       unsigned int rslt_msk, int ac_idx)
 {
 	int ret;
@@ -2122,7 +2122,7 @@ static void cs43130_imp_meas(struct work_struct *wk)
 	int i, ret, ac_idx;
 	struct cs43130_private *cs43130;
 	struct snd_soc_component *component;
-	struct reg_sequences *hpload_seq;
+	const struct reg_sequences *hpload_seq;
 
 	cs43130 = container_of(wk, struct cs43130_private, work);
 	component = cs43130->component;
-- 
2.45.2


