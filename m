Return-Path: <linux-kernel+bounces-229299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4653916E0A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998881F27FA2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C8A174ECA;
	Tue, 25 Jun 2024 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLbi8gAp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202BB16F0E2;
	Tue, 25 Jun 2024 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719332737; cv=none; b=e3XCsMOXSoeF0TsP+1mqORaFao7YZ05MLclED3LCPQesuKMI2ifU+aOOAdFnFlIyGE4QUNzreW2YFxuWxKd6++6r0kmQzqiCpR4pB1XvZAdtcxatxiuwgpa0/o6EDZAWlUIMe6ZtaFrJ24xjzs4KhHyqtPwfQ0/al3iXOji/WJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719332737; c=relaxed/simple;
	bh=11jynk5a/49/ElTJ9oo1LXDPA26BwDFO65Ty9CP0sI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nl2bNOCawfbQkGVoZtwZoZq1C7HprdH47x/LiSSBjvCo2WAmy/yEU574ADEqtIsDmmfJ5onoOxh+pyafxdRCOPmVVCiKwB71fbgJFH+lTp/UBbs/c/zg5GB59B6YZscfnwr9jOJxON+Xq53F0Fl/sgVF+lCzj+lRxXfiPF3uhZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLbi8gAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DC4C32781;
	Tue, 25 Jun 2024 16:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719332737;
	bh=11jynk5a/49/ElTJ9oo1LXDPA26BwDFO65Ty9CP0sI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eLbi8gApgYzOooqbHt3pXRvY/aqVqEuWUIGT0CsiZR3e9y+8WYghRJFNfRMK8jBMh
	 /LGtBdrfjEGpPQgIylcsJZi+/luO8Z0LUb0fp4ZAMXrqNv0gVf9Hyk/gyG82eabeN8
	 vM8gQIggsa4uvJ75C1+HVIROSOgZ2j5rdBVDhyWBTJgJwFbWBcxraSp+M4j8j0+OGF
	 Tk/p7n3J+NhBOh/ShrnjhzoySQsmwsN+I1P5byXlzlKFdDATn3fpjkyAuW0DkafKM3
	 0Djwr+gyV7iVX5jsJhHb7MomXSaSN+TIAgkmoCwbvKu9F6d8PcNRouVXpM8KGtUcfG
	 muzOE8EiR0UJA==
Date: Tue, 25 Jun 2024 17:25:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gunnar Dibbern <gunnar.dibbern@lht.dlh.de>
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: add Ilitek ili9806e
 panel controller
Message-ID: <20240625-rage-quarrel-a11f952c335b@spud>
References: <20240625133317.2869038-1-mwalle@kernel.org>
 <20240625133317.2869038-2-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wAaoyByR7rwocqHF"
Content-Disposition: inline
In-Reply-To: <20240625133317.2869038-2-mwalle@kernel.org>


--wAaoyByR7rwocqHF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 03:33:16PM +0200, Michael Walle wrote:
> Add the device tree binding for the Ilitek ILI9806E controller which can
> be found on the Ortustech COME35H3P70ULC DSI display panel.
>=20
> There are no peculiarities except for two different power signals.
>=20
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--wAaoyByR7rwocqHF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnrvewAKCRB4tDGHoIJi
0g9nAQC2COqHdQsCfqnwo+sayhzov4sVoNF8rbDAdYwfX1Pf1AD/Rc5AvjVuPaED
vu0KoJdqYy8bZZT59CZas5Y1in7tXwM=
=MVgJ
-----END PGP SIGNATURE-----

--wAaoyByR7rwocqHF--

