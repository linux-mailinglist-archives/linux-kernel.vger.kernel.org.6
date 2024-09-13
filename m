Return-Path: <linux-kernel+bounces-328720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B5D9787C6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EFDF285383
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5798E1369BC;
	Fri, 13 Sep 2024 18:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHuShvTa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48761EEE0;
	Fri, 13 Sep 2024 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726251884; cv=none; b=DgwAh9VpLMXRbdnN1+lUlTghlbGWWFbz3OC48zPAu/GU0PTmiyKRL5/Z0jadGFAGZUrSBRBS+yuTNeR8z+E1L9HPNax2sSTqzoYOwsUJvkQCBO2At0Fnpf4O8lEVd1KrkOZKomTdidanwntANFCsMx1BHygZhjrbVRiHf7N3TLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726251884; c=relaxed/simple;
	bh=iNlKwKpdp2ZsLozJYZ5+b//iKVeh2WfBLezgaI4UM7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0sYuy3DyiqdfY48JOZooNz+9aiGXtwpET7eM3+r0HXbTmeBR1AkA5WFi2KWkqZ5ejVlr+4M91YOwQCjIl1Yg13uOAj/aCgkRS/ov/j4uUh4C0E2XAzU+vY4e517i70zu+kdEJutuJpRvLl0wfJ721Hk+81Cd6ZCJAe0TzTHvls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHuShvTa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613EAC4CEC0;
	Fri, 13 Sep 2024 18:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726251884;
	bh=iNlKwKpdp2ZsLozJYZ5+b//iKVeh2WfBLezgaI4UM7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LHuShvTaDCz+nyy+cYZsSfLfat4WUzaHx69+RG+R0C1T/aCHHa8jhhdA9gHhTKrRJ
	 y5FTrUnowQkYSslrWiN9339L9ZLgLSeiZ5kIAqmIG0ndhwJgm4xUykvavx7xMBZGGs
	 wsNw9upMvoejwWM5VAOG8CPrdwuBwGy3W0vmGRyTJAUiB4gsnzXwwEQc+P6ayS+IBy
	 ZRXuD8zmE1p1GBJBsopYpLVtD+twRNkbdEdjQx1EW8hiwE87+YfiYTphh3noFE8GS2
	 E3asI79XPDTRkP+iv2tZR/becuEO7sa/zEIhfp5fSJI94JNpRXSCG9pnX29H34KOHG
	 KL52BWYfQWhDQ==
Date: Fri, 13 Sep 2024 19:24:40 +0100
From: Conor Dooley <conor@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 1/2] dt-bindings: phy: bcm-ns-usb2-phy: drop deprecated
 variant
Message-ID: <20240913-spiritual-sneeze-7c48a16d2700@spud>
References: <20240913044557.28315-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R27qjzCqPLhq9VAn"
Content-Disposition: inline
In-Reply-To: <20240913044557.28315-1-zajec5@gmail.com>


--R27qjzCqPLhq9VAn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 06:45:56AM +0200, Rafa=C5=82 Mi=C5=82ecki wrote:
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> The old binding variant (the one covering whole DMU block) was
> deprecated 3 years ago. Linux kernel was warning when using it for
> similar amount of time.
>=20
> There aren't any known Northstar devices with bootloader providing DT to
> operating system. Actually OpenWrt seems to be the only project using
> this binding and it always appends DTB to kernel. It has switched to the
> non-deprecated binding years ago.
>=20
> Given there is close to zero chance this breaks anyone's setup it should
> more than safe to drop this binding variant after 3 years.

I love a commit message like this.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--R27qjzCqPLhq9VAn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuSDaAAKCRB4tDGHoIJi
0k0YAP92wBmfRtY6iNbU8/6oouu4H1tJlPi0OczQX+aAQXy8CAD/fHQlTonufz8q
mRYlzKrkS/rh1bP/4IdYt2TOYdqF4wg=
=/aR8
-----END PGP SIGNATURE-----

--R27qjzCqPLhq9VAn--

