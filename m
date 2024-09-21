Return-Path: <linux-kernel+bounces-334862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A0797DD7C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 16:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B3C2828E8
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 14:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766C31741DA;
	Sat, 21 Sep 2024 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="edgpYJCW"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843631E51D
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726930752; cv=none; b=f8mjMhgSZugrcIgn4SVWS5FbsM2qRJlizof13Dv244UAk8s0d36urJCqpeOA0DzKImII1X36k3FC1UeYveAk/0+JlMTV82Mlmq/XZjszuT67vxeBSNsgoplku+ER8/MFY83CeLfGH3syMajS9UOg9Xk8cHPNRxeyYcPlcEMMpkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726930752; c=relaxed/simple;
	bh=i+IQmxSOAnlqQ8pJEbZJfYghp1yvyj66AEjad1mRo38=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tlCg7K96IOp7mwBXQa/2TEFnErGlHwtmVIv4tmsu1f2c9uSyh9RUzhJkCtjEdhuWaM8j+yMz33hS99+kCwm9rpYWw9JHzL6yyxwUmpUNwULTBphK65zTxKF73ylQlSXqZ6SRTDzungLtAdMBkUw5CqcGZ1SEbhnfShOpBZHd6/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=edgpYJCW; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1726930747; x=1727189947;
	bh=9HMM8ba88JvGMesGMQXrM/OTFzUpGO72vnk4VEcCpHs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=edgpYJCWs0lAprzrqWbkcShxnTQHXBupSP1DW+cPlVHyJItglyTXd2wKAWt8fDEuo
	 vbePyS8vprgj6yLp8QPomuVtGV8sXIq1Gn1MoWmf2IPz7A0EL0xDyFOF1AypZTnN5r
	 5qSRumodb1l6PG/LPiJBPWQQwGrV9sFIVDwbMzVgNn36xU2rGR8m9mRvSM4woArbUr
	 8sKfnO2DqhC40xLlW4yczrsIcp5K6yO0tvEHT7doy4nLrKLkT76nGCch/v4yuTNusj
	 Bb8jKPsyhyTSsyd7GZQXNsh5Z4kZVI3eFNDV8iH9Z3w5sgn3bjqmXJZojh/SJ+ipJn
	 cC/U38dp0+mnA==
Date: Sat, 21 Sep 2024 14:59:02 +0000
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: gregkh@linuxfoundation.org, tdavies@darkphysics.net, dan.carpenter@linaro.org, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] staging: rtl8192e: rtllib_rx.c: Fix alignment to open parentheses
Message-ID: <lpGiEC2yjymw5L8SqZsIw_ocyD4Eo8mJuTPAZufS4mStWL64WYn9-9lUD8SAptAwHzqChexGXFq1AWYMeeT2V4RnfhlzwlcPrOkQAqpdjmc=@protonmail.com>
In-Reply-To: <3fc0202a-d0b7-479f-8528-fed30e0e458c@gmail.com>
References: <20240920193356.32156-1-dominik.karol.piatkowski@protonmail.com> <20240920193356.32156-4-dominik.karol.piatkowski@protonmail.com> <3fc0202a-d0b7-479f-8528-fed30e0e458c@gmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 9fcfac6d149812f60522bdf44691d9d9789d3464
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Philipp,

On Saturday, September 21st, 2024 at 15:51, Philipp Hortmann <philipp.g.hor=
tmann@gmail.com> wrote:
<cut>
> Hi Domenik,
>=20
> I hope to not stress you beyond limits.

First of all, I want to thank you for fast, valuable reviews. I hope I am n=
ot
overusing your patience.

>=20
> Thanks for deviding the patch. I can apply it now to my repo.
> First two patches are looking good.
>=20
> I prefer to have a comma at the end of the line. This line does not
> increase readablility to me.
>=20
> ((struct rx_reorder_entry *)
> list_entry(list->next, struct rx_reorder_entry, list))->seq_num))

