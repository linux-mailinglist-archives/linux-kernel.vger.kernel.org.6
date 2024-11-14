Return-Path: <linux-kernel+bounces-409901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 992379C9311
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01C6CB27747
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35D51ABED9;
	Thu, 14 Nov 2024 20:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpwIZ3x6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B31BEEDE;
	Thu, 14 Nov 2024 20:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731615285; cv=none; b=Ay3UMQPO0ZV5W9dIU/ujAAV0N4fAEpCvfG0cJEBuaJSMChGwVD2gYSoQ9o2oo8uYRyFgo998tGChTS+PCCv6aKDgkR4IwFqqyHKikltvQJEM8wKGrkByGM455l0ZfQVlkhQ7WQLeUsm+ku8po8R9K2m7i/Saba8OETD5sF1xfDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731615285; c=relaxed/simple;
	bh=vQfNlFJn5un5Q7X63S53AeFCdYUq2T/YlhPFk4SHDeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6KBecurgfVJIyUNzv0yDG/IMp0qTneIU7qCAMxUpy/WheUXLvNvm/iLD7Csxa6RROqhIxFiXHR5OdVKnT9xLKW3lXiM+UZMdaT1+wA9Pr9lzUQiPQovQele9W4Fjc2xBJsbzX66FcYeeWP43EdbGj0FqSVJD1OPwVILMt2kW4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpwIZ3x6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7857EC4CECD;
	Thu, 14 Nov 2024 20:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731615284;
	bh=vQfNlFJn5un5Q7X63S53AeFCdYUq2T/YlhPFk4SHDeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YpwIZ3x65A2GjtdN4fI4XuWZ4VN9KgC/Po8vXkxyDnAGXTYA6DUgZLtJY5jXuE6Ll
	 4cAQD2IUaShtP18Bj/Z2/c861gmClb7vO4qZjKdrgxameRVWpqMjlrAf5dsNaJdOYM
	 hX5Y82gEP24LjZTxQe7EQ52vQi4JIDM2aQxvlXjQSBj5rmZRTp+32jmM9+4tdDTub5
	 xdh6NTmAeRZYFZfaeDeCc3Blzw0oTFiXTqEdDF9KjjUfT4pQq7ShQ0H6mya/Tqg0uP
	 kx+kNALxt0j0fr4WOvheVaAEGDg4Vxc5/n+8xJ1G8D0XUjNBOmSGnjqRVjnVmIl2Eq
	 OmPuUsW8FYHcg==
Date: Thu, 14 Nov 2024 20:14:40 +0000
From: Conor Dooley <conor@kernel.org>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: reset: add bindings for A1 SoC audio
 reset controller
Message-ID: <20241114-latticed-freight-859a3d78d413@spud>
References: <20241112230056.1406222-1-jan.dakinevich@salutedevices.com>
 <20241112230056.1406222-2-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iRBwY+Ocuqf4OHYD"
Content-Disposition: inline
In-Reply-To: <20241112230056.1406222-2-jan.dakinevich@salutedevices.com>


--iRBwY+Ocuqf4OHYD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 02:00:55AM +0300, Jan Dakinevich wrote:
> This reset controller is part of audio clock controller and handled by
> auxiliary reset driver.

I appreciate this, saved me looking up why there was no compatible
added.

> Introduced defines supposed to be used together
> with upcoming device tree nodes for audio clock controller fo A1 SoC.
>=20
> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--iRBwY+Ocuqf4OHYD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzZaMAAKCRB4tDGHoIJi
0vR0AP9g44FK5dhvfvAcPhPRREYySybWuiZ3/AVaNTszx4fjgwD9Ft38CPHPa0Qt
TCoNfx7EwoObzzGKwSNH8WbQEaM33ws=
=Psao
-----END PGP SIGNATURE-----

--iRBwY+Ocuqf4OHYD--

