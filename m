Return-Path: <linux-kernel+bounces-237993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1F89241D4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4862833CA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE491BA87E;
	Tue,  2 Jul 2024 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbBmbaX2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6616E167D8C;
	Tue,  2 Jul 2024 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932642; cv=none; b=O6CcTV0Yb/ZnKvy835wGsVBzf01GNKQaVx18/nHdxnHutmqGyVNRyqN6A9Q8kXh1m9MUkX4v054AU/9yZOCcWNwC70HNckjsGlbP7ckLvkGhPqoWm07C8kXc7udyiTvFSA450yefMI+VzoBa92O0U02Kf5NWM7Tyo0DYdKL1BNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932642; c=relaxed/simple;
	bh=z/FaIHcgl7sQ1kysGjj+4T7FKuV7Tu//tYWArbL4Qc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3sJF9WS4HSWyOfcdNt6VmITi+RJvd6AWNAFBBNaZX/dDh79CYjkFLvI8OtOUMzRCZ93p4rYrRN9yATKdEd5YUCGSesbcxZXrbdGTB2VQR1OThIg/C/biJIbjx0MMpVDn2/vvhrejgHy8J29yBY8yrKxAkINtu1VWnQ1EWakTdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbBmbaX2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C27C116B1;
	Tue,  2 Jul 2024 15:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719932642;
	bh=z/FaIHcgl7sQ1kysGjj+4T7FKuV7Tu//tYWArbL4Qc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fbBmbaX2MtozQGEBZJguE8WIQG4lcwn6o1TiRS3DrBSkdt5oXYzMXJoUzx9O8uzEJ
	 PUbu0hqpPon72vzjg5rdZREntvJQmllDmH+1FwmqEkShoYCD8krTPSdiVRUiWQ5YzL
	 h4rY04ZECVQ7G36X1t1MFDX2RvaN+9CM8q1rRXv+dXKv6WO6669MqaOd/ETlrNbxC/
	 6LjCCXUPfi++OkIu7u3ay9DOAfUbqpeW72IA9qJEPiWG38M2oPFv3VDBnLUPzzsQVc
	 6uRnUjKnU2GLEZ0df0gR+/jRXSB1/gheMbgNO9QXhmb7M93Rm0rrHVg8seTtf0BgRt
	 4/dP+hQWGgglg==
Date: Tue, 2 Jul 2024 16:03:56 +0100
From: Conor Dooley <conor@kernel.org>
To: Manikandan.M@microchip.com
Cc: megi@xff.cz, javierm@redhat.com, neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com, sam@ravnborg.org, airlied@gmail.com,
	daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: display: himax-hx8394: Add Microchip
 AC40T08A MIPI Display panel
Message-ID: <20240702-manly-theorize-7276ace7943e@spud>
References: <20240701085837.50855-1-manikandan.m@microchip.com>
 <20240701085837.50855-2-manikandan.m@microchip.com>
 <20240701-preset-shredding-409ef0d80ca4@spud>
 <d83e8a51-953d-43c0-83eb-c1a528f9009f@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ctz12PfT6BrOfHBD"
Content-Disposition: inline
In-Reply-To: <d83e8a51-953d-43c0-83eb-c1a528f9009f@microchip.com>


--Ctz12PfT6BrOfHBD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2024 at 04:47:39AM +0000, Manikandan.M@microchip.com wrote:
> Hi Conor,
>=20
> On 01/07/24 3:33 pm, Conor Dooley wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >=20
> >=20
> > ForwardedMessage.eml
> >=20
> > Subject:
> > Re: [PATCH v2 1/3] dt-bindings: display: himax-hx8394: Add Microchip=20
> > AC40T08A MIPI Display panel
> > From:
> > Conor Dooley <conor@kernel.org>
> > Date:
> > 01/07/24, 3:33 pm
> >=20
> > To:
> > Manikandan Muralidharan <manikandan.m@microchip.com>
> > CC:
> > megi@xff.cz, javierm@redhat.com, neil.armstrong@linaro.org,=20
> > quic_jesszhan@quicinc.com, sam@ravnborg.org, airlied@gmail.com,=20
> > daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,=
=20
> > tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,=20
> > conor+dt@kernel.org, dri-devel@lists.freedesktop.org,=20
> > devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
> >=20
> >=20

btw, please fix your mail client :/

> > On Mon, Jul 01, 2024 at 02:28:35PM +0530, Manikandan Muralidharan wrote:
> >> Add compatible string for the Microchip's AC40T08A MIPI Display
> >> panel.This panel uses a Himax HX8394 display controller.
> >> The reset line is not populated and leads to driver probe issues,
> >> thus add conditional block to narrow reset-gpio property per variant.
> > I really should have asked on v1, but I wasn't sure whether or not the
> > optional nature of the reset-gpios was specific to your new panel so I
> > held off: Is it ever the case that a reset-gpio can be provided for this
> > microchip panel, or just not in the configuration you tested? If it is
> > never possible, then I'd probably do...
> The reset-gpio line can be provided for the microchip MIPI panel, the=20
> SoC variant in which I tested did not have the reset line configured,=20
> hence had to make it optional here and also in the driver to avoid panel=
=20
> probe issues.

Okay, then:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--Ctz12PfT6BrOfHBD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoQW3AAKCRB4tDGHoIJi
0qtuAQC/vSPINfc3iyF5pQOr8/w2/T/0L/UB/+uWnSfXRgfoCQEA4Etmhp/L2tnQ
/Dv50f961xmnezYashzt99vCPRpf+AM=
=ml2W
-----END PGP SIGNATURE-----

--Ctz12PfT6BrOfHBD--

