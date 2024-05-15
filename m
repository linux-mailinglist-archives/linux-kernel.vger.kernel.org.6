Return-Path: <linux-kernel+bounces-180032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5338E8C6915
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F428283D7E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8367415573C;
	Wed, 15 May 2024 14:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSTDR7vc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C750E1E480
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715785123; cv=none; b=VgGg7VOGmnheeW1wjddlmRMAODyn/ma3K9Kq5iRGmfOYn+xPNB1M/VFpbm9tr2Zv9TyGHHgGG7FcfF4PMuQ2CcCoZ7DZFRhCJi/DudCRTUEN6Spj+dlmyQAxa/num61bO0NENtVLORo2q1R1c610lZSJcSBaNq3Brzh1DQ6fTTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715785123; c=relaxed/simple;
	bh=H4fvttaW5ayZbuhZGdEunUdzP2phRBo1WR9XclwqbBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mg5+wG2g9dyd4CkyrOM3KoXdariiMeWkG394varZFoWxk/bnaPSSvuo20RYCFlqdJ9cPWcO1+UqFPMAsmF3FlgriqSA4eR61h42nv3mY9MPXts8pokL3TXecW+aY96Up7LM2TgC3lT2KFw3LSqb7R/HMBUwIOxM/LW709KfTEqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSTDR7vc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AF9C116B1;
	Wed, 15 May 2024 14:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715785123;
	bh=H4fvttaW5ayZbuhZGdEunUdzP2phRBo1WR9XclwqbBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WSTDR7vcNt1KrNEwvkAlMGG6a0Qo9/t5SF3cOP3RroxNld3mBPBTaWAapgj38N44L
	 UMezzf6AULi4TxjtPWMNzRZVgxEQaoMKYffcIyBTZhl2VTXhK43lSWXiwuy4HREKBq
	 xSbw5wfswH747qb3wIBb0Ny8u7hw+HRZGY1vvc5amWd0juw1oEkSdFYQH9L3jPId2/
	 BMJPGj9yU2c1t63t/Amii0IcXTRm8qzG9T0Je1lzj+RrA2aXcdZT/Kt8C2CzDCgG0d
	 hQXWc+/nYJz3uOr4JNwaaJDcWxYu8DF6d+gNg6jH3KCXTlH8MpD7r9Bvkwfm42ITaV
	 eaMvBA5I+vMdw==
Date: Wed, 15 May 2024 16:58:40 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drm/bridge: Add 'struct device *' field to the
 drm_bridge structure
Message-ID: <20240515-copper-chimpanzee-of-fortitude-ff3dab@penduick>
References: <20240514154045.309925-1-sui.jingfeng@linux.dev>
 <20240514-scarlet-corgi-of-efficiency-faf2bb@penduick>
 <c44480ab-8d6b-4334-8eba-83db9b30ff1a@linux.dev>
 <20240515-fair-satisfied-myna-480dea@penduick>
 <d394ee32-4fa4-41a8-a5ca-c1c7f77f44d2@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="nnqcwypgq74a2js6"
Content-Disposition: inline
In-Reply-To: <d394ee32-4fa4-41a8-a5ca-c1c7f77f44d2@linux.dev>


--nnqcwypgq74a2js6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 10:53:00PM +0800, Sui Jingfeng wrote:
> On 5/15/24 22:30, Maxime Ripard wrote:
> > On Wed, May 15, 2024 at 12:53:33AM +0800, Sui Jingfeng wrote:
> > > On 2024/5/15 00:22, Maxime Ripard wrote:
> > > > Hi,
> > > >=20
> > > > On Tue, May 14, 2024 at 11:40:43PM +0800, Sui Jingfeng wrote:
> > > > > Because a lot of implementations has already added it into their =
drived
> > > > > class, promote it into drm_bridge core may benifits a lot. drm br=
idge is
> > > > > a driver, it should know the underlying hardware entity.
> > > > Is there some actual benefits, or is it theoretical at this point?
> > >=20
> > >=20
> > > I think, DRM bridge drivers could remove the 'struct device *dev'
> > > member from their derived structure. Rely on the drm bridge core
> > > when they need the 'struct device *' pointer.
> >=20
> > Sure, but why do we need to do so?
> >=20
> > The other thread you had with Jani points out that it turns out that
> > things are more complicated than "every bridge driver has a struct
> > device anyway", it creates inconsistency in the API (bridges would have
> > a struct device, but not other entities), and it looks like there's no
> > use for it anyway.
> >=20
> > None of these things are deal-breaker by themselves, but if there's only
> > downsides and no upside, it's not clear to me why we should do it at al=
l.
>
> It can reduce boilerplate.

You're still using a conditional here.

Maxime

--nnqcwypgq74a2js6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZkTNnwAKCRAnX84Zoj2+
dpZCAYCvwVAwC/xH/sNA6jr+W48uYJHUiGFm1EaRagcrEpn+Vmm6ntjQFe8LLIpl
eQetDGgBgN4V7i9OmkXkcdhGNkhsT/oGnh3L3/mF7PFNx89Z5mm5Cnw9b0axTGbn
lAqrW3gWLg==
=4/O0
-----END PGP SIGNATURE-----

--nnqcwypgq74a2js6--

