Return-Path: <linux-kernel+bounces-407807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE9B9C749C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28611F25CE9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4681F1301;
	Wed, 13 Nov 2024 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOTWGqJe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8812D7E575
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508905; cv=none; b=gdMe1I6cAlK4L7oJOxMVvn1lhyBZIvsAPlg71SJhuomnvedT3J0bSDvzJYhsln54Hee2QEFSZFqK/7wB+f9eTsClH+/Vwqze8jgX5KSddUvRETaVN3cB9uJ6dW7Ef0CF5SAF3u9CgxtARrnL89VNX+6JahwBinfvI4F1YcC04rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508905; c=relaxed/simple;
	bh=VyGYCCeFx450Hpu/biRn3Uj2PxNvAeYkXMdqdRIDXhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2acjeqkwTiejCc4gGlHhHehBBBydC+NyX4bHtILKSryyGYkXUHH0ooEznbSiYvu9iPVjsqGbsWRmSPLRBmDzCs6SBj9cdJ6+6BGXnGLAcwKhexTGBPNirUPLVXjt3fUwQJIaZ9c+e9+JyOSJrGuJybIt1OwcUo2kYPm9oplhPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOTWGqJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7072C4CEC3;
	Wed, 13 Nov 2024 14:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731508905;
	bh=VyGYCCeFx450Hpu/biRn3Uj2PxNvAeYkXMdqdRIDXhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VOTWGqJeAKj2mUWhmK81HXKaNoNUb/YQ/HyPVdC1rt4ZDScOrzuTFDrMBNdovXlro
	 i7OurOmsO1/BOoFxLSQqIbBUkeu5LrwKHWPuTp639Fue7DK9b0PFUz4DKQeXQZ6p/3
	 gx0zYe53qNyo/043o2AsjBI+Ho5M9IUHv/1MHez76bldkPLsrw0vqVRE75sCzQsb4f
	 6BAKuilKMsvldJMpepq1dWpnyZtXwESetV0iKKngqxeZxuisKdg1qg4/gW+YPC5i/T
	 IDYOOhgQlOspEWuugL27A2tR3VEV2K1mCBgIrb9m/yz3lbcwJluYjpIMn/lvm77IUe
	 7eMlqz++09Hxw==
Date: Wed, 13 Nov 2024 14:41:42 +0000
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: regmap I3C support
Message-ID: <ZzS6ph8KulEITt5C@finisterre.sirena.org.uk>
References: <67d549d0-64c6-4d62-add6-0958ef24910f@roeck-us.net>
 <ZzSxKctLlLZexdF5@finisterre.sirena.org.uk>
 <feda265f-f7ba-4017-a08d-b35916aafe96@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/MBr3yRXViFpTc6E"
Content-Disposition: inline
In-Reply-To: <feda265f-f7ba-4017-a08d-b35916aafe96@roeck-us.net>
X-Cookie: Editing is a rewording activity.


--/MBr3yRXViFpTc6E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 13, 2024 at 06:15:38AM -0800, Guenter Roeck wrote:
> On 11/13/24 06:01, Mark Brown wrote:

> > Don't these drivers end up with the same miserable problems with
> > dependencies on variations of things being configured built in and
> > modules anyway that mean we build separate SPI and I2C bus wrappers for
> > the same case with devices that do both I2C and SPI?

> Not really. There is no equivalent to module_i3c_i2c_driver() to handle both
> I2C and SPI variants of a chip. Also, SPI and I2C/I3C are not interdependent,

Sure, but lots of drivers were open coding an equivalent of that
(possibly some still do).

> while I3C automatically selects I2C. That means it does make sense to handle
> I2C and I3C in the same driver, but not I2C and SPI.

In terms of the devices they're very much the same and interdependent -
it's generally one IP block and one set of pins that's doing both I2C
and SPI, with nothing software visible different.  If I3C selects I2C
then that does eliminate some of the problem space, I can't remember the
speciifcs of how people (I think mainly randconfig people?) were
breaking things.  You at least have I2C=y I3C=m which means that
dependencies have to force the users modular.

> Sure, separate wrappers can be used, but that makes module_i3c_i2c_driver()
> pointless.

That's kind of my question.  If we are going to have this sort of stuff
we should also have it for I2C and SPI since it's such a common pattern.

--/MBr3yRXViFpTc6E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmc0uqMACgkQJNaLcl1U
h9DXlAf/Zd0jdT/eiQzUTKiwxvCPIpyyKykAFjSroVAdXl69TBjHVz10dvyw58Bb
iIbXuUAkNXFSyvntByV2iYosVofWEdYqyQ0ZRvuOH2kaxmcQwCo2Xajxe2XzyFle
Rf2H6k6+CCDyaUX8pKLXiDnhAGWFs1fs1b0y/RQ0LxiqeSFDAOE3e7xaQHIBY2uU
XB89yuJAd6oM/Tts93D3Dlb3y5NjROJOhd5S8xSLScBCCo0VMzAnJxxLUmyI+DIt
6WpozjuPer3/Mg7drs0Rk9uMAEmZHOoAZa94dkAreBn1s8GQTvTmaWwE062TKVUQ
q06hikV4FmKVe8y3R0uJ+zY3Zvy79A==
=WQbN
-----END PGP SIGNATURE-----

--/MBr3yRXViFpTc6E--

