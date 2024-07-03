Return-Path: <linux-kernel+bounces-239767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0646B92651C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39AEF1C22DEC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F97181325;
	Wed,  3 Jul 2024 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F877FsCW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D76017C204;
	Wed,  3 Jul 2024 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720021185; cv=none; b=ZBmYbQYJkyg47dhfdMCvbED/HEIDebXZZeel/g5SaOSPkn4hRweSiZVxHOXyCMgmPmA8M5P3Y0vLK88bzueqbfNBW5ak6EF9nEjxdbF//FebP7YqsYARcdC9j6DTFDCFyBXisp9j3+CcdlmUme5Oenz1pS+FyVloIaNkuE24FAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720021185; c=relaxed/simple;
	bh=wAyGisIX9CCv+TG3OfxzHu8vRzrUKCmaIRCO11WqeAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hv5ti7+21QJIkDgpXKXhl7ky9YaYygF6bFU/18FT5Sk8fKGCG0FbHJ0qqFGam20IiQndmR7rYjjCCZtbvsztDH1N/d2Q4vo62PtjLQM/JvQEKhZdxhf2rtBWw0R5QSjlW6amyn8W9KGkTBPAujn6+KSKZB7J/nA9BS1QPxCzK3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F877FsCW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25F5C2BD10;
	Wed,  3 Jul 2024 15:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720021185;
	bh=wAyGisIX9CCv+TG3OfxzHu8vRzrUKCmaIRCO11WqeAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F877FsCW/h44wdPUNsiSFXpG0mwv+zN199Lpf0BMqAeX66WfLHA5QpYSNBhpIZMvZ
	 5vVbISnpe3AtsCKlSO/xL5r9TjFxgPza63pvdvFWJvGN9+7lFF9d5avqJQGaywyJ6u
	 VAGFCP9CxwIttlzJMy3UkqKHLargnpAtXEBS7rL6UY8lYnwoBh43rdJSmvsRNF/2qx
	 Zvhm/jGNMehGK14nhT3DjXZbdDizNRrExNKoqi5EjYa3CjVBjUQck9TxXXqG4qp0AT
	 SEit1X86aA0V6oN2f8T3XAZW0/K9dBcoK+1vvIgdxvRETuCM+7UskPVvWCH3ZrE+si
	 BuwGzrHR52BKQ==
Date: Wed, 3 Jul 2024 16:39:40 +0100
From: Conor Dooley <conor@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: tglx@linutronix.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	dharma.b@microchip.com, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 14/27] dt-bindings: interrupt-controller: Add support
 for sam9x7 aic
Message-ID: <20240703-float-residency-778542d36224@spud>
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
 <20240703102806.196014-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DWarSnxkZBAIdBVg"
Content-Disposition: inline
In-Reply-To: <20240703102806.196014-1-varshini.rajendran@microchip.com>


--DWarSnxkZBAIdBVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2024 at 03:58:06PM +0530, Varshini Rajendran wrote:
> Document the support added for the Advanced interrupt controller(AIC)
> chip in the sam9x7 SoC family.
>=20
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--DWarSnxkZBAIdBVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoVwvAAKCRB4tDGHoIJi
0g+jAPsFReX4wE5oHOugI9Md+cQa2gCTgHi0weB/jlYsdHxYmgD/QKKdYnI5lpb0
+IhwxdcRExKR7QAI4SX+2Bim1m5XMgc=
=ibkS
-----END PGP SIGNATURE-----

--DWarSnxkZBAIdBVg--