I understand your point. I made this line similar to one that already exist=
s
above, see diff:

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192=
e/rtllib_rx.c
index 8fe224a83dd6..e58be8e07917 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -409,12 +409,10 @@ static bool add_reorder_entry(struct rx_ts_record *ts=
,
=20
 =09while (list->next !=3D &ts->rx_pending_pkt_list) {
 =09=09if (SN_LESS(reorder_entry->seq_num, ((struct rx_reorder_entry *)
-=09=09    list_entry(list->next, struct rx_reorder_entry,
-=09=09    list))->seq_num))
+=09=09    list_entry(list->next, struct rx_reorder_entry, list))->seq_num)=
)
 =09=09=09list =3D list->next;
-=09=09else if (SN_EQUAL(reorder_entry->seq_num,
-=09=09=09((struct rx_reorder_entry *)list_entry(list->next,
-=09=09=09struct rx_reorder_entry, list))->seq_num))
+=09=09else if (SN_EQUAL(reorder_entry->seq_num, ((struct rx_reorder_entry =
*)
+=09=09=09 list_entry(list->next, struct rx_reorder_entry, list))->seq_num)=
)
 =09=09=09return false;
 =09=09else
 =09=09=09break;

I can of course remove this change from patch.

>=20
>=20
> Sometimes it is better to change less.

True.

>=20
> The change does not perfectly fit to the description: There you say
> ...aligns the code to open parentheses... but you do not need to remove
> line breaks or shorten code to achieve this.

I agree. There are a few removed line breaks, where I thought it could
improve code readability. If these changes are not acceptable, I will
of course remove them.

>=20
> Smaller patches lead to an earlier acceptance. This typically leads to
> more confidence at the beginning for newbies. There is no question about
> that you know what you are doing. But there are some corners where the
> kernel is special.

Thank you, I will watch out for these corners.

>=20
> Find more below.
>=20
> > ...
> > @@ -876,9 +874,9 @@ static int rtllib_rx_check_duplicate(struct rtllib_=
device *ieee,
> > frag =3D WLAN_GET_SEQ_FRAG(sc);
> >=20
> > if (!ieee->ht_info->cur_rx_reorder_enable ||
> > - !ieee->current_network.qos_data.active ||
> > - !is_data_frame(skb->data) ||
> > - is_legacy_data_frame(skb->data)) {
> > + !ieee->current_network.qos_data.active ||
> > + !is_data_frame(skb->data) ||
> > + is_legacy_data_frame(skb->data)) {
> > if (!ieee80211_is_beacon(hdr->frame_control)) {
> > if (is_duplicate_packet(ieee, hdr))
> > return -1;
> > @@ -887,7 +885,7 @@ static int rtllib_rx_check_duplicate(struct rtllib_=
device *ieee,
> > struct rx_ts_record *ts =3D NULL;
> >=20
> > if (rtllib_get_ts(ieee, (struct ts_common_info **)&ts, hdr->addr2,
> > - (u8)frame_qos_tid((u8 *)(skb->data)), RX_DIR, true)) {
> > + (u8)frame_qos_tid((u8 *)(skb->data)), RX_DIR, true)) {
>=20
>=20
> I am understanding the logic behind this but I cannot really say that
> this increases the readability. It increases the readability of the if
> condition but I am losing readability of the overall code and it
> increases the issue with the too long lines.

I understand your point. If this change negatively impacts readability
of the overall code, I can of course remove it.
About the issue with too long lines - I am certain that none of the lines
I introduced were longer than 100 columns, unless we are trying to maintain
hard limit of 80 columns wherever possible. I know that line length of
80 columns is still preferred, though. Sometimes, these 20 additional
columns could increase readability, but I understand that it is not granted=
.

>=20
> I have not looked into the remaining patches.
>=20
> I need some support from another reviewer.
>=20
> Your patches are working fine on hardware.

Once again, thank you for thorough review, and I hope I am not overusing
your patience.

Thanks,

Dominik Karol

>=20
> Bye Philipp
>=20
> > if ((fc & (1 << 11)) && (frag =3D=3D ts->rx_last_frag_num) &&
> > (WLAN_GET_SEQ_SEQ(sc) =3D=3D ts->rx_last_seq_num))
> > return -1;

