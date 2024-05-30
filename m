Return-Path: <linux-kernel+bounces-195679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B00438D5031
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 18:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2651A1F22A7C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DB73D579;
	Thu, 30 May 2024 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6WZuwUB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0703B182;
	Thu, 30 May 2024 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717088065; cv=none; b=n+VPo7K/1sjq47m0ZvKLBrAsrvUGAJ69o6K2A9dPYoy22VLAXH8WXGzyZToXXRm1kscofCVv9fqjZfwh0FZtcVOQf/J1s0sOGmHnieHBtVTpL1caetUXJT/WvaEpY4W7z1iyk7LRUXvWuAkBvrzlhZDtTytGuePJAp+2IlJfNJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717088065; c=relaxed/simple;
	bh=E5MKtDqiXmKTf9aJZSweZq65rqd15dQTCuccwlI45EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijJAaQ2WeeS9mVriQ3rVCYXgHUpHAwAA2e57VBzTX9RGkx2q39NmU0CPBYC83lf+MMohD8+A3QybYDA3ghJijfaunBTAuvG9Aqk1oppn+YjkhkfPwVq2XRvVzqsgL0j3wsGPjXoucbKI9G9zA7ELr17Zeouz0tmTXzJr3BvE7nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6WZuwUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A02C2BBFC;
	Thu, 30 May 2024 16:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717088064;
	bh=E5MKtDqiXmKTf9aJZSweZq65rqd15dQTCuccwlI45EI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G6WZuwUBsOOdjfFQu2N1EPnWhJqARXMW7YuRVOp+wRcJbzp9ygGh9yZca5ASlGrxZ
	 P+4B7NuKO8+t+vwqfShH6ooixWYAZrC0HvCNAGbcZcV7PgUqmDi0v+mScwlHkXRBrQ
	 MHBxQFdOw6+0mQkxaviTLvTdru6D3sIryVnRTF5+g9X0Lj5X5eA3vhWw9mZH/dP4He
	 SG3OyRxiy+GZXuPsquJGiUHDk7xCO9XYnWWD8OoGOcAMfA41E5HdWRZl8SjJMaoCjT
	 UOPQZhMvzQ9TWo7Ei31tvBw1Q4HignZD+k3U3FHbjpUdoGv7WRncOqZorihqL3pd3T
	 2ywFS+jVZFl6g==
Date: Thu, 30 May 2024 17:54:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: rename gw7905 to gw75xx
Message-ID: <20240530-powwow-outpour-ca48b1f22a3e@spud>
References: <20240522215043.3747651-1-tharvey@gateworks.com>
 <07250029-7cea-4a82-9e70-22e0e6f7fb37@linaro.org>
 <20240523-vividly-sequester-d85ac7bccbbd@spud>
 <CAJ+vNU3fQt=6t3a_QFU_3jb5mTVLGJiptPnGEmWvvXZYGEPOFQ@mail.gmail.com>
 <20240524-cavalier-outthink-51805f49c8fb@spud>
 <8007abef-38bb-4d7d-a453-00bb5e6bede5@linaro.org>
 <CAJ+vNU3Rh6f-HrFbBLxNXVP1PwsGh8OyGmmGJBv6+GRwZaTXgw@mail.gmail.com>
 <20240528155808.GA695520-robh@kernel.org>
 <CAJ+vNU225kyG7+AmXU8MTDArj8_6ibD-DkogXg89YpWS57ai=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="muWFwkv8BWQta2Re"
Content-Disposition: inline
In-Reply-To: <CAJ+vNU225kyG7+AmXU8MTDArj8_6ibD-DkogXg89YpWS57ai=g@mail.gmail.com>


--muWFwkv8BWQta2Re
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 09:23:10AM -0700, Tim Harvey wrote:
> On Tue, May 28, 2024 at 8:58=E2=80=AFAM Rob Herring <robh@kernel.org> wro=
te:
> >
> > On Sat, May 25, 2024 at 12:58:18PM -0700, Tim Harvey wrote:
> > > On Sat, May 25, 2024 at 11:34=E2=80=AFAM Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> wrote:
> > > >
> > > > On 24/05/2024 20:40, Conor Dooley wrote:
> > > > > On Thu, May 23, 2024 at 04:04:50PM -0700, Tim Harvey wrote:
> > > > >> On Thu, May 23, 2024 at 7:47=E2=80=AFAM Conor Dooley <conor@kern=
el.org> wrote:
> > > > >>>
> > > > >>> On Thu, May 23, 2024 at 09:02:46AM +0200, Krzysztof Kozlowski w=
rote:
> > > > >>>> On 22/05/2024 23:50, Tim Harvey wrote:
> > > > >>>>> The GW7905 was renamed to GW7500 before production release.
> > > > >>>>>
> > > > >>>>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > > >>>>> ---
> > > > >>>>>  Documentation/devicetree/bindings/arm/fsl.yaml | 4 ++--
> > > > >>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >>>>>
> > > > >>>>> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b=
/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > >>>>> index 0027201e19f8..d8bc295079e3 100644
> > > > >>>>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > >>>>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > >>>>> @@ -920,8 +920,8 @@ properties:
> > > > >>>>>                - fsl,imx8mm-ddr4-evk       # i.MX8MM DDR4 EVK=
 Board
