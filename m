Return-Path: <linux-kernel+bounces-559806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9D3A5FA05
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2EB42134B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D84D26A1D0;
	Thu, 13 Mar 2025 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUwr2ncP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2882690CB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879778; cv=none; b=mRHWmFFKjvfKkC11MhpiEW+NMGQY9Q6+jOlL7qLDazCpDmpg9ht46y1g551CU253Rhf1gkzHjVyESZdkqnPcbaquhhhCQMZQikYSIWU93+ItvkSFyMRYd33oT/O0Pv1JymG2diU6xob5ZF1vu/b4wnmcwFB4kjON0rkeaCzY6T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879778; c=relaxed/simple;
	bh=A/sSWFFMO9u6pANfKr2GbGM1YcbdvlfvUEwWpLD4DB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XA42PSyT2uP0zz/DM0LgdkuBYGwNQ38nXnMtrPTdaJIP5Z0ozbSMQKUmJXjaR7O0go8OlvZ84gd4m8IXhE/ML/I6XEnFDg4YcClY/Azsde0Fz9vkDqD5YmDLzu6ItFGF7Z/2qcWbh9Sbo1ztb+jaZIk6p7016wdcHg3Dun/Hkao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUwr2ncP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B93C4CEDD;
	Thu, 13 Mar 2025 15:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741879777;
	bh=A/sSWFFMO9u6pANfKr2GbGM1YcbdvlfvUEwWpLD4DB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qUwr2ncPLZIg0HpQauLPI2SP7prIz0wireN3eqVB8MN844YicqLdt3N7hNVNgqgEO
	 Rql6RGzQG9OzrjbnrwHtp5IhL1DkrX6vgtaRTAZNQVO3MSxzojS3EPwafxzV4724U6
	 xAW7kX0BSZI5uvDPXSNUWorWMxsdhyp14xBFHJJdNOpYZa+LaXf+n4fA279go5DDkN
	 Kd6BLIhGYuXzI49ygrPzI4pO+K4cVw0oMUKRNnvrrVsGuNOl0/t5JrVpWKhsFMQ6Pb
	 qRJxXQIk3fSyt6Vg49fCDSD2QnoWaVEg2BgXeTCOmIYHMxnk5TBAuOWseM7BC0HwL8
	 fN/+mEEvkCfKw==
Date: Thu, 13 Mar 2025 15:29:33 +0000
From: Mark Brown <broonie@kernel.org>
To: Christian Eggers <ceggers@arri.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: core: move warning message below EPROBE_DEFER
Message-ID: <41eec6d9-80f4-464b-a1cc-732170d73987@sirena.org.uk>
References: <20250313143621.29454-1-ceggers@arri.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="19dS7VxEc2hVBs5x"
Content-Disposition: inline
In-Reply-To: <20250313143621.29454-1-ceggers@arri.de>
X-Cookie: A beer delayed is a beer denied.


--19dS7VxEc2hVBs5x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 13, 2025 at 03:36:21PM +0100, Christian Eggers wrote:
> Avoid getting extra "supply XXX not found, using dummy regulator"
> messages at startup (in case that the dummy regulator has not fully been
> probed at this time).

Thanks, I had actually unwound the commit and have your new version in
CI now since it was tip of tree and I wanted to get this into -next.

--19dS7VxEc2hVBs5x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfS+d0ACgkQJNaLcl1U
h9B1nwf8DKR65NYI7OSPzdAhiicvfs0kRZOUtMx85/+nc+44d8ATBayldR6Zr/k2
E/9d336nf4V3ORo5EiO9k05fTq37MexoMRmZVpTe5pfoWJGgBCt3sTnWk2BSNXMR
ZXnkIfsTZRX6mUzJr1ZyZomPQ3Lzp+SuohngVN+FjoNfC6TiM67nY/yuptePC8T1
CbJcT8RJggM0k8kYmmurIGm/F7S55aUifwbJY3KQNolMOC9zv7qukIPp7J4F2LRA
rWfx0BJvm0AVVYs/bAhBbsufRhmb1plyJTuufSmzZyYiv9EVuW/c5Qugg/rbHqNz
xxRE7QENukNAQCGukl1tYjuPPu3Lng==
=i4xE
-----END PGP SIGNATURE-----

--19dS7VxEc2hVBs5x--

