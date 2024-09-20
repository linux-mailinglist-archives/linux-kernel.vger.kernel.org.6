Return-Path: <linux-kernel+bounces-334361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2887097D63E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 15:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56B5EB21D8E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 13:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E69178395;
	Fri, 20 Sep 2024 13:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="sdlchPv7"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73729158DB1
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 13:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726839452; cv=none; b=GV3ZHi+iMcFpePRFVOG5/95Wh/27nqXHMGhy9g22/tIN2e9lO6fOs0ZpzVbN147HHhRFvhsgPmKNRWl8RK7kKw7Uky+B4oC+AiZgcW0i6xLB4ZBOXCHw/A2pYSQ4BmQeJ7+omFTb2EUea9gsuIs9gmsVU5EC4p/JAG+Dn0Up8wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726839452; c=relaxed/simple;
	bh=hOqLiThOivw6BibqdtT8D1c8R7QqDuIsn0z9ej131Tc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a8cmSVk16eUYVwGP0SinyOuzUI79MowWm9zatE1ajRadrR22I3Mv/P05KjSPem55yCkY3zjqG99VlnI+Ji83mvoyTzmDBbdoz9mL1FkHpZWJaTRgld+TEyzrL/HuvIXCd0Ned5e48EULd24dodseBCmt+i2A9PCd+iok+kcp5is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=sdlchPv7; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1726839447; x=1727098647;
	bh=hOqLiThOivw6BibqdtT8D1c8R7QqDuIsn0z9ej131Tc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=sdlchPv7e6N4qFv5XAkj2FB2X3y7TBwdrWhDYsAoPUCvsWcV4mgFDBCK0UI1tBmf0
	 EulVgO3vLTDBUEa4zBqU5iclWw13MYhg/6wxwF8tXJmr9EegCsQgep3WAkX23noEn6
	 U/K3BRUP+2PurVpOAojxTvFjzrrLspg/YqY4cZ0HdkIjRQk3N9hbqDqcwA4zllmJGt
	 ACoR2tTh3lmRvNEZ5O0oSXMax18UkWy96ixfUWOKkCpZU4nOp9hJIFlvLEuAgIomwx
	 ECrkE1HW8qmQ+uoWmCu+W+c7z0MWU29khzNourC7R7YsGS+tLPVAY4GZQAgmzeHI26
	 6Kj3bZHla1NdA==
Date: Fri, 20 Sep 2024 13:37:23 +0000
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: gregkh@linuxfoundation.org, tdavies@darkphysics.net, dan.carpenter@linaro.org, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Fix alignment to open parentheses
Message-ID: <qdwaM7uxN2Sm0zSi_JF5cMYkIhlMFdluiUK6bLU1XqiHDMaSnMcVpCOseEfvdJKu-3uRr_iAuEBMJPn6Qbix-FaNG0EF8n82K3E7lQ5Zg5M=@protonmail.com>
In-Reply-To: <e3c09066-3a40-4145-b5b4-4ccf5b755982@gmail.com>
References: <20240919185445.119969-1-dominik.karol.piatkowski@protonmail.com> <e3c09066-3a40-4145-b5b4-4ccf5b755982@gmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 95c3030774a9faddad1a95c7b02c61b34e53d56a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Philipp,

