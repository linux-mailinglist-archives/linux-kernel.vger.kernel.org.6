Return-Path: <linux-kernel+bounces-555612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48A0A5BA3C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527723B151F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AF0229B01;
	Tue, 11 Mar 2025 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlWn3Sq+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F19D223710;
	Tue, 11 Mar 2025 07:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741679527; cv=none; b=tKmRN9E+XbNIcmaPkWIstSxflSTzw/kDPk7xeIYUAB3dN+DzO6XdbLSlvPrwbLwKMrsJ3kfz1MjJpfWwYXVVjYngjSn8rnMjf30BTiDothQMIHH9Vgpy9i4BB/V9k6ytLaQLqaHR+uMG4OEAxRNUrhPuubehMz6CGy/Da6J9olg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741679527; c=relaxed/simple;
	bh=HfKcsZDJC2+EsMJOzdZg8I4d6CFSgODfRIZEeBSb+PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cspk3g21zCUycujXGxVZ0gsiop4kAbEILgTaHeCmRM4H0/2yTwbUrodaKiGwK+jWc9hk3ZcVfQ4cBK9Votabv5yZUwOhbKG8S2KEedgIniqYoCpDikngRYNcXVUdoVB9rbf3Ws5slYY58tyzJBrq2d1eK4YK+0UdQNJ2bq5w8Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlWn3Sq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881EAC4CEE9;
	Tue, 11 Mar 2025 07:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741679527;
	bh=HfKcsZDJC2+EsMJOzdZg8I4d6CFSgODfRIZEeBSb+PE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GlWn3Sq+A9WiR36/4he/MFeWaEc/E2RmM+kO/AG+SyfsjUjY1tmjPS595tWaaRZSR
	 jK7/n7ubXCUSDyx6YnlePq/k+gr1gcEDfQhSLmpAFcFIGLXepaec8ydoXIqW1d/udR
	 20PX2G7QqjLsutGT5M+73NLnlTuUsnMy/b4g7dv20gJOsqLastLX6cy4SgR8b4xGuF
	 hlq/2jcba+J6j/7aAhsVJNYnC2XYgdAGMbofu2RmwdKpsra1Wuk14bJDm23GdahIBw
	 c717rawmdYpdB+syU9d1OHoTChHQJ5gzL4dgRjDevK5vAQx8BmWJRYi1pLHIZsGRox
	 7Df+FiN2XetcA==
Date: Tue, 11 Mar 2025 08:52:04 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: Rob Herring <robh@kernel.org>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, 
	jonas@kwiboo.se, jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Subject: Re: [PATCH 3/5] dt-bindings: display: simple-bridge: Document DPI
 color encoder
Message-ID: <20250311-thoughtful-fluffy-echidna-b37b7c@houat>
References: <20250304101530.969920-1-victor.liu@nxp.com>
 <20250304101530.969920-4-victor.liu@nxp.com>
 <20250304152320.GA2630063-robh@kernel.org>
 <1891036.atdPhlSkOF@steina-w>
 <20250305163805.GA2071011-robh@kernel.org>
 <7d98163d-10c8-457d-92e7-6a1d6e379beb@nxp.com>
 <20250306-kangaroo-of-pastoral-typhoon-8aefb2@houat>
 <0e82c4d6-8b93-4dd0-ae34-155e537ab344@nxp.com>
 <20250310-hopeful-helpful-quoll-e0dee8@houat>
 <77beb311-c836-4908-bfa6-fbeda69eee99@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vsisrz3i6oudetjw"
Content-Disposition: inline
In-Reply-To: <77beb311-c836-4908-bfa6-fbeda69eee99@nxp.com>


--vsisrz3i6oudetjw
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/5] dt-bindings: display: simple-bridge: Document DPI
 color encoder
MIME-Version: 1.0

