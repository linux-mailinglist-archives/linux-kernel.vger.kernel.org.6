Return-Path: <linux-kernel+bounces-178949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C348C59A9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5BCC2834B8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50E717F378;
	Tue, 14 May 2024 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afb4nh6K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258392E644
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715703725; cv=none; b=oumtXc0eeKJJ+oJ0Yfiw33IdGvMgsu4rIuo3K5RNfH6OG6nEG/oeeoqltWk5ISmQe4NyLTTCsf3uSuA6DJeQTuOPmwiUbm+MWT9EQRt3FvbIYz1rLGZ1kHKC/5xRQdYWxIETayd9m0mn4xiGNLS51Gx/G/6GLOc+VhetQgvsHBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715703725; c=relaxed/simple;
	bh=IZFkvJvbgIHEjxhIM81KkL7BVlhpWpSB8wfcs7pwyfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cS+0eYh4r/FBFSZB7RSuAw3pGfTWN6U+NNWDphvfIOCMk5v/y97pt3f6dL6FGKflqRvBnqGzoUpk0ry4iPLutpceVFV71k016FgNoV4/gEBY1BWW8XTKYOfkoXTgEeriVvFJuEnoSRhlOWgWhICIOSGFM/Z8yuvfubt6Q2HTHNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afb4nh6K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE41C2BD10;
	Tue, 14 May 2024 16:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715703724;
	bh=IZFkvJvbgIHEjxhIM81KkL7BVlhpWpSB8wfcs7pwyfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=afb4nh6KH7MCpd0c5b1pGIYCVx4ZMQGOnrZozF1kR/cSPG4F40M3yvyXlbUPAoZbJ
	 9WsrjyB0DodVpK6zsPPJdZ028UuJr1HD4NewpKJjtrODKcy7WVz2tELrAYc+//fHdO
	 gHGeKF9wrp9s1kZ5E1sq6gT2YA2KGvFu9ZMt7EMjIyGnzRaksgYDz97I72j69n9Mn9
	 9ndiJNz9PEE3dkWKGjxUtozFtWKdpv2DuOul4rBd6NqKEmDwu1MaeyK6Etb4HNBThZ
	 tm6lcr0nqvg4UAhi8iPZyw9hPZEyrkKCX9U4ySeSh7afDrOroky/+98slqxKXiC2YZ
	 KQAssQSwxzmcA==
Date: Tue, 14 May 2024 18:22:01 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drm/bridge: Add 'struct device *' field to the
 drm_bridge structure
Message-ID: <20240514-scarlet-corgi-of-efficiency-faf2bb@penduick>
References: <20240514154045.309925-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="dgblqp33k4x2lbe7"
Content-Disposition: inline
In-Reply-To: <20240514154045.309925-1-sui.jingfeng@linux.dev>


--dgblqp33k4x2lbe7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, May 14, 2024 at 11:40:43PM +0800, Sui Jingfeng wrote:
> Because a lot of implementations has already added it into their drived
> class, promote it into drm_bridge core may benifits a lot. drm bridge is
> a driver, it should know the underlying hardware entity.

Is there some actual benefits, or is it theoretical at this point?

Maxime

--dgblqp33k4x2lbe7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZkOPpAAKCRAnX84Zoj2+
djLpAYCd28PWUhDWrhqkqi6BHUk9bT+cXJcAbMjeLgzcYs5NLe68uc4CGgzJJOpX
1OT5hikBfjD+kofCGPbLiRyVYR3LmtorahIMfw7JgdLmMERa3yPgYuEi33wzdVG7
H1XdJkSB4w==
=J0+X
-----END PGP SIGNATURE-----

--dgblqp33k4x2lbe7--

