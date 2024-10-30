Return-Path: <linux-kernel+bounces-389354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F229B6BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 19:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236D81C20D96
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A6B1CC161;
	Wed, 30 Oct 2024 18:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrtg4v2F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A9982899;
	Wed, 30 Oct 2024 18:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730312049; cv=none; b=ZuAY5WC5bpvxnEEX8P7q8WslCnyze1P9JBMQDMYTyaAbqhFMVt1cbKzq3MoL/t2Tlxd1v9WPWcP0mphSVdxlKWhjOat6nxTlqTXv7nnHF85cykFxuNcq4xSkhHATD0LP9EDddv6pcebtKffE0ebIh22BNLfVJ/V8+iuQ+pB/sLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730312049; c=relaxed/simple;
	bh=gPom55NrJIdbKpm1OIV8sl9jUaW8THjT/W08qytNduY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RiQqfpZQb0Dp4CRn6NRdVdVLUP/pzBcvJgLeQRjBDRV620PmM6YjqcejU3+AZV017xZOLdqDOUvhuolZ0X9Si4dwR84L5keZLCKIJpzpxyqBZPd6/Y5R79SVWrW5AzGLfvQvtQUp7pCDbeKSvfS2bWYsYfMr/3E+iEZbz14DeaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrtg4v2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF14C4CED2;
	Wed, 30 Oct 2024 18:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730312048;
	bh=gPom55NrJIdbKpm1OIV8sl9jUaW8THjT/W08qytNduY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lrtg4v2F6vLvgHtFFIiNEK8+MjINfH8XZyiQKGsB9f2m4CdhP5wbSNPOBOdGFjF6s
	 q9x8cw+TXo3Tt/72B2PYAbDnWOiGISanNNE24eUH1FbuCwReCBW/CHLK/Us4OqRJzw
	 BjX4vItTnYSgXIbrMaSV5T+ni9z44y8jlvTmeWJBy4hza7/EEeQn8AqP8ckO68mNDA
	 53YiMRdvzcsFDL58KaPXEyMYIQ5/O1KV7l1edIgNr88UksVk5vGsNBpM9FFetq5jD5
	 56Pf7WqdyDmlrex0iiLGoTcXZbR9dmjIF+QYCdxyGczP+A95eS9oAmztbNbvNp9MC0
	 7dXjUVU8zFIgQ==
Date: Wed, 30 Oct 2024 18:14:03 +0000
From: Mark Brown <broonie@kernel.org>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: sound: sprd,pcm-platform: convert to
 YAML
Message-ID: <97cb13bf-b1b8-4a8e-bb6e-7662ed28bde1@sirena.org.uk>
References: <9fc646b70a73e7a6c513771d69b0edcd140f09d7.1730310275.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gOI4wYstUM9HsCLk"
Content-Disposition: inline
In-Reply-To: <9fc646b70a73e7a6c513771d69b0edcd140f09d7.1730310275.git.stano.jakubek@gmail.com>
X-Cookie: I feel partially hydrogenated!


--gOI4wYstUM9HsCLk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 30, 2024 at 06:48:38PM +0100, Stanislav Jakubek wrote:
> Convert the Spreadtrum DMA plaform bindings to DT schema.
> Adjust filename to match compatible.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--gOI4wYstUM9HsCLk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcid2oACgkQJNaLcl1U
h9BOkgf+JtiwxnUsmi1LQ1DAbES3Mn8VD56Dkoe8ji5V7KVMAMP3JMqXUZBHWhMT
shdLHUEY9d8H1gmLZfZcE59NYdfPATsN56Ck/arp3pFX8cJTn+xX0vSSixfdw1fn
LSf4Mraf+yS8567FB7RTYxhFFWAKogO/SAIYt2iETRFmCCO8RSm0MlwhTC/XEd9I
ke7aLn7qWciXVR7rtTb9mrdHEAV9rUnylyJ+6rt4EsK07CPPvJaLoj7UBJ/csAG4
SLhaVP+pQrXeIp/plSpXKNUUUA5id5CrtfrzuEmIPIHuvHX4WUzuQ+ljkHJxddHI
pfZRoXRWVWDYHwBRswcRA/gRdmCzgA==
=uAbo
-----END PGP SIGNATURE-----

--gOI4wYstUM9HsCLk--

