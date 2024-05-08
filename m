Return-Path: <linux-kernel+bounces-173541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE948C01F6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D87AB21E05
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395FC12AAD1;
	Wed,  8 May 2024 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GENxTopR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D7C129E80;
	Wed,  8 May 2024 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715185688; cv=none; b=q6jnd5NcefYsyfOWu/syA67FHRjqBntEqX4a+4KiIb5qOmiEkKYn+MGn2zDc8mYuaMCt1oQ6AI4n4nBPWVf8JAyZU+0Gf8VWG+Qn1wIjCSKrY8aQPJ8OqVxVOMV3ZaVvCuCFdUReC/m8nADOP+WLrqCLorMiHGrjGp+v1/h3UQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715185688; c=relaxed/simple;
	bh=UYa9nQFbXFsPXVOkMa9L+1nCg7GuO4KyEPe7MnFS6Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gr8dRkBMblHRLwtjeRh6wLDDiiy68Sivf+4Fd4gtzG5DJ27FdxlOOl5LwvJO5ZbdyUyhbsS6yWcFzrkCAsBWj2ghlbHQnAhBc849hLUhCAnIKXb4XDrn85JyxESxL5q/0Xs88CaOxloPXlQz0N0g2p/+Q7T2G6+zJuO9LLceFjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GENxTopR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4B5C2BD11;
	Wed,  8 May 2024 16:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715185688;
	bh=UYa9nQFbXFsPXVOkMa9L+1nCg7GuO4KyEPe7MnFS6Gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GENxTopRekGLP/hpvKlsVPa/uM3UMefaKagfqUrxUv1AgSMFQrYTZ65RRMZiGt0bz
	 AnRMB47LJwr6GbmCWt7RMWoP9Mk+vuS5sdsdjenp9iCf5HtcxE3z8q+8cUtjTc27xu
	 Yx78/lzsuitziWFznkN8LKwJNUZ5DrmShAwGO1HAAf9cdGurgmG15c3HxSUVrUeBxM
	 i3LXC7vm/6ZQ/GVCn1qJ+2oZgQMRO99r/oYkBgYDJ7o30hcKbGy/weZ5jR3ShQlNd7
	 P3hAr+P3O81+lANvBLv7MuYKTeso51NDVU5o9M+UkfFcqUykBJNuscY2S0c7cVF9iE
	 9F5gZ+Bzx6/Xg==
Date: Wed, 8 May 2024 17:28:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel-janitors@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v5 2/2] arm64: dts: rockchip: Add Radxa ZERO 3W/3E
Message-ID: <20240508-blaming-kinfolk-7a0cf7f9a7c0@spud>
References: <20240508070611.4153602-3-jonas@kwiboo.se>
 <662d3052-d0ab-4034-84d3-fff4f985875b@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p7P9ZT5PsCFLYhGM"
Content-Disposition: inline
In-Reply-To: <662d3052-d0ab-4034-84d3-fff4f985875b@web.de>


--p7P9ZT5PsCFLYhGM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2024 at 12:22:52PM +0200, Markus Elfring wrote:
> =E2=80=A6
> > This adds initial support for =E2=80=A6
>=20
> Please convert this change description to an imperative wording.

I think that sending a new version for s/This adds/Add/ would be a
complete waste of developer time.

--p7P9ZT5PsCFLYhGM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjuoEwAKCRB4tDGHoIJi
0s48APwMPgOmyAXUppUMok08TEEu0Pz4L/HNda6y7HTL5uyrmAEAlCipL3IL9oOH
3dCsFvC7ldVF8jBqCdFSEl+5pu5BgQE=
=6FNx
-----END PGP SIGNATURE-----

--p7P9ZT5PsCFLYhGM--

