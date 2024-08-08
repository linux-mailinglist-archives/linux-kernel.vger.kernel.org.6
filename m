Return-Path: <linux-kernel+bounces-279807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E780B94C214
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945C21F2894E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB5318B489;
	Thu,  8 Aug 2024 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quvZyxoq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A535418CC0C;
	Thu,  8 Aug 2024 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132518; cv=none; b=Utp2xP+O5h1QpK/WWZTtqN2wm8Jhl7n0vP22NqngJGQcJ/Kz2PzHoYOyHOIejwuJ8MCrlh91YSJoY3/wEhBIxnUAjU53EtzASo6rpIIf/XkHS/0rup2L1qsBp+f0oqgfDZDYp0fRTH2KfXkymYDIEg08SM6lCrg/hSSo2imEq7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132518; c=relaxed/simple;
	bh=vEzY4C6mfTs2TFhQiIQT2GbsCRXnBiJuK+ehBtym/eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mz7zCpX0tpKPgZ2uzPSC2Nbicr4OJO2xqQCMMPwmAaDGcZGq3rlIDMhqgJRkEZxB/li9bnmNfx0KnLTbfPmn9WYyqSlqF//wJ0tocekeUqYAqN6wK7UCpZ/j5YTtKQEHKcty5HLwNrTSwzatGKf1c8qYynVPkYuE3q8VKVtnU3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quvZyxoq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F1DC32782;
	Thu,  8 Aug 2024 15:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723132518;
	bh=vEzY4C6mfTs2TFhQiIQT2GbsCRXnBiJuK+ehBtym/eM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=quvZyxoqosQ7vYc9F+w9yQtxhcLXk1oLpov53MqiZT+ELJixY4qSmgwrMGKhKg8nR
	 f2io3sgdUP9B98BCaO/Td8zOFsp4vk7JcyqTj85IWFYq0lGWlPsb2yK4VrF99DE9K+
	 koQPIpfA5iPU7mHzZEVyauLZ+F/+dn9a5vbvrP5GCK+91FFDeeW/cxBw65iv356xti
	 17ZSas5gjbF0CSIHqsytDlG5VDFT6gZ1ZwR6EpnehaBwndjZ/5eT234EQZ0nBeBbOB
	 5Oe+UdLfHSLRnIrXom0KYiE9FEriusJjrbRPmLTqK9yuVUR5iCJXCx1iI2Q2rf+7I0
	 3vg6CamLy1YiA==
Date: Thu, 8 Aug 2024 16:55:14 +0100
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
Message-ID: <20240808-linoleum-evasion-ad7111a2afc4@spud>
References: <20240808153120.3305203-1-Frank.Li@nxp.com>
 <20240808-frosted-voicing-883f4f728527@spud>
 <ZrTphsdTZVsbiGo/@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iF4455zFqFQ3CKov"
Content-Disposition: inline
In-Reply-To: <ZrTphsdTZVsbiGo/@lizhi-Precision-Tower-5810>


--iF4455zFqFQ3CKov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2024 at 11:51:34AM -0400, Frank Li wrote:
> On Thu, Aug 08, 2024 at 04:34:32PM +0100, Conor Dooley wrote:
> > On Thu, Aug 08, 2024 at 11:31:20AM -0400, Frank Li wrote:
> > > The mass production lx2160 rev2 use designware PCIe Controller. Old R=
ev1
> > > which use mobivel PCIe controller was not supported. Although uboot
> > > fixup can change compatible string fsl,lx2160a-pcie to fsl,ls2088a-pc=
ie
> > > since 2019, it is quite confused and should correctly reflect hardware
> > > status in fsl-lx2160a.dtsi.
> >
> > This does not begin to explain why removing the soc-specific compatible,
> > and instead putting the compatible for another soc is the right fix.
> > Come up with a new compatible for this device, that perhaps falls back
> > to the ls2088a, but this change doesn't seem right to me.
>=20
> It can't fallback to fsl,ls2088a-pcie if fsl,lx2160a-pcie exist, which are
> totally imcompatible between fsl,ls2088a-pcie and fsl,lx2160a-pcie.
>=20
> Previous dtb can work just because uboot dynamtic change fsl,lx2160a-pcie
> to fsl,ls2088a-pcie when boot kernel.
>=20
> fsl,lx2160a-pcie should be removed because Rev1 have not mass productione=
d.

Please re-read what I wrote. I said to come up with a new compatible for
this device, not fall back from the existing fsl,lx2160a-pcie to
fsl,ls2088a-pcie.

Thanks,
Conor.

--iF4455zFqFQ3CKov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrTqYgAKCRB4tDGHoIJi
0oKoAPwOlkVSMPKo4T7m7wer8pIHsbwifYEUcKJ8UxsVCdBU2gEAhNy5yupcBVO7
VUD6MOFw7a357c6cRPw6F/FAz+JfWg4=
=Xu7U
-----END PGP SIGNATURE-----

--iF4455zFqFQ3CKov--

