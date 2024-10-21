Return-Path: <linux-kernel+bounces-374827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502F49A70BA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8047B1C229DB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDB247A73;
	Mon, 21 Oct 2024 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="s8zO2rvV"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810821C330C
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530781; cv=none; b=EJvGHuEqgzKwgsaRPy+g68h9A44IU7d6Qg5oIAfg19LJCVmcKzBbpOhpSkKXtt9EGtUy7G9r8xXQhDDxn7f6LpVEjS32LnMtUAwCTGthw2pU5pI7hj1ZOVAfZmqJkVXtAOejhNKmYkTV5oBBJMVpFcWiEaf8/Ut+HsVrfaArQf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530781; c=relaxed/simple;
	bh=K0daLSF+0afKDESpJQutcIQsM+eqc+xlyPBd8VxIw9I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=j2289C3gBzROA9JSaRPWzIvYd7Psav+B9CaGbRVoBC89DNOeW+CqKJ+SexeRT3QStmMDUjrjSMEW6C4rCaDsPV9/Ffdo2rRI3ItQN7SdtA+2+0BRmExZd2klJI23SyUgnCC8wDpQSGsHo8Oh+O71JJMqjKdoDQ2Vq3sSsNKSBVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=s8zO2rvV; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1729530777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kvPmkBIx/ivw7uZCk44IFYWnah6/cVTz/JW1FGbUjKI=;
	b=s8zO2rvVtVD9CcaprtGFQ8LrPdb+bLZPCUnGnDpJrlrzP31NQbPavxxG85JIUnshOL1fu7
	roln1zihmHEhiquKA0w745DFuHjIIzPBrndW6xngmpR9w9OOI69F3RV2r6VbEOaj0BLyXN
	l/sY8ixZP8hoSFgp3Usj4a5WJ5YQYIq0pDv/m7Hysxiq7OC4ggHrGRhZKALBDGnF4rbsvW
	BMzlQMkVWun94YLt1HEeqd27yKYQ+JrL0FYbgPYBbFxyfyesnVOFyn6TMB94700IjBhWnF
	8THHa4aYFOaag07mCzwy7yQGfx6VIM8ZLty59CRkdw34/CilVeL+TK01kAAA0w==
Content-Type: multipart/signed;
 boundary=bf042a1c9c42b97560b590a0475495dc3bbc5c4b2774aa824be576d86101;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Mon, 21 Oct 2024 19:12:53 +0200
Message-Id: <D51NHOTBIUZO.3A40UBLT2ZXCN@cknow.org>
Subject: Re: [PATCH v2 0/5] Enable HDMI0 on several RK3588 based boards
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Heiko Stuebner" <heiko@sntech.de>,
 "Sebastian Reichel" <sebastian.reichel@collabora.com>, "Luis de Arquer"
 <ldearquer@gmail.com>, "Alexandre ARNOUD" <aarnoud@me.com>
Cc: <kernel@collabora.com>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "FUKAUMI Naoki" <naoki@radxa.com>
References: <20241019-rk3588-hdmi0-dt-v2-0-466cd80e8ff9@collabora.com>
In-Reply-To: <20241019-rk3588-hdmi0-dt-v2-0-466cd80e8ff9@collabora.com>
X-Migadu-Flow: FLOW_OUT

--bf042a1c9c42b97560b590a0475495dc3bbc5c4b2774aa824be576d86101
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Sat Oct 19, 2024 at 12:12 PM CEST, Cristian Ciocaltea wrote:
> Since the initial support for the RK3588 HDMI TX Controller [1] has been
> merged as of next-20241018, let's enable the HDMI0 output port for the
> following boards: Radxa ROCK 5A & 5B, Rockchip RK3588 EVB1 V10, Xunlong
> Orange Pi 5+.

Would the DT changes be the same for the ROCK 5 ITX?
I don't have the board (yet), but apparently some bought it on my
'recommendation' (I only mentioned its existence) and it would be cool
if HDMI out would work for them too.

Cheers,
  Diederik

> [1]: https://lore.kernel.org/all/20241016-b4-rk3588-bridge-upstream-v10-0=
-87ef92a6d14e@collabora.com/

--bf042a1c9c42b97560b590a0475495dc3bbc5c4b2774aa824be576d86101
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZxaLmAAKCRDXblvOeH7b
bh1SAQDblaBTFNz+sCdobwzX/XFw/7vjsd8y5vTigDHV9wRqtQEA2+t2bUSsMAxR
Fr6eO+/kszZiWxFDBBRrMxzb5GouVQ0=
=4uwl
-----END PGP SIGNATURE-----

--bf042a1c9c42b97560b590a0475495dc3bbc5c4b2774aa824be576d86101--

