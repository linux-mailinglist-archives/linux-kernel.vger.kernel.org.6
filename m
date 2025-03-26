Return-Path: <linux-kernel+bounces-577040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DFDA71797
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A4861890EA2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEAD1E832F;
	Wed, 26 Mar 2025 13:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJOewYLa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A721A4F12
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742996116; cv=none; b=sNf/DSX/Q0iz0N0gwPhGVCvQSlrnGde+6qSkUC8+//y4UFt6CgcwiHU40KT8VyQ0JT7SQ/LBklU937nW6ziu3H1UjFQeEewT2itDrgOpQuByFwXhyS55yPo0nH5pF+cgy1znXsvrW0b2l8rlC2Esmw1PyJ17EEPx8Uo+9ZTu2VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742996116; c=relaxed/simple;
	bh=zCODlL20JoV0OQ6i1mNCZKlE7ItorLWts2JQd76Vhts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEeyiQ/xyZQRtcFJXaeeiOZylmv+E7VIvappOMIbLNYuyGiuvCynMvi5YjoX4buuASHUCvruxEhHS9K0tU/sOQMg46JrFAow1wbFRmumFIQZQiYr2rFQX8I+CV/hXaxh9bbPL2DmdfZHrEbJNwJuwlhXLeQZK3i3K84NbedZi60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJOewYLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88972C4CEE2;
	Wed, 26 Mar 2025 13:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742996113;
	bh=zCODlL20JoV0OQ6i1mNCZKlE7ItorLWts2JQd76Vhts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HJOewYLax+X56A+WZggkMuB7Rv2NJlxq+4wWUoAdO0IHgRq/qn5nzLNH1ztXNJo/L
	 ThMTSZR6nmF67O7LI7I8rQ7d0YTRZiCUuQl3ENl2x5jE7SBpZb2f8vUytulLB28BaJ
	 G6a2233CrNB4QJkeJiP0clAI+fmie9DX6x/OHJzjvCGdZcFT5ztcUuDZodbbcn7h1e
	 hoLE7w/0n3h7jVehTIl5WIt6k/txY6rBhzzZIsFAkaLzoeaapMBtvLCRCae2VF3B9v
	 qtKvu4/d4QGtjImxkzFLUFc1Q/nne89dMv4mDcvLGfE4A3h7PsgaqvHzBcWE9CmxVe
	 e04sxnN9IeCrQ==
Date: Wed, 26 Mar 2025 13:35:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Brady Norander <bradynorander@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Aleksandr Mishin <amishin@t-argos.ru>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 2/3] ASoC: amd: use new ACP dev names for DAI links
Message-ID: <da54ee1e-fae5-498d-b773-85e76ec2d353@sirena.org.uk>
References: <20250325211545.2099169-1-bradynorander@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZB+phuY7bPIAHuNK"
Content-Disposition: inline
In-Reply-To: <20250325211545.2099169-1-bradynorander@gmail.com>
X-Cookie: To err is humor.


--ZB+phuY7bPIAHuNK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 25, 2025 at 05:15:45PM -0400, Brady Norander wrote:
> The old names used automatic platform device ids, which means they could
> change. Use the new device names which will never change.

>  SND_SOC_DAILINK_DEF(designware1,
> -	DAILINK_COMP_ARRAY(COMP_CPU("designware-i2s.1.auto")));
> +	DAILINK_COMP_ARRAY(COMP_CPU("designware-i2s.1")));

What happens if someone puts two GPUs in one machine?

--ZB+phuY7bPIAHuNK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfkAo0ACgkQJNaLcl1U
h9AzGQf9Ep+teGk/235hWpGlb2PF1oOwzrK/0/jVsSVbo1lvXC0IfnEpt515QAFM
LmZ/AEIWqFa0NMH72HY/V6AXojhAuPKupGyEzNt3WAg+DCifGdS2ddK8oO7zYNNF
rFtR8roq9YyTE25yzYpvzJir6lOcply9kVzpvJ4yu/oHvgU2NjmiHWm5NbI2NhLt
b7BF9lApJbiMK6qSG+zM5m4LvjFVUsU6gCu9loBAmUO4josUG+bVzo7fwxp7jiwS
cJkdafKKbYhtrXc6xvqdT/sZGV5RUSX2k18ib2cxp/lDWWfWCsgI7o9DgJ8RHJxu
dcphT3do9BNsUugNpl9ZRVy3db/VZA==
=3c2B
-----END PGP SIGNATURE-----

--ZB+phuY7bPIAHuNK--

