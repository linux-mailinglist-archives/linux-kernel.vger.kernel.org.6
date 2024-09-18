Return-Path: <linux-kernel+bounces-332895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD2397C061
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 21:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30588282E48
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 19:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34601CB505;
	Wed, 18 Sep 2024 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="KhKBdJTl"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2861CB30A
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 19:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726687285; cv=none; b=kcdLN0dK/7bVL0/LbORN947jj+vk5ltcn1PHHuhPCSbplzHzfbJuzaLcHDDZVU7kDWNcC0F4P/SlfoQRPC3vGChYaQcRpzfSns0Be/xZ5pxk4IpvVT93TpMDhLA7wfWeEMH3X9VgW8rWHFxarL8RhwUTm/Y28UhHLl+xuaT8dt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726687285; c=relaxed/simple;
	bh=JECJLvnhio78zZxE3FL4gNGIfj9yWbrkXe9N/pkvkAU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXwnXE12j0+8x/6PU57k0PpNp0NyD0PxzQtrhUJYJQYaOsDfWQS+xUypgE8i6dhcBAXDHLwRqaCWhoCO/WAQViDTqd03gCRBhV8u/LvTDYyhagntNiqQdFpf4sFeow5Bb9WxgzeVgDRqKfk4kP4rv5jLkN4+Ggxb0ngVVnH51+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=KhKBdJTl; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1726687280; x=1726946480;
	bh=n+iho082T7gTlh0cvK2vzkCqMr12X2d6EyFsyy1wuzo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KhKBdJTloYNb/v9VXyPvU8MFGLIm7QWXuYZeCxNdZ3Pu71AoUvPe0/wJoIV1TUmYF
	 w3E0ScujO8qMWMJfOMEdV2JmaFcS2vO7kGSUp0xQ9xx/frw302a8p0GKwWqRiPWGvf
	 kQBFWTC455J2F1XVPFvhFYIX0kDRATJP1q8InTb3uBu4QsDZV4Lo+oexO53ohQug4+
	 YpK3yVLwHkqP4/+NDe71kRdZHu3/6oSx9+cWULTViZrjA6ftwBDi1HDaPL0sVnrEkR
	 47wCCopq3o88pDWsSo84Pujt/a29pLiy8JrNpJ6YVTCX/ZaQ341K2RnAfnVzaVGZBp
	 zyErRq4/Nz5+g==
Date: Wed, 18 Sep 2024 19:21:15 +0000
To: philipp.g.hortmann@gmail.com, gregkh@linuxfoundation.org
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH 06/14] staging: vt6655: s_uGetDataDuration: Rename bNeedAck parameter
Message-ID: <20240918191959.51539-7-dominik.karol.piatkowski@protonmail.com>
In-Reply-To: <20240918191959.51539-1-dominik.karol.piatkowski@protonmail.com>
References: <20240918191959.51539-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 10ac2baaf174f0bd80ce457defa0a67e2c071d2a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch renames bNeedAck to need_ack in s_uGetDataDuration function
in order to avoid using camel case.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
 drivers/staging/vt6655/rxtx.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 7dd57d2e2831..72837898ea29 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -234,7 +234,7 @@ s_uGetDataDuration(
 =09unsigned int frame_length,
 =09unsigned char pkt_type,
 =09unsigned short rate,
-=09bool bNeedAck,
+=09bool need_ack,
 =09unsigned int uFragIdx,
 =09unsigned int cbLastFragmentSize,
 =09unsigned int uMACfragNum,
@@ -254,51 +254,51 @@ s_uGetDataDuration(
=20
 =09switch (dur_type) {
 =09case DATADUR_B:    /* DATADUR_B */
-=09=09if (bNeedAck) {
+=09=09if (need_ack) {
 =09=09=09uAckTime =3D bb_get_frame_time(priv->preamble_type,
 =09=09=09=09=09=09     pkt_type, 14,
 =09=09=09=09=09=09     priv->byTopCCKBasicRate);
 =09=09}
 =09=09/* Non Frag or Last Frag */
 =09=09if ((uMACfragNum =3D=3D 1) || bLastFrag) {
-=09=09=09if (!bNeedAck)
+=09=09=09if (!need_ack)
 =09=09=09=09return 0;
 =09=09} else {
 =09=09=09/* First Frag or Mid Frag */
 =09=09=09uNextPktTime =3D s_uGetTxRsvTime(priv, pkt_type,
-=09=09=09=09=09=09       len, rate, bNeedAck);
+=09=09=09=09=09=09       len, rate, need_ack);
 =09=09}
=20
 =09=09return priv->uSIFS + uAckTime + uNextPktTime;
=20
 =09case DATADUR_A:    /* DATADUR_A */
-=09=09if (bNeedAck) {
+=09=09if (need_ack) {
 =09=09=09uAckTime =3D bb_get_frame_time(priv->preamble_type,
 =09=09=09=09=09=09     pkt_type, 14,
 =09=09=09=09=09=09     priv->byTopOFDMBasicRate);
 =09=09}
 =09=09/* Non Frag or Last Frag */
 =09=09if ((uMACfragNum =3D=3D 1) || bLastFrag) {
-=09=09=09if (!bNeedAck)
+=09=09=09if (!need_ack)
 =09=09=09=09return 0;
 =09=09} else {
 =09=09=09/* First Frag or Mid Frag */
 =09=09=09uNextPktTime =3D s_uGetTxRsvTime(priv, pkt_type,
-=09=09=09=09=09=09       len, rate, bNeedAck);
+=09=09=09=09=09=09       len, rate, need_ack);
 =09=09}
=20
 =09=09return priv->uSIFS + uAckTime + uNextPktTime;
=20
 =09case DATADUR_A_F0:    /* DATADUR_A_F0 */
 =09case DATADUR_A_F1:    /* DATADUR_A_F1 */
-=09=09if (bNeedAck) {
+=09=09if (need_ack) {
 =09=09=09uAckTime =3D bb_get_frame_time(priv->preamble_type,
 =09=09=09=09=09=09     pkt_type, 14,
 =09=09=09=09=09=09     priv->byTopOFDMBasicRate);
 =09=09}
 =09=09/* Non Frag or Last Frag */
 =09=09if ((uMACfragNum =3D=3D 1) || bLastFrag) {
-=09=09=09if (!bNeedAck)
+=09=09=09if (!need_ack)
 =09=09=09=09return 0;
 =09=09} else {
 =09=09=09/* First Frag or Mid Frag */
@@ -315,7 +315,7 @@ s_uGetDataDuration(
 =09=09=09=09rate =3D fb_opt1[FB_RATE0][rate];
=20
 =09=09=09uNextPktTime =3D s_uGetTxRsvTime(priv, pkt_type,
-=09=09=09=09=09=09       len, rate, bNeedAck);
+=09=09=09=09=09=09       len, rate, need_ack);
 =09=09}
=20
 =09=09return priv->uSIFS + uAckTime + uNextPktTime;
--=20
2.34.1



