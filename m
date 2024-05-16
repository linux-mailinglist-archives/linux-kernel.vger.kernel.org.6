Return-Path: <linux-kernel+bounces-180979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FE08C75B3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A857DB216D8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC732145FE8;
	Thu, 16 May 2024 12:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFGv9a8x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310DC145A06;
	Thu, 16 May 2024 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715861478; cv=none; b=N8e+DfsEPVKYITHXdaCxO+tWZGkVQoicepEQyS0b84MVZG//f1NOVrJDJP++yRJ7npwjUrQmke4qE76s7ziVYqmowJkQClyZSJn5lTQNRS/ctzhBkOddzzlc8RcBuHJ7/J5BLgWMcFmgLqvXKSw9hLOrRdMQ3y34QHe81UphAaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715861478; c=relaxed/simple;
	bh=vzWty9Z112mKSwQmpKl9H1kFTMkTlX2pGHRLOpUzc/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URDSjOkF1eXVuTQuYwEzPDldd8g+Xq6U5wZs7HRJWORej7VQkgBa2xxjeDeSOBA/PI9njQwaikK+zoyjcJ/Tgvxif/x4ZukvaS2Ot3KMWplfSYCACBoACplF0IMLl5IMuyPx+cZbIKwZcBf7oZc96vJm5xOBzIOdXPaHbJJzC0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFGv9a8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE16C113CC;
	Thu, 16 May 2024 12:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715861477;
	bh=vzWty9Z112mKSwQmpKl9H1kFTMkTlX2pGHRLOpUzc/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MFGv9a8xqo8bIibuLTC9Sb22GP+YNQKltzSiK5BkAxKn0wNtLMgfSglvsKWq8NCFn
	 2p66bCe8JEZjQtBko0q30KPK5AEzNRLzP8+9Ybw2o/zP2GFmWoqGXdtMT+7ullrGHM
	 KsFRznanFdd7euh+hybdzmSQGcdITWEBsycbxu8GmiVmHbk/jrJXQUsgtR4MGWKPYi
	 aeKu03Xzz8FiBxjPfCL5MqFn9JRzfSdeGQ3b3a2r9C+qwOjRBWfTQRJFP/nHf9LdVA
	 Ujd3ycfgTKc6iR/hkJDzhkWpL6UkTirq8EiK1I5/EnNlQcy9QyxtdmikyTkTapXMno
	 cU/ARVbKxuyEQ==
Date: Thu, 16 May 2024 13:11:11 +0100
From: Mark Brown <broonie@kernel.org>
To: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCHv4 9/9] ASoC: dt-bindings: fsl-asoc-card: add compatible
 for generic codec
Message-ID: <ce9a87c6-4a5c-4f0a-a8df-1fdce8c1f5df@sirena.org.uk>
References: <20240515135411.343333-1-elinor.montmasson@savoirfairelinux.com>
 <20240515135411.343333-10-elinor.montmasson@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XZeYRrKEjeLfbFL9"
Content-Disposition: inline
In-Reply-To: <20240515135411.343333-10-elinor.montmasson@savoirfairelinux.com>
X-Cookie: I'm having a MID-WEEK CRISIS!


--XZeYRrKEjeLfbFL9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 15, 2024 at 03:54:11PM +0200, Elinor Montmasson wrote:

> Add documentation about new dts bindings following new support
> for compatible "fsl,imx-audio-generic".

>    audio-codec:
> -    $ref: /schemas/types.yaml#/definitions/phandle
> -    description: The phandle of an audio codec
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: |
> +      The phandle of an audio codec.
> +      If using the "fsl,imx-audio-generic" compatible, give instead a pair of
> +      phandles with the spdif_transmitter first (driver SPDIF DIT) and the
> +      spdif_receiver second (driver SPDIF DIR).
> +    items:
> +      maxItems: 1

This description (and the code) don't feel like they're actually generic
- they're clearly specific to the bidrectional S/PDIF case.  I'd expect
something called -generic to cope with single CODECs as well as double,
and not to have any constraints on what those are.

--XZeYRrKEjeLfbFL9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZF994ACgkQJNaLcl1U
h9B7owf/abYbh4drI6QTSdLIrmNMdhFX4cLfs8jwRLolmoqXOy0BxV3+SchLf/aR
T+1Cls7jAUyeAqoS8Z4NyDeCa/5Y17c7+QVmcgr53BmGgWjkKhxiyOjrl6q6gEXy
VMZBcrNghdW1k5rzO3OCOiO38eFODTZ6RzBL0sh3iThDf+qQLKwgKWeZgL7tsuNz
zJWwE0UVPkuiX9iR2pNWfWb0Q4VuEY9LieR9Onw5+rusb0xLF1PxGD6FaZIHLBBT
CeeFfhBmLKorYQzK0o8oROWKEIx2o+HFCt/VO4aVmT+xFS5qK2wAOm4u/GtwnQLD
6C87130dv/yD0+qYIIG6L3mTkpJ29A==
=nO6y
-----END PGP SIGNATURE-----

--XZeYRrKEjeLfbFL9--

