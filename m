Return-Path: <linux-kernel+bounces-182025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B53068C8541
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 13:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E72291C20E29
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 11:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285EA3FBBD;
	Fri, 17 May 2024 11:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmLfuhIB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F63F3F9C6
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715944031; cv=none; b=Ft/z/qHJdXuoEu9TsMnA15FosP9+nqhdaoDU9jklDDc9VUmzwHr3nooTrRUU4Nio+I/x7kQ/ojRTDxLkBh3kFndjAhHZDOoqhAphyhfe5aS/T+90wIAoOnTV/f0CmHpEh1nHXW7jWJWXHEWuNx3BQIAQfP1BzYfVonvzYiyK61o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715944031; c=relaxed/simple;
	bh=qepJpb+INo15UPmEy1U24ZqOyd6+e3G2rBEzzbA1XW4=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To; b=tgnbnfWjlaSiNhTAczmTbEQRAYrZ6b84+dg87dDmI3+kppd8Jp7hqiZ5MO/o+/sn3Hgwwg+JLlYTzeaWspa08nM2/G4ugziPD7aUI5dVflrx8syGoWQOVaTPxyK36ioX0hTth6OEiTaNcfaViA7BN8q/fY+76bHKY9my5VrT2xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmLfuhIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A15C2BD11;
	Fri, 17 May 2024 11:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715944031;
	bh=qepJpb+INo15UPmEy1U24ZqOyd6+e3G2rBEzzbA1XW4=;
	h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
	b=AmLfuhIBN1KnqaliLyugi8WI6e4hzmsCPH9zYGtSuoe6BLQ6RmOX/0qXTRClqtrm2
	 YWMGLkCpjwwh+GaTTY0Iw6uJ4jqOKJ9w+ZLpsY5MQmU47nSiuU2bkSJ03/yVQWNmDr
	 WBi8SGHPDbWGe2ZGdFOr+jbXFp0yAt4oSPJHacrcOJRe5uy8zkpzOHlqq+pXpKQvoY
	 mQaC7BYYYpl1GvR8NcXS1VdK08dEReVKRgjZ5h05/pKNq3zkTyi8VoH0AddKcE1KE9
	 tEvSBp8t8rB9lzi204rf/U5Byqyc1x8Pxirg3DDMhy/gXEu1TDqQtTWlv6y5JPmjRL
	 2HG80Y8QRvsnw==
Content-Type: multipart/signed;
 boundary=2e7c618b67a0e9241d302089bef35dcad20c6b884d610d157a60289baad9;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 17 May 2024 13:07:06 +0200
Message-Id: <D1BVE3G40OVL.3KX13LU75M122@kernel.org>
Cc: "Jani Nikula" <jani.nikula@intel.com>, "Chen-Yu Tsai"
 <wenst@chromium.org>, <linux-mediatek@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 "Chun-Kuang Hu" <chunkuang.hu@kernel.org>, "Philipp Zabel"
 <p.zabel@pengutronix.de>, "David Airlie" <airlied@gmail.com>, "Daniel
 Vetter" <daniel@ffwll.ch>, "Matthias Brugger" <matthias.bgg@gmail.com>
Subject: Re: [PATCH] drm/mediatek/dp: fix spurious kfree()
X-Mailer: aerc 0.16.0
References: <20240517093024.1702750-1-mwalle@kernel.org>
 <de0191f3-271b-4f0e-aa73-910543587c9d@collabora.com>
In-Reply-To: <de0191f3-271b-4f0e-aa73-910543587c9d@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--2e7c618b67a0e9241d302089bef35dcad20c6b884d610d157a60289baad9
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri May 17, 2024 at 12:35 PM CEST, AngeloGioacchino Del Regno wrote:
> Il 17/05/24 11:30, Michael Walle ha scritto:
> > drm_edid_to_sad() might return an error or just zero. If that is the
> > case, we must not free the SADs because there was no allocation in
> > the first place.
> >=20
> > Fixes: dab12fa8d2bd ("drm/mediatek/dp: fix memory leak on ->get_edid ca=
llback audio detection")
> > Signed-off-by: Michael Walle <mwalle@kernel.org>
> > ---
> >   drivers/gpu/drm/mediatek/mtk_dp.c | 10 ++++++++--
> >   1 file changed, 8 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediat=
ek/mtk_dp.c
> > index 536366956447..ada12927bbac 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> > @@ -2073,9 +2073,15 @@ static const struct drm_edid *mtk_dp_edid_read(s=
truct drm_bridge *bridge,
> >   		 */
> >   		const struct edid *edid =3D drm_edid_raw(drm_edid);
> >   		struct cea_sad *sads;
> > +		int ret;
> >  =20
> > -		audio_caps->sad_count =3D drm_edid_to_sad(edid, &sads);
> > -		kfree(sads);
> > +		ret =3D drm_edid_to_sad(edid, &sads);
> > +		/* Ignore any errors */
> > +		if (ret < 0)
> > +			ret =3D 0;
> > +		if (ret)
>
> Eh, this will never work, because you're clearing the error before checki=
ng
> if there's any error here?!?! :-P

Don't get what you mean? Yes, I'm ignoring the error. Thus, in case
of an error ret will be zero and there will be no free. If ret was
zero, there won't be a free either. So you're left with the "normal"
case, where you have to free the sads. Just like before.

> Anyway in reality, it returns -ENOMEM if the allocation was not successfu=
l...
> in the event that any future update adds any other error we'd be back wit=
h the same
> issue, but I'm not sure how much should we worry about that.
>
> To be extremely safe, we could do...
>
> if (ret !=3D -ENOMEM)
> 	kfree(sads)
>
> audio_caps->sad_count =3D ret < 0 ? 0 : ret;

Which is the same as above, but you only check for ENOMEM?

-michael

>
> Cheers!
> Angelo
>
> > +			kfree(sads);
> > +		audio_caps->sad_count =3D ret;
> >  =20
> >   		/*
> >   		 * FIXME: This should use connector->display_info.has_audio from


--2e7c618b67a0e9241d302089bef35dcad20c6b884d610d157a60289baad9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZkc6WxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gAqQF+If8ohfxWzONaLs9k/KTwOxp40wyYspvp
WPYgaY0y+YvqmfPt97bXGMvUrmaKiCVsAYCDq77Zckt0yPwr05dGwlFZov0Ytzw6
mKkHukD+eW43LnjracU3q6+XD7wqRPUSsQQ=
=180b
-----END PGP SIGNATURE-----

--2e7c618b67a0e9241d302089bef35dcad20c6b884d610d157a60289baad9--