On Tue, Mar 11, 2025 at 10:38:37AM +0800, Liu Ying wrote:
> On 03/10/2025, Maxime Ripard wrote:
> > On Fri, Mar 07, 2025 at 11:10:00AM +0800, Liu Ying wrote:
> >> On 03/06/2025, Maxime Ripard wrote:
> >>> On Thu, Mar 06, 2025 at 03:02:41PM +0800, Liu Ying wrote:
> >>>> On 03/06/2025, Rob Herring wrote:
> >>>>> On Wed, Mar 05, 2025 at 10:35:26AM +0100, Alexander Stein wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> Am Dienstag, 4. M=E4rz 2025, 16:23:20 CET schrieb Rob Herring:
> >>>>>>> On Tue, Mar 04, 2025 at 06:15:28PM +0800, Liu Ying wrote:
> >>>>>>>> A DPI color encoder, as a simple display bridge, converts input =
DPI color
> >>>>>>>> coding to output DPI color coding, like Adafruit Kippah DPI hat[=
1] which
> >>>>>>>> converts input 18-bit pixel data to 24-bit pixel data(with 2 low=
 padding
> >>>>>>>> bits in every color component though). Document the DPI color en=
coder.
> >>>>>>>
> >>>>>>> Why do we need a node for this? Isn't this just wired how it is w=
ired=20
> >>>>>>> and there's nothing for s/w to see or do? I suppose if you are tr=
ying to=20
> >>>>>>> resolve the mode with 24-bit on one end and 18-bit on the other e=
nd, you=20
> >>>>>>> need to allow that and not require an exact match. You still migh=
t need=20
> >>>>>>> to figure out which pins the 18-bit data comes out on, but you ha=
ve that=20
> >>>>>>> problem with an 18-bit panel too. IOW, how is this any different =
if you=20
> >>>>>>> have an 18-bit panel versus 24-bit panel?
> >>>>>>
> >>>>>> Especially panel-simple.c has a fixed configuration for each displ=
ay, such as:
> >>>>>>> .bus_format =3D MEDIA_BUS_FMT_RGB666_1X18
> >>>>>>
> >>>>>> How would you allow or even know it should be addressed as
> >>>>>> MEDIA_BUS_FMT_RGB888_1X24 instead? I see different ways:
> >>>>>> 1. Create a new display setting/compatible
> >>>>>> 2. Add an overwrite property to the displays
> >>>>>> 3. Use a (transparent) bridge (this series)
> >>>>>>
> >>>>>> Number 1 is IMHO out of question.=20
> >>>>>
> >>>>> Agreed.
> >>>>>
> >>>>>> I personally don't like number 2 as this
> >>>>>> feels like adding quirks to displays, which they don't have.
> >>>>>
> >>>>> This is what I would do except apply it to the controller side. We =
know=20
> >>>>> the panel side already. This is a board variation, so a property ma=
kes=20
> >>>>> sense. I don't think you need any more than knowing what's on each =
end.=20
> >>>>
> >>>> With option 2, no matter putting a property in source side or sink s=
ide,
> >>>> impacted display drivers and DT bindings need to be changed, once a =
board
> >>>> manipulates the DPI color coding.  This adds burdens and introduces =
new
> >>>> versions of those DT bindings.  Is this what we want?
> >>>
> >>> There's an option 4: make it a property of the OF graph endpoints. In
> >>> essence, it's similar to properties that are already there like
> >>> lane-mapping, and it wouldn't affect the panel drivers, or create an
> >>> intermediate bridge.
> >>
> >> I don't see lane-mapping anywhere. Do you mean data-mapping instead?
> >> data-mapping is not defined in dtschema. Only lvds-codec.yaml defines
> >> data-mapping in endpoint.
> >=20
> > I meant as a general concept. The properties are data-lanes and
> > clock-lanes in
> > Documentation/devicetree/bindings/media/video-interfaces.yaml
>=20
> This requires referenceing video-interfaces.yaml in existing DT binding d=
ocs
> and driver modifictions, which adds burdens.

If burden is an issue, any new driver also adds burden, thus we
shouldn't merge anything anymore and we can stop there?

It's not black and white, it should be managed, and here it's
manageable and / or mitigated.

> >> With option 4, I guess you meant display sink drivers, i.e., panel and
> >> bridge drivers, wouldn't be affected. Then, display source drivers, i.=
e.,
> >> display controller and bridge drivers, would be affected. This adds
> >> burdens for driver developers/maintainers(though almost no effort from
> >> DT's PoV), doesn't it?
> >=20
> > Not necessarily, panels have a phandle to the parent endpoint too so
> > they can do that walk and configure their format if it's any easier.
>=20
> I'm sorry, I don't get your meaning here.  I have no idea how to support
> this new property in endpoint-base(graph.yaml) or video-interfaces.yaml
> _without_ changing existing display source drivers.

Make a helper, and drivers can always call that helper. It will be a
single function call, and panel-simple will cover most of the existing
user-base already.

Otherwise, we have the option to use coccinelle if you want to mass
convert it.

> >> Moreover, why it has to be the display sink drivers which are not affe=
cted?
> >> DT writers might choose to set the format at the sink endpoint, e.g., =
setting
> >> RGB666 at the sink endpoint of a RGB888 DPI panel or bridge.
> >=20
> > Why wouldn't you run the panel at the highest bpc possible?
>=20
> Because hardware designers route less data signals than regular ones to t=
he
> DPI panel or bridge.

Sure, and that's a hardware property, that's what your bridge or that
property would cover. It wouldn't cover why someone would want to change
*that*, or I didn't underdstand what you meant?

Maxime

--vsisrz3i6oudetjw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZ8/rowAKCRDj7w1vZxhR
xfLwAP0V+VJ1dKVKkgzDnIWlw6E9VjMsIYHGeoJxWA7n2WZf2QD/erk64+1gK+oQ
aHQalpRgzmrf7lJaii1ZTnzvVEliyAg=
=a9fj
-----END PGP SIGNATURE-----

--vsisrz3i6oudetjw--

