Return-Path: <linux-kernel+bounces-186148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB87D8CC057
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77661282890
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C0382889;
	Wed, 22 May 2024 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxrcFi90"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432BD82486;
	Wed, 22 May 2024 11:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716377756; cv=none; b=md0CvNaJWAHtzHf8RDpHHmMaD3jxrDeEMcBVOYkBSmQ4zNkChqsjV8QqK+I4Ls5jvRJYAyq/QNUEL75p+JmsYyjFcIQIh08BCCSuHMp9K4DUk+pbAS10oyEa1oMZsmG4PnV1U4h8jSRVCMVmgolxyF6nXsHaGgY6hAYDTJM5zbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716377756; c=relaxed/simple;
	bh=u2Kpu450wSnKWwvLO/UisnjUxhEBL1STdP2N6DjA6QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmCvHf/XVt8MbbsDJaLYYao4gE8ul2XqEKnTo9VRSgGuqOYLiOpMyFVlvVv1Yh8yfXaQjCY2Ghed8myvf1FogX7FaeqjzQBDn9X9KTGtZ98v+jArHpMjgw+y36sMVy4mOxbiUvRrbG24vcF9Co6xxxyEwpSqSARRU5X1W3rElvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxrcFi90; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40DAC2BD11;
	Wed, 22 May 2024 11:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716377755;
	bh=u2Kpu450wSnKWwvLO/UisnjUxhEBL1STdP2N6DjA6QA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CxrcFi90U0N+Y69PMsTtNijGMFFUnNeTLxXiwAzh1Gd2obFlDu/3qMLWJFWX3Tw3G
	 HisFhhjVj0nBmH+TCHKXEJaY46xFp8/Kbr1wzvGKLEXGHExaZNc4yLsZCn8uGJcCkC
	 TNMs8SKIZmCdvpSGuZRhEUOGWf/SfiFzZpjqQzN/a8IEaRpf8QSlb4DZMeCMqPV/Ab
	 Ncj6P2AFAZdULLsWxuRMcI0FSyrLMccxjquAXomjWWCwQJ14SRHw15Z3CW3XO+kttr
	 P7K3JAqXS8OGW2kWNfz8HBMNeWtIvbx+nCl7PO4s0ETc2DzLcOScFtQdfFIfUQuqBP
	 gffNCvLrBLXMA==
Date: Wed, 22 May 2024 12:35:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Alina Yu <alina_yu@richtek.com>, lgirdwood@gmail.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, cy_huang@richtek.com
Subject: Re: [PATCH 2/2] regulator: dt-bindings: rtq2208: Add specified fixed
 LDO VOUT property
Message-ID: <05843386-92f4-4246-a633-315c3178d86f@sirena.org.uk>
References: <cover.1715846612.git.alina_yu@richtek.com>
 <9c1bbe4b38a4ee5650d888478f1ce2cec2733669.1715846612.git.alina_yu@richtek.com>
 <5d26b19c-7679-4dba-a9ba-a7368d39b474@linaro.org>
 <20240522090302.GA19548@linuxcarl2.richtek.com>
 <b094ce68-9ce2-411d-99f2-1f143e4c3347@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JFA9gN8tjjyEAmoi"
Content-Disposition: inline
In-Reply-To: <b094ce68-9ce2-411d-99f2-1f143e4c3347@linaro.org>
X-Cookie: Bridge ahead.  Pay troll.


--JFA9gN8tjjyEAmoi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 22, 2024 at 11:27:06AM +0200, Krzysztof Kozlowski wrote:
> On 22/05/2024 11:03, Alina Yu wrote:

> > Due to the fixed LDO VOUT being outside the range of the adjustable one,
> > a special-use property has been added to avoid overusing the constraints.

> Hm, why exactly this is not a bool property? What are the benefits?

It avoids confusion between invalid constraints specified on the
variable voltage regulator and allows us to validate any constraints
that happen to be specified (though it'd be pointless to specify
constraints).  The fact that the regulator could also be variable
voltage is asking for confusion if we use boolean.

--JFA9gN8tjjyEAmoi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZN2JUACgkQJNaLcl1U
h9BHCQf7BRNB5Tl6030hx5cP3OOQVNDxhTNvG2H2sY14s9X3i7eDXjSBnXQaP8jG
KLpSR/o0ha6/YiMfx5sGFQ+DuCaeGYzYBqk9DXfP3wnhwO1PJDm7NNpKhMOWSJLI
xlxsPP03n9Qh4Wl1bjXJjPgxnp/38Q88JnG2s84MPwMacADeUFfTxFWz12oE7/g0
aNwbmzf4OIKZlMK7NeQBz5Z11mPUzqGbxxysLRYVgvBO9xHq5J4xyL3be28Jcefj
pE3P0JM4bjJytpPukGG61TIj+z2vUdGQnebptqIQWI7aoI0Xz5cRkrju5nTX3oll
VpLuRpvq4uZout3Pp+bz/vhhRPMFyg==
=Cx7R
-----END PGP SIGNATURE-----

--JFA9gN8tjjyEAmoi--

