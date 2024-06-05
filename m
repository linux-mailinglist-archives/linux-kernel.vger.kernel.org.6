Return-Path: <linux-kernel+bounces-202995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5198FD475
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4D3C1C21F76
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DB6194AFD;
	Wed,  5 Jun 2024 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEz/nDoH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0296E13A26E;
	Wed,  5 Jun 2024 17:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610190; cv=none; b=FL8PNYCogHbKUIJhggqo9H4V7c+FAqONCU4NeXu8oWjczNwQTX05XCQcB8mStFis8QV4SDmaEP2e6VZQF4qP2bnygPj3BQrxuLIlk9wAldImCcqejxSUbV9gaQpVsF277DPNLkMQXhhyC+kJtfdE0UVAEQGNlnZig0nVuVnhZjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610190; c=relaxed/simple;
	bh=SNzE0F9enywAXpbx37sfhGTyuSO2Iy8uiW1YPcMF1Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIFiQf19y4dKCxv7LV+PYdJUn1F4BAuDkGRUzJ/2I2eGjuBJBp47LttuzeByPSjDT3jMtRs/6RQY6oi5GoYMVawDN3OY3FFP7DplO/gxrNjV7dcZOYLiSNKFhgTqFO5hnoC6VSWJQhvI6GuXUVHbhRN0Ns86dwHrkIiqESNehms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEz/nDoH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1473BC2BD11;
	Wed,  5 Jun 2024 17:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717610189;
	bh=SNzE0F9enywAXpbx37sfhGTyuSO2Iy8uiW1YPcMF1Dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UEz/nDoH7s82EQnTwVzzeG15BOpK5GJlr9WAW3VNhJXcoL19pKBtCAea+URGa6Avw
	 F/MDrcZe8922kwzTJ2yUQhCSZv2DoyQgJn/PdA/wWzSAjivbG164pcspqFPMpkmB8/
	 8pLXCvAOt5cHKS/LnU/L4vmTx9ut0i6FuyGJP8HHZ7/nhlKAn4088tYwvgIPFUKfqq
	 dIJTtteJKT/kX8//XAqJ4VxSvxeTk44TyhUWIHPGE6ldpCawXhzhKc6W5KIyw5OwMa
	 3H7qUe9GdOrMaD9svpkhwlH+lBksHM+tnS3ISRftFKgF2YZDV8or0PPgkRMD4UeDlG
	 MlzQbiAEuHl7w==
Date: Wed, 5 Jun 2024 18:56:24 +0100
From: Conor Dooley <conor@kernel.org>
To: Alex Bee <knaerzche@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: clock: rk3128: Add HCLK_SFC
Message-ID: <20240605-proponent-ion-d78e863ca7b5@spud>
References: <20240605172154.193047-1-knaerzche@gmail.com>
 <20240605172154.193047-2-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IkMWFnV2LSveQRFT"
Content-Disposition: inline
In-Reply-To: <20240605172154.193047-2-knaerzche@gmail.com>


--IkMWFnV2LSveQRFT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 05, 2024 at 07:21:52PM +0200, Alex Bee wrote:
> Add a clock id for SFC's AHB clock.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--IkMWFnV2LSveQRFT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmCmyAAKCRB4tDGHoIJi
0kr2AP9CcJSE0xRZszok5aIlAw4wAVI+sOpC9KTCCLbELcfxoAEAjH2YTfqU+eA7
7Cbv3vSQO00bE61flXDiiId5PhMPBgs=
=3UhK
-----END PGP SIGNATURE-----

--IkMWFnV2LSveQRFT--

