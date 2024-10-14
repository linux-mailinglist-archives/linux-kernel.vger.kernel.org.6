Return-Path: <linux-kernel+bounces-363951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9556099C951
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9E15B2235C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037BF1607B7;
	Mon, 14 Oct 2024 11:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWr/B0uX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6039C4E1CA;
	Mon, 14 Oct 2024 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728905376; cv=none; b=ouuSSleTUzbS3NqT3XuehTMQmbSiQmBhDyAAiaazzFVfZ3lsBfYOmIuC3loKYeN3mtsaLN7pxRbRpvhGeNPPwl44EwsCqMQYrlWyiu2J/9niC2/D/7BcC/uiQsDvVnM7T3CBEOlRepi9WtUgnbxeYMLwSkaOIwjkTFDxOJ6+RCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728905376; c=relaxed/simple;
	bh=uPsxoDsjm78t3sip5bb8f9bnQIziBkAhu9wO8ejFzX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wc6mDvs9rKK/wai4Ty/x6eDeXqFOVzoUSDrOSGG1Hdyb/htHg8yBCgS3qiXBmjC9AN38XgQt6KyX216HHx3xK31pj0Xc50+B8pDxU3IKAEBj3eLCHLoV6w2NmkOqJOUOUCSk7+4v+6uN4fMsfx7t5/K27b/9F+HKodqXQxFGKVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWr/B0uX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85982C4CEC3;
	Mon, 14 Oct 2024 11:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728905375;
	bh=uPsxoDsjm78t3sip5bb8f9bnQIziBkAhu9wO8ejFzX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fWr/B0uXBy8X2ff3QNKKl7vU3NeBKoFmIyF3JkMQ4Y2uLOkST8vLmdZqemyjuPOT/
	 Hehn6vsAPugYmYU8VwttGyBUPkSFcyPxhklTT5egxCLEY115JTgRaHVoM7Ms4STZ01
	 dIAW2wu1mCNJSEne5ajUh0yCUZFU/CPunANgZJ23yVXAHTZi7SVTHyc2oSh08eXlYN
	 cLdXI0QzcrWU1Vrt2hMcIkI8DR0HPBc68oktSW351NaQ2kNRW5LNkWVR205Wbop1zg
	 LgibIRXTztvRCLKFgBDb4FQR/Wc1pnCCQ22uDIUZd3upgjObSoUQPTywhOfOa71DV2
	 APeC5iOYjbLKw==
Date: Mon, 14 Oct 2024 12:29:25 +0100
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lee@kernel.org, lgirdwood@gmail.com, linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: cs42l43: Disable IRQs during suspend
Message-ID: <Zw0AlU9QsWpZs2Sh@finisterre.sirena.org.uk>
References: <20241014095202.828194-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MxatpfiH1izAoaZY"
Content-Disposition: inline
In-Reply-To: <20241014095202.828194-1-ckeepax@opensource.cirrus.com>
X-Cookie: Editing is a rewording activity.


--MxatpfiH1izAoaZY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 14, 2024 at 10:52:02AM +0100, Charles Keepax wrote:
> The ASoC CODEC driver masks the IRQs whilst entering and exiting
> system suspend to avoid issues where the IRQ handler can run but PM
> runtime is disabled. However, as the IRQs could also be used from
> other parts of the driver, it would be better to move this handling to
> the MFD level.

Acked-by: Mark Brown <broonie@kernel.org.

--MxatpfiH1izAoaZY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcNAH8ACgkQJNaLcl1U
h9C+Vwf6A7neaYAg6jb8xksBLfI1Vg5veJTyx8i4TPu3qBr1Y5B2o7wwMwRSX35z
/yWBHwOXvoS7BB74+8xKHgrEX8lzmvovmgeECm5ChOpU4z6pSL9CXZ3PqhfplLax
owIic4qifXozB6iErFFNIKqLNB7uNGjYTb/16l9mrOSdtpOAqfz213/diBMIh0XY
PCCoY7GqRZxw6Wr3+4/zJFYFKjfcCVSODG4rsd7PxKLCOXTdrhVJoEZBRDZzb5GT
ZBzk48CgCy4Bbzng9kTUxtSMKABnAHfTNOV6920nYNVUp3dRfbuznWQwHV3JLmvc
CVFsmtPI+dHR9kr2dzDfT1xNNn+sSA==
=RzDS
-----END PGP SIGNATURE-----

--MxatpfiH1izAoaZY--

