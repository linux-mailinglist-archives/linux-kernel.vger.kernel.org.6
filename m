Return-Path: <linux-kernel+bounces-388734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F1E9B63B3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1BCCB22B86
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F16A1E909F;
	Wed, 30 Oct 2024 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGXK1CHN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62855192D98;
	Wed, 30 Oct 2024 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730293712; cv=none; b=DI1py4MF6R+VL+iF7wgKGHNK87QAg8VlAEXk9tqf/7+eDtuiIYYnmWbJfXBf9nTnjL3D2gWJHXaXdS4UIR1ZS1z+tkqrr3HSnmsAcDyPoNgo9ZnvRU0+AGplUFOZgy/1oI5To812k2vn5R5wKBHhbFoWSlhRsGiuDqMMYN+NXsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730293712; c=relaxed/simple;
	bh=o+s7ZnBHWJvZlyxsOrOauxNzmpzZAvZYYC+ndhFNhR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IW5O0GDTIzyEjnGu1iiItPTyp9vzY8iVrX5VYk0vOKbKZVH5qilbgdosuj2MbZve545w1cXRoeY9k0ZXex79bxYNMbS2tLGPJh0SWd1CbATwSlpZgEI60qYr7AUosVaIeWd7i36p6K0fj7T8hYRO9ZDvJ7GhgxR30yMYdATZdxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGXK1CHN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4515AC4CEE3;
	Wed, 30 Oct 2024 13:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730293712;
	bh=o+s7ZnBHWJvZlyxsOrOauxNzmpzZAvZYYC+ndhFNhR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mGXK1CHNiFxSFPkxz7qSI1Djzx4o2P8yIe4U/G3KGrQyF0t5wQ6B+YNbRRxQoeOp1
	 8J5nMtCftDHgpQTqyfcY38fyCobuhJ53h2qWeG6yUMARPNpL13FMVz00ZyOzDNXUAp
	 lDdOlkgjd/JW92ThzBoKwjvxVemiCV2ueutj8vvcXx5pAoqwmCwB10IJGzhOIX2vcF
	 nZ+R0CdIrrIHSXB+79o8L3kIXInRqVuOxECXPk2vdOg9hpjH9dY9C/zJC2o28jm3E5
	 5q8T3LlyZs6cX4qFH2/b3dZJL7kQtfdmXCFToHmduVcqEUQRQ7yGj0hSz6iRPTKbMx
	 i6CNUQsKNXvBQ==
Date: Wed, 30 Oct 2024 13:08:27 +0000
From: Mark Brown <broonie@kernel.org>
To: anish kumar <yesanishhere@gmail.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, corbet@lwn.net,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH V2] ASoC: doc: update clocking
Message-ID: <fceef9c9-f928-47fe-a6e7-cdb28af62f71@sirena.org.uk>
References: <20241029235623.46990-1-yesanishhere@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fFFDrKB2iKg9uOaC"
Content-Disposition: inline
In-Reply-To: <20241029235623.46990-1-yesanishhere@gmail.com>
X-Cookie: I feel partially hydrogenated!


--fFFDrKB2iKg9uOaC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 29, 2024 at 04:56:23PM -0700, anish kumar wrote:

> Add ASoC clock api details to this document.

> +ASoC provided clock APIs
> +------------------------
> +
> +.. function:: int snd_soc_dai_set_sysclk(struct snd_soc_dai *dai,
> +                                          int clk_id, unsigned int freq,
> +                                          int dir)
> +
> +   This function is generally called in the machine driver to set the
> +   sysclk or MCLK. This function in turn calls the codec or platform
> +   callbacks to set the sysclk/MCLK. If the call ends up in the codec
> +   driver and MCLK is provided by the codec, the direction should be
> +   :c:macro:`SND_SOC_CLOCK_IN`. If the processor is providing the clock,
> +   it should be set to :c:macro:`SND_SOC_CLOCK_OUT`. If the callback
> +   ends up in the platform/cpu driver, it can set up any clocks that are
> +   required for platform hardware.

This feels like it is (or should be) duplicating the kerneldoc generated
documentation - I'm not sure that we can cross reference the two
sensibly through?

--fFFDrKB2iKg9uOaC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmciL8oACgkQJNaLcl1U
h9C7vgf/XlginEQC03bk9Zib+/edtgHMPpjMuAjPclK32cvelsOOllhQPku5ZBFR
ECvprfuANQWCJkc3ZT/Hx+r8AaSNL9ZQbDOXmWwW9xSNFFqbeLeyt+ZzrqCv/cqv
pmQ5/TA9mNKmD6DSJUVCgmAKvdKzhPkJ3ZpZYENUW2bMADaQqq/rp/G1j20IZr2K
yR8Vf8qwjwOcdlLQA4Pu9wb59lYIorCS/Pgu0Lx+3hH8L9B/+SJlknUEMk4MvWyM
wZDyvoQLMyay5SDOMpsZodLz5PMRmXt3V2r0tKugDkfpBLrz/mKU6/9/RUR6VKxO
nM1T+YACb5ZeM6dX4orv9TBG+kZVbw==
=8KBx
-----END PGP SIGNATURE-----

--fFFDrKB2iKg9uOaC--

