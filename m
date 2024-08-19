Return-Path: <linux-kernel+bounces-292776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1986957432
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F451C2286E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41731D6DBB;
	Mon, 19 Aug 2024 19:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmYXRELR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A485156861;
	Mon, 19 Aug 2024 19:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724094712; cv=none; b=XGAdHk2OAIRGOcQ9zpCy4CY5n8SxU+lGaq/uvliZWIiBcONZn9IrwldbcxCDvf3osINAD/dVY/5Rz8thKIyXrernjKLa6cuxaUhMJsFa9z/uHnzsKwz8vFZRWaf/oeNYu29Jl+NhRWQBFeNtJkwI2YLoSFJMaeZHYTZFXM44SiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724094712; c=relaxed/simple;
	bh=1zt/Bh4mE2qUb7G97JJ5w51Zd0bpT2uum99d1MEx5ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1Lpw8YSs/nSEz3d+3BvaXE2HQ6EPlMvtL0nw3rpWtJ7z1/70rKxKeM2vDJyYfjUzUZM+hmRww8HO7PmNYaoUixswfk9ciheEYiF3Tx4kraRWtd0jq1NQbtOqqsVYV+jOJasODuB5tg86h84zPfdAOgThbKTx4z3cnAG2TLiiJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmYXRELR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5590DC32782;
	Mon, 19 Aug 2024 19:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724094711;
	bh=1zt/Bh4mE2qUb7G97JJ5w51Zd0bpT2uum99d1MEx5ZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gmYXRELRE2hZZFSniOB3CgBUfNvqbr88VZSCXDCy31CVWx8HAkUugpwX4kkko8wNs
	 Gn0vq8D9QyTMGPjrmaSWbaaaNlyfDAPhEyvVVNTAm19SX53Yk1/F/OlPFPxEoSSJi+
	 Gi8JpIv/+7nUyv68s73S44tUr3XBpQVsn5+wqlTW7lPVkSvsejnvTw3I1NwjZxPKEO
	 bs/zGzl4BDRn4/tHsTX+xBRk3GXDVNBn0bfUVBTOG+tyTNO151wx/SU/18bszcpyaH
	 Aorrs9pejxWVp20RhrIvvHYwZGDzDEP/3IaU+03ug5/7Rw78N3d8y6XQ1tqs8jnPI9
	 X6ze7s211alqg==
Date: Mon, 19 Aug 2024 20:11:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	"open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: hwmon/regulator: Convert ltc2978.txt
 to yaml
Message-ID: <bea0d3be-6b2a-41a7-8644-44b17d3a26dc@sirena.org.uk>
References: <20240819190652.373222-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V96bX+YleADfP3J8"
Content-Disposition: inline
In-Reply-To: <20240819190652.373222-1-Frank.Li@nxp.com>
X-Cookie: Interchangeable parts won't.


--V96bX+YleADfP3J8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 19, 2024 at 03:06:51PM -0400, Frank Li wrote:

> change from v1 to v2
> - maintainer change to Mark Brown <broonie@kernel.org> (regulator maintainer)

I also shouldn't be the maintainer for this specific binding, it should
be someone with knowledge of the devices.  This is a requirement imposed
by the DT people, I'd be happy to just not list a specific maintainer.

--V96bX+YleADfP3J8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbDmPEACgkQJNaLcl1U
h9BNrAf/dSKG3cX4kMQOuSrliVdWt38WGwtMIJAl7flz7pW82TdD6DjeU/qGPKt6
f3eZ5CW+feXtGCDQXH8TBDFLSUQBqRmPS+SDGTs6LpqysE8CkCEHfo4bg7Y9NHED
3VyFGVe3Qx+4EIssltZO+QbDb4eN0qkR/pR/Vq/3pAmKSijLfcTO9s4kCQzlIRq/
meaz4pvJFD5bdgVBLG/4vUDslSu/LaNWJNj9PkUDw7xMOj+55nP9gqeNbu1VVgyN
O17/lmLJZBXtlGPoRu8IQfF3Clcaxjk0ViYDJkDtyy96mCbxSi6JAGVsF6a3c1eb
xKKdaY0hFys2/OPaGlMwukLnjhGLUw==
=MLIg
-----END PGP SIGNATURE-----

--V96bX+YleADfP3J8--

