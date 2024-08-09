Return-Path: <linux-kernel+bounces-281088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6809E94D2ED
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC6BAB2141C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225A1197A97;
	Fri,  9 Aug 2024 15:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+ZMHH7/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6184A155A25;
	Fri,  9 Aug 2024 15:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216050; cv=none; b=V5lEzdzHtzjcPQTB0+fvMwBIL7QroujDoF31DRq7R7ANmIRUnBwZI805792raHVMy6DtcMsWIGxMjGgbHkGqHqg1bjJeNQO28bzwJFRKhhoJzkxdTsCxT0jHvoKnwzhvOaEHEKYj4WLI8ARV70CYhi0DuPXsaccTHQuvKUrH9Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216050; c=relaxed/simple;
	bh=jZLAqxbDw1Q7Bre45+Qasn0USRspIPfzQt7t2DwZdu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocA7+1tOOLnWG9ZHI5xBH6LKNkdl+2+mRYGG8N33F9bTilcvUDxaAJIyeaVJL+odd52QzS6v1EnNv4ny7VvcdprEw9B5LrjEHQ7VpmGuBtZzDAFvRQl/zM8k+m+hl0w6O9Lg8sXf6Fflbzfu+9ql/sCbIE7li3A3FkqIlvHYBkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+ZMHH7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003D0C32782;
	Fri,  9 Aug 2024 15:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723216049;
	bh=jZLAqxbDw1Q7Bre45+Qasn0USRspIPfzQt7t2DwZdu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C+ZMHH7/Ky1jYRed3dGXymjDrDX1nSAuHkGWFTYxh5gmyk79O5BJBjfjHL5eh9nHm
	 dMQ32ZSffgri8/8+zEESezP94mOfiLlZL7P6tb2NkAEsgnXNyQfson7LP7ySmLq5KD
	 Kk02AvfO4JDT0409ElPGc6nmdlbWu1ppM6Q1NHbAZ2qj3JMUM5D6Ua4fjHbJOUa8q7
	 ONmUwcTkttL9h8y1Nm9SUGhhpbcfCybvsTVJue5w5Y+eSzOch0Ai2k+KthpRELhbdA
	 ylcPTr0dQdtTmWpnVDmMB9CjK6hiCgZZuBlJNt1gaCTNiN0yT9G2St5BOclCguuRaq
	 ZlbCIdrE8tQeA==
Date: Fri, 9 Aug 2024 16:07:25 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] arm64: dts: lx2160a: Change PCIe compatible string
 to fsl,ls2088a-pcie
Message-ID: <20240809-freewill-compactor-4f441a4a60bb@spud>
References: <20240808153120.3305203-1-Frank.Li@nxp.com>
 <20240808-frosted-voicing-883f4f728527@spud>
 <ZrTphsdTZVsbiGo/@lizhi-Precision-Tower-5810>
 <20240808-linoleum-evasion-ad7111a2afc4@spud>
 <ZrTvB/3GGIhEOItT@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UqI6MOyeE0fEpu25"
Content-Disposition: inline
In-Reply-To: <ZrTvB/3GGIhEOItT@lizhi-Precision-Tower-5810>


--UqI6MOyeE0fEpu25
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2024 at 12:15:03PM -0400, Frank Li wrote:
> On Thu, Aug 08, 2024 at 04:55:14PM +0100, Conor Dooley wrote:
> > On Thu, Aug 08, 2024 at 11:51:34AM -0400, Frank Li wrote:
> > > On Thu, Aug 08, 2024 at 04:34:32PM +0100, Conor Dooley wrote:
> > > > On Thu, Aug 08, 2024 at 11:31:20AM -0400, Frank Li wrote:
> > > > > The mass production lx2160 rev2 use designware PCIe Controller. O=
ld Rev1
> > > > > which use mobivel PCIe controller was not supported. Although ubo=
ot
> > > > > fixup can change compatible string fsl,lx2160a-pcie to fsl,ls2088=
a-pcie
> > > > > since 2019, it is quite confused and should correctly reflect har=
dware
> > > > > status in fsl-lx2160a.dtsi.
> > > >
> > > > This does not begin to explain why removing the soc-specific compat=
ible,
> > > > and instead putting the compatible for another soc is the right fix.
> > > > Come up with a new compatible for this device, that perhaps falls b=
ack
> > > > to the ls2088a, but this change doesn't seem right to me.
> > >
> > > It can't fallback to fsl,ls2088a-pcie if fsl,lx2160a-pcie exist, whic=
h are
> > > totally imcompatible between fsl,ls2088a-pcie and fsl,lx2160a-pcie.
> > >
> > > Previous dtb can work just because uboot dynamtic change fsl,lx2160a-=
pcie
> > > to fsl,ls2088a-pcie when boot kernel.
> > >
> > > fsl,lx2160a-pcie should be removed because Rev1 have not mass product=
ioned.
> >
> > Please re-read what I wrote. I said to come up with a new compatible for
> > this device, not fall back from the existing fsl,lx2160a-pcie to
> > fsl,ls2088a-pcie.
>=20
> According to my understand, It needn't add new compatible string if nothi=
ng
> difference. for example, it use fsl,vf610-i2c for all i2c without add
> new soc-specific fsl,lx2160-i2c.

No, you should have soc-specific compatibles regardless. Just because
you got away with it once, doesn't mean I'm not going to complain about
it here!

> So far lx2160a-pcie is the same as ls2088a-pcie.


--UqI6MOyeE0fEpu25
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrYwrQAKCRB4tDGHoIJi
0kFZAQDhZtW3Gh4EocWE0cDSarMnBHPDLutlvuYc7HAvPYLSJQD7BZstVgOrE24z
F/qic6aIukQGRBClY+6y9FD4k33rUgw=
=nqIL
-----END PGP SIGNATURE-----

--UqI6MOyeE0fEpu25--

