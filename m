Return-Path: <linux-kernel+bounces-367996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C12A19A0942
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8EC1F24923
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7300207A38;
	Wed, 16 Oct 2024 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWjzdgna"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF8720896A;
	Wed, 16 Oct 2024 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729081383; cv=none; b=qcUS6j460BhrqPpF5ewYWT0zW9WTAHDfnwJICzQWYXdVv6GCGux/yeNyCB1a4G6w3yCzmH9K3MXsunqVkujsJ8tQE2kgaGRuJh1TTVMBz0/tXfikPCdEm9hWPg0ZzLoMpeQv6/uLZ0l0rlUwnGmdhnuCF4oDXvZjvhku9vESeDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729081383; c=relaxed/simple;
	bh=GNpQFqou08L4HvvgQmtVoW2aASKtf7vi33xFSNUzSZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcfHmVfAVJXbaTDad4VYn54fzYFiPAgmJ7v2amAwF12NDLexz2KcJEIZ43mBWSF0mJ0UUgbi/UK/nJjxxfq73d9fUniTVlXkrpOrxocoekRnDhmbp8VDoPE5ypX7ZrTosvpRbLgraLIpoed9KXO8aHTk8oOY96B08MkPekWntG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWjzdgna; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871D3C4CEC7;
	Wed, 16 Oct 2024 12:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729081382;
	bh=GNpQFqou08L4HvvgQmtVoW2aASKtf7vi33xFSNUzSZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cWjzdgnaZcMpXiy19gCFyyD33hQfirE7sLHUiJqd2s0Iw9icd5iwZuDCs2m3QbqeW
	 2q8PbqVNoDsjZGR52OMlqmnr+IhcxMCN9qwRgQ+/dQe3s/wvnpqNNoBmQTA32OVO01
	 VacWIHA2AiBftcAY3MzV1qEwgXNat67ttJVKAUOzCGmGVivali/h+tSiVuczwYkv6u
	 /JMI+BWwGUSd7qxQ9OiVjyvz6ojbO9WDXxTp+jH2E3mkux2ipaa7pwRJDTfai9lhEk
	 Hn/k1oHMd+of9Mt/xN1neNgr6WfVg142fQ5DIVDvuO/0SweUcTphlzIDMs2lApYAwd
	 Z557QyjsWpRcg==
Date: Wed, 16 Oct 2024 13:22:56 +0100
From: Mark Brown <broonie@kernel.org>
To: James Calligeros <jcalligeros99@gmail.com>
Cc: Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	asahi@lists.linux.dev, linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 2/3] ASoC: cs42l84: Add new codec driver
Message-ID: <abe88a18-28fb-40e5-8bd2-3fde5de9cb56@sirena.org.uk>
References: <20241016-cs42l84-v1-0-8d7e9d437d2d@gmail.com>
 <20241016-cs42l84-v1-2-8d7e9d437d2d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="maBAkUOwaatk+XRK"
Content-Disposition: inline
In-Reply-To: <20241016-cs42l84-v1-2-8d7e9d437d2d@gmail.com>
X-Cookie: Snow Day -- stay home.


--maBAkUOwaatk+XRK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 16, 2024 at 08:41:01PM +1000, James Calligeros wrote:

> The CS42L84 is a codec from Cirrus Logic found in Apple Silicon Macs.
> The chip continues Apple's long tradition of compelling vendors to
> spin out bespoke SKUs that are based on existing IP but made subtly
> incompatible with the publicly available part. CS42L84 is very similar
> to CS42L42, but has a different regmap.

>  sound/soc/codecs/Makefile  |    2 +
>  sound/soc/codecs/cs42l84.c | 1081 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/cs42l84.h |  210 ++++++++++++++++++++++++++++++++

Something's wrong with your formatting here...

> @@ -0,0 +1,1081 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * cs42l84.c -- CS42L84 ALSA SoC audio driver
> + *

Please make the entire comment a C++ one so it's more clearly
intentional.

> +static const struct regmap_config cs42l84_regmap = {
> +	.reg_bits = 16,
> +	.val_bits = 8,
> +
> +	.volatile_reg = cs42l84_volatile_register,
> +
> +	.max_register = 0xffff,

Does that register actually exist?

> +	.cache_type = REGCACHE_RBTREE,

Unless you've got a particular reason to use something else new drivers
should use _MAPLE.

> +static int cs42l84_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
> +{
> +	struct snd_soc_component *component = dai->component;
> +	struct cs42l84_private *cs42l84 = snd_soc_component_get_drvdata(component);
> +	unsigned int regval;
> +	int ret;

> +				ret = regmap_read_poll_timeout(cs42l84->regmap,
> +							       CS42L84_PLL_LOCK_STATUS,
> +							       regval,
> +							       (regval & CS42L84_PLL_LOCK_STATUS_LOCKED),
> +							       CS42L84_PLL_LOCK_POLL_US,
> +							       CS42L84_PLL_LOCK_TIMEOUT_US);
> +				if (ret < 0)
> +					dev_warn(component->dev, "PLL failed to lock: %d\n", ret);

This is too heavyweight for a mute operation, do you really need one?

> +	case 0b00: /* open */
> +		dev_dbg(cs42l84->dev, "Detected open circuit on HS4\n");
> +		fallthrough;
> +	case 0b11: /* shorted */
> +	default:
> +		snd_soc_jack_report(cs42l84->jack, SND_JACK_HEADPHONE,
> +				SND_JACK_HEADSET);
> +		cs42l84->hs_type = SND_JACK_HEADPHONE;
> +		dev_dbg(cs42l84->dev, "Detected bare headphone (no mic)\n");
> +	}

For coding style we should have a break at the end of the case.

> +		default:
> +			if (cs42l84->plug_state != CS42L84_TRANS)
> +				cs42l84->plug_state = CS42L84_TRANS;
> +		}

Here too.

--maBAkUOwaatk+XRK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcPsB8ACgkQJNaLcl1U
h9BddAgAhJBsG36HFJDYb3ITfSZniD+YMmeHaXnJ0/NZt4kJKDV5ar0f0TqNxi9M
naq16zKH3bgx1eu4jD4hN9mPYsRkT2Q9X/IurlEUYpE0HCm35Q4vU+1Aq3FO9UD/
BpgkdOV9VfBU82/FVtFINBGR+rIIT+OBVrUAABtAAw3docMOY4aL4AsLNoqyEyg4
9poBy6vDCctHPol6RAL0IuPrOHa853ZIulARXnpDwOLDeGAzuumw+qcqwekTVn3u
VHWGDSwW1A10dWRK2xS3Xvjtp6lxerKfzoJR7CqdLVW3wkV4DXjmB+F2Zts1dwgY
z+vt3hhpCnJzwPPq+mdx5jZVkd80jg==
=zgvX
-----END PGP SIGNATURE-----

--maBAkUOwaatk+XRK--

