Return-Path: <linux-kernel+bounces-180002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15858C68B5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF332836D3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B940A3236;
	Wed, 15 May 2024 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFeI6Eu4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081BB13E8BA
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715783425; cv=none; b=Hu4201J07QBYkWfAAk9O8FNNvutC5bkdmHOB1EuTihIAN9K16nqQcPr72lsv6N3knwGqp4GNHLgLkdBolvRCyCGQHHnm1D0phabT2firBA6PlQn0GlJ/UsGf8hckklIJ5g32Nkxlz50SO57j0LU0GNhuWO3lnivsWU2VkAXkJ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715783425; c=relaxed/simple;
	bh=gGILRtmhPe2nXKaL9dnOVNi7GPppKkCM2B0TLvSQGHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4a8cXaHadwdqPK7reGvHEspNzhkwsZoKctb+EBWsJzPuaFKN9JMX5JYVg2wDgTQ4A6NuUB6qbyBiUGhu9hjSFuX7EjdfNk3Xj6KRY/5//8zn6HRLcSerqsjgl6xwOQJZXgfMMd/sRE7fIwyMADBGmO8BNSRZrMuAyBNvN8ZqF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFeI6Eu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56DE7C116B1;
	Wed, 15 May 2024 14:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715783424;
	bh=gGILRtmhPe2nXKaL9dnOVNi7GPppKkCM2B0TLvSQGHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BFeI6Eu4/ENBl7p4/B3tUMbhrrYB0ZIH9VwgJ4QcR36GJ70rvvP5pZEoFulPZa4+X
	 If29+7uJE3cTRI/8Sg7eUVm6wJ6aHJ87/SBLMizK3TUsQg8uku0UlLSd+Pmm9Vqkr4
	 wAEnn378WXX0IU6AoYsjWlWvCJeRq8BuPX2uMzLc4JS+JPvejqfw7Rgd2PGZcHJa7h
	 bjojAWrxP2wi/mmcdSTHMSG1lVIATMQN/ZSvPDk+8Xix7WhthK4LvLtXOcai0EJkpf
	 CX1Ui41Bsg6cBUVTxmxcfA83TD6VzBWbqKsFucCbbO/xjhzCOp4Ifb7zRMXIWPNUuR
	 5XpwxAaspOoKw==
Date: Wed, 15 May 2024 16:30:21 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drm/bridge: Add 'struct device *' field to the
 drm_bridge structure
Message-ID: <20240515-fair-satisfied-myna-480dea@penduick>
References: <20240514154045.309925-1-sui.jingfeng@linux.dev>
 <20240514-scarlet-corgi-of-efficiency-faf2bb@penduick>
 <c44480ab-8d6b-4334-8eba-83db9b30ff1a@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="llrm42vacf3vqq5y"
Content-Disposition: inline
In-Reply-To: <c44480ab-8d6b-4334-8eba-83db9b30ff1a@linux.dev>


--llrm42vacf3vqq5y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 12:53:33AM +0800, Sui Jingfeng wrote:
> Hi,
>=20
> On 2024/5/15 00:22, Maxime Ripard wrote:
> > Hi,
> >=20
> > On Tue, May 14, 2024 at 11:40:43PM +0800, Sui Jingfeng wrote:
> > > Because a lot of implementations has already added it into their driv=
ed
> > > class, promote it into drm_bridge core may benifits a lot. drm bridge=
 is
> > > a driver, it should know the underlying hardware entity.
> > Is there some actual benefits, or is it theoretical at this point?
>=20
>=20
> I think, DRM bridge drivers could remove the 'struct device *dev'
> member from their derived structure. Rely on the drm bridge core
> when they need the 'struct device *' pointer.

Sure, but why do we need to do so?

The other thread you had with Jani points out that it turns out that
things are more complicated than "every bridge driver has a struct
device anyway", it creates inconsistency in the API (bridges would have
a struct device, but not other entities), and it looks like there's no
use for it anyway.

None of these things are deal-breaker by themselves, but if there's only
downsides and no upside, it's not clear to me why we should do it at all.

Maxime

--llrm42vacf3vqq5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZkTG/QAKCRAnX84Zoj2+
dvo9AX9a5QiWezo2NOJlySdtUAQyNsdzN/lWX5aLvyVRCmJNkK/V1srS75EVegBF
nGFUoyABgPBWQK5lWVLa+U3wwCyNoYQ2gTgS6QR2Ggrusqvkk3zxOXvaf2spQ0V2
xv6kQMUBLQ==
=pCFD
-----END PGP SIGNATURE-----

--llrm42vacf3vqq5y--

