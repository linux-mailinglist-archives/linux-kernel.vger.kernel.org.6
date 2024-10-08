Return-Path: <linux-kernel+bounces-355798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 540F0995742
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00DC1F231BF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FA0213EC2;
	Tue,  8 Oct 2024 18:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="By/cPCEb"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BF5213EC6
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728413751; cv=none; b=fyo4iID32HNnQJtU+km7Gcr8IFd81DjLtNRpxTk0p7bf1W3qT8uyflrruNBUuoRugNziB6qJCEcK+a7JsjG4+4X9ykRyDDhIo8P5G0+FibQFBuoCrsqXPqct4JfxbF8FeJELtRDMaKw+PwWYzzDZ3Vq/zJlWA62l3di0yEczOCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728413751; c=relaxed/simple;
	bh=6pIwymGOgGwBExwNMf7+e5M3D1A73/fqXlHGBi/x4R8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=hBwEWHPpK3VnyVHNH7d3U2C4Eahvnqucp7/MduGenOXah/aRuyOJZ1lVKv0EgwqQVhqGrDMtnFvAbcMSGnhBUO/ED6KgaIL0GlXDFHHR9CtUV2qu4aiWnVC6La692J0lUxv/3XiaRSOJXyDhN/duy12tpN2asTFSkpuFrqvJp+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=By/cPCEb; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1728413746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JDuErN1Auxr6ysu/+eLU20CGd8PRtkQZVoMuxVC2HnU=;
	b=By/cPCEbi14X259+giAyG1muNCXQuu/bN4P640/FesFGvqDGXyyNqFyUMzXmsCbzP9GRw0
	of7uW+mJALcUd7XrpCHYk3VaC1Y/eL/+36CslzVJYNXq3Dhk+TPOYdF9Y60yKYz9QGXU06
	l/6GCj7jdKUIQARQSUHdLxP8167kKWKMZp4qFoADE8SGCG1NbzV+BIJtGHomD2CFpTeQa0
	zNnJKsufxzo40D276oaUKPEYS7HwHEIp1wUjumpX/ER3PHHmfNmz7x0LRjuA8BgKRSV73Q
	6G/D51UfCJTb9s7lIv+5OjDYoZRvTHinp836YJmV0y8e+H586WFlVEj2aysBLA==
Content-Type: multipart/signed;
 boundary=739a0fdf5b1fcc13df7ae7eaf2f2533e1b5977cf4b7fc59b27bf68bef8be;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Tue, 08 Oct 2024 20:55:34 +0200
Message-Id: <D4QNJ85V43NU.YD01E8AB4116@cknow.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Michael Riesch" <michael.riesch@wolfvision.net>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Heiko Stuebner" <heiko@sntech.de>
Cc: "Dragan Simic" <dsimic@manjaro.org>, "Samuel Holland"
 <samuel@sholland.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Diederik de Haas" <didi.debian@cknow.org>
Subject: Re: [PATCH v2 1/4] arm64: dts: rockchip: Add PD to csi dphy node on
 rk356x
References: <20241008113344.23957-1-didi.debian@cknow.org>
 <20241008113344.23957-2-didi.debian@cknow.org>
 <e07990da-8ac6-43ae-8e21-14988ee5fcbe@wolfvision.net>
In-Reply-To: <e07990da-8ac6-43ae-8e21-14988ee5fcbe@wolfvision.net>
X-Migadu-Flow: FLOW_OUT

--739a0fdf5b1fcc13df7ae7eaf2f2533e1b5977cf4b7fc59b27bf68bef8be
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Michael,

On Tue Oct 8, 2024 at 2:32 PM CEST, Michael Riesch wrote:
> On 10/8/24 13:15, Diederik de Haas wrote:
> > The "rockchip-inno-csi-dphy.yaml" binding requires the power-domains
> > property. According to RK3568 TRM Part 1 section 7.3 (page 475) the
> > CSIHOST is placed in the PD_VI power domain.
> > So set the csi_dphy node power-domains property accordingly.
>
> Thanks for the patch. However, I am not sure about this one.

