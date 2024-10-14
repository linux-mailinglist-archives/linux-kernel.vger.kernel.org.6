Return-Path: <linux-kernel+bounces-364708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB8A99D839
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58280B21611
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5940E1CCB42;
	Mon, 14 Oct 2024 20:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBcUVaQn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D674C7C;
	Mon, 14 Oct 2024 20:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937873; cv=none; b=t8HwokQ7yE2CUW4AwZPPJaIDcQLzubUflEdxUq4wYNyTnDYRURRtMWQQnKTIpQRYL1epWJ0vREO4xwRbCv7E1UDtEVOO02Iukyvv16Dp3/dmtLaw6annH5r8Vllgkx9I4S4zAev2pjSIqVza5AijsRiUW+Z8zP/cfSYlZsJpJVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937873; c=relaxed/simple;
	bh=/519vrXSCEBrD8167XIHl1Q+dorXR1ZPGe+dQgXTbfc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8U3xIV+3ET+M3AWdAUvagcbNN+gw2meT/l85mKiKcycXFhDkk8hcgIkAh+UF7aNsRULzmhqaaEiDqWH/90dTx/ZRT3tQe7srIdF6FYtpPhgpB/fFW/lFmD+8I+HQF42KN7d0e9vny3tZo9pFSHszw48K1YxutFUI7OQtEt0wso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBcUVaQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16EAC4CEC3;
	Mon, 14 Oct 2024 20:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728937873;
	bh=/519vrXSCEBrD8167XIHl1Q+dorXR1ZPGe+dQgXTbfc=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=gBcUVaQnHhFUCe5WUEVgYCtrlI6M6a4O80Q7mJz7rcdfmE5/Y9G7vBFwQw+xP7q/9
	 72ferCcQ0dXgfgYy9nKixtl+b+opIuj+lMuIAw41KW427fJr0wNFLZC8mS2RTMiYEH
	 S/OLWWvBI5oQDz/XannhpYf1VvJ+IbBlfdVnbMhvSxvlT2txZyVCe934sIWrHhhnGj
	 y/TQf8jm4UIlBxOGxXAx38KZlScBZlAuZQSFsulAeZEFaMoSTw35whA/clFMGxaaWx
	 x52SEQucqS4W1J0OmxADkMtH/R2GbjZVIMRvyBm8EUXsx4+MVoHT+aQN1O4LUOkaKQ
	 90PE0zwzzgxAg==
Date: Mon, 14 Oct 2024 21:31:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jack Zhu <jack.zhu@starfivetech.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	E Shattow <lucent@gmail.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbdjM=?= =?utf-8?Q?=5D?= riscv: dts:
 starfive: jh7110: Add camera subsystem nodes
Message-ID: <20241014-roamer-cinnamon-1e100b485052@spud>
References: <ZQ0PR01MB13026F78B2580376095AF7E7F2442@ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn>
 <Zw1-vcN4CoVkfLjU@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Bjrafg8s2P5yt9cp"
Content-Disposition: inline
In-Reply-To: <Zw1-vcN4CoVkfLjU@aurel32.net>


--Bjrafg8s2P5yt9cp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 10:27:41PM +0200, Aurelien Jarno wrote:
> Hi,
>=20
> On 2024-10-14 01:08, Changhuang Liang wrote:
> > Hi, Aurelien
> >=20
> > >=20
> > > Hi,
> > >=20
> > > On 2024-02-18 19:27, Changhuang Liang wrote:
> > > > Add camera subsystem nodes for the StarFive JH7110 SoC. They contain
> > > > the dphy-rx, csi2rx, camss nodes.
> > > >
> > > > Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> > > > ---
> > > >  .../jh7110-starfive-visionfive-2.dtsi         | 49 ++++++++++++++
> > > >  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 67
> > > +++++++++++++++++++
> > > >  2 files changed, 116 insertions(+)
> > >=20
> > > We have been asked to enable CONFIG_VIDEO_STARFIVE_CAMSS in the
> > > Debian kernel, which from my understanding and given the device tree =
shown
> > > below also requires enabling CONFIG_VIDEO_CADENCE_CSI2RX. That said
> > > doing so triggers the following error in dmesg:
> > >=20
> > > [   25.143282] cdns-csi2rx 19800000.csi: probe with driver cdns-csi2rx
> > > failed with error -22
> > >=20
> > > From a quick look it seems there is something in the port@0 csi2rx en=
try. Do
> > > you happen to know what is wrong?
> > >=20
> >=20
> > You need to add your sensor node. You can refer to this patch:
> > https://patchwork.kernel.org/project/linux-riscv/patch/20240119100639.8=
4029-3-changhuang.liang@starfivetech.com/
> >=20
> > We suggest that using the imx219
>=20
> Thanks for your answer. I do not have any sensor attached, the goal is
> to build a generic kernel, and people can use overlays or patch their
> device tree to add support for additional devices.
>=20
> In that regard, I have the impression that csi2rx device (and maybe the
> camss device?) should not be marked as enabled in the default device
> tree. I think they could be enabled by users as part of the change need
> to add the sensor node.

Yeah, that's probably what should've been done when the imx219 node was
removed. Feel free to send a patch with a Fixes: tag for that removal
and a cc: stable on it - otherwise I'll send one out tomorrow or w/e.

--Bjrafg8s2P5yt9cp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZw1/jQAKCRB4tDGHoIJi
0q8FAQDgeLWFLXi0q6X4bNcfHbUpz10qI/NjWDXGcvylrBjMCgEA7y/5Vki87xQ+
/7MuPhrTacNGUSIwcbhKT8B2yd/OnQg=
=AKJE
-----END PGP SIGNATURE-----

--Bjrafg8s2P5yt9cp--

