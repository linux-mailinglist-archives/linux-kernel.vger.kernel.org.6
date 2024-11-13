Return-Path: <linux-kernel+bounces-407972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044D19C782E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD2F8283706
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699D0156C5F;
	Wed, 13 Nov 2024 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQQAwf0X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C998E171C9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513949; cv=none; b=B4CGwbPW9hwYlLKz/AxZbjwCldBgsug/mKrg4x2loClFtN8pClah015UTkOXF14hdcR+oStQbhK1O3f5024Mzx/rEGybBdcKSA/ITOdElwc0OhYLII7Fo2O27mA5G+1aPmMuyjzUR9rqkmwnLo/OQ4MUg/OME4S2DmsW1LHhUZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513949; c=relaxed/simple;
	bh=K6ABoXisbgIp6le9/U47l2l9qM1d2ci+WWVzBn0HiW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcFNTUPHhVnOUuh+RvmroJWMAayTCnxOq9QLQ/AzoC/K1a8B7Y5BuxFGk1sT51aPd/umS9IN1NgMQWd7DfPQWAvupHFe/rGS2KcmZiTfyrWm85fiBX8sQ3GgAYF7enGGWlr9deEjdHUMB0Q10tdhId+ZCsrKYcSJD/CGWK/LsTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQQAwf0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0A3C4CEC3;
	Wed, 13 Nov 2024 16:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731513949;
	bh=K6ABoXisbgIp6le9/U47l2l9qM1d2ci+WWVzBn0HiW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eQQAwf0XMpDVHIj318nTsr2/5bnDshcZH9tKVSbv8Ribm5lqH8PrinzEAFNj2hzNQ
	 khD7rAmHsPnNDiDz0DOOG0NpYKX686f+v8exELzoYciJL5Q4pCSv4v+owNYIfwgVKT
	 GaRh8CWRnHWVGtpOCXbMCTCVqftzTSPAZmmLAFoXfFPTzCRFBIxUuu8giFBEHrOttr
	 fzFis/gkjoR+rOC/VxF/780atF+VTONXzVPcfCA5rRfacA65EgbSvkycx22FO/taph
	 QoZ9o9fltFI7edsArZmzh3wEVVu+JZZj4LbIIsPV3ZK1TC23+ll5XnAf/4qL7/dv26
	 7Zb95V0xAynLw==
Date: Wed, 13 Nov 2024 16:05:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] regulator: core: Fix resolve supply
Message-ID: <ZzTOWoTT2to6aW5g@finisterre.sirena.org.uk>
References: <20241113153614.1755825-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x2QeaPf1dY999b3k"
Content-Disposition: inline
In-Reply-To: <20241113153614.1755825-1-kory.maincent@bootlin.com>
X-Cookie: Editing is a rewording activity.


--x2QeaPf1dY999b3k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 13, 2024 at 04:36:14PM +0100, Kory Maincent wrote:

> The regulator should not use the device parent to resolve the regulator
> supply. It fails to resolve the correct supply when the of_node
> variable in the regulator_config structure is not within the parent
> node.

I can't understand what you are saying here at all.  What is "it", why
and in what way does it fail and why would we expect it to succeed?  How
does your proposed change fix whatever the issue is?  The DT binding is
against the actual device, not the virtual device.  Please describe both
the problem and the fix more specifically.

> Fixes: 6261b06de565 ("regulator: Defer lookup of supply to regulator_get")

>  static int regulator_resolve_supply(struct regulator_dev *rdev)
>  {
>  	struct regulator_dev *r;
> -	struct device *dev = rdev->dev.parent;
> +	struct device *dev = &rdev->dev;

The rdev is a virtual device, it's not going to have any OF
configuration, and given that prior to the refactoring in the commit
you're referencing in the Fixes: we were using the struct device passed
into regulator_register() which should be the same device as we're using
here so if there is an issue it doesn't look like it was introduced in
the refactoring.  What makes you believe that there is an issue in htat
commit?

--x2QeaPf1dY999b3k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmc0zlkACgkQJNaLcl1U
h9AFewf9ExChjUDQ6iiR37grOJQQs2CxcYMutSmVMSysi8WlyOJ2JPhQYk5H1gyG
tb2uDQ64YOH6pRN9yPm9Nfkkqa6B6OtoHZbxh32xrYUnoRHmxJnlx7bXMDJC90bd
zSfeM/4aEus6/DS+N+rNMsT8f8gveNg2yIg2NLL17X6RbH1qkagLohmU7srxwfeB
xJMoxjSb4FMfHiC0TncRs9Dzb9N2KOGvrnDoXDLpPBH+fG+BdwYrP9hk51kchExW
PBFgLX7wpf4P53TVJH+l4d9sg+OZwdc+yVRFObU/l9pu18xd2+Yj6wybESi9odTB
jwQB34TX76QBqO1DvS99wYPxuSmZhA==
=6WdY
-----END PGP SIGNATURE-----

--x2QeaPf1dY999b3k--

