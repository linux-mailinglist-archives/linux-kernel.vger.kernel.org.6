Return-Path: <linux-kernel+bounces-358720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B230B9982D0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE7E1F216F8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FC61BDAA8;
	Thu, 10 Oct 2024 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnoFtgwV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1684029AF;
	Thu, 10 Oct 2024 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728553789; cv=none; b=rRxQRzRdTRJzOmfFob5S7ugvGnE8y7qyNTCCgwY+MOEhm8C4fLGjnEGr74bsmwkhFz725Bq89NHaF3bRjE6PeUd3Tv1hyCmSjvbm8wW9Yop8jzSqkcgs/XaGWE7/+VMvDmgS0G3o3ac07BGo4IAKtPN0MRYWcJ7FGOlZQ1z9QU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728553789; c=relaxed/simple;
	bh=sOKlcUDcVIYv8es7Svh5TEbxwRfsmyZvU+K9y1sAGl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwvOEkQWPKe0qE5mq4ppCtMEwXpOGKIfaDcjXuLih/cyvXEAW6j2lacPkLatoofth4pUiB9nZ2jMbP8JPyYl/X05rA9apodz/IcxUSmNssuvg256QLh73pzCbGwy7880Viln8QOKfUgfvCsvm2dQXlQZYHZGKtHt0YHGUNl7m4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnoFtgwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503A7C4CEC5;
	Thu, 10 Oct 2024 09:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728553788;
	bh=sOKlcUDcVIYv8es7Svh5TEbxwRfsmyZvU+K9y1sAGl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PnoFtgwVFP8jz1lqnlXqpRQFN9k9Gva+GButJXcoVLTcJa80vNNGkb9YtN5UCSFpY
	 xuCbNx4zI7qvl6rHE/B7nZJCjjyNuCwwZ/2D8HUtGZkX39z18lrF6Tw5xWrRocr2lo
	 FV0LgQDhc5U1igE2/UBjkLizAompnTYylpbPbf2TxZzS6DAoLsxVll2k81AVEOCZP4
	 /8CqtbwhJZBH/gf6NeWOkoZEDrlhhTwZZYO8fTBosdytGk2S7IefQuEvpLs6g2QTvc
	 smkCJ9sAUigCuCJAod5CZ/yLQdq9uwXHH2g0fLpV5KwNjyYsVMibdjGqh1MiCgR9+t
	 MQs71v9bWMkjg==
Date: Thu, 10 Oct 2024 10:49:45 +0100
From: Mark Brown <broonie@kernel.org>
To: Tang Bin <tangbin@cmss.chinamobile.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] ASoC: mediatek: mt8188: Remove unnecessary variable
 assignments
Message-ID: <ZwejOZQlSsWbAWBg@finisterre.sirena.org.uk>
References: <20241010073547.3720-1-tangbin@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k3nsdihw8mA/diZ8"
Content-Disposition: inline
In-Reply-To: <20241010073547.3720-1-tangbin@cmss.chinamobile.com>
X-Cookie: Editing is a rewording activity.


--k3nsdihw8mA/diZ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 03:35:47PM +0800, Tang Bin wrote:
> In the function mtk_dai_hdmitx_dptx_hw_params, the variable
> 'ret' is redundant, thus remove it.

Please don't send patch serieses without cover letters, having a cover=20
letter makes it easier to tell why the series is a series and makes it
easier for tooling to work with the series.

--k3nsdihw8mA/diZ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcHozgACgkQJNaLcl1U
h9BTrQf/dvyLMa5N8atLKqhwKgHzZbLbq3zfN9tjwPX11KsHTUv8NHPRtsBQWZCX
89eRdk8SEXRIS82p5CCQU509DCJFSgzborbduFb7MDaI73hhopdRV2WLPPDMu5G6
CNjjVHR9Lr3YgqDSR+D5vc5MvhRwnGd5rej2ymlPgvsGleSnseHtVqdzkD44tvJC
CcZS8Rs2kaDF0hyqckQq6deQSivyJBTEaDNewRB89palzjMlmvFU/Q6FPv2aAY2O
pZ1bXNci5zOYdSrALGKzCCzzpUA3REoyBwZjhoFqF6ujeCnYia4eUtsm0ZAOSzHs
uGG0teM2LEb459x/lteK+r/WiCnrLg==
=A4F3
-----END PGP SIGNATURE-----

--k3nsdihw8mA/diZ8--

