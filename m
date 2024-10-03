Return-Path: <linux-kernel+bounces-349160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 449FB98F1E5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 16:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75C31F226EB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3A819F420;
	Thu,  3 Oct 2024 14:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFmhVNCf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61692E62C;
	Thu,  3 Oct 2024 14:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967180; cv=none; b=gWiBeC1eP7C6lEGuRNZM3U7ERZvd2f8DIDjvQLmpBYWXU0/jpzP0zZOwIrSLurmNxWYBw78DDvC9iDNrcNyBk+yyvSR9V2tB/Ibmzq6JoPjO7XixRmcgrPjsLTyvxFH2/+KHPdrUMspA2d94u7UFWs54WMNnU43DytwahODddX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967180; c=relaxed/simple;
	bh=FTejungkp1rV0ewWV0AZdfydCT1BXrEsUQdUSWtLuWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQKR7iMkKf98HKCoFviiF3m3L+1w+3zRmyD3VI/tZ0bvRGPGGx6n07LeMzQRehntWZrtuHHzWipszkA/+3oqOtzq4oj7GAv6ksIFabtbNk/54EPZDszY4lxtZVrs15S8Y1uTyo2JC+kHsDrtLmUmS+UkKmYWJ1LO/ynISlk1S+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFmhVNCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E70C4CEC5;
	Thu,  3 Oct 2024 14:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727967179;
	bh=FTejungkp1rV0ewWV0AZdfydCT1BXrEsUQdUSWtLuWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JFmhVNCfyUZpKVZ/EfgpLyqXJ1T33ksm8IZBlmEaFHl/x8t7lsSk5FDZgh3QWFVm+
	 SteiCedsRir11lAAJmD/d15hfUFfwUfdVp9X9ws5Q999tIWNhZxahn0jsz8NyBB9Il
	 PWeNxhko9ApEPuQipZYtcP73M98RmDekXIEJpfKHqKrKXBVX1Fw3ucx5adAouGUH9k
	 DbGYDILBgEBuogmEpCSSSD0+BNQauC2dl844hGxhuKkASWX/v4gvYsteIwBEt3g35j
	 zsavQHwrh/v+VLcrBq1snfqCvb33/ShsCwM3LIPcrSbiH+5MX5f1MpHu9JtzxXJEAe
	 MFmCJlN+dh4ww==
Date: Thu, 3 Oct 2024 15:52:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Martin Botka <martin.botka@somainline.org>,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 5/5] regulator: axp20x: add support for the AXP323
Message-ID: <2c0b69d4-a7a2-42d4-a416-8eb39a1a7a66@sirena.org.uk>
References: <20241003111444.543964-1-andre.przywara@arm.com>
 <20241003111444.543964-6-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RKu+djmcrttNTcdA"
Content-Disposition: inline
In-Reply-To: <20241003111444.543964-6-andre.przywara@arm.com>
X-Cookie: I'm into SOFTWARE!


--RKu+djmcrttNTcdA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 03, 2024 at 12:14:44PM +0100, Andre Przywara wrote:
> The X-Powers AXP323 is a very close sibling of the AXP313A. The only
> difference seems to be the ability to dual-phase the first two DC/DC
> converters.

Reviewed-by: Mark Brown <broonie@kernel.org>

--RKu+djmcrttNTcdA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmb+r8UACgkQJNaLcl1U
h9BhDwf/RYTvpNDc1pAuZZM8MRv8tl4uVL4IMM6Lm1In2Nk8QdnAKEi2yjq0hHSD
J2iHIWyYt9cVrXKjv+PKBn707TiqJfzMiTcKgaKdTi1RarEr5kl4RdYrAYApQyCL
reThlZlBK4kROtC4tH/1YHK+JJHJANRL6Slu9sHVYjFUddXZ71lpEmlW6Mvm3Dxa
X5uITJnOTFoIswrYhiShOIK6oUhNQgiGRwPINnB9o/R/jhBBwCc7BQfTRV71pJZJ
pKnG+my1vNsKmRMqxagh3Q2CMWT2VspRpMxh++H5uSfh6rbd+IPp3PlXCW/dMCn5
7U/wYl4qFGyMvouoEuj8Ik8ab7x2vA==
=FxwP
-----END PGP SIGNATURE-----

--RKu+djmcrttNTcdA--

