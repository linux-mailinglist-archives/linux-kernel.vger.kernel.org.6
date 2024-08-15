Return-Path: <linux-kernel+bounces-288215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2A295376B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C8992835D9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B43F1AD411;
	Thu, 15 Aug 2024 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVdnOhC6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417652562E;
	Thu, 15 Aug 2024 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723736253; cv=none; b=DFhgk2J/JsjAdY2+PhMXiBuYJT/xyi+RumXUMqvMbn7J7agMVttN0UxFm/9zyAm9o3vWRs1tvEEIee7sj8EYH1BS4k4+2/KVeFwSORPI1N2U+362j2hv81PwskKMIBy+vVVL4cLZ9YjKwQH8K47tRedVt+MO6pKqFM8wmUPL06I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723736253; c=relaxed/simple;
	bh=KC71ZArG2NY4xsQIn0t5rwxnUKbfbXLMnjF2bC/tQAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSjIGWuEkWiIcOaNcHyLGdiLcbsGVvGyPnV1wgH7iTaxsd2wSo5w9rgUEvFqp0fl7ssCosYEpuETzONE6FPCWN8oPS7lyrKiJxP6KmqHwnryWxYKdUn0KkLBpH6emQ6IrqBfzcL+klr0Nwd6GLqI2ymE/KtaMprK4WCy4GnLTW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVdnOhC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DECCC32786;
	Thu, 15 Aug 2024 15:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723736252;
	bh=KC71ZArG2NY4xsQIn0t5rwxnUKbfbXLMnjF2bC/tQAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jVdnOhC63PhKcH5A43pJHH8Gsh1C76Tqt4hKQOMQTee/GzXsfPkHtgaJlI2fP7SVx
	 VSZc3Ky8lxa0ToXkmLZ7ij6Wfh6U7HJJKPSxki961IC1vIxJzbRDx9DVlA5DmMNd/6
	 tbfId9uhrvNvKls0idZb2fHFtrUD5KEWXX8Q+T+Y4d65/cIgkFGWmISNhys52ohxlA
	 l7BZAc7y/0zbJSCE3HWu/EBUlVrRGOHxyBZG0PzMhTJf/MycVtkFn6IPsgQ3WTBbjE
	 RuylRvbXwQiw9s1V9vqU7oCangytZo7JFGwC3SfYqkJDK5DGNiaZQUAo0ss97r2dTl
	 ZIotaz2pN+pFA==
Date: Thu, 15 Aug 2024 16:37:29 +0100
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [RFC PATCH 06/11] dt-bindings: soc: microchip: document the two
 simple-mfd syscons on PolarFire SoC
Message-ID: <20240815-anteater-water-d35f729c381b@spud>
References: <20240815-shindig-bunny-fd42792d638a@spud>
 <20240815-pending-sacrifice-f2569ed756fe@spud>
 <172373604945.1948429.11074973738435374630.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JO4R+jmknScHMLaV"
Content-Disposition: inline
In-Reply-To: <172373604945.1948429.11074973738435374630.robh@kernel.org>


--JO4R+jmknScHMLaV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 09:34:11AM -0600, Rob Herring (Arm) wrote:
>=20
> On Thu, 15 Aug 2024 15:01:09 +0100, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > There are two syscons on PolarFire SoC that provide various functionali=
ty of
> > use to the OS.
> >=20
> > The first of these is the "control-scb" region, that contains the "tvs"
> > temperature and voltage sensors and the control/status registers for the
> > system controller's mailbox. The mailbox has a dedicated node, so
> > there's no need for a child node describing it, looking the syscon up by
> > compatible is sufficient.
> >=20
> > The second, "mss-top-sysreg", contains clocks, pinctrl, resets, and
> > interrupt controller and more. For this RFC, only the reset controller
> > child is described as that's all that is described by the existing
> > bindings. The clock controller already has a dedicated node, and will
> > retain it as there are other clock regions, so like the mailbox,
> > a compatible-based lookup of the syscon is sufficient to keep the clock
> > driver working as before so no child is needed.
> >=20
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> > (I'll split this in two later, it's just easier when I have the same
> > questions about both...)
> >=20
> > Are these things entitled to have child nodes for the reset and sensor
> > nodes, or should the properties be in the parent and the OS probe the
> > drivers for the functions? That's something that, despite supposedly
> > being a maintainer, I do not understand the rules (of thumb?) for.
> >=20
> > Secondly, is it okay to make the "pragmatic" decision to not have a
> > child clock node and keep routing the clocks via the existing & retained
> > clock node (and therefore not update the various clocks nodes in the
> > consumers)? Doing so would require a lot more hocus pocus with the clock
> > driver than this series does, as the same driver would no longer be
> > suitable for the before/after bindings.
> > ---
> >  .../microchip/microchip,mpfs-control-scb.yaml | 54 +++++++++++++++++++
> >  .../microchip,mpfs-mss-top-sysreg.yaml        | 53 ++++++++++++++++++
> >  2 files changed, 107 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/microchip/mic=
rochip,mpfs-control-scb.yaml
> >  create mode 100644 Documentation/devicetree/bindings/soc/microchip/mic=
rochip,mpfs-mss-top-sysreg.yaml
> >=20
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-control-sc=
b.example.dts:21.13-38: Warning (reg_format): /example-0/soc/syscon@3702000=
0:reg: property has invalid length (8 bytes) (#address-cells =3D=3D 2, #siz=
e-cells =3D=3D 1)
> Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-control-sc=
b.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-control-sc=
b.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_forma=
t'
> Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-control-sc=
b.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-control-sc=
b.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-control-sc=
b.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-control-sc=
b.example.dts:19.27-26.13: Warning (avoid_default_addr_size): /example-0/so=
c/syscon@37020000: Relying on default #address-cells value
> Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-control-sc=
b.example.dts:19.27-26.13: Warning (avoid_default_addr_size): /example-0/so=
c/syscon@37020000: Relying on default #size-cells value
> Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-control-sc=
b.example.dtb: Warning (unique_unit_address_if_enabled): Failed prerequisit=
e 'avoid_default_addr_size'

Yeah, these are all known. One of the bindings doesn't even have an
example. I know this is automated, but just to point out that my only
objective here is figuring out whether or not child nodes are okay here.

--JO4R+jmknScHMLaV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZr4guQAKCRB4tDGHoIJi
0oetAP0XPSEVCIQDn1c3IOfukkdMDI+yO6TFuJxNcLSOqlXQQAD/VkGG1C3mV2sJ
w4LbaTQbKiKBBzcabEb60r5dCiGbQQw=
=2gA+
-----END PGP SIGNATURE-----

--JO4R+jmknScHMLaV--

