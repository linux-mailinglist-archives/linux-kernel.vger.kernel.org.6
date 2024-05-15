Return-Path: <linux-kernel+bounces-180105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606E38C6A24
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916691C22083
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A38156248;
	Wed, 15 May 2024 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="seLoGa36"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61163155A52;
	Wed, 15 May 2024 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715789078; cv=none; b=jP42h4w05qz0S/VcFf+eXl3JiyHp2ceoNf2bp2FocvjoOc7NTmav2Za5pNVKWuovkksqj/kwAmpIfuis8x4XVAx71O7kN7GL5hlZ5DWWo5unNDCXA3dZu0/mxV0a3VuSnraU0sadguZaP/1rPwK+zGipuNgsPv8N61yyuLJito0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715789078; c=relaxed/simple;
	bh=XUNB3rc6qOB6hmGzG/aYjOt9XKcCt6Cs/MYeTHAvKNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtDtMHScAjIGUEl5RxX85FfymD3Ut3qtOY2TqmdlX5adzbnkBnafUFEEoS0t3Suucj2FbOOzHEG49LTz1j8g2s8qhPvYVDRZ2Fo0u2l/P1XPHLN6NwzWyup9zCx9Tu3UGzOPLLGjtvO9rPDzlG7AVCq3ktpPubUukugkvW+n62M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=seLoGa36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D1AC32786;
	Wed, 15 May 2024 16:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715789077;
	bh=XUNB3rc6qOB6hmGzG/aYjOt9XKcCt6Cs/MYeTHAvKNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=seLoGa36mHd6Zu2k/lRfyaOspM3ci/EWSH4XR8EiPlgcmV2NSG/5ZWlrP+0iNhQYW
	 ekGemx9eQiUeZJHrNnSgRHsDAoyi4GCTaiL8cXy8keS2khA7aBc7X44re5R8AcdKCW
	 cwqt+qR3MRdfOW8/w0EKDYW90OmCtQAPFWF89XnlItLUfkV3RWLnprFUZWnC1wTCxI
	 yMPnz/JEv7hz9pRSmJtIfnfE80YLXdz8i6+9OVR4rfO8MfFVF/ZYIBzYmT1wunOpW2
	 N67wdP1+z4PX5aH7Tm/FX9NOr6FTyNJ6kVUZiZFIG2TBrMo8hcus84v04IqSIXeO6t
	 d/t9GtaZnfk4g==
Date: Wed, 15 May 2024 17:04:32 +0100
From: Mark Brown <broonie@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Alina Yu <alina_yu@richtek.com>,
	Conor Dooley <conor.dooley@microchip.com>, lgirdwood@gmail.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, johnny_lai@richtek.com,
	cy_huang@richtek.com
Subject: Re: [PATCH v3 6/6] regulator: dt-bindings: rtq2208: Add property to
 get ldo of RTQ2208 is adjustable or not
Message-ID: <35bfdfa3-0b4d-4457-988f-1f861dc5c125@sirena.org.uk>
References: <cover.1715340537.git.alina_yu@richtek.com>
 <6a3a90d9aa2022dfb92e124e417f3e72c2f28b0b.1715340537.git.alina_yu@richtek.com>
 <20240513-tissue-repave-13d2e3bf88fd@spud>
 <d97752ed-4032-4681-b28f-17f149fdc3d4@sirena.org.uk>
 <20240514-plunging-chair-803d9e342e6f@spud>
 <20240515073830.GA12525@linuxcarl2.richtek.com>
 <20240515-wrinkle-engross-ab6b089baae3@wendy>
 <20240515090229.GA15889@linuxcarl2.richtek.com>
 <20240515-gigantic-justifier-1fa140b59de6@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9AcE8zRTsKNaksUc"
Content-Disposition: inline
In-Reply-To: <20240515-gigantic-justifier-1fa140b59de6@spud>
X-Cookie: When in doubt, lead trump.


--9AcE8zRTsKNaksUc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 15, 2024 at 04:51:30PM +0100, Conor Dooley wrote:

> BTW, you should probably change the example so that the voltage you add
> there is actually outside of the range, rather than identical to one of
> the range's constraints :)

No, that'd be invalid - the constraints need to include a value offered
by the regulator, in this case the one fixed voltage.  For a fixed
voltage regulator it's probably better to just not specify a voltage
range since it can't be changed anyway.

--9AcE8zRTsKNaksUc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZE3Q8ACgkQJNaLcl1U
h9AV3wf+MxjUh6NJfNfEd9wJkPBg8mAS+DXWvNUXl2n5keniDabcCVvRGAZaMZdj
rFVyMN3fVa8b6mie+s7cSANggS4z1b5H/qgxfF+2QvNWBGu4hYY2Ra7W0knaPrWn
NRNZtZ4T3DhtwipASAGFxAoTMWQjjhr7UqTvRrI8gGVmy245cucMzIFgU+nPkGxI
gkjuppfEegKWldrDA0IRVsOIOiqBgkGwgJzb10rT77o3WZtRxXmuivJ4b3z9h20Z
bldpjd8xbqDYvFOIdKrdGUB4z6RPn5WjnYcLQLaXX8rpVmOBFzcyNwPRzgd7Jttr
cBVqx2YZ6YtkpoGoprELrskI/k+/Dg==
=svLP
-----END PGP SIGNATURE-----

--9AcE8zRTsKNaksUc--

