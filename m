Return-Path: <linux-kernel+bounces-380313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5C79AEC39
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E786282E68
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181381FAEE8;
	Thu, 24 Oct 2024 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GChDux71"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD801F9EB9;
	Thu, 24 Oct 2024 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787594; cv=none; b=e9Z9KZ8u+rlDotUT53ICMuIBaz/lrcoHPWE742k65cloWuNsnvrg8DY4W6KSECUrjbDWdd+0t1AV3MKZh9bBOcHWwh44Hk5CIWUUO2OAcidLIysmNU+ykBADLpzwUwvY9Va7twnMo/D5DbbCrIc6ehMyFmK0aWVglY9B2DDdEQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787594; c=relaxed/simple;
	bh=6DBp88axNIeJshw6Euf0CaTQfLnYECvMMAKQFkVp8WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxV6nfiOuhQE0+F+LYH7VJ357owJPb/M+EMDiUW0nn+5QGVCPbdfw9FO1BhVIZyuUf4kh5+fkdSa9DpOHOg8iXOafBgHuDSlNTcSiiYP6azcAazJ28GlHAaQXv1YBnL56CNWB1QLV4w7umsq3ZzOhtmssXPNjGyze73Kt6gUSUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GChDux71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C439EC4CEE7;
	Thu, 24 Oct 2024 16:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729787593;
	bh=6DBp88axNIeJshw6Euf0CaTQfLnYECvMMAKQFkVp8WA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GChDux7196fdX9ocyCfG6C6vVv1dxabsJCWppMPDl6lXMdL2LgoVzVnBY82ohu/Uf
	 pfXmuuvPSTnvTPH5iuKTi+wbIib//os0saoIvZVpJSPJPN3fCwueQZIqeQ1zFgkduq
	 xqgEzbmuYD9HvREnZvOzweOI5OIHXiiXkB8mw2mQotRsjNfAyNXAe5k4D0qcRcPW+/
	 tWF0x94vPA4Ho49xgazkAqSTSSaOulYSaWxxBPQWLaql9wb9bCyip6uko6JF+h+o0V
	 NzuVZR/W/kY0oEwpCJpn2Xf01ju+YI5YGMLMqbBvuaJ+b37SHPtcAKdJKLXbWTTR50
	 opxFN3+YVOPUg==
Date: Thu, 24 Oct 2024 17:33:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Wenliang <wenliang202407@163.com>
Cc: linux@roeck-us.net, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
	krzk+dt@kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: modified ina2xx to match SY24655
Message-ID: <20241024-reprimand-culpable-22e60395d889@spud>
References: <80bfd968-8f12-46b1-9b72-837502ccdb2a@roeck-us.ne>
 <20241024083055.82047-1-wenliang202407@163.com>
 <20241024083055.82047-2-wenliang202407@163.com>
 <20241024-skyline-cahoots-6783be97795a@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZWKSEbtUNNgZDTRr"
Content-Disposition: inline
In-Reply-To: <20241024-skyline-cahoots-6783be97795a@spud>


--ZWKSEbtUNNgZDTRr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 05:32:19PM +0100, Conor Dooley wrote:
> On Thu, Oct 24, 2024 at 04:30:55AM -0400, Wenliang wrote:
> > Adding Silergy's sy24655 as an adapter chip for Ina2xx drivers.
> >=20
> > Because it is similar to INA226, the supply voltage and pin definitions
> > are the same. It also supports IIC communication, with only two
> > additional registers added for configuring and calculating average powe=
r.
> >=20
> > Signed-off-by: Wenliang <wenliang202407@163.com>
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Actually, I take that back. You can add it if you send the patch to the
dt mailing list so it can be tested.

Thanks,
Conor.

--ZWKSEbtUNNgZDTRr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxp2xQAKCRB4tDGHoIJi
0urYAPwMKDNCtTSI8+XCPKj/xCK/XhVJao6UrtbInlcj8f9tkgEAgd1KIbwCy99Z
zlSKviK8T/z509EIH9y4rC18IxCbBQk=
=WPs4
-----END PGP SIGNATURE-----

--ZWKSEbtUNNgZDTRr--

