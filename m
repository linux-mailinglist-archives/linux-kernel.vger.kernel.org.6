Return-Path: <linux-kernel+bounces-279763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3305F94C18C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D082D1F285A2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C123D18F2EE;
	Thu,  8 Aug 2024 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoLCBfu3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BADB674;
	Thu,  8 Aug 2024 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131277; cv=none; b=MaU0a8hRce72kdlTxjYSVbKQRXzslmOO+FWHjwS32UZKyYWdQd9flHDFFHLyuvbPhw3qF9kATbwg0co58324WdhgczhzPFMhEI4tNynqOeU5N1eTWHgZV7A7xBpHh0IZGwUsl+Z8QYvqt2RTkIoDY15WS1px0ZQaArjEvDsGfvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131277; c=relaxed/simple;
	bh=lfhr7WtVDtGF7P2nNz7nZBOaYt7c3uJT9tXhXQQfIuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrVHKR7gpowv1YNa48TKww+na62VIzRK+uJ7sQo6Tkc/UUy8yYnToOkMFJ1+aVdqdff5Md7ow/m1dGO4TpRUxcbRYU702RWxKuR5iLmgOe2YZuBc3crZttuOFSxyA7kzjuQMfvt47IfQZ50yTCwMrykMQqGWqQ2+uVM95VahDJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoLCBfu3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F2CC32782;
	Thu,  8 Aug 2024 15:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723131276;
	bh=lfhr7WtVDtGF7P2nNz7nZBOaYt7c3uJT9tXhXQQfIuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OoLCBfu3Vo2PMPjiYEEIAbihIiOlIziT1E8wCAKvIHbDzGeh649pQcPATOKYIRyH5
	 amw9n8+kDDpg10YR+nDVcTjDk0aRBJFFJQotlFgAMJ2q+zIafHh1IZQwJjQCJxs+Or
	 tC0PBDevLZ0aPMiqZoCulnQauMZOkkwIiDMsd1d1Qwy6OvmJLPJGEyXQMC0ml+/u5s
	 KaLC/jb2DagRJJpTO9OtxQplxtsx9x1yIaRsXAtHlrRHubGleuw9AzH2vRzZm0LaMi
	 V2UmyR/KACkiS0ukrHPw/pcsf2dk7XIr1QlPUItUvDVujAKx1bDPKxwdIuwAr0bIuu
	 BHPvFcCZBURhQ==
Date: Thu, 8 Aug 2024 16:34:32 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] arm64: dts: lx2160a: Change PCIe compatible string
 to fsl,ls2088a-pcie
Message-ID: <20240808-frosted-voicing-883f4f728527@spud>
References: <20240808153120.3305203-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z7wJ4+2iQ06n8AeS"
Content-Disposition: inline
In-Reply-To: <20240808153120.3305203-1-Frank.Li@nxp.com>


--z7wJ4+2iQ06n8AeS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 08, 2024 at 11:31:20AM -0400, Frank Li wrote:
> The mass production lx2160 rev2 use designware PCIe Controller. Old Rev1
> which use mobivel PCIe controller was not supported. Although uboot
> fixup can change compatible string fsl,lx2160a-pcie to fsl,ls2088a-pcie
> since 2019, it is quite confused and should correctly reflect hardware
> status in fsl-lx2160a.dtsi.

This does not begin to explain why removing the soc-specific compatible,
and instead putting the compatible for another soc is the right fix.
Come up with a new compatible for this device, that perhaps falls back
to the ls2088a, but this change doesn't seem right to me.


Cheers,
Conor.

--z7wJ4+2iQ06n8AeS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrTliAAKCRB4tDGHoIJi
0gD2AQDAc7IRmpIMN0cHmSuC2YTspBgnCETEkRKCvS1rMGah4QEA3gjqEBizewkX
zguqttOBNgD5G3x7cpwvNLO3KFmCFQI=
=hpez
-----END PGP SIGNATURE-----

--z7wJ4+2iQ06n8AeS--

