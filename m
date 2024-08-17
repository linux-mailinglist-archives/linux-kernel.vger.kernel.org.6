Return-Path: <linux-kernel+bounces-290667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C17955719
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 12:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9AE82821DB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 10:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D3F149C4A;
	Sat, 17 Aug 2024 10:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="N8Dvz+IY"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D348005B
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 10:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723889254; cv=none; b=DUuuoTsV17sO7stpe4LDXINUUpX02rPOq2OiWTDlVgMzvzZxuWcekKv2y8L53h166Vr4bZBLFsNv0DDiKYDOwEyRbn6dnqKT9o2bn9ZcrF2b1HWBEt7NLofVQ+hkg9AIi1JHUQ2RgImDBaCozV8Yvu350BmNM+i4GViJ0jNGcME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723889254; c=relaxed/simple;
	bh=Jn9wdDW8U7nXahtKgzAhdBLR5Gusg2jiALCcsf0XAtE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=g/sUu3tLazawI1E9uUXSupsIP05xxb/CFqAmg9mpzp1QO4MGT8msmxWv1ABlGjpQNGe7K4pLrYmj5H3PBAeUFaYvWj1hTfCLdA9vXZfiMXneY3y4t2UfxtpwsLBqNFF3Br3oGpTF+eMno6kc3e39S5uDZX0pbo8/nXFTjmKGNg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=N8Dvz+IY; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1723889250; x=1724148450;
	bh=TFYv1VRBNCN/E0qo/1YUyImx5ns3Zf75xpcEDQhjdeI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=N8Dvz+IYkdHplgdoE9mWA/8JPkLRbVLuSG3Ewa4Gh74ESjdFn9Tn4vdJIgOaKnzuG
	 EDFpWaHtzdq9FlX6qBUWkw5XF1qDS1ch0ABJRB4w2VcxTBoVgBPc6DuZrYWeG4SpPL
	 DUPgyVSTNfDDNpFjSDj+Q7wmnPWFjw2Zrzj/bjYa13x/w0RrenvGQ8koXplvj9QvNi
	 JCMPHLvz/tLmltHH2L2xPPdeN/D2tDBpI1/v+cwwmM1Jf02ybc6XcM3i5eRxf32B3F
	 snQpb1lKgvZb2n0/i8EnrnrRvpKPqkuTEvRKUcZ1f7ayZAjgR5FS+Ay6K9it6mVDIR
	 /qRzYbIfrePtg==
Date: Sat, 17 Aug 2024 10:07:26 +0000
To: gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH] staging: vt6655: Fix alignment to open parentheses
Message-ID: <20240817100559.33174-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 32076799cf8c93c638f126ab2e80ea0bbe144d1f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch fixes the "Alignment should match open parenthesis" checks
detected by checkpatch.pl.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
 drivers/staging/vt6655/card.h        |  4 ++--
 drivers/staging/vt6655/device_main.c |  6 +++---
 drivers/staging/vt6655/rxtx.c        | 14 +++++++-------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/vt6655/card.h b/drivers/staging/vt6655/card.h
index f52e42564e81..f6b462ebca51 100644
--- a/drivers/staging/vt6655/card.h
+++ b/drivers/staging/vt6655/card.h
@@ -55,8 +55,8 @@ void CARDvSafeResetRx(struct vnt_private *priv);
 void card_radio_power_off(struct vnt_private *priv);
 bool card_set_phy_parameter(struct vnt_private *priv, u8 bb_type);
 bool card_update_tsf(struct vnt_private *priv, unsigned char rx_rate,
-=09=09    u64 bss_timestamp);
+=09=09     u64 bss_timestamp);
 bool card_set_beacon_period(struct vnt_private *priv,
-=09=09=09  unsigned short beacon_interval);
+=09=09=09    unsigned short beacon_interval);
=20
 #endif /* __CARD_H__ */
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/=
device_main.c
index 3ff8103366c1..9ea647aefd60 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1140,7 +1140,7 @@ static void vnt_interrupt_process(struct vnt_private =
*priv)
 =09=09=09=09PSbIsNextTBTTWakeUp((void *)priv);
