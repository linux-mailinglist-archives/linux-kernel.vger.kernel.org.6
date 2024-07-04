Return-Path: <linux-kernel+bounces-241009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B50539275B5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43161282AE4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08B71AE840;
	Thu,  4 Jul 2024 12:05:57 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D121AB503;
	Thu,  4 Jul 2024 12:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720094757; cv=none; b=aHSlQgv0VBun4mWRZDrmisSJvXKq871rvHw+eCVuJKsN329mnfiZklSfsHTk30S6SBc98CLRjZgulcs+peh2bM3QpX77dMqs3ewSYpS+VinuUNOI7RglQjxGf84tsg+AUI4l1SprYvUJFlQI+t74aHwIEKchzl0MbZZTBM9ehg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720094757; c=relaxed/simple;
	bh=L+Sz0ZouYi21bliJnhv4trBwcjkjzcxkmiWNOR4Bjko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t71sWlbfex/CLe/JJGNAAicZAICj8yJFtNMb+wIMlRx3ue6ivXv+BRmhg3fJmWjWYfFFFPC1R3pVk/M8mjb2v6ngqTIy9P7Llu4WHer5WhzpDtykVxfFf6DbQfXX2wx4YdsneXaM1L60GZFd+jfoHiV1Pe9GJeQVJIlcD9EnMpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875ac2.versanet.de ([83.135.90.194] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sPLDg-0000bm-60; Thu, 04 Jul 2024 14:05:48 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
 Diederik de Haas <didi.debian@cknow.org>, Alex Bee <knaerzche@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: add rock5 itx board
Date: Thu, 04 Jul 2024 14:05:47 +0200
Message-ID: <2004736.8hb0ThOEGa@diego>
In-Reply-To: <2c46dfb7-5ef3-494f-8cf1-413033e73412@gmail.com>
References:
 <20240703210524.776455-1-heiko@sntech.de> <4552794.8F6SAcFxjW@diego>
 <2c46dfb7-5ef3-494f-8cf1-413033e73412@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Donnerstag, 4. Juli 2024, 13:43:47 CEST schrieb Alex Bee:
> Am 04.07.24 um 12:05 schrieb Heiko St=FCbner:
> > Hi Diederik,
> >=20
> > Am Donnerstag, 4. Juli 2024, 11:38:51 CEST schrieb Diederik de Haas:
> >> Thanks for submitting this. A quick scan indicates it should work with=
 a
> >> (recent) Debian kernel OOTB :-)
> >>
> >> On Wednesday, 3 July 2024 23:05:24 CEST Heiko Stuebner wrote:
> >>> +&sdhci {
> >>> +       bus-width =3D <8>;
> >>> +       no-sdio;
> >>> +       no-sd;
> >>> +       non-removable;
> >>> +       max-frequency =3D <200000000>;
> >>> +       mmc-hs400-1_8v;
> >>> +       mmc-hs400-enhanced-strobe;
> >>> +       mmc-hs200-1_8v;
> >>> +       status =3D "okay";
> >>> +};
> >>> +
> >>> +&sdmmc {
> >>> +       max-frequency =3D <200000000>;
> >>> +       no-sdio;
> >>> +       no-mmc;
> >>> +       bus-width =3D <4>;
> >>> +       cap-mmc-highspeed;
> >>> +       cap-sd-highspeed;
> >>> +       disable-wp;
> >>> +       sd-uhs-sdr104;
> >>> +       vmmc-supply =3D <&vcc_3v3_s3>;
> >>> +       vqmmc-supply =3D <&vccio_sd_s0>;
> >>> +       pinctrl-names =3D "default";
> >>> +       pinctrl-0 =3D <&sdmmc_bus4 &sdmmc_clk &sdmmc_cmd &sdmmc_det>;
> >>> +       status =3D "okay";
> >>> +};
> >>> +
> >>> +/* M.2 E-KEY */
> >>> +&sdio {
> >>> +       broken-cd;
> >>> +       bus-width =3D <4>;
> >>> +       cap-sdio-irq;
> >>> +       disable-wp;
> >>> +       keep-power-in-suspend;
> >>> +       max-frequency =3D <150000000>;
> >>> +       mmc-pwrseq =3D <&sdio_pwrseq>;
> >>> +       no-sd;
> >>> +       no-mmc;
> >>> +       non-removable;
> >>> +       pinctrl-names =3D "default";
> >>> +       pinctrl-0 =3D <&sdiom0_pins>;
> >>> +       sd-uhs-sdr104;
> >>> +       vmmc-supply =3D <&vcc3v3_ekey>;
> >>> +       status =3D "okay";
> >>> +};
> >>> +
> >>> +&sfc {
> >>> +       pinctrl-names =3D "default";
> >>> +       pinctrl-0 =3D <&fspim2_pins>;
> >>> +       status =3D "okay";
> >>
> >> Shouldn't those properties be sorted alphabetically? Or at least consi=
stently?
> >> Note that the same issue is present on other places too, but I believe=
 the
> >> above quoted part shows the issue enough.
> >=20
> > The main sorting is
> > - compatible
> > - reg
> > [... alphabetically ...]
> > - status
> >=20
> Yeah ... that's always the question when adding new board files. Do it li=
ke
> "it's always been done" or re-sort the properties alphanumeric _everywher=
e_
> which looks quite strange at times. If I'm getting the newly added dt
> coding style correctly common (subsystem?) properties should also be plac=
ed
> before vendor (driver?) specific ones. Yet I didn't see a board file which
> places 'regulator-max-microvolt' before 'regulator-min-microvolt'. So I
> guess it's fine if it's done consistently within the same file?

I always see it as a best-effort thing. If all regulator-* stuff is grouped
together it will be mostly fine. I'm not going to haggle over the sorting
of the 10th character of property names ;-) .

(and of course reading min before max, is sort of more intuitive)

And of course leaf-things (board dts) are less "important" than the core
nodes in soc devicetrees.




