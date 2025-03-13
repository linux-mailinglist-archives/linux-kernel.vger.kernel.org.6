Return-Path: <linux-kernel+bounces-560468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0817A604B7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90EA31894BBC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A79B1F8918;
	Thu, 13 Mar 2025 22:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r74KK4ya"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6107C1F4E4B;
	Thu, 13 Mar 2025 22:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741906181; cv=none; b=paePjF9zHbneg3rX6V17wDnTQiOf/tfum+cH1vmdVq5Qk2EUjtnaW673Su4i2T/rtMy7iZAaEQsijtRQBj3pmmd3CYIC4Qnw3XOkTP2C7Ht4VYWriZYpM1itN3X0k6/1jNdm1+OVue3HRRh6BKslL6bskJmuFzllMsytybygsnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741906181; c=relaxed/simple;
	bh=fpQaP9ugtY/Kmb/2J2OVe2Gd583gcVOt6wrvlY0JLq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEU6BJm2ACMf3oNp78uWilj7MHUWlkY/WL7AU+8eAW736B3aPryI47FUdBKQVI+x5S0D6QsnaROgGnwPiStGiOfl2lqU3k0kwLUGqX6m5uCm1CILUQ1tPL92gb4Qct1Fe5XylqGah0aRq+18UH+5O6UyDoOvKadYruyORaNCppM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r74KK4ya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7630C4CEDD;
	Thu, 13 Mar 2025 22:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741906180;
	bh=fpQaP9ugtY/Kmb/2J2OVe2Gd583gcVOt6wrvlY0JLq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r74KK4yaLKmRAfvoB96epDg7unCRrNokwziaBvcg9lK2yjOqeRIHDSk3zvIPYkJPh
	 SHh1B5y8FBvvDyVCDiL8U1gh/kOdq/AaIw1K0WfayBRdN2sk1PRg1AeYoAtYTH9ybM
	 p6SaTxxte3L0PlE8uXRsbpDInLZS84xAcVt6/3n5/HCX9qEX4l2aANsTXBZN797fzi
	 UwZB8DKJlNTY44tygXY6PYeZLI18jXc8CdlxhisNZfiT3YiUQMYWkpLLOA5/AgH/o1
	 /Zj942vAABQR2CS3gj50L82WvZk+Jgea4MpHS7TGuOzphw/9F7OfYknBGDGaXCmn1Q
	 gBR4W/nZBLuWw==
Date: Thu, 13 Mar 2025 22:49:36 +0000
From: Mark Brown <broonie@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH RESEND v4 1/2] regulator: dt-bindings: pca9450: Add
 nxp,pf9453 compatible string
Message-ID: <6319c560-4534-456b-bcd7-3bd1ee328f15@sirena.org.uk>
References: <20250218-pf9453-v4-0-ddfd34e02da0@nxp.com>
 <20250218-pf9453-v4-1-ddfd34e02da0@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MU3/IJvhTQbjpyoG"
Content-Disposition: inline
In-Reply-To: <20250218-pf9453-v4-1-ddfd34e02da0@nxp.com>
X-Cookie: Drilling for oil is boring.


--MU3/IJvhTQbjpyoG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2025 at 12:38:39PM -0500, Frank Li wrote:
> Add the compatible string "nxp,pf9453" for the PF9453 regulator. The PF9453
> is similar to the PCA9460 but supports only LDO1, LDO2, LDO_SVNS, and
> BUCK[1-4].

This doesn't apply against current code, please check and resend.

--MU3/IJvhTQbjpyoG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfTYP8ACgkQJNaLcl1U
h9Baewf9EhhllbI3hxhMJ7t3qtSDpbJ/xwu/VLfaFxtk2UkMhYijQJzoou2rmPcU
tpKAKNvIsGy3fiKw7axS2FTXl3xcNRWDIHqPA81bca/FmaquGpOfHqzhj3BsP3Vx
xQVoHNJ252fGGxmkeHK+YB/j4lZWe1uG8t+bOdco7YMRz80Wx3ZyO40015K8jLKE
DSWccl1xUUz2t3ZyPzeMmmBLQxW+rl6Q10vCbW4gNzqGWNqyZDWrZfoESv8ATj1m
S4Q5zD7xS0BDhhwR7D5oDBudI31ROKqbu6Nx60VkVYzu12Rb70ZYRYxjioq0nusZ
qNB/Pr8FZ/JreveAmpLyKtEhGfMX3A==
=Fupi
-----END PGP SIGNATURE-----

--MU3/IJvhTQbjpyoG--

