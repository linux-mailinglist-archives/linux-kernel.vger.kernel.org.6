Return-Path: <linux-kernel+bounces-334642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5524097D9DB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 21:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3EC61F23700
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 19:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FCF186E33;
	Fri, 20 Sep 2024 19:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="VFsnIkdV"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAD0186617
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 19:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726861009; cv=none; b=cRGniVrWGhKyCLgOppBRmgVSznjNmnYrg61O+G6lVyCocrEJojA6gfwQMlON37x9eQBVzVF4RO82URxVG9eMss08RVjuVP8wS9NKXKnvN6QZRWRYtQihI4JlsC8C76c3St3T6FixJbe9HfYCEEh23beXhQCYKLoIaDDJGUx2JDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726861009; c=relaxed/simple;
	bh=FWUAVX80TncB9m90tqjT3S569a7lQWjqB53otGHgEis=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ven29WLYl/ls0zhYVPcSHGfwo+UP40AhHInLrf2zDfVRiXer4q338WeDGrbwJ0LwzVxoGZAPWFqMnAmksDIchdaYvlwRTkOegRA268rXfHcDEgFzUqjRGcIcmqzbXsCvIShFf7AXxyUeuul7MDQcgJVFM8IXotE68FLy5+A17yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=VFsnIkdV; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1726861005; x=1727120205;
	bh=MX8ZfbYDKOWv75YzIM+14X2Ac72mkrn1kbOyp2I1f9A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VFsnIkdV+L6fjUZIOl/2NZSfzwtI8MqpSt1jpui+sb5eTtUsGagQ1Es/gT+3B18Sb
	 MyDQFeVjCGJYEsnMx6xgJRuEipG4/bZ2PIeDFgVctGcPe+qGPV8BnMkKt93O+5nEiv
	 kD19JQpl8VjdoOutywl/6uL6Dhsd2anHS6E9BwRT3+vD2+TBbHtAaHNqRHuQwW8FNG
	 G6Lscxbf/ba14aU4kCif/Z2mkob09qt5GcHQ5Zm/HpnkwVXBj8LM29j4LdOD90p9QX
	 tCz1DFNvJa1vKRj6ApELliR36zUnNoGDJelUe65J+apWInZ+5/zTe/Q8vmq4BbtZSR
	 Y5qtigcZTrJAA==
Date: Fri, 20 Sep 2024 19:36:40 +0000
To: gregkh@linuxfoundation.org, tdavies@darkphysics.net, philipp.g.hortmann@gmail.com, dan.carpenter@linaro.org
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH v2 6/6] staging: rtl8192e: rtllib_wx.c: Fix alignment to open parentheses
Message-ID: <20240920193356.32156-7-dominik.karol.piatkowski@protonmail.com>
In-Reply-To: <20240920193356.32156-1-dominik.karol.piatkowski@protonmail.com>
References: <20240920193356.32156-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 70ca165da1c5231c088e787e586883e0795f37ad
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch aligns the code to open parentheses to improve readability.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
 drivers/staging/rtl8192e/rtllib_wx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192=
e/rtllib_wx.c
index c730d921463d..b25343f01f8d 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -134,8 +134,7 @@ static inline char *rtl819x_translate_scan(struct rtlli=
b_device *ieee,
 =09=09=09=09((ht_cap->short_gi_40mhz) ? 1 : 0) :
 =09=09=09=09((ht_cap->short_gi_20mhz) ? 1 : 0);
=20
-=09=09max_mcs =3D ht_get_highest_mcs_rate(ieee, ht_cap->MCS,
-=09=09=09=09=09      MCS_FILTER_ALL);
+=09=09max_mcs =3D ht_get_highest_mcs_rate(ieee, ht_cap->MCS, MCS_FILTER_AL=
L);
 =09=09rate =3D MCS_DATA_RATE[is40M][isShortGI][max_mcs & 0x7f];
 =09=09if (rate > max_rate)
 =09=09=09max_rate =3D rate;
--=20
2.34.1



