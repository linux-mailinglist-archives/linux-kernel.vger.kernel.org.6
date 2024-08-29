Return-Path: <linux-kernel+bounces-307270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EC6964B1C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E42286913
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA261B3F14;
	Thu, 29 Aug 2024 16:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqqRpPpy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A210192B84;
	Thu, 29 Aug 2024 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947787; cv=none; b=pNHQ7NHQlq6tU/4T/21wluHGicyTI1Y5pzSEwO/zPzOzI9cufPUsmhzWfzaV/zqYvqSOQVuFpm0N0UvqmsepPHHjxzXOqaV2w0n8dNcR4pF+K/6oy+FL+q/UEa1CHweZNWP4gyG1KOG1AcJxKDH/ty8bfLLdxq7wuNm2esHe2uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947787; c=relaxed/simple;
	bh=tyKDa9eF9hWmJ5krbc0vX9Qd82zc8OOsfQkxJ4wEuwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjlBWiTS2rCcYmHDwKfZ3maUmHWVXeLjgYJTWbAdz5xqGXfvgA20t8wqAGXjk5XiBvjed1IiPjv73jFWc+7cU4DrU1ubQR7BLZWAMegI1V03bn2DaYqyE3NlJNqZjwPXcoBxi8rgYBUyhGYfsqpMPDkGM7vKLzfes4LcRj/aXnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqqRpPpy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD096C4CEC1;
	Thu, 29 Aug 2024 16:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724947787;
	bh=tyKDa9eF9hWmJ5krbc0vX9Qd82zc8OOsfQkxJ4wEuwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dqqRpPpyypSmADZrtxUQTuhdXioLX4bNUO4CeBn/sxR03V+3Pg+Yj5+ffrNqO7d47
	 rHI9e6s5f54GSKZpsKO0VesJu0xYXFq4B0LZU6DKRcXeyb5PQArSTmmZ2wwSJ0g/rU
	 6vs1GjOzrODidwKMW7UlbTzjn7EdaosbmgueNkFTTSQWULDdTApqB2mjBSHXVMZtxj
	 XI+jlTTNGHi2hS85Vk6oHH6tWOOCZXjTtVHlyLhMYrRGGHowXGt5aFGqUoO7HiOTUT
	 hcUrK8G6DKGsP0fsRKVzcd7bDjqes3Q6bguURytmClL9c2idhZX3ra7iQ9Llr056oR
	 YU4XzusjSC6LA==
Date: Thu, 29 Aug 2024 17:09:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: clocks: atmel,at91sam9x5-sckc: add sama7d65
Message-ID: <20240829-mosaic-elective-2dcaad5fc6c4@spud>
References: <20240829-sama7d65-sck-v1-1-3e7b19e3cbf9@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DS9Ulw7sw6YNxpVn"
Content-Disposition: inline
In-Reply-To: <20240829-sama7d65-sck-v1-1-3e7b19e3cbf9@microchip.com>


--DS9Ulw7sw6YNxpVn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 04:24:37PM +0530, Dharma Balasubiramani wrote:
> Add bindings for SAMA7D65's slow clock controller.
>=20
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--DS9Ulw7sw6YNxpVn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZtCdRgAKCRB4tDGHoIJi
0rI6AP49JYlSWrgb4BX978wCCGjZhQj2Je3Uvv2k/pdMlbWHYQEAnpwFboh90uYG
ySqncxdvHBYGWtyxim6MRTo7bWFlpwY=
=E7BV
-----END PGP SIGNATURE-----

--DS9Ulw7sw6YNxpVn--

