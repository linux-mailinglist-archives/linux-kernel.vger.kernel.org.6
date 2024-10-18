Return-Path: <linux-kernel+bounces-371369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 578959A3A23
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1491F263D6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFDB1F5833;
	Fri, 18 Oct 2024 09:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="souU73yz"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3292A1EF951
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729244166; cv=none; b=XXy0T96GbgwpF0/4UouKdfu+aICMykeUBJEiNEJyJgLmYLNpCSidjadCYzGxWfQ5Xvf4jQMZXNRWQ4805FPmBz0PpLeI5sAt6iEJEU0+pWmtKXXqhDnKZidg8KDUHa2L0PpGVohE2+83V28oUNYiU8/DTB5KwUL/bPMvtv3RlDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729244166; c=relaxed/simple;
	bh=jDQE5Xc/NFnpW5Nw8t/wzvuB0RC/Q1Ju0YrG/wCOlqA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YzK+KuEm2vzjEk0Uk4qdoWc9ekferoKNRxlPzS50gJ/eQdY/BIQDmVef4L/5clVrHuaJd5y73hiG4dvJyQhV982njA2Ln1negAOwNcZNdj16hjrmQeZNEqyw9YelTkzTjh5kOa53sRuKb3x472scaP6NS+QH8rFeHrle2PcgLTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=souU73yz; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1729244162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F4Q5pjFxV4dLJAhsTivrmJ808iIdznS4J2cV8bWpHlU=;
	b=souU73yzW/K6zuqC1wKuvnrpoQvQTD9z8b4a1G4tnQk6PzsFRd6vszZaHIMN83y4N7T8WN
	LieM/rS7hAjtkujqkyxZiNIDz3AfgXqeX8UCQI+ncopXohQz6blbHD6J2CubGe5ozZcB9K
	B9Ys1N9prpCiD2CQWZZFZ0AFTOtLau0ePmSeTDHp7h8+oQb0W3glh1UXySshuG2qu9jJB4
	SyVso3HW4Mje23QMtmGizE6bxiL3iE9i+ABlGk9dpUh7Xd+DFsE/HpANjr4Dpg6DhZ+NZX
	rYJVEy0xf1/XxP4WZGgWMOYEF9TyzdL8GEcLFMzpIxOt12OR6sIdqoDNK1BHOQ==
Content-Type: multipart/signed;
 boundary=4e751b745d2d7d1e0292ea89bf0ecffa15671491eb01b3a2ea430744a9bb;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Fri, 18 Oct 2024 11:35:51 +0200
Message-Id: <D4YTW4DVRT68.1Z97ZHDYWTKHT@cknow.org>
Cc: <linux-rockchip@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: (subset) [PATCH v2 0/4] rockchip: Fix several DT validation
 errors
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Heiko Stuebner" <heiko@sntech.de>
References: <20241008113344.23957-1-didi.debian@cknow.org>
 <172841572989.2562611.18254512768409976284.b4-ty@sntech.de>
 <D4X4RACGCRRH.39SMPGMZZ2GK4@cknow.org>
 <D4X8GJV0W6JL.32E469JSATFEP@cknow.org>
In-Reply-To: <D4X8GJV0W6JL.32E469JSATFEP@cknow.org>
X-Migadu-Flow: FLOW_OUT

--4e751b745d2d7d1e0292ea89bf0ecffa15671491eb01b3a2ea430744a9bb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Heiko,

On Wed Oct 16, 2024 at 2:35 PM CEST, Diederik de Haas wrote:
> On Wed Oct 16, 2024 at 11:41 AM CEST, Diederik de Haas wrote:
> > On Tue Oct 8, 2024 at 9:28 PM CEST, Heiko Stuebner wrote:
> > > On Tue, 8 Oct 2024 13:15:35 +0200, Diederik de Haas wrote:
> > > > This is a set of 4 small device-tree validation fixes.
> > > >=20
> > > > Patch 1 adds the power-domains property to the csi dphy node on rk3=
56x.
> > > > Patch 2 removes the 2nd interrupt from the hdmi node on rk3328.
> > > > Patch 3 replaces 'wake' with 'wakeup' on PineNote BT node.
> > > > Patch 4 replaces 'reset-gpios' with 'shutdown-gpios' on brcm BT nod=
es.
> > >
> > > Applied, thanks!
> > >
> > > [2/4] arm64: dts: rockchip: Remove hdmi's 2nd interrupt on rk3328
> > >       commit: de50a7e3681771c6b990238af82bf1dea9b11b21
> > > [3/4] arm64: dts: rockchip: Fix wakeup prop names on PineNote BT node
> > >       commit: 87299d6ee95a37d2d576dd8077ea6860f77ad8e2
> > > [4/4] arm64: dts: rockchip: Fix reset-gpios property on brcm BT nodes
> > >       commit: 2b6a3f857550e52b1cd4872ebb13cb3e3cf12f5f
> >
> > Please revert the 4th patch.
> >
> > I must have messed up my testing previously, but BT does not work on th=
e
> > PineNote with the 4th patch applied and does work with it reverted.
>
> FWIW, I figured out what went wrong.
> My testing was correct, but redo-ing the implementation to make it ready
> for submission wasn't very smart.
>
> With ``shutdown-gpios =3D <&gpio0 RK_PC4 GPIO_ACTIVE_HIGH>;``
> it does work correctly, but I forgot to change GPIO_ACTIVE_LOW to
> GPIO_ACTIVE_HIGH before submitting.
>
> I'll first figure out a better procedure before making a new submission,
> so the revert is still the best approach IMO.

I've now done a new submission:
https://lore.kernel.org/linux-rockchip/20241018092237.6774-1-didi.debian@ck=
now.org/

So please don't revert the 4th patch now.

Cheers,
  Diederik

--4e751b745d2d7d1e0292ea89bf0ecffa15671491eb01b3a2ea430744a9bb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZxIr+gAKCRDXblvOeH7b
biFSAP9UgW4eqqASkSkYTt8RP7eJ9las6XeYd+dsutQV7Sxg/wEA8R9UPgWYv2l9
8EngFl4AJcRtW7RQMxTbNc8+6HF0mwo=
=sBOj
-----END PGP SIGNATURE-----

--4e751b745d2d7d1e0292ea89bf0ecffa15671491eb01b3a2ea430744a9bb--

