Return-Path: <linux-kernel+bounces-362609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCD899B6E0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 22:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F6A1F21E49
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 20:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261E815252D;
	Sat, 12 Oct 2024 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="u6fh8US+"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730311B977
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 20:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728763364; cv=none; b=RHjYVxV+wR7fMxN7kQJK3+VykFv1BTGkx523roDDhvDXdy5lceiagSPS5wj35bNb+8kINAQQmV2JryrLDahaKaOx++XWEH/jEee3AmKHHJ1G3dJsmzuJr4bXO3iwzG93qrJjJBwFPYfmYXPtBCMCko+T4YqejqXs6sRWVPQp0E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728763364; c=relaxed/simple;
	bh=PVHa9X+HNIfAtZ9K6pNvtZEk43SFZRVkQNKYwNcl4qc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Ts9ZfzDZsU0rRsNMHaep2LMYUaf5KpqA8O1v8Ynx/9LFwJ1h2mHKRaLrtdeL8Ejmuzow8FgNjk2Vm7mlr7LtCsa2Y/n2bObisoZLkPagEcnBHB+71sutdkUTMpQuQK3MJ5UhJ8sIsZDmnvjcvv/uzqHof1cxK0/9r4f5qhv79O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=u6fh8US+; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1728763355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/OHT9QdN7wzd/CkALWfMYR0kdujeKzv+3XUMfTAODMM=;
	b=u6fh8US+TgcJVH89X8tgPtR4yEzMKofevLFrAk0fVfDNiyzVUb4CFKruN9k4qhodNxfDXw
	moug2pGAXgEgKCa2HqfTuwBKZEI/yy0kDAipJBs3SNsYCeKWmY7oueTAVzpt9epXUTGc1A
	4HWO1ghZ5D0vh7RxiUB4vMLYOuHQrlcbbMibcpImcaV1+q+p78cUx7F6mWccQsv5Mj6xbg
	S3ZUK1gDB3IVS7SUGShD6KSAREGAMhWilv3lpEudFjUNDsIYkC48jnObAiv7Gc4ggfyLxA
	y+p0fo6CYdfc+xQ5MYZHMdFswGfgZKtOjPopEHWkJr/iUvYgNK6Ck1JCIwq5vA==
Content-Type: multipart/signed;
 boundary=d7dfdf25674c7fbf2f24ab8bc09bc74052d5606ff79667bdf6e09fe52f2e;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Sat, 12 Oct 2024 22:02:24 +0200
Message-Id: <D4U3GKLN5U06.6VOVFCPFN6G7@cknow.org>
Cc: <linux-rockchip@lists.infradead.org>, <heiko@sntech.de>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: Update CPU OPP voltages in
 RK356x SoC dtsi
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Dragan Simic" <dsimic@manjaro.org>
References: <cover.1728752527.git.dsimic@manjaro.org>
 <2e1e100284b1edb470d6e7fde021a0f1779336c8.1728752527.git.dsimic@manjaro.org> <D4U2PO4VF4ST.9SBVKYF6095M@cknow.org> <0a1f13d06ec3668c136997e72d0aea44@manjaro.org>
In-Reply-To: <0a1f13d06ec3668c136997e72d0aea44@manjaro.org>
X-Migadu-Flow: FLOW_OUT

--d7dfdf25674c7fbf2f24ab8bc09bc74052d5606ff79667bdf6e09fe52f2e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Dragan,

