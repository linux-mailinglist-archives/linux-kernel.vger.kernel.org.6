Return-Path: <linux-kernel+bounces-192648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABABA8D2024
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C53861C20887
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B99172BDD;
	Tue, 28 May 2024 15:16:34 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9942171080;
	Tue, 28 May 2024 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909393; cv=none; b=QM/aE4IaU0MeYEcZZE04xMsKE2CIgfDn4QVSQPNYYVhtouzZuoD9/ScsH9BZAvOFhnwotYtDlpfn80XMTL4rHavYFZSkGJjsj1Hf55uHQPOaawK+8/Xg1TJh8XRX9iglgYthOvbei+Fim7AabbXG6jc1EqN7lOOZhoPj9mfgm5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909393; c=relaxed/simple;
	bh=KQUl1FxTa7R52d6jouTH3YkHig0GUioUMVAcrGm63HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fL7Gh+3DKdAp6E8odfYPWluU7y5Tz5u+8FZUaAMc6snkwbclhE3kGVVdENPTbiwjc3uK2QG0RMYeAJ21/O4VZUTBOhO4CKWAbon6tg2ZLP07R7hmIM1j/Djy6QVrqwpWDIJ/7fKMqletq7xflT7Alzwosq70vD/9Gs5Thk7FOxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [213.70.33.226] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sByYn-0004ud-Ul; Tue, 28 May 2024 17:16:22 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Alexey Charkov <alchark@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu Tsai <wens@kernel.org>,
 Diederik de Haas <didi.debian@cknow.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] RK3588 and Rock 5B dts additions: thermal,
 OPP and fan
Date: Tue, 28 May 2024 17:16:20 +0200
Message-ID: <6230150.aeNJFYEL58@phil>
In-Reply-To: <8727e1c29bd6f562a7fc3de0ddac62cf@manjaro.org>
References:
 <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
 <5122636.irdbgypaU6@phil> <8727e1c29bd6f562a7fc3de0ddac62cf@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Dienstag, 28. Mai 2024, 17:01:48 CEST schrieb Dragan Simic:
> On 2024-05-28 16:34, Heiko Stuebner wrote:
> > Am Dienstag, 28. Mai 2024, 16:05:04 CEST schrieb Dragan Simic:
> >> On 2024-05-28 11:49, Alexey Charkov wrote:
> >> > On Mon, May 6, 2024 at 1:37=E2=80=AFPM Alexey Charkov <alchark@gmail=
=2Ecom>
> >> > wrote:
> >> >>
> >> >> This enables thermal monitoring and CPU DVFS on RK3588(s), as well =
as
> >> >> active cooling on Radxa Rock 5B via the provided PWM fan.
> >> >>
> >> >> Some RK3588 boards use separate regulators to supply CPUs and their
> >> >> respective memory interfaces, so this is handled by coupling those
> >> >> regulators in affected boards' device trees to ensure that their
> >> >> voltage is adjusted in step.
> >> >>
> >> >> This also enables the built-in thermal sensor (TSADC) for all boards
> >> >> that don't currently have it enabled, using the default CRU based
> >> >> emergency thermal reset. This default configuration only uses on-SoC
> >> >> devices and doesn't rely on any external wiring, thus it should work
> >> >> for all devices (tested only on Rock 5B though).
> >> >>
> >> >> The boards that have TSADC_SHUT signal wired to the PMIC reset line
> >> >> can choose to override the default reset logic in favour of GPIO
> >> >> driven (PMIC assisted) reset, but in my testing it didn't work on
> >> >> Radxa Rock 5B - maybe I'm reading the schematic wrong and it doesn't
> >> >> support PMIC assisted reset after all.
> >> >>
> >> >> Fan control on Rock 5B has been split into two intervals: let it sp=
in
> >> >> at the minimum cooling state between 55C and 65C, and then accelera=
te
> >> >> if the system crosses the 65C mark - thanks to Dragan for suggestin=
g.
> >> >> This lets some cooling setups with beefier heatsinks and/or larger
> >> >> fan fins to stay in the quietest non-zero fan state while still
> >> >> gaining potential benefits from the airflow it generates, and
> >> >> possibly avoiding noisy speeds altogether for some workloads.
> >> >>
> >> >> OPPs help actually scale CPU frequencies up and down for both cooli=
ng
> >> >> and performance - tested on Rock 5B under varied loads. I've dropped
> >> >> those OPPs that cause frequency reductions without accompanying
> >> >> decrease
> >> >> in CPU voltage, as they don't seem to be adding much benefit in day=
 to
> >> >> day use, while the kernel log gets a number of "OPP is inefficient"
> >> >> lines.
> >> >>
> >> >> Note that this submission doesn't touch the SRAM read margin updates
> >> >> or
> >> >> the OPP calibration based on silicon quality which the downstream
> >> >> driver
> >> >> does and which were mentioned in [1]. It works as it is (also
> >> >> confirmed by
> >> >> Sebastian in his follow-up message [2]), and it is stable in my
> >> >> testing on
> >> >> Rock 5B, so it sounds better to merge a simple version first and th=
en
> >> >> extend when/if required.
> >> >>
> >> >> [1]
> >> >> https://lore.kernel.org/linux-rockchip/CABjd4YzTL=3D5S7cS8ACNAYVa73=
0WA3iGd5L_wP1Vn9=3Df83RCORA@mail.gmail.com/
> >> >> [2]
> >> >> https://lore.kernel.org/linux-rockchip/pkyne4g2cln27dcdu3jm7bqdqpmd=
2kwkbguiolmozntjuiajrb@gvq4nupzna4o/
> >> >>
> >> >> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> >> >> ---
> >> >
> >> > Hi Heiko,
> >> >
> >> > Do you think this can be merged for 6.11? Looks like there hasn't be=
en
> >> > any new feedback in a while, and it would be good to have frequency
> >> > scaling in place for RK3588.
> >> >
> >> > Please let me know if you have any reservations or if we need any
> >> > broader discussion.
> >=20
> > not really reservations, more like there was still discussion going on
> > around the OPPs. Meanwhile we had more discussions regarding the whole
> > speed binning Rockchip seems to do for rk3588 variants.
> >=20
> > And waiting for the testing Dragan wanted to do ;-) .
>=20
> I'm sorry for the delays.

Was definitly _not_ meant as blame ;-) .

The series has just too many discussions threads to unravel on half
an afternoon.


> > So this should definitly make it into 6.11 though, as there is still
> > a lot of time.
> >=20
> >> As I promised earlier, I was going to test this patch series in=20
> >> detail.
> >> Alas, I haven't managed to do that yet, :/ due to many reasons, but
> >> I still remain firmly committed to doing that.
> >>=20
> >> Is -rc4 the cutoff for 6.11?  If so, there's still time and I'll do my
> >> best to test and review these patches as soon as possible.
> >=20
> > As early as possible, the hard cutoff would be -rc6 though.
> > I guess I'll just start picking the easy patches from the series.
>=20
> I'll do my best to have the patches tested and reviewed in detail ASAP.
> As a suggestion, perhaps it would be better to take the series as a=20
> whole,
> so we don't bring partial merging into the mix.

Patches need to work individually anyway (in correct order of course),
so like starting at the top with the general thermal stuff should not
create issues ;-)


Heiko



