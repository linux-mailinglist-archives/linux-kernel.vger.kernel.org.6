Return-Path: <linux-kernel+bounces-209923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7737903CFC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60ADD287116
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196EB17C9F5;
	Tue, 11 Jun 2024 13:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iF2ogBzd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5797D17B42E;
	Tue, 11 Jun 2024 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718111955; cv=none; b=oRfig9fmqF6e+FNrhklXEWQ4L1cF43/GMT4VAzOUuBREWW8bcsTtrm9cxF72lLOGXZBhzoEgMDOKa4wjASaJ6wZB3GInX0ghQf1WN0hLaMo1GZovZoB4yCKJsXeMGvIPPonixI4ApmMTcK/bdQ73pSqzREFkU+y8BNeruOw8QY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718111955; c=relaxed/simple;
	bh=J8yhVuHGe30lXX6K160M1LciDauZy7HN1wD2X9gUkcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkQkLRfh89U9RQ6NC/SFiTTVljqdKzW1YxRGynnn4zDiTyjf3brWtUGAKmK2BXiqqGJzfxa7dHh+mMModPJD20sefne03erYh2ek+w+adNV2cjN+i6tJqunLvav9e+d7Kks8PCpKivsSSlvI0GtqjaUS9aEGRS0yeZz7Z8q1o0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iF2ogBzd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D914C2BD10;
	Tue, 11 Jun 2024 13:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718111954;
	bh=J8yhVuHGe30lXX6K160M1LciDauZy7HN1wD2X9gUkcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iF2ogBzdTXnby9LDZhbj6ywrmVv5y4/40fTX7bT04jojCnB5hwI7vy1ibGcJ8/r88
	 XYFw9P19hjgZoO+QtbYGCraSsJ4jQz8NSmVFD/UtW7QW3rV2RqX3mpo++bIky+LrpX
	 jM3Ot4XwUy41z1nP+5IWc3fQBT7vvV1as9FrnOujEXlHY2H1e9c24le/Og2N7/pZMZ
	 PXSIFplW3DEFzQsPk4R2zwpsm1+X/HlmNr94C9FRqMnjVTqn9U1LnE0faOxcOxTLeY
	 a71HjU9vUmwHQXTj9+/oQjdmNzNod8sbirixKktKFZfUFJIIGXh2sqKN9GxzYWDNAP
	 9fDFRuXW1K0sg==
Date: Tue, 11 Jun 2024 14:19:11 +0100
From: Mark Brown <broonie@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Rui Zhou <zhourui@huaqin.corp-partner.google.com>, lgirdwood@gmail.com,
	perex@perex.cz, tiwai@suse.com, matthias.bgg@gmail.com,
	trevor.wu@mediatek.com, allen-kh.cheng@mediatek.com,
	kuninori.morimoto.gx@renesas.com, maso.huang@mediatek.com,
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1] ASoC: support machine driver with TAS2781
Message-ID: <ZmhOz7BB8eJ38QVE@finisterre.sirena.org.uk>
References: <20240611022227.2508354-1-zhourui@huaqin.corp-partner.google.com>
 <Zmgsfafmfedd9_MV@finisterre.sirena.org.uk>
 <d7d32ef3-8b2e-476c-a15e-7f829ea0d60a@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L8C5DHVHxE1pZFLB"
Content-Disposition: inline
In-Reply-To: <d7d32ef3-8b2e-476c-a15e-7f829ea0d60a@collabora.com>
X-Cookie: Your love life will be... interesting.


--L8C5DHVHxE1pZFLB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 11, 2024 at 02:38:09PM +0200, AngeloGioacchino Del Regno wrote:
> Il 11/06/24 12:52, Mark Brown ha scritto:
> > On Tue, Jun 11, 2024 at 10:22:27AM +0800, Rui Zhou wrote:
> > > Support amp TAS2781 for mt8188 platform

> > > +++ b/sound/soc/mediatek/Kconfig
> > > @@ -233,6 +233,7 @@ config SND_SOC_MT8188_MT6359
> > >   	select SND_SOC_HDMI_CODEC
> > >   	select SND_SOC_DMIC
> > >   	select SND_SOC_MAX98390
> > > +	select SND_SOC_TAS2781_I2C
> > >   	select SND_SOC_NAU8315
> > >   	select SND_SOC_NAU8825

> > Ideally this would be sorted to avoid spurious merge conficts.  Also do
> > we really have dependencies here or should these just be being enabled
> > by users - these drivers are all pretty generic now?

> The only dependency is on the MT6359 PMIC's audio related IPs and nothing else.

> I'd even remove the other select statements for the other codecs, honestly,
> as there's no reason why MT8188 wouldn't support a codec or the other, and
> there is no reason why that SoC needs exactly those codecs, apart from some
> board (Chromebooks) having one, or the other.

Right, that's what I meant - the drivers are now so generic that they
probably shouldn't be selecting everything they could possibly work
with.

> Instead of adding a select statement on MT8188_MT6359, adding the TAS2781_I2C
> driver as a module in defconfig is a better idea..... at least, IMO.

Yes.

> >  Not that this
> > change in itself makes a huge difference to the existing state.

> I agree it doesn't make any huge difference, but I also don't see why users
> can't simply enable (y/m) that in the kernel configuration :-)

I think this is a result of the drivers originally being very specific
to a particular setup and gradually getting made more generic, if the
driver can only be used on a specific machine then the selects make
sense but that's no longer the case for these drivers I think.

--L8C5DHVHxE1pZFLB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZoTs4ACgkQJNaLcl1U
h9C5qQf9G5KuVznYWJOIxmrBhe90rR14xzXQ8iuN/dpwJrplNgIKiv/scP1621jG
KMls3d3XffNozTDEjmE38BVH8H8kpa0pS2A88fKLp9Gv+4lvXMQXrw/XO/oKxkIZ
b5sX+1YNLdebMbKyDzw16JmUenEkZHgSNpxc68bfmxFptlhtqo+0V3ZPkpGlsTCr
i8uIMveI3ySIyxh+nRJHll9qfgqA5YvoHEadaflAnaRhQ6eI9beW9VtbBX3+P02n
IYysSSakV433928mgTzoGvXGTgyJkc9ZV/uF7E5RRntPdqzU+/dEVlvt2wipweI2
LyNOUbLuMhdQXn/GFYSUfFaJBROFdw==
=JJl5
-----END PGP SIGNATURE-----

--L8C5DHVHxE1pZFLB--

