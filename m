Return-Path: <linux-kernel+bounces-227583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C72A891538C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF7C1F24767
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF6E19E80D;
	Mon, 24 Jun 2024 16:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8uhoAnX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C31F19E7F6;
	Mon, 24 Jun 2024 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246192; cv=none; b=QSGjkAXtWswANQIZB7Ulnbjjwdg9eY7XT9k0+Y0ukz/2gwrovAz+WiWD9S79l1ojBkYTklPUKZosv6mrqM9YLwlQJnXSowM++wHr1MUXC648j+yaWzurWU28Gg2u0sgF7SznyHz84I2buEEUNfsvOwXh/vPHm5g6gqZWo/hQbLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246192; c=relaxed/simple;
	bh=4EFcG92bn8m3C7P7WSc1UKVb67kZ/q7dj6odcHRRAYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqjhy2mC1CadunCepD16Y9nd+h16YRuMUHKU2fP5TneAAYc3WPMHKu7CxNl8RxbkngmxbeLU012478gWzZPFkLWC2Wj2i7acqpmqJ4UJao/jwhN63ZcH2DZkr4GjKd9dWeENtEp3IrrtgFQbLElYz3OTg0KXsxp4cKW7jVcqDTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8uhoAnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A80C2BBFC;
	Mon, 24 Jun 2024 16:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719246191;
	bh=4EFcG92bn8m3C7P7WSc1UKVb67kZ/q7dj6odcHRRAYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A8uhoAnXMhwh0jFhx3rbLY0lhbWqRGx0PT2geeamzLGuRsnq/PxpDiLEAs4Ye4C9r
	 lXOZNt2ne0d2TqqjfwOWudF3IYY174wUqZifQUF+UJvuHprzUyxH5sc2ijiA8HqaMi
	 GSocEH1/6C2rk+oNX1tT6LegLWUSG8jZFPmEFY1cQKT5jWc11ZyMcYjmftG8okLDXL
	 KyE9fd5iTc0wiD2agYJQ1WWPl+/0oFonQYbzqYT1ymCW5KQkC37h63fbvTqcQhXJMZ
	 MYxRUdTYkC7YER6nKH5CZnkuIFIm4ECoO1cw1sOJE5jwXtJPssRfQx8Lx2GECGWPga
	 GoZ5LHSdNb0Bg==
Date: Mon, 24 Jun 2024 17:23:06 +0100
From: Conor Dooley <conor@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: dwc2: switch to unevaluatedProperties
Message-ID: <20240624-venus-parish-e1159f455537@spud>
References: <20240624-topic-amlogic-upstream-bindings-fixes-dwc2-subnodes-v1-1-f2544f21f594@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NcujpWxopTaQHiCu"
Content-Disposition: inline
In-Reply-To: <20240624-topic-amlogic-upstream-bindings-fixes-dwc2-subnodes-v1-1-f2544f21f594@linaro.org>


--NcujpWxopTaQHiCu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 10:58:23AM +0200, Neil Armstrong wrote:
> Define "unevaluatedProperties" instead of "additionalProperties"
> to allow properties from common schemas but still disallow undefined
> properties.
>=20
> This allow defining a device subnode and fixes:
> meson-gxbb-odroidc2.dtb: usb@c9100000: '#address-cells', '#size-cells', '=
hub@1' do not match any of the regexes: 'p
> inctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/usb/dwc2.yaml#
>=20
> Fixes: bb88dbbee2c9 ("dt-bindings: usb: dwc2: Add reference to usb-drd.ya=
ml")
> Fixes: 54bd6c9a3b7b ("dt-bindings: usb: dwc2: document TPL support")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>


Acked-by: Conor Dooley <conor.dooley@microchip.com>

--NcujpWxopTaQHiCu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnmdagAKCRB4tDGHoIJi
0g9zAPoCSvn4/xhuGIyIa/DMhbg1Og78t4fwZV9QHM33OlR1tAD/TUSZdkYIS+CN
XFzwMRH40fgQ6O3n52qC2uBuNQSeYQI=
=ko+5
-----END PGP SIGNATURE-----

--NcujpWxopTaQHiCu--

