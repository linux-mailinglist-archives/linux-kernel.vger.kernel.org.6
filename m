Return-Path: <linux-kernel+bounces-308874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D529662F7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395CF1C20A99
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088201ACDEF;
	Fri, 30 Aug 2024 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJj1nbaq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C84F17BB17;
	Fri, 30 Aug 2024 13:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725024747; cv=none; b=KuURoKsQGGFRg++5dnKbhZl2+5Z1I+MOwLxPllqmAbgATfj4W4sXiHQZ4ioQoZb9ahEksuS3E0wcph406mRz4z9pZYpqBIP5r2ONPUohiWs8xjWQsstIgOuQC1b6sGoXvscuiq+3sAotbx5uD6AdRkSNh+iW3qNT8uYUuuVPZeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725024747; c=relaxed/simple;
	bh=7e72g1sG3Aetpfg2qZQ6u07s6zBI2/8LUyBugxKUU4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0NijilK8d4fveRjutazPPsbP63d77gMjhPOHHep/0+xYN162Fgap8RwuPjHKcpO0ide1+fLgwL275O0KEioG/thfFOy17jcJGTx6+ePnhPMjVRLRgkRnEiigLFXXXIOQRVp2D28EpL6BJXd7272a9SBVbRVwhD6FLAe23x0iUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJj1nbaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24EB4C4CEC2;
	Fri, 30 Aug 2024 13:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725024746;
	bh=7e72g1sG3Aetpfg2qZQ6u07s6zBI2/8LUyBugxKUU4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OJj1nbaqCh5A93DOZ1+oFS3JWTvEm9mbXmqsbIlGiGzlMoQABx3zCuWx6PHnwNZZp
	 j6YhFUnRm+FQETx4AsFdEMH/TBZaZxr4djx2nfT/U/qkVlrBrYs+fVczHUNDRSWuZh
	 rfdtbFX6Pk8NMfnUFeV303E/4FBkiYV3rrt5yfq1uCBy1el7KBRMab1igHT0PcMOqJ
	 ZL3gwQFdfpevvgGKlR2ktDNc8CCCe6CoGc9fVKear2XkHUfQFoP5fACXPAXWwwAxUy
	 XnaBMcUXbdendbFZB1VI2/J2mcYakL9JH01Z82Ik4ZQwSc7Y2aq861eLBkdBGy1An8
	 6EX40SlBDhShg==
Date: Fri, 30 Aug 2024 14:32:22 +0100
From: Conor Dooley <conor@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, sjakhade@cadence.com,
	yamonkar@cadence.com, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, nm@ti.com, srk@ti.com
Subject: Re: [PATCH] dt-bindings: phy: cadence-sierra: Allow PHY types QSGMII
 and SGMII
Message-ID: <20240830-juncture-observant-f979caae1c52@spud>
References: <20240830105316.1824319-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="M6rR9CDKVnFegJOM"
Content-Disposition: inline
In-Reply-To: <20240830105316.1824319-1-s-vadapalli@ti.com>


--M6rR9CDKVnFegJOM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 04:23:16PM +0530, Siddharth Vadapalli wrote:
> The Sierra SERDES can be configured for QSGMII and SGMII protocols. Hence,
> update the bindings to treat "PHY_TYPE_QSGMII" and "PHY_TYPE_SGMII" as
> valid values for the "cdns,phy-type" property.
>=20
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--M6rR9CDKVnFegJOM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZtHJ5QAKCRB4tDGHoIJi
0jxRAP9/gABn2MmITzGpHBdNrboXK3lxJHTriCPGEXmZ7YC62QD9GW28ROZ21O4I
C0Ni6P8GH4RmP1OxiqV7VM9sosabxQc=
=0g22
-----END PGP SIGNATURE-----

--M6rR9CDKVnFegJOM--

