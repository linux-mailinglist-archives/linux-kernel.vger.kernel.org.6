Return-Path: <linux-kernel+bounces-305299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B18D962C92
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9491C242AB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFCD1A2C36;
	Wed, 28 Aug 2024 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmcH+K1W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B0313C3D5;
	Wed, 28 Aug 2024 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859583; cv=none; b=DFPcwZiqYQBtLQgElq/9bncJitsBlC8XDGLeJkc3SxJDxEzsPatagwo6VQFcrBHEdiN8kyKlq5WVe0phDORVQlFpzZdFZCA/MgNbevubE6JTwGnmapZEEN2IBRXKWcpFEi6j5o4ZsPrBaJLp+nhhAnBTU5kObVi8YQsw9sLBdvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859583; c=relaxed/simple;
	bh=bJikFcZwx9JucrgqW1e8FTFYmK48P/7CWwLxWQz7Xpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZW6K/CWZmZPBvyn/KMfAf5UXlu829r48NDbVoYAsUIKAVUUX/e3g4TC1IbsIa8vaO5+csFYwr9P4EgRk0+h/13FI/ybSbvLFl86UcBEF3pMQH0oXpI38LtsDRpieQ7Zp6kOB1/HkFbwEDSEnkRw3g4tRUbjDN6IfPABBmwrWyQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmcH+K1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F11C4CEC9;
	Wed, 28 Aug 2024 15:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724859582;
	bh=bJikFcZwx9JucrgqW1e8FTFYmK48P/7CWwLxWQz7Xpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jmcH+K1Wl8Wvhvdo3dN1dZyG8OU9/A4kujAK5JNouySApI/WPoXAg2h+XbLKaxFoM
	 2LN2x5TR/J/Wv4T2SGaRwPP4HGEt7yc8JKfG/w3RIj06+iTd8S6zr5PeOlmfflMFxx
	 5a5U7ylXEIVsbGfHEOIKG0QV4w2lE5o1QfR6DDCsczh3i93f2UWfxNA3vLQ6iiSqyL
	 360zSE8Ipu7mDpRXtBlc7uwlRQOo2R40z1bpYDUDaN0WINqTPh8x/a1YXOlqEdPLts
	 uPhdFiMWZcGcDNa88PC9pg1aUQrsahtAqspZA1uy2g9zbKCcqe8krLzZiftVFq5+I8
	 Ds0uO2In3ea9w==
Date: Wed, 28 Aug 2024 16:39:38 +0100
From: Conor Dooley <conor@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, kernel@collabora.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Fix compatibles for RK3588 VO{0,1}_GRF
Message-ID: <20240828-reprise-lethargy-1190b6e3a05d@spud>
References: <20240828-rk3588-vo-grf-compat-v2-0-4db2f791593f@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MHhSniWftcmWfCNL"
Content-Disposition: inline
In-Reply-To: <20240828-rk3588-vo-grf-compat-v2-0-4db2f791593f@collabora.com>


--MHhSniWftcmWfCNL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 03:40:07PM +0300, Cristian Ciocaltea wrote:
> As Conor noticed recently [1], RK3588 VO0 & VO1 GRFs incorrectly share
> the compatible string, since they are not identical (though quite
> similar in terms of layout).
>=20
> Provide dedicated compatible strings, as a follow-up.
>=20
> [1] https://lore.kernel.org/lkml/20240821-stretch-scam-09d7adc08a4c@spud/
>=20
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--MHhSniWftcmWfCNL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZs9EugAKCRB4tDGHoIJi
0jSfAQC7QoPhTY9jXgMOAKRdVlBmctOzmHqYkq2eO/gU9HyYCQEA/WygIBP5zkLi
fD/XjTO50/CMHhRbMTBYAzARqySdpgg=
=3ZzO
-----END PGP SIGNATURE-----

--MHhSniWftcmWfCNL--