> > > > >>>>>                - fsl,imx8mm-evk            # i.MX8MM EVK Board
> > > > >>>>>                - fsl,imx8mm-evkb           # i.MX8MM EVKB Boa=
rd
> > > > >>>>> +              - gateworks,imx8mm-gw75xx-0x # i.MX8MM Gatewor=
ks Board
> > > > >>>>
> > > > >>>> That's not even equivalent. You 7500 !=3D 75xx.
> > > > >>>>
> > > > >>>
> > > > >>>>>                - gateworks,imx8mm-gw7904
> > > > >>>>> -              - gateworks,imx8mm-gw7905-0x # i.MX8MM Gatewor=
ks Board
> > > > >>>>
> > > > >>>> Compatibles do not change. It's just a string. Fixed string.
> > > > >>>
> > > > >>> I think there's justification here for removing it, per the com=
mit
> > > > >>> message, the rename happened before the device was available to
> > > > >>> customers.
> > > > >>> Additionally, I think we can give people that upstream things b=
efore they're
> > > > >>> publicly available a bit of slack, otherwise we're just discour=
aging
> > > > >>> people from upstreaming early.
> > > > >>
> > > > >> Hi Conor,
> > > > >>
> > > > >> Thanks for understanding - that's exactly what happened. I'm in =
the
> > > > >> habit of submitting patches early and often and it's no fun when
> > > > >> something like a silly product name gets changed and breaks all =
the
> > > > >> hard work.
> > > > >>
> > > > >> The board model number is stored in an EEPROM at manufacturing t=
ime
> > > > >> and that EEPROM model is used to build a dt name. So instead of =
GW7905
> > > > >> which would be a one-off custom design it was decided to change =
the
> > > > >> product to a GW75xx. The difference between GW7500 and GW75xx is
> > > > >> because we subload components on boards between GW7500/GW7501/GW=
7502
> > > > >> etc but the dt is the same.
> > > > >>
> > > > >> If there is resistance to a patch that renames it then I guess I=
'll
> > > > >> have to submit a patch that removes the obsolete board, then add=
s back
> > > > >> the same board under a different name. Shall I do that?
> > > > >
> > > > > I think this patch is fine - other than the inconsistency that Kr=
zysztof
> > > > > pointed out between the "renamed to gw7500" and the "gw75xx" in t=
he new
> > > > > compatible.
> > > >
> > > > I am not a fan of renaming compatibles because of marketing change,
> > > > because compatible does not have to reflect the marketing name, but
> > > > there was already precedent from Qualcomm which I did not nak, so f=
ine
> > > > here as well. Double wildcard 75xx is however a bit worrying.
> > > >
> > >
> > > Hi Krzysztof,
> > >
> > > Thanks for understanding. The double-wildcard is again a marketing
> > > tool. All GW75** use the same device-tree by design. The boot firmware
> > > that chooses the device-tree understands this and for a GW7521 for
> > > example would look for gw7521 first, gw752x next, gw75xx last.

When it is doing this matching, does it actually apply a wildcard, or
does it look for "x"? IOW, if your eeprom said "gw7521" and there were
no devicetrees matching "gw7521" but there was one with "gw7500" would
it match?

> > You haven't documented the other 2 though.
> >
> > How do "all GW75** use the same device-tree", but then there are 3
> > possible DTs for just 1 board?
> >
> > Selecting a DT is not a unique problem. We don't need unique
> > solutions. There's the QCom board-id proposal[1] and OS provided DT[2]
> > which are addressing similar issues.
> >
>=20
> Hi Rob,
>=20
> I'm not sure those links are really able to address all needs. I see
> some similarity with the concept of a board-id taking the place of the
> don't-cares used in our names but not the concept of marrying a
> baseboard to a SOM with the two different boards creating a named
> combination (both which may have some don't cares). The Gateworks
> Venice product family of boards (imx8m{m,n,p}-gw7***-*x) boards have
> been in the kernel for quite some time now as has been the U-Boot code
> that determines the device tree using a baseboard model number
> combined with a SOM model number.
>=20
> A baseboard with an model of GW7301 (programmed into an EERPOM at mfg
> time) gets coupled with a SOM with the model of GW7000 and this uses a
> device-tree of gw73xx-0x (prepended by the SoC name of imx8mm, imx8mn,
> imx8mp). The don't care's here and the naming convention has been
> chosen by us, the board manufacturer, leaving enough significant
> digits for component subloads that was desired at the time. So a
> GW7300 and a GW7301 are the same schematic, they just have some
> different loading options.

By "loading options" do you mean "we changed the supplier for the 12v
barrel jack" rather than something that is actually visible to an OS?

> I really don't understand the issue here. A board was originally named
> gw7905 when I brought up the prototype in the lab and created its
> device-tree but between then and when it shipped it got moved to the
> more generic 'family' of gw75xx baseboards which get coupled with a
> SOM. I already have a gw71xx, gw72xx, gw73xx out there for years that
> function this way.
>=20
> Device trees describe hardware using a name... the name changed :(
>=20
> Quite simply there are no boards out there with a GW7905 in the EEPROM
> that need to be supported... they all have a GW7500 programmed in them
> (and some may in the future have a GW7501, GW7502, etc).
>=20
> Is the problem here the fact that I use don't-cares in the names or
> the fact that a name changed?

IMO, getting hung up on the name changing before a released product is
rather silly, but straightening out what exactly your selection method
is worthwhile.

Thanks,
Conor.

--muWFwkv8BWQta2Re
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlivOwAKCRB4tDGHoIJi
0uG2AQC7WKKJVbwVs/MBHS6BbQ03F7tZHiaMnwYsIOhvHyRqCAEAugshRhIs/1Wa
jTdL1pBUp8iFI4rKswK6EteyBf0lOg8=
=c8+5
-----END PGP SIGNATURE-----

--muWFwkv8BWQta2Re--

