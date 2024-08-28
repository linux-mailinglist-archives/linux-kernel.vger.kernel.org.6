Return-Path: <linux-kernel+bounces-304880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D8696262B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1DA1285D68
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FF516D9BF;
	Wed, 28 Aug 2024 11:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="E5Nr5HWw"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FFA171E5F;
	Wed, 28 Aug 2024 11:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724845056; cv=none; b=mpjf4dgBMCmm3sGw+61b3kwBkqYo3KNSvyFREO/AAUTR1eZBc3V+v6uwZIU83mMHqgqCXegXRivdYCgAh25a8BiSDuUGdT/sdz+BOedBpR3Mc2Buy5nDLzz4Sm7jB15itini80R5h85oQDBLlCAvCT0ewzSLIg67w61HQx3PFA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724845056; c=relaxed/simple;
	bh=Rt23x+Z3I8iukH4ZIcW8lmeAjhdTehSaRhcHPHwj+BA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=VaQkNHRNd+NDrmT8uwyWQDLpXlIab5oD8UghL4TQ/Iz2mpD7ygQ8QDpOMBfJY7c6VpbBipUYK+eg80oKshRJX0aIPdHBjygS1Qf6PhjqiRsP6wHLk0C8F+xfEAsr3v4DOBZQvHbaoJrVPPczYe8Z+mJ3EOyKLxBqvNHtq4MvVGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=E5Nr5HWw; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1724845051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rt23x+Z3I8iukH4ZIcW8lmeAjhdTehSaRhcHPHwj+BA=;
	b=E5Nr5HWwMY8ydf5lboDmLryWqYnrHUY4fv7b3Hxv4L3UE584qjhFefqNT62Zpxx0mnEGZk
	q5Yo4RVp4ohCMKA+lNu7EC9my5lkbPhOXRxVXcMAt/oAEKz3n4zA+3VarwvsgjdvHHAaRY
	Il35luGF4np0tKyHBBRVKzKExcA1Sm7dOKGY2BOZAG/lSWLoKUbGE2M95RTbC1a9QZch9m
	8jzWo56nXQBt3mt2pkdwJb8jY1Lp+RobBBfyKugM6TKzvRvDfkvt3XtwZ8iVNwJYLoue9K
	PEEMN2e432Mh856s55h2N5Kj4Y/vzXWP3lrdDu3+dzbWxQKpS6gsTmuxM/JHTA==
Content-Type: multipart/signed;
 boundary=8176c0910110b2751c496c935bb6f58df2d108ac65f75328a6bb1174599f;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Wed, 28 Aug 2024 13:37:22 +0200
Message-Id: <D3RIJDLW8QYE.1HYYTUUBD1H5M@cknow.org>
Cc: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH v3 2/5] clk: clk-gpio: update documentation for
 gpio-gate clock
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Heiko Stuebner" <heiko@sntech.de>, <mturquette@baylibre.com>,
 <sboyd@kernel.org>
References: <20240828101503.1478491-1-heiko@sntech.de>
 <20240828101503.1478491-3-heiko@sntech.de>
In-Reply-To: <20240828101503.1478491-3-heiko@sntech.de>
X-Migadu-Flow: FLOW_OUT

--8176c0910110b2751c496c935bb6f58df2d108ac65f75328a6bb1174599f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Aug 28, 2024 at 12:15 PM CEST, Heiko Stuebner wrote:
> The main documentation block seems to be from a time before the driver
> handled sleeping and non-sleeping gpios and which that change it seems

s/which/with/ ?

> updating the doc was overlooked. So do that now.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>


--8176c0910110b2751c496c935bb6f58df2d108ac65f75328a6bb1174599f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZs8L9AAKCRDXblvOeH7b
bv4UAP9DMhUi5AxRybS8zex8A36FmbWrDyUmxWT81dQ5DLnq3wD/XM+7U9lbgS2g
Ai6Vjn85KETcvxvY+0MI3D/hSyLylg8=
=vX1l
-----END PGP SIGNATURE-----

--8176c0910110b2751c496c935bb6f58df2d108ac65f75328a6bb1174599f--

