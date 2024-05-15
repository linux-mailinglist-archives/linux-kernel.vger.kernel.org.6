Return-Path: <linux-kernel+bounces-180092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A2A8C6A03
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AF4EB224E8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89835156237;
	Wed, 15 May 2024 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYKLC1xx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C567B155723;
	Wed, 15 May 2024 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715788294; cv=none; b=BEnUu7uW8IhiYTGQnL65HA543zFY9Pfw0vMLW4SWnyLpl0EJyrcvbeLK/BlfpBn6qmvI2EMsqsIZu0z4OSMH7a/ezYy3KNAiXyg5oGd+m1xYzu8XvhCm18Rso/wT2OesKxiCOvQM9evGyTRZoDWGvMG6oKlFthDl1JQgUbJJ+vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715788294; c=relaxed/simple;
	bh=XJNOkBFhCsi2Lc3PNBSPax4TnDj2BZ736C8kerbm1RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyY5V5CS2uTz1EvhDmhxqcG3EyqBH7r+A1ylFL9j4dMxTRaXZHbtn+ld+CuPo34+K7pqDAXm1oXKLG5YMISq1KA3o2Jz/Ib92gEvScz6hf7Xjw7FuGVPhV51WGD6tbqJ90pjtRlXLOmOvssXysKkYigeKvP7OtbZA/pRwS9dNpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYKLC1xx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F2BC116B1;
	Wed, 15 May 2024 15:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715788294;
	bh=XJNOkBFhCsi2Lc3PNBSPax4TnDj2BZ736C8kerbm1RQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IYKLC1xxYUpc1G3K8sDvpJSWyvi1Mqs3wtm6+YqQ8Kg6ZwJ1k4Pe4DywDFrAocwJ0
	 CRGpU4sxzmzqbKlDOdKSZfLyKAIMpB/NEZF/pVH4/sIQedl1F0iICR41+ZAkeFrmfX
	 NUwyQ8Ct0huERlW4UABtnGpJD6T+uTOLpzhlgtltR+vWQVHm/rtYRZ+s96ZLOJZdjJ
	 BdNwhd7NDBUxd40itfhvoVzYepXBQHI1oSpg0du9oQm+/YqHPOKgPCEwJNOk36aJg6
	 wfRvmFM8QdWpqkI3jY3PH4LMqTepE0M3PnV8IfVaMyll/kCcvvPx2waATIGiSqduHM
	 agmQzbv6xLlnw==
Date: Wed, 15 May 2024 16:51:30 +0100
From: Conor Dooley <conor@kernel.org>
To: Alina Yu <alina_yu@richtek.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, johnny_lai@richtek.com,
	cy_huang@richtek.com
Subject: Re: [PATCH v3 6/6] regulator: dt-bindings: rtq2208: Add property to
 get ldo of RTQ2208 is adjustable or not
Message-ID: <20240515-gigantic-justifier-1fa140b59de6@spud>
References: <cover.1715340537.git.alina_yu@richtek.com>
 <6a3a90d9aa2022dfb92e124e417f3e72c2f28b0b.1715340537.git.alina_yu@richtek.com>
 <20240513-tissue-repave-13d2e3bf88fd@spud>
 <d97752ed-4032-4681-b28f-17f149fdc3d4@sirena.org.uk>
 <20240514-plunging-chair-803d9e342e6f@spud>
 <20240515073830.GA12525@linuxcarl2.richtek.com>
 <20240515-wrinkle-engross-ab6b089baae3@wendy>
 <20240515090229.GA15889@linuxcarl2.richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QCDsa/Y4oznDo0Yx"
Content-Disposition: inline
In-Reply-To: <20240515090229.GA15889@linuxcarl2.richtek.com>


--QCDsa/Y4oznDo0Yx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 15, 2024 at 05:02:29PM +0800, Alina Yu wrote:
>         properties:
>           richtek,fixed-microvolt:
>             description: |
> -              If it exists, the voltage is unadjustable.
> -              There is no risk-free method for software to determine whether the ldo vout is fixed or not.
> -              Therefore, it can only be done in this way.
> +
> +              There are two types of LDO VOUT: fixed voltage mode and adjustable voltage mode.
> +              For fixed voltage mode, the working voltage is out side the range of the adjustable mode.
> +              The constraints are unsuitable to describe both modes.
> +              Therefore, this property is added to specify the fixed LDO VOUT.

I think you could do something as simple as:
	This property can be used to set a fixed operating voltage that lies
	outside of the range of the regulator's adjustable mode.

BTW, you should probably change the example so that the voltage you add
there is actually outside of the range, rather than identical to one of
the range's constraints :)

--QCDsa/Y4oznDo0Yx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkTaAgAKCRB4tDGHoIJi
0vNYAQDJvKqdfEIJdg7jJ2twWh9wq7Okv2yyW06rZsjDLfO8nAEAsWEP3oqXZDg+
ffsSjpGPijo2ClizZ+29ShoT94mIGg4=
=FXE2
-----END PGP SIGNATURE-----

--QCDsa/Y4oznDo0Yx--

