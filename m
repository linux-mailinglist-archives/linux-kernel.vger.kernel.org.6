Return-Path: <linux-kernel+bounces-288122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCE19535E3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DEF0281FB9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EAE1AC43B;
	Thu, 15 Aug 2024 14:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEAB2bn5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902F41A2570;
	Thu, 15 Aug 2024 14:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732925; cv=none; b=OBaX9VzF/z34F04OOGXB6MBLwc2NcP/l0shPKwf87Ci8DchWZx33vWUAJKc18QcxNvwgvJXtbIQNEtpEUGCRdCaG+4hXSseb6y7+y4jZ1kzZyF93RnH90u9OVnSdNt6PEn3kzNLkS3a8E1E98HbamlQ0M8l++joQynQu41j/z6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732925; c=relaxed/simple;
	bh=M40/005yIp6PCsxxKStq9i/vMz5yXRGyPImHwfgRiyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngdOLL7p9Pt2K9xjn0eEvnaosRzcHKy4zmY4KTPglX9YTM9q+6flb3Rl5QYI0trPtniS0BTgfgJdvlg9ReeXs6enRTnOwl+JGC5w5+mHG9JZUK9SOZsWh7GyopQkw7E3LSg5pQvYaip3aJOaWcQcwHdckvjYCXVHhsVdpvrTQi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEAB2bn5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93ABC32786;
	Thu, 15 Aug 2024 14:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723732925;
	bh=M40/005yIp6PCsxxKStq9i/vMz5yXRGyPImHwfgRiyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VEAB2bn5hNHq7njuWlDTwBaBdfm593hUm+7dAlHYT1OXAgZo5F5FwZQGGvCvXRcXH
	 Ix+EVn36nGzdPtpoGHDBmxWfsDGB9R00F1NtpKo4KUZ9xEVMEVhVdT0rd0s/JGskIz
	 kRvbs7GY5572G1kVn+7t23D+XoNj7g+exF5MT9GlnanqdVJX1MhOVfjO+Q4Ugd2B0e
	 sicrwqsWDLXwTCTJPcY0xgvtcgPYed8xFYfaCRxFaNN9icRjFy6/FNsFVZVrZcEa5a
	 SPO8jgsVrwOzqHhwrvhd7IIJ1xngfd5kKoV01ssLmo63DyCnmulPArf46eD/FZxn/9
	 JdARv89eYqdMg==
Date: Thu, 15 Aug 2024 15:42:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Jan Kiszka <jan.kiszka@siemens.com>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjIgMS8z?= =?utf-8?Q?=5D?=
 dt-bindings: phy: jh7110-usb-phy: Add sys-syscon property
Message-ID: <20240815-endless-credible-324438d164f4@spud>
References: <cover.1723472153.git.jan.kiszka@siemens.com>
 <30f3ca9f6bd788e16767b36aa22c0e9dc4d1c6a4.1723472153.git.jan.kiszka@siemens.com>
 <20240812-overstuff-skirt-7a8aabbcdc6f@spud>
 <8cdba8b0-7364-4c09-b18a-f3f59da1eae2@siemens.com>
 <20240813-haiku-pusher-f2fb037a2f49@wendy>
 <SHXPR01MB08633B523DA1F6C5632F6D9DE6802@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y6obAq/LA5e3r0dd"
Content-Disposition: inline
In-Reply-To: <SHXPR01MB08633B523DA1F6C5632F6D9DE6802@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>


--Y6obAq/LA5e3r0dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 10:33:55AM +0000, Minda Chen wrote:
>=20
>=20
> >=20
> > On Tue, Aug 13, 2024 at 07:31:50AM +0200, Jan Kiszka wrote:
> > > On 12.08.24 17:55, Conor Dooley wrote:
> > > > On Mon, Aug 12, 2024 at 04:15:51PM +0200, Jan Kiszka wrote:
> > > >> From: Jan Kiszka <jan.kiszka@siemens.com>
> > > >>
> > > >> Analogously to the PCI PHY, access to sys_syscon is needed to
> > > >> connect the USB PHY to its controller.
> > > >>
> > > >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > > >> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > > >> ---
> > > >> CC: Rob Herring <robh@kernel.org>
> > > >> CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> > > >> CC: Conor Dooley <conor+dt@kernel.org>
> > > >> ---
> > > >>  .../bindings/phy/starfive,jh7110-usb-phy.yaml         | 11
> > +++++++++++
> > > >>  1 file changed, 11 insertions(+)
> > > >>
> > > >> diff --git
> > > >> a/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yam
> > > >> l
> > > >> b/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yam
> > > >> l index 269e9f9f12b6..eaf0050c6f17 100644
> > > >> ---
> > > >> a/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yam
> > > >> l
> > > >> +++ b/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy
> > > >> +++ .yaml
> > > >> @@ -19,6 +19,16 @@ properties:
> > > >>    "#phy-cells":
> > > >>      const: 0
> > > >>
> > > >> +  starfive,sys-syscon:
> > > >> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > >> +    items:
> > > >> +      - items:
> > > >> +          - description: phandle to System Register Controller
> > sys_syscon node.
> > > >> +          - description: PHY connect offset of
> > SYS_SYSCONSAIF__SYSCFG register for USB PHY.
> > > >
> > > > Why is having a new property for this required? The devicetree only
> > > > has a single usb phy, so isn't it sufficient to look up the syscon
> > > > by compatible, rather than via phandle + offset?
> > > >
> > >
> > > I didn't design this, I just copied it from
> > > starfive,jh7110-pcie-phy.yaml. As that already exists, I'm neither
> > > sure we want to change that anymore nor deviate in the pattern here.
> >=20
> > To be honest, I think some of the other users of phandle + offset on th=
is soc were
> > just copy-pasted without thinking about whether or not they were requir=
ed too.
> > This one seems like it should just be a lookup by compatible in the dri=
ver instead
> > of by phandle. As a bonus, it will work with existing devicetrees - whe=
reas your
> > current implementation will fail to probe on systems that have the old
> > devicetree, a regression for systems running with that devicetree and
> > downstream firmware.
> >=20
> > Cheers,
> > Conor.
> >=20
> Hi Conor
> I know you would like to put the offset value to the code, Just set sysco=
n in dts.
> Just like pcie-starfive.c. right?

No, not quite. That still uses a phandle lookup, I was talking about
using syscon_regmap_lookup_by_compatible().

--Y6obAq/LA5e3r0dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZr4TuAAKCRB4tDGHoIJi
0sIFAQC/JyXvK+VLgbIRFzTwOSJvSzC4aJueRc46G1g/t0SWQAEAsiQzJzNWfk3E
4/t1gvtNHk8K7qm6C0l8crJVrI7AsAY=
=JWz8
-----END PGP SIGNATURE-----

--Y6obAq/LA5e3r0dd--