On Thursday, September 19th, 2024 at 22:15, Philipp Hortmann <philipp.g.hor=
tmann@gmail.com> wrote:
<cut>
> > diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/s=
taging/rtl8192e/rtl8192e/r8192E_dev.c
> > index 2672b1ddf88e..cf1231fe5319 100644
> > --- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> > +++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
<cut>
> > @@ -335,8 +334,9 @@ static void _rtl92e_read_eeprom_info(struct net_dev=
ice *dev)
> >=20
> > for (i =3D 0; i < 14; i +=3D 2) {
> > if (!priv->autoload_fail_flag)
> > - usValue =3D rtl92e_eeprom_read(dev,
> > - (EEPROM_TxPwIndex_CCK + i) >> 1);
> > + usValue =3D
> > + rtl92e_eeprom_read(dev,
> > + (EEPROM_TxPwIndex_CCK + i) >> 1);
>=20
>=20
> Sorry this is not really increasing readability.

You are right. The problem with this line is that it has 5 levels of nestin=
g,
and this makes it hard to fix the readability without having too long lines=
.

A some kind of rewrite could be helpful in the future, moving the deeply
nested code into its own functions. For now, I think it is not sanely fixab=
le.

>=20
> > else
> > usValue =3D EEPROM_Default_TxPower;
> > *((u16 *)(&priv->eeprom_tx_pwr_level_cck[i])) =3D
> > @@ -345,7 +345,8 @@ static void _rtl92e_read_eeprom_info(struct net_dev=
ice *dev)
> > for (i =3D 0; i < 14; i +=3D 2) {
> > if (!priv->autoload_fail_flag)
> > usValue =3D rtl92e_eeprom_read(dev,
> > - (EEPROM_TxPwIndex_OFDM_24G + i) >> 1);
> > + (EEPROM_TxPwIndex_OFDM_24G + i)
> > + >> 1);
>=20
>=20
> Sorry this is not really increasing readability. The >> 1 in the next
>=20
> line is net nice.

I agree, this was a bad idea. This line is a similar case to the previous o=
ne,
with it also having 5 levels of nesting. For now, I think it is also not sa=
nely
fixable.

>=20
> > else
> > usValue =3D EEPROM_Default_TxPower;
> > *((u16 *)(&priv->eeprom_tx_pwr_level_ofdm24g[i]))
> > @@ -1325,8 +1326,8 @@ static void _rtl92e_query_rxphystatus(struct r819=
2_priv *priv,
> > } else {
> > if (rf_rx_num !=3D 0)
> > pstats->signal_strength =3D precord_stats->signal_strength =3D
> > - _rtl92e_signal_scale_mapping(priv,
> > - (long)(total_rssi /=3D rf_rx_num));
> > + _rtl92e_signal_scale_mapping(priv, (long)
> > + (total_rssi /=3D rf_rx_num));
>=20
>=20
> I am not happy with this either. There are two =3D in the same line...

Right. The double assignment could be split into separate line, improving
readability, and probably allowing for nicer formatting.

<cut>
> > diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/sta=
ging/rtl8192e/rtl8192e/rtl_core.c
> > index dc1301f1a0c1..82a1b19fa1b3 100644
> > --- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> > +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
<cut>
> > @@ -406,8 +405,8 @@ static int _rtl92e_qos_assoc_resp(struct r8192_priv=
 *priv,
> > }
> >=20
> > static int _rtl92e_handle_assoc_response(struct net_device *dev,
> > - struct rtllib_assoc_response_frame *resp,
> > - struct rtllib_network *network)
> > + struct rtllib_assoc_response_frame *resp,
> > + struct rtllib_network *network)
>=20
>=20
> one space missing...

Is it missing? In my editor it looks okay.

<cut>
> > diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/stagin=
g/rtl8192e/rtl819x_HTProc.c
> > index 9c9c0bc0cfde..ec43b5fda06e 100644
> > --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
> > +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
<cut>
> > @@ -418,8 +416,8 @@ static u8 ht_filter_mcs_rate(struct rtllib_device *=
ieee, u8 *pSupportMCS,
> > }
> >=20
> > void ht_set_connect_bw_mode(struct rtllib_device *ieee,
> > - enum ht_channel_width bandwidth,
> > - enum ht_extchnl_offset Offset);
> > + enum ht_channel_width bandwidth,
> > + enum ht_extchnl_offset Offset);
>=20
>=20
> This one is not correct.

Is it incorrect? In my editor it looks okay.

>=20
>=20
> Hi Dominik,
>=20
> this patch is to long. 1200 Lines are long for a patch. It might work
> out when it can be checked automatically. But in this case I need go
> through it line by line.

Fair point - I will keep that in mind and try to keep the patches short in
the future.

>=20
> Another issue is that I cannot apply it on top of the following patch
> series that I see likely to be accepted.
> https://lore.kernel.org/linux-staging/Zung-0ClV_527-_e@kernel-710/T/#t
>=20
> Here a trick to ensure this is not happening. I would look into the
> coverletter of above mentioned patch series. There are only 8 files
> changed so there are plenty left untouched. You can work on them.

Thank you for making me aware of this. I will prepare a v2 fixing the files
that are untouched by the mentioned series.

>=20
> My opinion is that people who are knew to the kernel community should
> start with simple patches and then evolve.
>=20
> I propose to look for unused macros in:
>=20
> r8192E_hw.h
>=20
> This is the output of a program I wrote. You need to carefully check if
> they are really good for removal.
>=20
> BCN_TCFG_CW_SHIFT
> BCN_TCFG_IFS
> IMR_BcnInt
> MSR_LINK_ADHOC
> MSR_LINK_MASTER
> RRSR_SHORT_OFFSET
>=20
> You can find patches in git about the removal of the macros as an example=
.

Thank you, I will look into these macros.

Thanks,

Dominik Karol

>=20
> Thanks for your support.
>=20
> Bye Philipp

