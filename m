Return-Path: <linux-kernel+bounces-332903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E26E97C069
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 21:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9C20B21C70
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 19:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29221CB523;
	Wed, 18 Sep 2024 19:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="BAhp1U2A"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2ED1CB306
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 19:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726687333; cv=none; b=rorzGsd4aKLt/jxwaUDuFEY1Ykac3rMRBDkHOB9Iou2pB3xBYC0nhB4upffYrw47Y2U27eKQZOKJrLEPW/eCBWITLlsx414dC5J5HTNKUaNcnOXyhTlscV+gxB2sg/4RmPhZkq7Ja5mQiXlE5W8ke94HSCQIaDR3CCXtRucQT0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726687333; c=relaxed/simple;
	bh=Czcp2yJGBgla6TgqvWXVkKu/fcKssVBswa8oW4pdJa8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AB/hBsIea30B25V1DgA4TxvWErFvePZ0kxbMbYvKreD0o61oNdEU3hfH4S3SPgqf0upngfXW4mW1XH1FfMf+M3dec0UFc2bnX2+YRsuLQzKUnmBlz2cA4gj1wbEmgK9ufjzYNdbC3TF6TtCgGTOLlqjLz6xaho3+vW2Zt5Ks0cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=BAhp1U2A; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1726687329; x=1726946529;
	bh=DDUH7OeMtsMPrOEqS4QwSZsqF8KwfUJ1uBYoBUpU6g4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=BAhp1U2AQuHr70NfiHFvnmagDADGo68TdleVcIsHRkhZsX+bqzX6LIALS8Lh6c1AC
	 YEhz5+jJGr4MrBqUYrzabJz67TdwTR4/HSEeQI0n9/u9ZcV4ibp2j7/eRNChxj1E9t
	 FBRP7qDiowS+37y4acOg1XDf9edOJLYUxj6e2L69DjZ0iydoAo4gVHkGm0SYJV6+DU
	 1wnlhUpwBnP+sbb/Bez096IEUc9ypu62fvW0zeAUhNemxess22ZyLOoBvEWq8W5qDT
	 SsZHQeukCeyp193cXKqAqRgdKf4ZUUx914Zi5eMq/RtRhGQyEVzLd5aUVmsVuVMQs+
	 zHUWp/8j7kcMg==
Date: Wed, 18 Sep 2024 19:22:02 +0000
To: philipp.g.hortmann@gmail.com, gregkh@linuxfoundation.org
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH 14/14] staging: vt6655: s_uGetDataDuration: Fix declaration formatting
Message-ID: <20240918191959.51539-15-dominik.karol.piatkowski@protonmail.com>
In-Reply-To: <20240918191959.51539-1-dominik.karol.piatkowski@protonmail.com>
References: <20240918191959.51539-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: eaaebe65bf716151aaa44cbe820b8e090a1716b1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch fixes formatting of s_uGetDataDuration function declaration.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
 drivers/staging/vt6655/rxtx.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 5e93ca38008e..4bcc75348284 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -226,20 +226,16 @@ static __le16 get_rtscts_time(struct vnt_private *pri=
v,
 }
=20
 /* byFreqType 0: 5GHz, 1:2.4Ghz */
-static
-unsigned int
-s_uGetDataDuration(
-=09struct vnt_private *priv,
-=09unsigned char dur_type,
-=09unsigned int frame_length,
-=09unsigned char pkt_type,
-=09unsigned short rate,
-=09bool need_ack,
-=09unsigned int frag_idx,
-=09unsigned int last_fragment_size,
-=09unsigned int mac_frag_num,
-=09unsigned char fb_option
-)
+static unsigned int s_uGetDataDuration(struct vnt_private *priv,
+=09=09=09=09       unsigned char dur_type,
+=09=09=09=09       unsigned int frame_length,
+=09=09=09=09       unsigned char pkt_type,
+=09=09=09=09       unsigned short rate,
+=09=09=09=09       bool need_ack,
+=09=09=09=09       unsigned int frag_idx,
+=09=09=09=09       unsigned int last_fragment_size,
+=09=09=09=09       unsigned int mac_frag_num,
+=09=09=09=09       unsigned char fb_option)
 {
 =09bool last_frag =3D false;
 =09unsigned int ack_time =3D 0, next_pkt_time =3D 0, len;
--=20
2.34.1



