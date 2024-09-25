Return-Path: <linux-kernel+bounces-338231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B9C98551E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A471C21A70
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC402158A33;
	Wed, 25 Sep 2024 08:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNtno5qz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6601B85D1
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727251661; cv=none; b=WV5PIGU2/wBefa/s58zBLDi6EmduObuwlXOJp27E6NPlEHyit4CDcZV2EipYdDdA63hJTSTiGXcNr8+DW5OhogD0K+WlzuNbA2e1DIyjJ4kucUzPqvE55Tvuaz20R8nxo4AKUroJGokZbH3bNRDAlw0I34KDrvttfD28BeB67kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727251661; c=relaxed/simple;
	bh=rLG3cCBmxUroayKg5taeHJFRaUORGUOvTXZv1v3bltc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5bA5EiWn2q1NV+4DNUTQNyu2WjIuG7MFqkRkf8OF7kZTcCyJqwhb/lNxFCWfpEgHmf+4UeHV8J3fRpldSHDvgXtvAxSX1vTkjq5Nud6CX1GxKnxRxuWgQWOM71DJZ0gantdQopv1+JjeZr85YUCxXwtPIDourJeQKE6OyRQRyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNtno5qz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB58DC4CEC3;
	Wed, 25 Sep 2024 08:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727251660;
	bh=rLG3cCBmxUroayKg5taeHJFRaUORGUOvTXZv1v3bltc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CNtno5qzusBAcP6XVwR20vEwwe0ehMMY63AyD9ufu6L15IniAL8a7mIBYrxlxvLjT
	 D7zac60HZeXIIbuEBg98+cjVw0WBFzKxn5dxrC9unf1pg+uiBaRMI/q1IV7S6MqlPw
	 UqxASasM+gVy/sbv3+DH2acv1bH9yCR1MM0Dosr5nq2YlvYPOAHggmP4triNGRP932
	 8LheNkVwkNPuzpTO1PHiqH8MJ9UjKgmZk6Jxg4a2o9a757ActIp+LryoIllCf8bWBd
	 CMqBTXRErG/8dQi7odYcmI+k1ruxFpjBwyQwPekuB8x0mzQ7Dj/eBF+vyh97vzp2Hi
	 VgNbCSC+S6+QA==
Date: Wed, 25 Sep 2024 10:07:36 +0200
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: bd96801: Use maple tree register cache
Message-ID: <ZvPEyFWZthCcQeTK@finisterre.sirena.org.uk>
References: <20240924-mfd-bd96801-maple-v1-1-04fe33e1f009@kernel.org>
 <5ec5c65d-8bdb-4dec-87b2-75413a025657@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a6Tb6xj7zVkx5irv"
Content-Disposition: inline
In-Reply-To: <5ec5c65d-8bdb-4dec-87b2-75413a025657@gmail.com>
X-Cookie: Editing is a rewording activity.


--a6Tb6xj7zVkx5irv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 25, 2024 at 07:57:46AM +0300, Matti Vaittinen wrote:

> Thanks! So, I should have used maple tree with regmap instead of the rbtree
> when sending this... Do you know, is there any occasion where the rbtree
> would be better?

rbtree stores in device native format so large syncs might be more
efficient, we can just send directly from the buffer.  This could be a
good tradeoff for larger syncs running on slower CPUs but it's probably
pretty marginal.

> As a unrelated thing - seems like you've made it safely back from the LPC.
> It was nice finally meeting you :)

Actually in Paris for Kernel Recipies so not quite but yes, good to meet
you!

--a6Tb6xj7zVkx5irv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbzxMgACgkQJNaLcl1U
h9B1+Qf+JURflmKtEZbH4Y4VwwOPmqE8x6oUcnmEqb67yJjBuwcyxL49xLG/ndVq
l4d+xsj55m7nha+pca8uDGSOfL63v+61F78965HIXihzKJ3ElQI27M6ub0jfqZUJ
lybKhJUNJ66QH3M+4G/jTDGp8DvnFrNxkm5JVb1u5v2DqnEHSCRe63L0QXlSjWyv
SfFECIRTZagiD46X5Q316keO/uC+DKp5QM0pXHtY+Umt9yN9OzAGHNFpX84gZeyw
Rp7ap2xkLdzJtWS/wTwU9Gb8uEcbGVjt7a7OPG5jAA8h+y3m2xuizvARZfGFBhS1
Y6N2x3KgWTnfzsKqon5nCaMUfSB+KQ==
=atuG
-----END PGP SIGNATURE-----

--a6Tb6xj7zVkx5irv--