On Sat Oct 12, 2024 at 9:45 PM CEST, Dragan Simic wrote:
> On 2024-10-12 21:27, Diederik de Haas wrote:
> > On Sat Oct 12, 2024 at 7:04 PM CEST, Dragan Simic wrote:
> >> Update the lower/upper voltage limits and the exact voltages for the=
=20
> >> Rockchip
> >> RK356x CPU OPPs, using the most conservative values (i.e. the highest=
=20
> >> per-OPP
> >> voltages) found in the vendor kernel source. [1]
> >>=20
> >> Using the most conservative per-OPP voltages ensures reliable CPU=20
> >> operation
> >> regardless of the actual CPU binning, with the downside of possibly=20
> >> using
> >> a bit more power for the CPU cores than absolutely needed.
> >>=20
> >> Additionally, fill in the missing "clock-latency-ns" CPU OPP=20
> >> properties, using
> >> the values found in the vendor kernel source. [1]
> >>=20
> >> [1]=20
> >> https://raw.githubusercontent.com/rockchip-linux/kernel/f8b9431ee38ed5=
61650be7092ab93f564598daa9/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> >>=20
> >> Related-to: eb665b1c06bc ("arm64: dts: rockchip: Update GPU OPP=20
> >> voltages in RK356x SoC dtsi")
> >> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> >> ---
> >>  arch/arm64/boot/dts/rockchip/rk3568.dtsi |  1 +
> >>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 18 ++++++++++++------
> >>  2 files changed, 13 insertions(+), 6 deletions(-)
> >>=20
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi=20
> >> b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> >> index 0946310e8c12..5c54898f6ed1 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> >> @@ -273,6 +273,7 @@ &cpu0_opp_table {
> >>  	opp-1992000000 {
> >>  		opp-hz =3D /bits/ 64 <1992000000>;
> >>  		opp-microvolt =3D <1150000 1150000 1150000>;
> >> +		clock-latency-ns =3D <40000>;
> >>  	};
> >>  };
> >>=20
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi=20
> >> b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> >> index 0ee0ada6f0ab..534593f2ed0b 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> >> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> >> @@ -134,39 +134,45 @@ cpu0_opp_table: opp-table-0 {
> >>=20
> >>  		opp-408000000 {
> >>  			opp-hz =3D /bits/ 64 <408000000>;
> >> -			opp-microvolt =3D <900000 900000 1150000>;
> >> +			opp-microvolt =3D <850000 850000 1150000>;
> >>  			clock-latency-ns =3D <40000>;
> >>  		};
> >>=20
> >>  		opp-600000000 {
> >>  			opp-hz =3D /bits/ 64 <600000000>;
> >> -			opp-microvolt =3D <900000 900000 1150000>;
> >> +			opp-microvolt =3D <850000 850000 1150000>;
> >> +			clock-latency-ns =3D <40000>;
> >>  		};
> >>=20
> >>  		opp-816000000 {
> >>  			opp-hz =3D /bits/ 64 <816000000>;
> >> -			opp-microvolt =3D <900000 900000 1150000>;
> >> +			opp-microvolt =3D <850000 850000 1150000>;
> >> +			clock-latency-ns =3D <40000>;
> >>  			opp-suspend;
> >>  		};
> >=20
> > While it felt a bit much to send a patch just to remove the blank lines
> > between the opp nodes, this sounds like an excellent opportunity to=20
> > make it consistent with the opp list in other DT files?
>
> Actually, my plan is to work on the SoC binning, which will involve
> touching nearly every OPP in the Rockchip DTs, and will add much more
> data to each OPP node.  Thus, having empty lines as the separators
> between the OPP nodes is something we should actually want, because

As indicated in the "arm64: dts: rockchip: Add dtsi file for RK3399S SoC
variant" patch series, I do prefer the separator lines ...

> not having them will actually reduce the readability after the size
> of the individual OPP nodes is increased.
>
> That's the reason why I opted for having the separator lines in this
> patch series, i.e. because having them everywhere should be the final
> outcome, and because in this case they were already present where the
> OPPs were moved or copied from.

... but you actually removed those lines in the other patch set.

While I'm looking forward to the extra data to the OPP nodes, I don't
think the amount of properties should determine whether it should have a
separator line or not.

My 0.02

Cheers,
  Diederik

--d7dfdf25674c7fbf2f24ab8bc09bc74052d5606ff79667bdf6e09fe52f2e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZwrV0wAKCRDXblvOeH7b
bg9zAQDo90OyxAf/h9U4TC9xmlrPJ8gjPqJrhdXG8qyvtHSHhgEAsCvJamwLgWEP
dQ+R1gov9Un0Jgyr4SvJ6EQfeo62cAE=
=DvV+
-----END PGP SIGNATURE-----

--d7dfdf25674c7fbf2f24ab8bc09bc74052d5606ff79667bdf6e09fe52f2e--