Thanks for your reply.

> The CSI host sure is in this power domain, but we are talking about the
> CSI PHY here, right? According to the table CSIPHY is part of the power
> domain "ALIVE", which leads me to believe that the power domain is not
> necessary here. However, I guess you could put "RK3568_PD_LOGIC_ALIVE" he=
re.
>
> It should be noted, though, that I still haven't figured out what the
> role of this CSI host actually is. I know that the RK3568 ISP has its
> own MIPI CSI host controller within its register space. But I can only
> guess right now that this CSI host is somehow linked to the RK3568
> VICAP, which is also capable of receiving MIPI CSI. Maybe we can leave
> this up to however brings up the RK3568 VICAP MIPI CSI feature :-)

It indeed isn't as clear cut as I want(ed) it to be.

Given that you're also the author of commit 29c99fb085ad ("phy:
rockchip: add support for the rk356x variant to rockchip-inno-csidphy"),
which added support to the driver part, your opinion should have more
weight then mine (IMO).

Nonetheless, I collected some extra data points:
- The TRM part 1 makes several mentions of 'dphy' in a block describing
  'GRF_VI_CON1' (page 381 & 382). The above mentioned commit only added
  'PHY_REG' for 'CON0', which I assume was deliberate given your
  response above. But 'GRF_VI_CON1' does have 'VI' in its name
- In rk356x.dtsi there are 'dsi_dphy0' and 'dsi_dphy1' which have
  'RK3568_PD_VO' in their 'power-domains' property. Page 475 has
  'DSIHOST' in 'PD_VO', while 'DSIPHY' is (also) in the 'ALIVE' power
  domain. So to be consistent it seems to me that 'csi_dphy' should be
  in 'PD_VI' or the 'dsi_dphy' nodes should be placed/moved to
  'RK3568_PD_LOGIC_ALIVE'.
- Of all the compatibles from the binding, I only found
  'rockchip,px30-csi-dphy' referenced in DT files (next to
  'rockchip,rk3568-csi-dphy' in rk356x.dtsi) and in px30.dtsi the
  'csi_dphy' node has 'PX30_PD_VI' as value for its 'power-domains'
  property.

But this is all 'circumstantial'; it would be nice to have a clear
answer (from Rockchip?).

Cheers,
  Diederik

> > Fixes: b6c228401b25 ("arm64: dts: rockchip: add csi dphy node to rk356x=
")
> > Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
> > ---
> > changes in v2:
> > - No change
> >=20
> >  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot=
/dts/rockchip/rk356x.dtsi
> > index 0ee0ada6f0ab..d581170914f9 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > @@ -1790,6 +1790,7 @@ csi_dphy: phy@fe870000 {
> >  		clocks =3D <&cru PCLK_MIPICSIPHY>;
> >  		clock-names =3D "pclk";
> >  		#phy-cells =3D <0>;
> > +		power-domains =3D <&power RK3568_PD_VI>;
> >  		resets =3D <&cru SRST_P_MIPICSIPHY>;
> >  		reset-names =3D "apb";
> >  		rockchip,grf =3D <&grf>;


--739a0fdf5b1fcc13df7ae7eaf2f2533e1b5977cf4b7fc59b27bf68bef8be
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZwWAKgAKCRDXblvOeH7b
bmodAQCBcwCIgvd9UHVv/WX9kntNibQ3vLI0rpAX+9rBhgzvQAEAr3TExg+y9mrl
hf4D6cRD9gWX+/OHYN/FLDk/SoNEfQk=
=PxK6
-----END PGP SIGNATURE-----

--739a0fdf5b1fcc13df7ae7eaf2f2533e1b5977cf4b7fc59b27bf68bef8be--

