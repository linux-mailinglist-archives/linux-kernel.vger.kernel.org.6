Return-Path: <linux-kernel+bounces-529287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E73B0A422CD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA093B3EDD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0999A158536;
	Mon, 24 Feb 2025 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMbbMM0d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6248B1519BC;
	Mon, 24 Feb 2025 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406081; cv=none; b=iuTxFbfc9uLslgq0Ko4D4MiVZRHTUS6Sd1sv9pyOHuj5x1+Bu/alEuQTvUDES76hB4EnlTSL9HXjjoY3r4sfJHDFzoE3UjABpb4HskWgtRdge2x6fFipH6RubAqixDSpuLKYfg7/GsZ/O5xWWwKFdrHtErOnxZnUJowhksMwEhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406081; c=relaxed/simple;
	bh=2Xh/CfGdgSxRfbbImYhq2ENBrcAb518D98+0M2bj6ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgQUrMvIMCoMYSDAMWAkYiW4B3ex5GwJguTMy+8D+JguhxLzikuaWtScaavATE3svVBZEC1GkPf/gwAy6MI3ke/dFQwjwbvPZLj5QIPScNxJcEpfgeOx1qbwRmns63Kf/joI++q5m/JiP2doAHo8xt7TRSvTJhSL2JBkeK171ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMbbMM0d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E00CC4CED6;
	Mon, 24 Feb 2025 14:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740406081;
	bh=2Xh/CfGdgSxRfbbImYhq2ENBrcAb518D98+0M2bj6ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fMbbMM0dWD9NrcVjRM240tB/ZUsOeCpi4klbYY3lePBqRFVoky6Mxh3micFJAEbQ8
	 bzud+OhAyOmFPTz3yJY3MDLYF8z5xoLdIywUXxwYm2dqQ3szY474uNFMPEIHE2fbRD
	 7s7i4gjthU0XecfcIgTJ/ToAO8bTCYVQKvT8oeOGnO6+bdub6L30YTYrA1So2m9Tc/
	 imzuNvKbXMb4db9JLlymd79zu8xQksPgWCoQMbkmORxJ18zvj2qmPZuZPSszI/RoV5
	 ITUOM9UfsuKEvXnFUQHJF4Mrz8bsO6UGLdWQWlhFtDZrQUtkE0KG83Nlok9S3MW5/n
	 Va4SB7Al0KfoQ==
Date: Mon, 24 Feb 2025 14:07:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: linux-sound@vger.kernel.org, tiwai@suse.de, vkoul@kernel.org,
	vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev, bard.liao@intel.com
Subject: Re: [PATCH v2 11/16] ASoC: SOF: Intel: hda-sdw-bpt: add helpers for
 SoundWire BPT DMA
Message-ID: <da5d80b3-d710-4d4e-b1e3-9bb95edb65bd@sirena.org.uk>
References: <20250224064451.33772-1-yung-chuan.liao@linux.intel.com>
 <20250224064451.33772-12-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GArUNYkf9zLJK+16"
Content-Disposition: inline
In-Reply-To: <20250224064451.33772-12-yung-chuan.liao@linux.intel.com>
X-Cookie: Phone call for chucky-pooh.


--GArUNYkf9zLJK+16
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 02:44:45PM +0800, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
>=20
> Add SoundWire BPT DMA helpers as a separate module to avoid circular
> dependencies.

Acked-by: Mark Brown <broonie@kernel.org>

--GArUNYkf9zLJK+16
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme8fTwACgkQJNaLcl1U
h9B4nQf/UxkQ/EhEBh3G3Sv/jDpPKeJjpGW4Cgz6mq8BXT3ly9c6ob6SzXP63mZ1
Y0ZG65kAiFusO/7izQiBLWZqr9IfYfMtxYoqvfJTtrjhYoq934vPujju7pk+mrAT
sy2T9GnHKkaS3Tzb30gEHvRMYTqeU3F+H5Uzbtx+NK1Ngzi7WihSlOv8R5qL+29q
fChzKIPZihnlCN4/C/d1nCM64+RS2cfZHqLQJNiyHXB2NJR3eFSgIUjO6li4I9pj
Amyy0w9yMFjUrp9gZk2F33Khez9RG+K0YITm+kXkZ24+DjY6YjMYdwP2IWG8rSLx
4zX0CiK+ZjfPusSmlEyhPyyk/9PtFQ==
=TOFo
-----END PGP SIGNATURE-----

--GArUNYkf9zLJK+16--

