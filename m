Return-Path: <linux-kernel+bounces-409896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9A29C9304
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D653728281E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60071AB526;
	Thu, 14 Nov 2024 20:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luW8tAln"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16065EEDE;
	Thu, 14 Nov 2024 20:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731615196; cv=none; b=fEbj/HoKXbfdESkoEVjd6bUzNZxut2ln4ibv74JfIO6ExvryhH08J5xyZ52QuR2SNUCCnN8J94mKwtGdjNSnY687DHledmvcGaWwlRbNjeEZkncHzItrAzjJnPPqc1T1E6jX47JNcpiJsEixZAXAjJEuRF1wbAcPPtqEsoTMyBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731615196; c=relaxed/simple;
	bh=km/eEsWSrKWhwTGSdpfnPapg/ccwqeJd2W0uboQT3Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHtpV+UdK3VVVdm5lpRZFPFXGXLWgvK815Y0isyGQ+GeetpOnHQYDuVjMkHRYEi84eMc+q+u+uFjLCBG4cMAxoh+vQNCK1wTauy/thqnJcqXfu4WR1zUCzZ7/jfrP1yupRisHiiJzBfaqYSZ3wwb6p4PJOtpCQlQxGGZhMC/HKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luW8tAln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D6CC4CECD;
	Thu, 14 Nov 2024 20:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731615195;
	bh=km/eEsWSrKWhwTGSdpfnPapg/ccwqeJd2W0uboQT3Ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=luW8tAlntLOADt4NhTwlSuS+DjwgJJmoxXUZCfmke7+Q689FsPQRF4tsc9GlmIIBZ
	 WtmcM3EmH+VAj0pgkFW6iNb9NFFxMmBwh5ruJAerpH+iHiHEqRvlzcl8diAgoAALoh
	 KW3Ae69yJU4xuB8HA7nfnR6ysXfTt27HCJy9pIAV+0ThuYsdu1DTLg92kcw/iFBBwA
	 9FenclQfTbh6sq6ktWPGuxf/HOKYikd0zYzMhTbN7h7SwN785DCAx26SBp/cChzMSL
	 QyJdlvaIyTBeOOfN2PaaVNoZq7vwHUsr/FG1C/rzARiyRZWDbkbegbIfZGQQY3g+7E
	 F+ic/JacQ5yYA==
Date: Thu, 14 Nov 2024 20:13:10 +0000
From: Conor Dooley <conor@kernel.org>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v5 2/3] dt-bindings: clock: axg-audio: document A1 SoC
 audio clock controller driver
Message-ID: <20241114-zoom-wanted-7dfda7d36f6b@spud>
References: <20241112230443.1406460-1-jan.dakinevich@salutedevices.com>
 <20241112230443.1406460-3-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="K9ZM2+nYnJZ83qMp"
Content-Disposition: inline
In-Reply-To: <20241112230443.1406460-3-jan.dakinevich@salutedevices.com>


--K9ZM2+nYnJZ83qMp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 02:04:42AM +0300, Jan Dakinevich wrote:
> Add device tree bindings for A1 SoC audio clock and reset controllers.
>=20
> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--K9ZM2+nYnJZ83qMp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzZZ1gAKCRB4tDGHoIJi
0l/FAP432TheokBBb1mXfuGWT800uk2Ed6s9mOkVQncD9I71xQEAur/YW7sxvZL5
me+5Anm5adO3g2uYoZ1Rsp/Lyny2Ags=
=KugJ
-----END PGP SIGNATURE-----

--K9ZM2+nYnJZ83qMp--

