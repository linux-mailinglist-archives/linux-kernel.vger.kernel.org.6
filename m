Return-Path: <linux-kernel+bounces-212222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DFB905CD2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776601F241D3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA5A84D0D;
	Wed, 12 Jun 2024 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNaxhTTK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7645464A;
	Wed, 12 Jun 2024 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718224177; cv=none; b=ZnLllBOTdmQCPFHrFa6ydZfBIlQTmOmVXI3h4c6hCgzE0GMf2nMG4EKIIppCa+uuRg9WY+COiGyStfRWSy9eefIqgD6NNCho02hstuIxDDUOo2P4cYJhPapUO7H4Qr8FWuSkUHYPCvtRbSD5SJ7rXohTYeHV2pU7Tf+lzgMgOKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718224177; c=relaxed/simple;
	bh=gCWYIm7bTku77ZC6+dqoln8xvBDLmYRwniWsE89dzJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hgdt6y64gNNAleNVNePUl/asMc/w9+toPHhEkI+NDDqhFoGKbNGbD6d4qI3Hk4KIooFnaHl+oA0W6gJdf+dtwbMyKcKBXZoZN24+F57OWY0iHzZOMLdNIIbJRvRpMrDJiD7xoYGktFyx0Ip11+12iZEBOKjsSq/h504RiRcqAdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNaxhTTK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F786C116B1;
	Wed, 12 Jun 2024 20:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718224177;
	bh=gCWYIm7bTku77ZC6+dqoln8xvBDLmYRwniWsE89dzJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cNaxhTTKl+SspOwSlEHNQvVoS0JL8tO0YYyYJuwXVEoSo8ReWdiq+NtN7oJ8NAveT
	 z0/gkj8P9jZjc+NQSKy8ETCvdUOJbEb1CQjPVn29Os88FsauX1BN/xY/zRqQ+pmLQK
	 iE3iPhD34t4/evmgNP5NrPWC+5PVrgCYZbTk7WzwYeKZy9NH1jSTTREwOzKiW3hBXa
	 I3veBK3rMM5ogi/b080kLseDv5V4stIgIgjWTFOcVc0XdAN8UYQQ1MyxOPigU9M0V6
	 NanknOc+8I6p+XApjml3BsC7b94+BFBP/v0RwJbE/iE0/5CX//jUiSU6WvbUB8kCor
	 6/zwW1RYJZIvg==
Date: Wed, 12 Jun 2024 21:29:34 +0100
From: Mark Brown <broonie@kernel.org>
To: Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH] ASoC: mediatek: mt6358: Add "Dmic Mode Switch" kcontrol
 for switch DMIC mode.
Message-ID: <ZmoFLizJO-J0N-m2@finisterre.sirena.org.uk>
References: <20240612094155.23354-1-jiaxin.yu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XNKysN0M+FLP/L8C"
Content-Disposition: inline
In-Reply-To: <20240612094155.23354-1-jiaxin.yu@mediatek.com>
X-Cookie: Your love life will be... interesting.


--XNKysN0M+FLP/L8C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 12, 2024 at 05:41:55PM +0800, Jiaxin Yu wrote:

> +static int mt6358_dmic_mode_set(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *c = snd_soc_kcontrol_component(kcontrol);
> +	struct mt6358_priv *priv = snd_soc_component_get_drvdata(c);
> +	int enabled = ucontrol->value.integer.value[0];
> +
> +	if (priv->dmic_one_wire_mode != enabled) {
> +		priv->dmic_one_wire_mode = enabled;

This will allow any value to be written rather than just 0 or 1,
mixer-test should report that this is a bug - there should either be
validation or clamping of the value so it stays as either 0 or 1.  Both
options are valid.

--XNKysN0M+FLP/L8C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZqBS4ACgkQJNaLcl1U
h9COmQf/a8xD+qrXvkFvABKq8FFX5YPeNHTkBlKnyk5PLvhdn856OJ7nHQoq3reW
8qMriRZkD3z1FVN9qzUpt0hygDXVV6alDJ522jwYJVcr6kxuMpVlp9xwfX+H5nCR
7slQUKmP7cyMS3LYJJZfGtG/a5oseajX6pRXl2q/BSui8usaEyYVzrfVd2I0F78G
tQvPmJ/tQUX85DSWXCJmSUJJe6rQE0tH/Ly0hDfuIZuWS25XzFhkWnp3iDS7uKsK
mCPiLFkvMRngfRApM8T2iPQiMBKFt5AkgzHWcBsHRalB1OlAQmZXchn4d5EKL5/j
QrkFiepQBmCiKQ1rGMLc/CDy4GpjhQ==
=0AqR
-----END PGP SIGNATURE-----

--XNKysN0M+FLP/L8C--

