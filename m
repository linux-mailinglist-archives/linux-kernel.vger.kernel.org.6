Return-Path: <linux-kernel+bounces-211281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE0E904F71
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E7C1C217AC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CA516DECE;
	Wed, 12 Jun 2024 09:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Lm6MbmcC"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C4042052;
	Wed, 12 Jun 2024 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718185337; cv=none; b=O8yICvUg3BxaxM5zsKWUv9/YTEna1G23tdgldHDdeOFdxjA9mSxMsXYUQYEKAc4w7+OJZ8Z8zrSMe+d4zJwLsfpQxA5iU/BIh4C42UBhh+lbBHsQJcWsgslPWh4F6gYPTgELTHbneG4+AB+a5d/4mXCTf29S48snD3+XKUj8gAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718185337; c=relaxed/simple;
	bh=4GOJEx8lRbFHjPsnV+Ngy5dtVAH6+Y7YlJIgsFptwAc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t0HWPxzmg6HhhjOjUk7o6QHl9ya2E9lYhghJ9AfjPI5RLn0Ke/3HkQedwjPXkDh9nuDgWT3shr0C0GpaYSA/zrPS9lkc/idLTYSUmr88JQ2z3GBHd+LNCLj4WzNoR5ZwubU/qr2tgf4RXEj+iQhx3izZXyktFDXRmPK5AobnyRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Lm6MbmcC; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 07297f0a28a011efa54bbfbb386b949c-20240612
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=lFva8B6gp3ExQoZEXAzokC/lEp9q82UBvksUzqGmJOc=;
	b=Lm6MbmcCsEsp7KzwpZ4FRwQCmCDrqRkNvluMBnpb3lUKbmXm9BBBlKeDCJS8fpMiU8m368YXEgjJ0+vmaM6JennViJEep1KwVgOeVbLsBwrH6ckeSb73mgn4FS+IUvn+llD7CUHFnI5B38NT1M+XC0Rk1vkTT5WpmVdzMYjVduo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:96a417ae-64d7-4a42-a744-cca4f6d66ad7,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:393d96e,CLOUDID:94957c44-4544-4d06-b2b2-d7e12813c598,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 07297f0a28a011efa54bbfbb386b949c-20240612
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <jiaxin.yu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 140183744; Wed, 12 Jun 2024 17:42:05 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 12 Jun 2024 17:42:03 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 12 Jun 2024 17:42:03 +0800
From: Jiaxin Yu <jiaxin.yu@mediatek.com>
To: <broonie@kernel.org>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<angelogioacchino.delregno@collabora.com>, Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: [PATCH] ASoC: mediatek: mt6358: Add "Dmic Mode Switch" kcontrol for switch DMIC mode.
Date: Wed, 12 Jun 2024 17:41:55 +0800
Message-ID: <20240612094155.23354-1-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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
 sound/soc/codecs/mt6358.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/sound/soc/codecs/mt6358.c b/sound/soc/codecs/mt6358.c
index 0284e29c11d3..3623e2a38423 100644
--- a/sound/soc/codecs/mt6358.c
+++ b/sound/soc/codecs/mt6358.c
@@ -577,6 +577,36 @@ static int mt6358_put_wov(struct snd_kcontrol *kcontrol,
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
 
@@ -599,6 +629,9 @@ static const struct snd_kcontrol_new mt6358_snd_controls[] = {
 
 	SOC_SINGLE_BOOL_EXT("Wake-on-Voice Phase2 Switch", 0,
 			    mt6358_get_wov, mt6358_put_wov),
+
+	SOC_SINGLE_BOOL_EXT("Dmic Mode Switch", 0,
+			    mt6358_dmic_mode_get, mt6358_dmic_mode_set),
 };
 
 /* MUX */
-- 
2.25.1