=20
 =09=09=09if ((priv->op_mode =3D=3D NL80211_IFTYPE_AP ||
-=09=09=09    priv->op_mode =3D=3D NL80211_IFTYPE_ADHOC) &&
+=09=09=09     priv->op_mode =3D=3D NL80211_IFTYPE_ADHOC) &&
 =09=09=09    priv->vif->bss_conf.enable_beacon)
 =09=09=09=09MACvOneShotTimer1MicroSec(priv,
 =09=09=09=09=09=09=09  (priv->vif->bss_conf.beacon_int -
@@ -1535,7 +1535,7 @@ static void vnt_bss_info_changed(struct ieee80211_hw =
*hw,
 =09    priv->op_mode !=3D NL80211_IFTYPE_AP) {
 =09=09if (vif->cfg.assoc && conf->beacon_rate) {
 =09=09=09card_update_tsf(priv, conf->beacon_rate->hw_value,
-=09=09=09=09       conf->sync_tsf);
+=09=09=09=09=09conf->sync_tsf);
=20
 =09=09=09card_set_beacon_period(priv, conf->beacon_int);
=20
@@ -1763,7 +1763,7 @@ vt6655_probe(struct pci_dev *pcid, const struct pci_d=
evice_id *ent)
 =09priv->memaddr =3D pci_resource_start(pcid, 0);
 =09priv->ioaddr =3D pci_resource_start(pcid, 1);
 =09priv->port_offset =3D ioremap(priv->memaddr & PCI_BASE_ADDRESS_MEM_MASK=
,
-=09=09=09=09   256);
+=09=09=09=09    256);
 =09if (!priv->port_offset) {
 =09=09dev_err(&pcid->dev, ": Failed to IO remapping ..\n");
 =09=09device_free_info(priv);
diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 5e5ed582c35e..3705cb1e87b6 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -493,9 +493,9 @@ s_uFillDataHead(
 =09=09buf->duration_a =3D cpu_to_le16((u16)s_uGetDataDuration(pDevice, DAT=
ADUR_A, cbFrameLength, byPktType,
 =09=09=09=09=09=09=09=09      wCurrentRate, bNeedAck, uFragIdx, cbLastFrag=
mentSize, uMACfragNum, byFBOption));
 =09=09buf->duration_b =3D cpu_to_le16((u16)s_uGetDataDuration(pDevice, DAT=
ADUR_B, cbFrameLength, PK_TYPE_11B,
-=09=09=09=09=09=09=09=09       pDevice->byTopCCKBasicRate, bNeedAck, uFrag=
Idx, cbLastFragmentSize, uMACfragNum, byFBOption));
+=09=09=09=09=09=09=09=09      pDevice->byTopCCKBasicRate, bNeedAck, uFragI=
dx, cbLastFragmentSize, uMACfragNum, byFBOption));
 =09=09buf->duration_a_f0 =3D cpu_to_le16((u16)s_uGetDataDuration(pDevice, =
DATADUR_A_F0, cbFrameLength, byPktType,
-=09=09=09=09=09=09=09=09=09  wCurrentRate, bNeedAck, uFragIdx, cbLastFragm=
entSize, uMACfragNum, byFBOption));
+=09=09=09=09=09=09=09=09=09 wCurrentRate, bNeedAck, uFragIdx, cbLastFragme=
ntSize, uMACfragNum, byFBOption));
 =09=09buf->duration_a_f1 =3D cpu_to_le16((u16)s_uGetDataDuration(pDevice, =
DATADUR_A_F1, cbFrameLength, byPktType,
 =09=09=09=09=09=09=09=09=09 wCurrentRate, bNeedAck, uFragIdx, cbLastFragme=
ntSize, uMACfragNum, byFBOption));
=20
@@ -520,7 +520,7 @@ s_uFillDataHead(
 =09=09=09buf->duration_f0 =3D cpu_to_le16((u16)s_uGetDataDuration(pDevice,=
 DATADUR_A_F0, cbFrameLength, byPktType,
 =09=09=09=09=09=09=09=09=09       wCurrentRate, bNeedAck, uFragIdx, cbLast=
FragmentSize, uMACfragNum, byFBOption));
 =09=09=09buf->duration_f1 =3D cpu_to_le16((u16)s_uGetDataDuration(pDevice,=
 DATADUR_A_F1, cbFrameLength, byPktType,
-=09=09=09=09=09=09=09=09=09=09wCurrentRate, bNeedAck, uFragIdx, cbLastFrag=
mentSize, uMACfragNum, byFBOption));
+=09=09=09=09=09=09=09=09=09       wCurrentRate, bNeedAck, uFragIdx, cbLast=
FragmentSize, uMACfragNum, byFBOption));
 =09=09=09buf->time_stamp_off =3D vnt_time_stamp_off(pDevice, wCurrentRate)=
;
 =09=09=09return buf->duration;
 =09=09}
@@ -1375,8 +1375,8 @@ static int vnt_beacon_xmit(struct vnt_private *priv,
 =09=09/* Get Duration and TimeStampOff */
 =09=09short_head->duration =3D
 =09=09=09cpu_to_le16((u16)s_uGetDataDuration(priv, DATADUR_B,
-=09=09=09=09    frame_size, PK_TYPE_11A, current_rate,
-=09=09=09=09    false, 0, 0, 1, AUTO_FB_NONE));
+=09=09=09=09=09=09=09    frame_size, PK_TYPE_11A, current_rate,
+=09=09=09=09=09=09=09    false, 0, 0, 1, AUTO_FB_NONE));
=20
 =09=09short_head->time_stamp_off =3D
 =09=09=09=09vnt_time_stamp_off(priv, current_rate);
@@ -1391,8 +1391,8 @@ static int vnt_beacon_xmit(struct vnt_private *priv,
 =09=09/* Get Duration and TimeStampOff */
 =09=09short_head->duration =3D
 =09=09=09cpu_to_le16((u16)s_uGetDataDuration(priv, DATADUR_B,
-=09=09=09=09    frame_size, PK_TYPE_11B, current_rate,
-=09=09=09=09    false, 0, 0, 1, AUTO_FB_NONE));
+=09=09=09=09=09=09=09    frame_size, PK_TYPE_11B, current_rate,
+=09=09=09=09=09=09=09    false, 0, 0, 1, AUTO_FB_NONE));
=20
 =09=09short_head->time_stamp_off =3D
 =09=09=09vnt_time_stamp_off(priv, current_rate);
--=20
2.34.1



