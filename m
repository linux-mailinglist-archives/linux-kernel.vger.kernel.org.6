Return-Path: <linux-kernel+bounces-212477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526D8906187
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 04:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528EC1C216FE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 02:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0E52942A;
	Thu, 13 Jun 2024 02:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fGZSZb0T"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4517F9;
	Thu, 13 Jun 2024 02:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718244466; cv=none; b=daIZXzrVmAQ8rLUUKqIiHIZgNRrqzxqz2t9jXBuBHanNsFbMfMSaHaQr4xyvW6Glp+Gyu4EzIUkhIka1FcDQcWMJAcipY929ytl+IMbvQ5137bKpPOhe48o2K1c3Rjj6ZPqxP7sMuupM3BOji7k1687y+4JamxCFFdoDIhrMPOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718244466; c=relaxed/simple;
	bh=dBbES7awD4iFglEVKTenODuZBBYjAay3KmNMAQU0kvg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W+J/+UT3B+sILDPke6dpfN5yNnAjiU0gRysY2A4l/mIdmehTDFBaubsn/depTRuA1iqZXweKd5QTdHATQZMF/+UAbGEt/czMIwCvc+4ik6WRRN3tjFtdl1GQDAOEIBG83fygzMkw5VTReqVGlIRp7zRXEh6d1gQ/ht/5pjvGIQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=fGZSZb0T; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b213090c292911efa22eafcdcd04c131-20240613
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=2crroThV307a6U2HBQxfAj7rvwYaNimPg3nw6UZQSko=;
	b=fGZSZb0TbzqTWlboQgHS0OUdEKgIdRjjtwWEO7e3LQN0LbngX+cL2FlZPjtigKaS4cgwZBgRcVJJlQCKVotYIPoMntZBp7BXCb34Wf/pBDGkro4kA6vqPg/MX11+IydM5DZ8LK5djVGz+shyBcUYN5rLrSfKeADbqc5bDAtjnE8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:ff59c77f-f08b-456b-bfd4-7717010e5b1a,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:393d96e,CLOUDID:a4f38244-4544-4d06-b2b2-d7e12813c598,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b213090c292911efa22eafcdcd04c131-20240613
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <jiaxin.yu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 464247858; Thu, 13 Jun 2024 10:07:32 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 13 Jun 2024 10:07:28 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 13 Jun 2024 10:07:27 +0800
From: Jiaxin Yu <jiaxin.yu@mediatek.com>
To: <broonie@kernel.org>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<angelogioacchino.delregno@collabora.com>, Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: [PATCH v2] ASoC: mediatek: mt6358: Add "Dmic Mode Switch" kcontrol for switch DMIC mode.
Date: Thu, 13 Jun 2024 10:07:25 +0800
Message-ID: <20240613020725.27874-1-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.735100-8.000000
X-TMASE-MatchedRID: 7/lA1c0rODlUeA157rRKD2h77jTUbA6yoA9Le8XJpbovM0Gdq0fzqaJQ
	wY2eSfAKzQCEFcQpqpiD1p+T3PkHc6o+znd4MHO5KaMQ6tw7oDJUENBIMyKD0bKeTtOdjMy6F8G
	YXulqwlo0AOwawpZRrJu74XJZgEpKHxPMjOKY7A8LbigRnpKlKTpcQTtiHDgWCGZVZ8EYI018t8
	OiP4eDQIaxMeSCvXD3QXZ+RKpogWYFpx4IRdvLnIR5/Gw18G/B1f8mlpYseAs8jJT9O16z2i5IC
	Jp2q1I34sOrsb4iT/K/bbEolHIgZUOc7GjOamnWv5a9cmIodEszD8HZ4XvJ2ZRMZUCEHkRt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.735100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	4799F9C4A4B70B3A0C2BF48F28D264815A81BBF9223A6F6C1EF8F65DEFDE680F2000:8
X-MTK: N

There are two hardware connection methods for DMICs on the MT6358. In cases
where more than two DMICs are used, we need to time-multiplex these DMICs.
Therefore, we need to dynamically switch the modes of these DMICs based on
the actual usage scenarios.

            ---- DMIC1
AU_VIN0 ---
            ---- DMIC2

AU_VIN2 --- ----DMIC3

When we want to use DMIC1/2, configure it to one-wire mode. When we want to
use DMIC1/3, configure it to two-wire mode.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
---
 sound/soc/codecs/mt6358.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/mt6358.c b/sound/soc/codecs/mt6358.c
index 0284e29c11d3..9247b90d1b99 100644
--- a/sound/soc/codecs/mt6358.c
+++ b/sound/soc/codecs/mt6358.c
@@ -96,7 +96,7 @@ struct mt6358_priv {
 
 	int wov_enabled;
 
-	unsigned int dmic_one_wire_mode;
+	int dmic_one_wire_mode;
 };
 
 int mt6358_set_mtkaif_protocol(struct snd_soc_component *cmpnt,
@@ -577,6 +577,39 @@ static int mt6358_put_wov(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static int mt6358_dmic_mode_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *c = snd_soc_kcontrol_component(kcontrol);
+	struct mt6358_priv *priv = snd_soc_component_get_drvdata(c);
+
+	ucontrol->value.integer.value[0] = priv->dmic_one_wire_mode;
+	dev_dbg(priv->dev, "%s() dmic_mode = %d", __func__, priv->dmic_one_wire_mode);
+
+	return 0;
+}
+
+static int mt6358_dmic_mode_set(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *c = snd_soc_kcontrol_component(kcontrol);
+	struct mt6358_priv *priv = snd_soc_component_get_drvdata(c);
+	int enabled = ucontrol->value.integer.value[0];
+
+	if (enabled < 0 || enabled > 1)
+		return -EINVAL;
+
+	if (priv->dmic_one_wire_mode != enabled) {
+		priv->dmic_one_wire_mode = enabled;
+		dev_dbg(priv->dev, "%s() dmic_mode = %d", __func__, priv->dmic_one_wire_mode);
+
+		return 1;
+	}
+	dev_dbg(priv->dev, "%s() dmic_mode = %d", __func__, priv->dmic_one_wire_mode);
+
+	return 0;
+}
+
 static const DECLARE_TLV_DB_SCALE(playback_tlv, -1000, 100, 0);
 static const DECLARE_TLV_DB_SCALE(pga_tlv, 0, 600, 0);
 
@@ -599,6 +632,9 @@ static const struct snd_kcontrol_new mt6358_snd_controls[] = {
 
 	SOC_SINGLE_BOOL_EXT("Wake-on-Voice Phase2 Switch", 0,
 			    mt6358_get_wov, mt6358_put_wov),
+
+	SOC_SINGLE_BOOL_EXT("Dmic Mode Switch", 0,
+			    mt6358_dmic_mode_get, mt6358_dmic_mode_set),
 };
 
 /* MUX */
-- 
2.25.1


