Return-Path: <linux-kernel+bounces-180077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163F38C69D5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41F461C2124A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A22156228;
	Wed, 15 May 2024 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwnoZinf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23198149DEE;
	Wed, 15 May 2024 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715787313; cv=none; b=rEaHq97Ou9tLusbgDC3wpVKpN3HCP6XwLuOT6NznLEevRMlnID+c6i7+bjzGU2d7EgtlfGvyrAWtJYVKOSseV4/wTxd53iL5dEo1OfxTD+XHq3YmkzuGVSZ6MKc2sfzAaC9bY3vaAo0y54cVZl9e0MlH1hiAIQNq3FQaiCbEd3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715787313; c=relaxed/simple;
	bh=mFPp89JBP13RP40YmDW6PgfDx4xfBMuoJNU3Pvo3lPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpUPoW7KZ4S8fVm/TPib3z/oNhmP8b3QPfx+txxJnmBiI1rCy4wxrO+wUJ4Dbds+G/k5ma05uF/zzPNo/PntD4GeMcX6wZfsdsqm1ccu9Kn9BAoW4jDpjj6Ogeu6RTGC5AP0RyySZzY4Ym2+DcgC3liV99cgNAor41RKoQ7U84g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwnoZinf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6B6C116B1;
	Wed, 15 May 2024 15:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715787312;
	bh=mFPp89JBP13RP40YmDW6PgfDx4xfBMuoJNU3Pvo3lPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TwnoZinfDQsP+m0lTu3G2vz/ndIu67rdNHIyrnbBkM2FgZxv4tDrte3dOZZO76PHf
	 M8Z3D7Y9GoMyrleamOzdVl2trMR/gXwDsdPLKL6u42kYeIO8deSPr3B6FZxPXUkG8F
	 Z35LRSO2qIWfUchrt/ROI0BYTxPn5qJaNpzw7hDZjbV00lsL6rIRgZzwf8LkIZ35sP
	 ArSrc0qg6WLww+/dBRmiQdF0MPqPkklMKy+tH7E53uZqO50pLUlLDNd6xi9tCv8Hd9
	 qFtkXA6M7yu9j+LS2T6JW9sJI2w+B73PkeeUEDsPshndxh9yS5GI+AVrc35UobrrvE
	 QqMPYYoLRvfDg==
Date: Wed, 15 May 2024 16:35:07 +0100
From: Conor Dooley <conor@kernel.org>
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
Cc: Marek Vasut <marex@denx.de>,
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
Message-ID: <20240515-monsoon-starfish-0dc59707e843@spud>
References: <20240513095605.218042-1-patrick.delaunay@foss.st.com>
 <20240513115601.v3.1.Ia0a99d90acb512aa020a6e7a8cca8cc1b71f1759@changeid>
 <615dfdcb-cbda-426f-895e-810f03a8ce60@denx.de>
 <20240513-stabilize-proofread-81f0f9ee38b9@spud>
 <d73d4435-75d6-4cea-b38e-07c7ceae3980@foss.st.com>
 <20240514-entryway-idealize-fcd5ed0e1de7@spud>
 <0c97408c-422d-46b3-8017-da9ebb0767e1@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JkKRkMhRtnwamX99"
Content-Disposition: inline
In-Reply-To: <0c97408c-422d-46b3-8017-da9ebb0767e1@foss.st.com>


--JkKRkMhRtnwamX99
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 04:33:22PM +0200, Patrick DELAUNAY wrote:
> with
>=20
> =A0 compatible:
> =A0=A0=A0 oneOf:
> =A0=A0=A0=A0=A0=A0=A0 - items:
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - const: st,stm32mp1,pwr-reg
> =A0=A0=A0=A0=A0=A0=A0 - items:
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - const: st,stm32mp13-pwr-reg
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - const: st,stm32mp1,pwr-reg

Other than the extra ,s this looks okay, thanks.

--JkKRkMhRtnwamX99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkTWKwAKCRB4tDGHoIJi
0kUTAP9I0to3ssOtvgcT5/L329easVlA8psjlud98+mrtpVugQD/Y946XMX4gg7A
wxrHcdLedP6hua+tppsYB4CaczHmqwQ=
=igsK
-----END PGP SIGNATURE-----

--JkKRkMhRtnwamX99--

