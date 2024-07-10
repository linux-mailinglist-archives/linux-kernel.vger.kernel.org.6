Return-Path: <linux-kernel+bounces-247713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA3B92D384
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1EB11F211E9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A0019309E;
	Wed, 10 Jul 2024 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEenr21p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CD0193074;
	Wed, 10 Jul 2024 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720619694; cv=none; b=Shnsbztrbczvo31ceo/sbA3RbNz5wejA13izJcbErJLHMVNrtV/pvN/ddQlWyzhj076RHOHyMLgg0qrOU0Hg4qOewwilEIThw34nfOmePr8kMgXMt91Dto7x22zjB3kU3tV7B6+q4ShozEFSal9OYqFJzsRDYLYm1pBWyPrTeUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720619694; c=relaxed/simple;
	bh=y2gmS34Q778sKnc3UY4lw/NDrvv5SpWlH3ZR36Y0R1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRW9gVDpAr3GXDDYsGgDpXvL/2We8AQLkeJS1qTGEH0VhUOyBxqIuPwdiBmaa6qLVUgT73SsIi16PAqeGF39K3ceVsHLp16MrRWme1em8GPSUE2pyqjLf6UakLDy1Lmgyv19oyFfXLZ1ZS03Z09WhtD11wdHXKkAvUKgn6SHxPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEenr21p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD26DC32781;
	Wed, 10 Jul 2024 13:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720619694;
	bh=y2gmS34Q778sKnc3UY4lw/NDrvv5SpWlH3ZR36Y0R1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QEenr21pF9ItOW6whCxqpxVQR5dscccyC+fUJq2SoJ0JKToYLDcRIK41jNGFQZYKl
	 OsMq/AIaec9MWsYlhR+nFXLqBS1DNFMETYGcS4U86Na3kmiwQkrL3wAWMx3BPt/AFj
	 En1qw7YpBF2x0qjn/KTTzbpQA81J4qGLz84XecmVoC9aJbi8CQBG9V+V4jEOBdahFE
	 ZHtFhiYacbcw33jMJRUzj6eArGoVO8ePZv3O519ydSI0XhJNfmjq1lKazZeOcYPSJL
	 Csed9E3jVTGuzzBGTbMMMUBrcaaLhoSFPrkGo0j1ymXo/A8TL+Pb1I82sl1wOvsSI0
	 YfUPRkqPmM8Dg==
Date: Wed, 10 Jul 2024 14:54:49 +0100
From: Conor Dooley <conor@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: document BOE
 TV101WUM-LL2 DSI Display Panel
Message-ID: <20240710-console-dodgy-d7d48667eb96@spud>
References: <20240709-topic-sdm450-upstream-tbx605f-panel-v1-0-af473397835d@linaro.org>
 <20240709-topic-sdm450-upstream-tbx605f-panel-v1-1-af473397835d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MEX5X5+p8+Bv5NnH"
Content-Disposition: inline
In-Reply-To: <20240709-topic-sdm450-upstream-tbx605f-panel-v1-1-af473397835d@linaro.org>


--MEX5X5+p8+Bv5NnH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2024 at 03:05:44PM +0200, Neil Armstrong wrote:
> Document the 1200x1920 BOE TV101WUM-LL2 DSI Display Panel found
> in the Lenovo Smart Tab M10 tablet. The controller is unknown.
>=20
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--MEX5X5+p8+Bv5NnH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZo6SqQAKCRB4tDGHoIJi
0m8lAQCDsd9XInZIae0ukgPefMVHdfVotzljYPbRmEP+1BP27AEAv4A0Vqu2vrbA
w0lGgrSbFErSHtc63vpQ2guyYxoYvwc=
=tWU0
-----END PGP SIGNATURE-----

--MEX5X5+p8+Bv5NnH--

