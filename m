Return-Path: <linux-kernel+bounces-446466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EADCD9F24AA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 16:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18BC57A1166
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 15:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30EB191F94;
	Sun, 15 Dec 2024 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tk6Qengc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170A317A5BD;
	Sun, 15 Dec 2024 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734277084; cv=none; b=V7Pix0+c8K2fyuXvHCpO1D8Mem9opJT7zwIbXz8QyJGeAGVNDuhOSSqJDK12Du04YxLSmPNJdkJpsg/WIuS6sVuzjZEwvY1t8BecULO3m9XL2faVQc+lBxMufCtUHWZyc+ISvZl3srMQSsErhICeE7UMEpoZ6qV11eunsiEeJLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734277084; c=relaxed/simple;
	bh=2W2SoC3Nq3QLI2t/piJWvaObAI3cgUGGfwurTfGoCgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKD2hBKWcuao3Ni1Bdiui7trsC9ehzINt+xXme9+rJQ6/iAfMo6Ds+MK6VeQGHXsOrojRybSd2aCchCt4IPHRNHlhewPJe5hCijdTXIu0D7FqHja7llYHo+cuzQDCpH9CcT8Ag6veZyK4vSZBl3JOkcz7VlG8vqmsnLJIbwkFkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tk6Qengc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1BCC4CECE;
	Sun, 15 Dec 2024 15:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734277083;
	bh=2W2SoC3Nq3QLI2t/piJWvaObAI3cgUGGfwurTfGoCgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tk6Qengc6DMAIRbf0Hq4AFplTGfpDTP/Lb1uEgESFZmMyNtcDP9rXH/1b3WXrBxR3
	 vDZYNerpWtShblO6t6JBEtBCO6IFfwT1Kxy/pCudaOjGC2+Og/cvj7VLtJ0fZ7yC/K
	 9Qu2qQNIZuZdwDDRQdQcvbLa3urGGVdJLGDRQGBUySOUTHUIKjpyNRJgRTm+oI5g7S
	 fAmDKxpsjcWfaF+/Eokd0I+/Y2tuhcBvrubdXViPTbu5NowLF8XfX5802vuI8Q7zUA
	 JxfDW6pefzO6LXFQ4ff6ABd8MQpPHdpwZeuw7Tq1v44vwRo5yHCY95usEZFAX+jJbr
	 LBdbPAKvmIm5g==
Date: Sun, 15 Dec 2024 15:37:58 +0000
From: Conor Dooley <conor@kernel.org>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Kyle Tso <kyletso@google.com>, RD Babiera <rdbabiera@google.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: connector: Add pd-revision property
Message-ID: <20241215-spectacle-jailhouse-b0d3110076fa@spud>
References: <20241205-get_rev_upstream-v1-0-90158ee7d75f@google.com>
 <20241205-get_rev_upstream-v1-1-90158ee7d75f@google.com>
 <20241206-perch-elliptic-4e8a8170426e@spud>
 <e8b2501a-0808-4e14-960b-7355fa52e8ea@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PTjNqyidzZNOXYaQ"
Content-Disposition: inline
In-Reply-To: <e8b2501a-0808-4e14-960b-7355fa52e8ea@google.com>


--PTjNqyidzZNOXYaQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024 at 04:43:44PM -0800, Amit Sunil Dhamne wrote:
> Hi Conor,
>=20
> On 12/6/24 8:52 AM, Conor Dooley wrote:
> > On Thu, Dec 05, 2024 at 11:46:08PM -0800, Amit Sunil Dhamne via B4 Rela=
y wrote:
> > > From: Amit Sunil Dhamne<amitsd@google.com>
> > >=20
> > > Add pd-revision property definition, to specify the maximum Power
> > > Delivery Revision and Version supported by the connector.
> > >=20
> > > Signed-off-by: Amit Sunil Dhamne<amitsd@google.com>
> > > ---
> > >   Documentation/devicetree/bindings/connector/usb-connector.yaml | 6 =
++++++
> > >   Documentation/devicetree/bindings/usb/maxim,max33359.yaml      | 1 +
> > >   2 files changed, 7 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/connector/usb-connecto=
r.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > > index 67700440e23b5b7ca0db2c395c8a455bcf650864..341d2872e8d43450d219b=
7b72d48790051dc4e2b 100644
> > > --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > > +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > > @@ -293,6 +293,12 @@ properties:
> > >         PD negotiation till BC1.2 detection completes.
> > >       default: 0
> > > +  pd-revision:
> > > +    description: Specifies the maximum USB PD revision and version s=
upported by
> > > +      the connector. This property is specified in the following ord=
er;
> > > +      <revision_major, revision_minor, version_major, version_minor>.
> > > +    $ref: /schemas/types.yaml#/definitions/uint8-array
> > > +
> > >   dependencies:
> > >     sink-vdos-v1: [ sink-vdos ]
> > >     sink-vdos: [ sink-vdos-v1 ]
> > > diff --git a/Documentation/devicetree/bindings/usb/maxim,max33359.yam=
l b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
> > > index 20b62228371bdedf2fe92767ffe443bec87babc5..350d39fbf2dcd4d99db07=
cb8f099467e6fc653ee 100644
> > > --- a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
> > > +++ b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
> > > @@ -70,6 +70,7 @@ examples:
> > >                                          PDO_FIXED_DUAL_ROLE)
> > >                                          PDO_FIXED(9000, 2000, 0)>;
> > >                   sink-bc12-completion-time-ms =3D <500>;
> > > +                pd-revision =3D /bits/ 8 <0x03 0x01 0x01 0x08>;
> > Why do you need this?
>=20
> This DT property helps Type-C Port Manager (TCPM, consumer of the connect=
or
> class properties) fetch the exact Power Delivery (PD) revision &=A0version
> information of the Type-C port controller (TCPC)'s connector. In turn, we
> require it to be able to support "Revision_Information" Atomic Message
> Sequence (AMS) in TCPM to be USB PD spec compliant for all revision &
> versions after PD3.1 v1.x.

This information should be in hte commit message.

>=20
> > Doesn't the compatible already give you this
> > information?
>=20
> Compatible property does not give information regarding the PD revision &
> version but only gives info on the type of connector (usb a, b or c). Als=
o,
> connector class is used by several TCPCs like maxim,max33359, ptn5110, et=
c.
> and each of them may be compliant to=A0 different combinations of revisio=
n &
> version. This feature would help users set these values based on the
> revision/versions their TCPC supports.

Is the version fixed for a given TCPC? If so, the driver would be able
to determine the correct revision based on the compatible. If not, then
you commit message needs to mention that this is variable.

> Currently=A0 TCPM driver hardcodes the Revision value to 3.0 and doesn't
> provide any info on version (undesirable).
>=20
> It should be noted that:
>=20
> 1. There are multiple versions & revisions of the USB PD spec and they ke=
ep
> evolving frequently. A certain connector hardware may only be spec compli=
ant
> for up to a certain version + version. Thus, this is the only way for TCPM
> to know what ver + rev the connector hardware supports. This will enable =
the
> TCPC system to present the exact rev & ver values when requested for
> revision info by the port partner.
>=20
> 2. I also considered incrementing the revision & version information valu=
es
> in the TCPM code. However, that won't be backward compatible for connecto=
rs
> whose hardware doesn't support features in the latest spec. In this case =
we
> would be presenting incorrect revision & version values (higher than what=
 is
> actually supported by the hardware).
>=20
> Regards,
>=20
> Amit
>=20
> > >               };
> > >           };
> > >       };
> > >=20
> > > --=20
> > > 2.47.0.338.g60cca15819-goog
> > >=20
> > >=20

--PTjNqyidzZNOXYaQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ1731gAKCRB4tDGHoIJi
0uvwAPwKfYXkPVbf+76Hv2f+mA1b5G6k9RDNgxsHzsQZQYmBFwD/dnKl3Jpx03tD
bvWiHLEL+/jwNyab+KvKeVuNVf/wvAg=
=/0RX
-----END PGP SIGNATURE-----

--PTjNqyidzZNOXYaQ--

