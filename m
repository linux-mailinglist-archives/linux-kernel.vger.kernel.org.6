Return-Path: <linux-kernel+bounces-194394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A56BB8D3B81
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5751F279FF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8DD181CF8;
	Wed, 29 May 2024 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="eM4NCV4d"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132E5181315
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998147; cv=none; b=M6wcYPWtSJBaYXMWiG8QpiLGfXWdyf0ubnMCby3POG2oG5pSI5jpFM7aZcB/mtUpJtNPZqXh4ealYoasHktfFa61TUB1XAxHRiL+E73hKIDTQHKHHv/Rq7IjDvh0p6liBI+h3wXxAe8786cYrOYNk1vuKSKvXe01vIhcQo9pvE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998147; c=relaxed/simple;
	bh=+pYI+bMJGo4NqoiYpBOogZyuwpPP/luQTBEuiisPj/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SkqsHSf9Ij70zmNSACWwN2sNy3suzEEJ6rgim7rJFZK9rJRxMY/qjo6fb2vxymC61OfMubhAb5La9i37kwLVnY4z3quboG4OFr9j1uJ+Ts4WSzxqlKLHNiEeg4BOKgImTDeKPK0ySZ6bQEjPeXiw+Tzot428qbNK+cfiBgGjqR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=eM4NCV4d; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Envelope-To: andyshrk@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1716998143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4v4JxLcVLd8gWkKTMWCIwey80lFqT9gw7qVAp737Dzg=;
	b=eM4NCV4dS8iSwN/mOl5uzlsEI1LjYgeCgfecjsWoyo3XXG8yFFz3DVfV7jdPbn17iu7gSi
	OdUK3Gcy58sPhOhc274/8+ybpTz9LTNiBSFy7DxkRogyT5zvsAbpx00b2EgfIyM5Lmlabj
	tJFQALmxUD2R/VvbaX2jGYyyqo0bijRCJfjqCawV2B+khyJFolrhDVt7yE5LOAI8JXtvXI
	eiRGXgW6DB3CPwynNORtxQPH+2PujPvtJ6Z91puigUlg9ZormsIIiRAf9xEabIqnp1Cmr1
	l9pLLuredi+4cWZzDPKINY+nV6Qa6dPfMaAcDmXm0+wh2B4rZ9tXBNPQ7sPy7g==
X-Envelope-To: linux-rockchip@lists.infradead.org
X-Envelope-To: heiko@sntech.de
X-Envelope-To: mripard@kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-rockchip@lists.infradead.org
X-Envelope-To: hjc@rock-chips.com
X-Envelope-To: tzimmermann@suse.de
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: s.hauer@pengutronix.de
X-Envelope-To: andy.yan@rock-chips.com
X-Envelope-To: heiko@sntech.de
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Diederik de Haas <didi.debian@cknow.org>
To: Andy Yan <andyshrk@163.com>, linux-rockchip@lists.infradead.org
Cc: Heiko Stuebner <heiko@sntech.de>, mripard@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, hjc@rock-chips.com, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org, s.hauer@pengutronix.de,
 Andy Yan <andy.yan@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 0/1] Fix the port mux of VP2
Date: Wed, 29 May 2024 17:55:25 +0200
Message-ID: <2397969.FhQbyb98Gs@bagend>
Organization: Connecting Knowledge
In-Reply-To: <171405838036.2897712.4067984796758491640.b4-ty@sntech.de>
References:
 <20240422101905.32703-1-andyshrk@163.com>
 <171405838036.2897712.4067984796758491640.b4-ty@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7320409.ZChHLWW2r3";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT

--nextPart7320409.ZChHLWW2r3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
To: Andy Yan <andyshrk@163.com>, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 0/1] Fix the port mux of VP2
Date: Wed, 29 May 2024 17:55:25 +0200
Message-ID: <2397969.FhQbyb98Gs@bagend>
Organization: Connecting Knowledge
MIME-Version: 1.0

On Thursday, 25 April 2024 17:19:58 CEST Heiko Stuebner wrote:
> On Mon, 22 Apr 2024 18:19:04 +0800, Andy Yan wrote:
> > From: Andy Yan <andy.yan@rock-chips.com>
> > 
> > The port mux bits of VP2 should be defined by
> > RK3568_OVL_PORT_SET__PORT2_MUX, this maybe a copy and paste error when
> > this driver first introduced.> 
> > Hi Heiko:
> >    Maybe thi is the problem you met when you porting the dsi2 driver.
> > 
> 
> Applied, thanks!
> 
> [1/1] drm/rockchip: vop2: Fix the port mux of VP2
>       commit: 2bdb481bf7a93c22b9fea8daefa2834aab23a70f

Wasn't this patch supposed to be part of 6.10-rc1?
--nextPart7320409.ZChHLWW2r3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZldP7QAKCRDXblvOeH7b
btUeAQC4sSMaBwRDiexmeDgGbIxjwMuMYE0XHbgLjJI+tvfh9QD/R83eqtzCIjKM
dqgg+qGOUYmVLyE8XIDN42D5ZijcDQY=
=uCK0
-----END PGP SIGNATURE-----

--nextPart7320409.ZChHLWW2r3--




