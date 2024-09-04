Return-Path: <linux-kernel+bounces-315001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 356E196BC01
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 100FD1C21BAE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863781D88BD;
	Wed,  4 Sep 2024 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHy11RqW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22AF1CFEC8;
	Wed,  4 Sep 2024 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725452710; cv=none; b=HNAhm1rmGdEtpcG3pkdmnzktUvKxBMMJKNbfU0leW62Z9pwVLLdUwVtaVp2BEa7F0qc2jL32wXeCYdgXc6FwhM0itKLQs6UVSsIz1PWNbepd9d9l9CcifeRxmJbFjndD62OgTVuWDH1SbaxS0av5gfTyYyYfnwe2fr9+xKRYoyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725452710; c=relaxed/simple;
	bh=NRw43zX42ozCIh3tpA8n379wVpc9fGBYUv4G/U5n5pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8tuWExjUIoe9Z5doNd+NF4EcHxVDpnXq9qBDbkNneEAHs2Hjsv66bQ7WmPV67xO5JUko5a+aoWR74Chp0qI9VUvLjzUIZV8qpIUEX9LuNJfQX+dxuehi17whGQZn0/r21iWlv8zCs+5jKAnkE8WRHGVTIt95AGUVLBudAr3ADg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHy11RqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A978C4CEC2;
	Wed,  4 Sep 2024 12:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725452709;
	bh=NRw43zX42ozCIh3tpA8n379wVpc9fGBYUv4G/U5n5pI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EHy11RqWO6mOvhN0j95yBYvWvOZ0df73huWzEKGuHm8eBoQyws8KMwhavwt/6Da/l
	 pYAMTsQX/43XPE4QGtLD5o/P23HNu+F5p1C8XT94v9l914bJRJtPPSsvmI+krmebEU
	 DbsuBWo7nqKASYIJlAq20EMim6CDcWoOE63bfTbPDlY10krAsCeNP+qvhSoYPO3HQi
	 xyCmIwIZIux9PMp4fmyVX9X80XrGUhcTYPxt33xw+JTP7TDQlRlZnyG2QrtSmzxx9v
	 QekVOdz5QSTahpgC30wpL2A92tOx9VJQaI2CS6IdKguAyGbeL+iMJobZ5LzJ/9IJ3L
	 jUpa2oVuNrSCA==
Date: Wed, 4 Sep 2024 13:25:04 +0100
From: Mark Brown <broonie@kernel.org>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: tiwai@suse.com, linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH] ASoC/HDA cs35l56: Remove redundant IRQ handling
Message-ID: <e1aeb66c-ecb3-4778-b306-f3a212caf879@sirena.org.uk>
References: <20240904120700.188644-1-simont@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dwYiuZQXQUCbdHo9"
Content-Disposition: inline
In-Reply-To: <20240904120700.188644-1-simont@opensource.cirrus.com>
X-Cookie: Linux is obsolete


--dwYiuZQXQUCbdHo9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2024 at 12:07:00PM +0000, Simon Trimmer wrote:
> The IRQ handling in the cs35l56 driver was purely informational. It was
> not necessary to support the HDA or ASoC driver functionality and added
> unnecessary complexity to the drivers.
>=20
> As the IRQ signal GPIO line could be connected and shared with other
> components the handling is replaced with a regmap patch to ensure the
> cs35l56 IRQ sources are masked and will not generate interrupts that go
> unhandled.

Given that the code is there now and has been since the driver was
introduced about 18 months ago what's the ongoing cost of having it?
The information it's providing is notification of hardware faults,
reporting those does seem useful.

--dwYiuZQXQUCbdHo9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbYUaAACgkQJNaLcl1U
h9BjLwf9GlVkug+fLA2NQHbZ7YKMdUwPYr2Q4QVuZ394iIv4v89hMk8BqX5VJbKS
bjD80BOjQ1Mxnc0NOFqSrIMPGIe8oPaOwtnurRrECRFqE+fr4FoatYUFQddHuPHM
HMyCjx+njD4T25li9WB+fhIVfXpxrn1PEGJXWoobbJuZoafbjFuFeRmAobgkfc/M
v/48BmXfzeYYtjxcGCFRXtPU3Eju7TdXZMUhyADEiZ+hNhgQHEG3rdiixTIDIqVa
Tr8tH9P2M3E9h23lCcQ5+XZvZ6kojF4SxT5YsV73001IzBkptBOq/Q2cFv9yKf5O
FEMaro+/KPTAO8JrnTVCmud7ykJJkQ==
=6n19
-----END PGP SIGNATURE-----

--dwYiuZQXQUCbdHo9--

