Return-Path: <linux-kernel+bounces-200547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBDB8FB181
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15581F2271E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF85145B28;
	Tue,  4 Jun 2024 11:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgYh7/YR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26622144D21;
	Tue,  4 Jun 2024 11:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717502175; cv=none; b=Td3XzVFn3N67lE1MgVYc3U9nYLke+2kX6xrkBKLjm/+BoLFxaWLjlbzwmGjWmnwZxgAW+GfCPEVNpGhv9/p8wkdjPpIVpweDtF7OJhNds181JmjBvDVSH8U0itt4n4R/Q4jYCJkX9naHwFATJx0XkVR7yFW69AGJK/HQzEdXQw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717502175; c=relaxed/simple;
	bh=tXhLaowrcYMXzmicpuj4T6jEZTq866kBwfpJR7KjHYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtPHhJ+QqZ0YYlnG9Ib6spp1ECVW0w9D+cOvCGvKF7cm2morDcmHuzyqlR8iLl282pgxOA0kwXouZWXdaylJlSYA4OTO+2LoSZVNZekrD3ZjMtY3RhAwfM8RtXHEzp39151Nrsm9iHZGHF55pDSGftcaEbtTm7XfCH5j4xDZL8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgYh7/YR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E591C4AF08;
	Tue,  4 Jun 2024 11:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717502174;
	bh=tXhLaowrcYMXzmicpuj4T6jEZTq866kBwfpJR7KjHYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dgYh7/YRAhKIjwsFQx2Yz+cbECMwgft3/F98XxETZRu4tkigfPDgdpb1Zqzo5wWfO
	 91p0Qofhs1+TJT3TaZ7vnos/RbQEgcOAv3xdN0ZcGQkANtWaYR5bVJPwlB1EMlWA3G
	 xjzZ/pl+BYxugx6nwsQKw7hT6789Mfa2DG+oQeSlErvJfCyt1chADHod/anBD/W/cH
	 u4BUqhHUMeO5xdDxpkD6Vg+ptIeJ6pKeZTXeFiujIBFN8LmR2UtJ+49F8iALj4IzCE
	 N0T5PLrZaHmdy9IxX3axhsfuxENX0Qp1U/fg62ScSWH+m1lj+bzrWss6DIRi41W5Cf
	 k2ZoKfOCDSreg==
Date: Tue, 4 Jun 2024 12:56:09 +0100
From: Mark Brown <broonie@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	kernel@quicinc.com
Subject: Re: [PATCH] ASoC: qcom: add missing MODULE_DESCRIPTION() macro
Message-ID: <0bd0a518-4d85-4251-9bf9-d056dc3d7b08@sirena.org.uk>
References: <20240603-md-snd-soc-qcom-sdw-v1-1-101ea8bcdd38@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SHcC+f3LwF29Fsqc"
Content-Disposition: inline
In-Reply-To: <20240603-md-snd-soc-qcom-sdw-v1-1-101ea8bcdd38@quicinc.com>
X-Cookie: Is it clean in other dimensions?


--SHcC+f3LwF29Fsqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 03, 2024 at 05:16:07PM -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/qcom/snd-soc-qcom-sdw.o

Is anyone getting any value from these MODULE_DESCRIPTION()s?  This all
just seems like a huge amount of noise and I'm having trouble thinking
of a use case.

--SHcC+f3LwF29Fsqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZfANgACgkQJNaLcl1U
h9DD7Qf/Wbjd2t6/LWhnHPaYr8UDzVQzgJXS+fzgQ9Lou2WkHI9D2KV19uaMUqmV
ACLaw7+m3lBGyG+FkxREZCucSN1wLhS7mPM2+41IaRAQ6/bj1LLQovR1vrwOyUcu
bWJ+VFJLo2Yl+NIje4Z16Mg+f9QT7/VvR0Spz2LZXLwmTjis/GVwSY9I/v4ZiaTt
dHeWr3dhPWNRnBx4PggQs0OyO3Ky4gxPVN1qfp7eiSLe9rOC3qcYsi5hdx50kVdy
ViqX56cl1qJ2HfUZmbCVc43IViRnhVfgtrkKLTdtsM/acBnMl5oFDUkmL8+lOOFe
V1/zKaMwRJMzabvh16khcsrHchaMSw==
=Mgl8
-----END PGP SIGNATURE-----

--SHcC+f3LwF29Fsqc--

