Return-Path: <linux-kernel+bounces-174720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99F88C13A8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 19:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89E41C20E0A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 17:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1140179B2;
	Thu,  9 May 2024 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXcSLdt7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C431FDDDA;
	Thu,  9 May 2024 17:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715274999; cv=none; b=BQgOyKH4FWBMGVhlVZFss9cZvgbXAJI/wfyI0N+GV8QhDzlyCI4Y+33D0WnYpmdsvQg/TiI/lOzRFBpvKuEq7DBvSkVYbzgO+Sz4ryvzrj4svCu7aX2swxJYEUjPvL17X2FNI9h8YZ2bmRJpr2kn3Bk1DNdz6gmPDfuvm2Dkf+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715274999; c=relaxed/simple;
	bh=973lRpNkD5J9l+d336n7NUlE/nZ9DF8NwU/k6a2Ez3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ogg3w4UjP5bY8WJtQvCpC6ViruWavRxEWOlZjHLxxUan2kP1QICjap6bawTwLkCQ8VHu97grF3aAojOYxN/9khTR0SxH06XURF6LdiAc5Xhdl8GxQ3FRMp2iG4fAdGQ9mNu1B4LAID03Scs3UTQvP2VeAa9IJdSnoKISZV3ELO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXcSLdt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83522C116B1;
	Thu,  9 May 2024 17:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715274999;
	bh=973lRpNkD5J9l+d336n7NUlE/nZ9DF8NwU/k6a2Ez3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oXcSLdt7LvEnsnJJoeHM78dSo0hKxgKPKHlcqoeiz0V6zkXKHRgd+lZCnw0Z+LFBj
	 cP8h05WwELK4HxoFYC9Y2RxvQmSiH1MCzJIU6jMzN9D59llt5Qg9IXW1L8OVl8u/9J
	 2J5IiUGjD/at+lYV2DQqPOvFgnqvPXBplQ686rUJNr7CVkneOc4cmgNhLwu6Htboto
	 5WmmPzCa/g8XKMEyVRHPYtlBNyWNA1/MLeMgXl41G0pbsEslJ30RFeVCdaeO7P/uHq
	 wPg4UlGIz5lHzRDqokPJvnUtQtI4pIhAJf8fid0kKNriY6se9IAB554he7KSc+/fzs
	 qEHodZz5WgArQ==
Date: Thu, 9 May 2024 18:16:34 +0100
From: Conor Dooley <conor@kernel.org>
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
	dianders@chromium.org, linus.walleij@linaro.org,
	krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
	conor+dt@kernel.org, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xuxinxiong@huaqin.corp-partner.google.com
Subject: Re: [PATCH v5 1/7] dt-bindings: display: panel: Add himax hx83102
 panel bindings
Message-ID: <20240509-regretful-trombone-42ed9d7a3817@spud>
References: <20240509015207.3271370-1-yangcong5@huaqin.corp-partner.google.com>
 <20240509015207.3271370-2-yangcong5@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ncHccA2eRd27cZCy"
Content-Disposition: inline
In-Reply-To: <20240509015207.3271370-2-yangcong5@huaqin.corp-partner.google.com>


--ncHccA2eRd27cZCy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 09:52:01AM +0800, Cong Yang wrote:
> In V1, discussed with Doug and Linus [1], we need break out as separate
> driver for the himax83102-j02 controller. Beacuse "starry,himax83102-j02"
> and in this series "BOE nv110wum-l60" "IVO t109nw41" panels use same
> controller, they have some common CMDS. So add new documentation for
> this panels.
>=20
> For himax83102-j02 controller, no need 3v3 supply, so remove it.
>=20
> [1]: https://lore.kernel.org/all/CACRpkdbzYZAS0=3DzBQJUC4CB2wj4s1h6n6aSAZ=
QvdMV95r3zRUw@mail.gmail.com
>=20
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--ncHccA2eRd27cZCy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZj0E8gAKCRB4tDGHoIJi
0g5CAQDdF++R3wBg5Amvd/uInS7O/p6gOkr7yA9Poj2KRSaGWwEA1n7FZs3H0ZeE
NJTFuluFnC5smgyw1ffLSVO+JzeBoA0=
=8+Bx
-----END PGP SIGNATURE-----

--ncHccA2eRd27cZCy--

