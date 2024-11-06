Return-Path: <linux-kernel+bounces-398327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690CF9BEF9B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF5C2814BB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12874200CB7;
	Wed,  6 Nov 2024 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="civDo1qo"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083291E0DC4;
	Wed,  6 Nov 2024 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730901406; cv=none; b=CWNHF88z4siK+KUzT5Z4bcr22J5AcAc+i7aQaq7yy2N64SkZ41KvBe32LGPnhTr4TjRjCSzsuffAUSI+25rKNB4AXu7QGcwGTm3mlS3HHxQzoymBZHmpr7cVnDTEImZMQtSr6R8yNh5rwijYNiIPKXG90+pLzoQrTfWNggYNAts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730901406; c=relaxed/simple;
	bh=7J7DnXd/AUvMjHWLvIl/lim+ofnGteAjqqRMdS9BgGw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FS3jsq0CvRePI4+gexZi9v9FyGEUnplfNSllaM5mMlwx8Lu9xyQeOkCP8YoPvfIAeDwuMu5tQLYviz36172xbIHW0QEyWe7WLsfOWiL0dQxCWM+1e8z0AkQrVz6IVw1O8sb2NZ4yZ/mmigHqB6ajLD4WdHcN0X+EmNREFlEQhSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=civDo1qo; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1730901402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NHHYML0BEoPmu07uEuVWCMR6UzMbCnRMamSxbmnkn0o=;
	b=civDo1qoh0TP45iFIHWo4U31+mpvHe8lkbDh3GuEa0ZZmzQA7y+buDTUPY8xijrRBFSqrA
	zb3ECm1xYuV+iBNrn1zt5jb/GJLTMj06G+kgpeUfKzmgfNYRKy3DE3naaYSbrmmPFeYAg/
	9x2nE4nLfvRsjInfpYCYoa0zGncOLDL2YA3n0tAYHybQEsTG6oqYJmsL4ywlHV9x6iHVij
	txY05WsCJ9qvX8B72j01ZStfRUv20+6gxHIhIWisOLMziav2EQ8BjtmVp0OHdG/qHfOb4Z
	V3j4BzFKr+Owb0XOY3mlV9SJIJCzEdOJgxJIINdOjazassPtDa5APqVneEMwag==
Content-Type: multipart/signed;
 boundary=012b4e88e5ada0d79e0d754e24911a278ebf87aafc76bd346a02ee35533f;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Wed, 06 Nov 2024 14:56:31 +0100
Message-Id: <D5F5C1RWVHG5.TSHPO29TXYEF@cknow.org>
Cc: <quentin.schulz@cherry.de>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Heiko Stuebner" <heiko.stuebner@cherry.de>
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: add mipi dcphy nodes to
 rk3588
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Heiko Stuebner" <heiko@sntech.de>
References: <20241106123758.423584-1-heiko@sntech.de>
 <20241106123758.423584-2-heiko@sntech.de>
 <D5F525WYXDO1.3I92CTU67RVF6@cknow.org>
In-Reply-To: <D5F525WYXDO1.3I92CTU67RVF6@cknow.org>
X-Migadu-Flow: FLOW_OUT

--012b4e88e5ada0d79e0d754e24911a278ebf87aafc76bd346a02ee35533f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Wed Nov 6, 2024 at 2:43 PM CET, Diederik de Haas wrote:
> On Wed Nov 6, 2024 at 1:37 PM CET, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@cherry.de>
> >
> > Add the two MIPI-DC-phy nodes to the RK3588, that will be used by the
> > DSI2 controllers and hopefully in some future also for camera input.
> >
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 42 +++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64=
/boot/dts/rockchip/rk3588-base.dtsi
> > index 51ba7563f7d0..8c95c56e8097 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
> > @@ -576,6 +576,16 @@ sys_grf: syscon@fd58c000 {
> >  		reg =3D <0x0 0xfd58c000 0x0 0x1000>;
> >  	};
> > =20
>
> No power-domains property?
> RK3588 TRM v1.0 part 1 page 1097 has ALIVE(PD_BUS) for
> MIPI_DC_PHY0~MIPI_DC_PHY1

Please ignore. They're defined in patch 2 of the series.

Cheers,
  Diederik


--012b4e88e5ada0d79e0d754e24911a278ebf87aafc76bd346a02ee35533f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZyt1kwAKCRDXblvOeH7b
btIaAP9GEyWWHj2Ucfg8SHEqGPFXB1DOlzMCnFSxDRzE8HkkHQEAoDu8i0KMPRAh
xQ0hirMyEoP9TjRU/1stf0TaofvvzQQ=
=oNr/
-----END PGP SIGNATURE-----

--012b4e88e5ada0d79e0d754e24911a278ebf87aafc76bd346a02ee35533f--

