Return-Path: <linux-kernel+bounces-180123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DE68C6A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4AF1F233D8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5684A156644;
	Wed, 15 May 2024 16:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUKFii8/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9647615624B;
	Wed, 15 May 2024 16:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715789761; cv=none; b=r+vugSeHcD4JqT43enQ29PjipdYeSHCLxDbXzSeaofy+rz2vv9qMHUuUZVUnJqk1Vu/fvWXxkfRF1e6iQI5QoKyEt+6+vgs5URlEodIERdtX6GNoQ6s19vjrpR1Q9eTlRAKhFozkSXWSMQRsJIxsSyIk+xXXWDAHhxinyYT4iVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715789761; c=relaxed/simple;
	bh=42K17Pixe7XXPK9EXtpix+bwi36V54XcX1AVcxIzguU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrOjOAjdeDPO26ApS6xcGck12ZWs7vuQBngJXkiGzC6uKFKpZE5kMTYqkvr2+stIX4qLdR6NzfYNBfw8kb47WVye4glQl/EqPPEIbfGldjwQpfgtXxZTHob2V0EFy/0QNToI/PORc2qAdFfrm8Wqnh29cER1QP49bGv3KcG8qTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUKFii8/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6694DC2BD11;
	Wed, 15 May 2024 16:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715789761;
	bh=42K17Pixe7XXPK9EXtpix+bwi36V54XcX1AVcxIzguU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RUKFii8/7p0ye6uTbavZiSXtpCpADTjXNc4JuqYMXL/DWJGc+MaVAoHh2BtYnHktK
	 ebx8rN0S1pcglDZdethKl1TgooFBCGDv4XtdhS61qPFk8Xo5+/i/IpB1Gc5Dq6hPFs
	 p/CWoznIdWcyZHg5jwLtAI9f5GDEua76zMTefc6ogdMN1dE/YAT1Jek4WhZd1Brp+J
	 kjx1sbCfPCuBGBjdgy5NYiGBo+MqCUQqoiNirM3Llho7IVYPTLEJnAdkCloARMHK16
	 d7jct0ZrqUfh9w0D2cIZcbAgseOyyLsGUfUeUiSOf7Qd+bl7VYWp0hmBH7m+Ml/1c+
	 V9spvA0Sfj0Eg==
Date: Wed, 15 May 2024 17:15:56 +0100
From: Conor Dooley <conor@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
	Alexandre TORGUE <alexandre.torgue@foss.st.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Pascal Paillet <p.paillet@foss.st.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v3 1/2] dt-bindings: regulator: st,stm32mp1-pwr-reg: add
 compatible for STM32MP13
Message-ID: <20240515-edginess-evacuee-356bd6dd1dfa@spud>
References: <20240513095605.218042-1-patrick.delaunay@foss.st.com>
 <20240513115601.v3.1.Ia0a99d90acb512aa020a6e7a8cca8cc1b71f1759@changeid>
 <615dfdcb-cbda-426f-895e-810f03a8ce60@denx.de>
 <20240513-stabilize-proofread-81f0f9ee38b9@spud>
 <d73d4435-75d6-4cea-b38e-07c7ceae3980@foss.st.com>
 <20240514-entryway-idealize-fcd5ed0e1de7@spud>
 <0c97408c-422d-46b3-8017-da9ebb0767e1@foss.st.com>
 <20240515-monsoon-starfish-0dc59707e843@spud>
 <9de93cbb-5868-473e-8b32-a6b6f50e128e@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vGXUQ+w0Hao4jwFN"
Content-Disposition: inline
In-Reply-To: <9de93cbb-5868-473e-8b32-a6b6f50e128e@denx.de>


--vGXUQ+w0Hao4jwFN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 05:37:49PM +0200, Marek Vasut wrote:
> On 5/15/24 5:35 PM, Conor Dooley wrote:
> > On Wed, May 15, 2024 at 04:33:22PM +0200, Patrick DELAUNAY wrote:
> > > with
> > >=20
> > >  =A0 compatible:
> > >  =A0=A0=A0 oneOf:
> > >  =A0=A0=A0=A0=A0=A0=A0 - items:
> > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - const: st,stm32mp1,pwr-reg
> > >  =A0=A0=A0=A0=A0=A0=A0 - items:
> > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - const: st,stm32mp13-pwr-reg
> > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - const: st,stm32mp1,pwr-reg
> >=20
> > Other than the extra ,s this looks okay, thanks.
>=20
> I think the extra ,s are actually correct, those are the ones from the
> original compatible which had TWO ,s (it does look a bit unusual).

Oh my bad then.

--vGXUQ+w0Hao4jwFN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkTfvAAKCRB4tDGHoIJi
0p9iAPwN5XTdKgnKFAKBFLUCmGz50a3vlmMabr0JmpTLuLgpKAD/cZUlfPgi/276
T/QPKGx911es1Agw6CvtZIZoWgzNOgk=
=Bsop
-----END PGP SIGNATURE-----

--vGXUQ+w0Hao4jwFN--

