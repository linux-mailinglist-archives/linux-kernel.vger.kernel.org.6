Return-Path: <linux-kernel+bounces-546287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5454CA4F8C4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA4D71702EF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50C21EF0BC;
	Wed,  5 Mar 2025 08:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="td0ucEqV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C531C8FBA;
	Wed,  5 Mar 2025 08:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741163184; cv=none; b=G0Kf1l6gzAJcDeX/CBFV4pZ3PrNgHz++g++Q1nkA7zVyXw7HEunEgF2diqlYvHk1uV42Y3Qq0RtPjwR1khn/A8OqEUZ1WXR9xd92CaNHCit1OrT9hHFdl9Ja+2rkMli+wKc/FYCyggMb1hvJ72iabUXVWCY5Q22blXORGty1nGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741163184; c=relaxed/simple;
	bh=CKep9lIEux6rqMukCPsUfeFS8wPwAtgSYA5QVRjKI8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjNFnY7LcjK/ejrRq+SpVHqa76RIyOGgibirOf3wb7F4bjT747B9gMycaDJbR30GBV7gETaEv/MjNabCtzgrz+YHx5qM0WWYkw/7qklaaHwHxZiifc2X8+5+nLJMxtZ5MxoBpu7v+bbZWMngW0QyGeaHD3MgaKkfbM5XTBBHYAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=td0ucEqV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C68FC4CEE2;
	Wed,  5 Mar 2025 08:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741163183;
	bh=CKep9lIEux6rqMukCPsUfeFS8wPwAtgSYA5QVRjKI8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=td0ucEqVHK8atYbmGCD+2yVZyseFmvPelf27qLYlwjCJX1PRm2Jl1gp94QHf0E/15
	 bDfvcNs0uHO3Mm+SmYEodhe8qT7Qoo/8GPjG65DXb6KDUfVmj/kLZhMahF2rBFCKkU
	 Y+H13LWFngwpJoHEahxJNEG62cQuXUj8f01140SikPCPxGwUwqJkgXxaAa8TFAcyMg
	 rIfAlhFHFkNSjRchZlOSebYTnWekg6uhO91EABD3w1Rg3T82qZ7eG9iDqrDByfwHJG
	 s0IwQyXlNld9cQ7K93Yu7Jx6P8hPA/RfcpHokcZRVZlgpnaYyeWWMTHKdHITMhfTmt
	 ZEQgk6BrRbRAA==
Date: Wed, 5 Mar 2025 09:26:21 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, 
	jonas@kwiboo.se, jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Subject: Re: [PATCH 1/5] dt-bindings: display: Document DPI color codings
Message-ID: <20250305-mustard-parrot-of-karma-1caf5d@houat>
References: <20250304101530.969920-1-victor.liu@nxp.com>
 <20250304101530.969920-2-victor.liu@nxp.com>
 <20250304-deer-of-striking-pride-ff6e86@houat>
 <20250305-important-quizzical-chamois-ff48af@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="5qv5lchsz5iuy4wj"
Content-Disposition: inline
In-Reply-To: <20250305-important-quizzical-chamois-ff48af@krzk-bin>


--5qv5lchsz5iuy4wj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/5] dt-bindings: display: Document DPI color codings
MIME-Version: 1.0

On Wed, Mar 05, 2025 at 08:51:35AM +0100, Krzysztof Kozlowski wrote:
> On Tue, Mar 04, 2025 at 11:33:44AM +0100, Maxime Ripard wrote:
> > > +properties:
> > > +  dpi-color-coding:
> > > +    enum:
> > > +      - 16bit-configuration1
> > > +      - 16bit-configuration2
> > > +      - 16bit-configuration3
> > > +      - 18bit-configuration1
> > > +      - 18bit-configuration2
> > > +      - 24bit
> >=20
> > Do we really needs strings there? It would be much better to use an int
> > plus a header
>=20
> So DTS would sill have a name, just being a define? Then what is the
> benefit comparing to strings above in DTS readability?

There's no benefits and no downside when it comes to readability.

However, it's not the only criteria, and not having to manipulate
strings but instead just doing int comparison is a huge plus.

Maxime

--5qv5lchsz5iuy4wj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ8gKqAAKCRAnX84Zoj2+
dmR6AX9CqkD6CQeYuRvWlWgsp7zA1WNfpdOgY78fwFZQvBxUy7DgUkaNJkl7kDij
znChBsYBgOdchqndi69u/xUJVL4Z4hKuZewp7WoAxHunfX0JNjLh2SEustfv649+
zXvzjFWpBQ==
=vkHY
-----END PGP SIGNATURE-----

--5qv5lchsz5iuy4wj--

