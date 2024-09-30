Return-Path: <linux-kernel+bounces-344163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFE798A59B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9861F23F79
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAD3191496;
	Mon, 30 Sep 2024 13:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYJO/IKp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A3915C15E;
	Mon, 30 Sep 2024 13:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703714; cv=none; b=hYTyAqkQL/RnHfhNlPfSP1VSAPJRpPO/o43Y2mIoYDry0I7NJq/lzz2UK7iSHFPfNg8kNO6h61htNKE2s3Hn07AHapBX6388ioHzVSo+vQyAT8UBaNTtuonlOlAKjjBGpl1YqNO7Z2CXbl7VlMLx1VP0idIYpUCW4J35MM1JDG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703714; c=relaxed/simple;
	bh=kkTbjYmmUtL4o0lZr/q/BfPDhvqxwi4Q0kpgSrt4B54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXg9wF/y2wafSHwhI8cXgDl4+ZNe79WP5p8d7vDYpJTEUnkdRvYWu1Ny/PIbIjvF9cbXjYzJoFzyYrK11mbLRKQs3VmDUmAloZTn4fZSZCMoS+zV0CeD1NwFHXO6yCdKNfUGuNnNRJrTHJqCMfoUdN5m3VhNaUhzTG2hzeP1BBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYJO/IKp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C107C4CEC7;
	Mon, 30 Sep 2024 13:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727703713;
	bh=kkTbjYmmUtL4o0lZr/q/BfPDhvqxwi4Q0kpgSrt4B54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QYJO/IKpnHnqxuBvWEZyRrcWjYWYASGSyvReh6IYUyAOGwvUA0AbzUh1a1Wb9u/nF
	 ymAclTW+qvRnOUHODtsoM4pzXfJLUpKd6HYoDMVNulv9+AQmUBkk7xXxN3t6r49HWp
	 CMdl0/kVmMxK3Q9GT+s3PuQNsip4DDkZXX0e9i4q9nvsYZNkk3/hQewWlocQT9cDfL
	 rFwckZKo9C38qkyVOXVPNrtEX+otW0g08F6F4IqpiPoQPkHDgtlbcp96NqvHoYsJTq
	 GpcjK+PEHbWHzQ6tszEdA9fM6AfPynRehvgNRBrQMRtZuXjn1shwZfccrQ3jqE3O+d
	 lJFfo9r4ONCPA==
Date: Mon, 30 Sep 2024 14:41:46 +0100
From: Conor Dooley <conor@kernel.org>
To: pierre-henry.moussay@microchip.com
Cc: Linux4Microchip@microchip.com,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [linux][PATCH v2 02/20] dt-bindings: usb: add PIC64GX
 compatibility to mpfs-musb driver
Message-ID: <20240930-retake-limpness-e4146e07b5cd@spud>
References: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
 <20240930095449.1813195-3-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ThiFJzVa0Ijeb/Ca"
Content-Disposition: inline
In-Reply-To: <20240930095449.1813195-3-pierre-henry.moussay@microchip.com>


--ThiFJzVa0Ijeb/Ca
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:54:31AM +0100, pierre-henry.moussay@microchip.co=
m wrote:
> From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
>=20
> PIC64GX musb is compatible with mpfs-musb, just update compatibility
> with fallback
>=20
> Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--ThiFJzVa0Ijeb/Ca
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvqqmQAKCRB4tDGHoIJi
0oneAP9p9DNiQsEO0OewaLjqzJNAamer1DJKYTVugtYz1mJ1GwD+JCtZJC6yIA3N
S0GXaSJQBlLlCemMVODAO4MziXC4HQU=
=xPIy
-----END PGP SIGNATURE-----

--ThiFJzVa0Ijeb/Ca--

