Return-Path: <linux-kernel+bounces-538556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7723DA49A2F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3F5170F9D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8565126B96B;
	Fri, 28 Feb 2025 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUa4d7Lg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEFE2F41;
	Fri, 28 Feb 2025 13:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740747941; cv=none; b=KpDPGN2DwNPl1lGxgvBNsPNLmzkU9wqt62vpQp4TQOsTelYjRBt7C2z/is1QPtw+KBI2zJ1HNo3bIanmFBsdftbmzEs+3TOzNzpa1N+dfxGt2v2UIelzICTMOhNS8g+5dRHZooe0d2qoB0IpGbCzcHBV1VIhu6XFq85RbZm6G0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740747941; c=relaxed/simple;
	bh=BIgz5OKhiCWbjc6Gbdi22MD5aJieg9cn1vGzAVxoOkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVdnQhNFjys8w/LLobFEa1/siqc88n2pcMk+82AAIFDDTD54ijxlTtyV+MHGAqL40DCZZOcQYcdRQAOgrT3sFnT+MqwuqFQwHGO3EHn/mRBQ1zwcTY5A3acIkdmUNNrRvn0oGnfzDbFjPMSScR1j3UuBwDPoOOIhuZYARZUGYqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUa4d7Lg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6B6C4CED6;
	Fri, 28 Feb 2025 13:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740747940;
	bh=BIgz5OKhiCWbjc6Gbdi22MD5aJieg9cn1vGzAVxoOkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WUa4d7LgeIXgQXXcwxOxnWFJ5x3FrwYOKX+F9iwTh3syqpB1V8apYwxkQcZNTqovg
	 MdR1iwNhoInZKFx+t7ru9rK4lB/74lGw8FYHvyd3gOlh0XXumjyQv+S4epOX7t+bK2
	 cCH6FsQ/ROrzMogqiqRwhp97SfnLwX3BQbqoH8lgPEXk+7yI2GqEeICA5ESrhKrxBc
	 vK8hw8Ww84i0Tnze1YRjgMSEljuh6g2WoMkV4TH873Fjx2WZYX78vsc9Pawf8u8TZs
	 9LY/JQo8B7GngbKD5mYXd4YHk3h6P/113IonH5rOxze1SnW3g7uCX6FTLEX9NMHT2F
	 7Uq6cxaMZM/nQ==
Date: Fri, 28 Feb 2025 13:05:36 +0000
From: Mark Brown <broonie@kernel.org>
To: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] regulator: adp5055: Add driver for adp5055
Message-ID: <61fe771b-befd-42b5-9f0d-7bad03c0b044@sirena.org.uk>
References: <20250225-upstream-adp5055-v1-0-a5a7f8e46986@analog.com>
 <20250225-upstream-adp5055-v1-2-a5a7f8e46986@analog.com>
 <a7f7d4dc-283a-40b9-bb1b-0bc8aceb99c1@sirena.org.uk>
 <SA1PR03MB634020464A151651A08ECAACF1C22@SA1PR03MB6340.namprd03.prod.outlook.com>
 <8afb3d94-336c-4e33-a73b-fc690f287556@sirena.org.uk>
 <PH0PR03MB6351EBB5118D642D00F853F0F1CC2@PH0PR03MB6351.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/bAIL7fIJafYDuc2"
Content-Disposition: inline
In-Reply-To: <PH0PR03MB6351EBB5118D642D00F853F0F1CC2@PH0PR03MB6351.namprd03.prod.outlook.com>
X-Cookie: Avoid gunfire in the bathroom tonight.


--/bAIL7fIJafYDuc2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 04:01:37AM +0000, Torreno, Alexis Czezar wrote:

> > You've open coded the operations instead of using the framework helpers=
, you
> > shouldn't need to anything other than supply data here.

> I did code this similar to the helper functions like regulator_enable_reg=
map.

Yes, that's the problem - you shouldn't be copying them at all.

> if having both gpio and register enable isn't that common, I guess it's a=
n option=20
> to remove the gpios and stay purely software

It's extremely common to have the option of choosing between a register
and a GPIO, that should just work with the framework code - we should
use the GPIO over the register if it's available.

--/bAIL7fIJafYDuc2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfBtJ8ACgkQJNaLcl1U
h9C2OQf+JV/IOupHsp1nb5IDUVREG7aohkPNRsi5mARwdFubR5vVqdsS9/0RXBiw
8A5EsquPODcS1I7e6Oshr+jW48R4djXp0nlwApcVHS5b1MTAbyZWw8lfDUkt1FsS
qsRfSalJnuia/etScd1PWCyOyIO9cA3SKh8S/feZGXifAqgsRNxXPhmE/mlJz6n6
3mND3WyR5aZmHwCbnhKrfFaTBIIkHuw/Ys8j49hojyIj9wSiabqZ+Loke5nQGzaL
ZvaArmba/2ehOzp4fJT1soi2pkiawV+eS0X4YxNsgoHj61T8BEY/O75VD81o9FcS
1dvnXoFeLWlX2xlbfwx1OWwyhJRWcg==
=2myS
-----END PGP SIGNATURE-----

--/bAIL7fIJafYDuc2--

