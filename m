Return-Path: <linux-kernel+bounces-192544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E87DD8D1EEA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75EFCB2259F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A148216F8F7;
	Tue, 28 May 2024 14:34:37 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763261DFDE;
	Tue, 28 May 2024 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906877; cv=none; b=Mn1ir0LQfrz43hA1Dqq+VfL7EvxV5SKsAK8VDD5A0U06m1Heg8vlwL6GaoCvZqi/VEDojAUp0Qbr9qViu8iSrpo8ntS/bmQnXNg7qHMUEJioxa62hENlyrvb6fsepkeILDFUgjpdnJ1HWSZiEKWA25iXJH8q2bTDNnRqDGtO7vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906877; c=relaxed/simple;
	bh=QbezeNKJyW6qf2V3kTpxOxe+UTcg7sBnxBqrvnatxGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rdZLyI11+YDpWTAtvReBM/ceHHNiWV9A6nM9zn28HiHvTHikdSziFruSKSyEtbgoBMTGEYmNR8eUH7+pLEdPqKBCBFJ7PSTWgvA903P0F6QOkaTKYkUJVlB46PY2/uSL8l6OVClXWWlkDts50NWdd+z/1aeISy4L6WWAGHhOiyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [213.70.33.226] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sBxuB-0004aE-9M; Tue, 28 May 2024 16:34:23 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Alexey Charkov <alchark@gmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu Tsai <wens@kernel.org>,
 Diederik de Haas <didi.debian@cknow.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] RK3588 and Rock 5B dts additions: thermal,
 OPP and fan
Date: Tue, 28 May 2024 16:34:21 +0200
Message-ID: <5122636.irdbgypaU6@phil>
In-Reply-To: <ea2311d7a41162a847d37ce05d0fc441@manjaro.org>
References:
 <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
 <CABjd4YyuDsWGbSfNyqcW3s=59p8adVf5Js79PYyKFqfyM71dxA@mail.gmail.com>
 <ea2311d7a41162a847d37ce05d0fc441@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi Dragan,

Am Dienstag, 28. Mai 2024, 16:05:04 CEST schrieb Dragan Simic:
> On 2024-05-28 11:49, Alexey Charkov wrote:
> > On Mon, May 6, 2024 at 1:37=E2=80=AFPM Alexey Charkov <alchark@gmail.co=
m>=20
> > wrote:
> >>=20
> >> This enables thermal monitoring and CPU DVFS on RK3588(s), as well as
> >> active cooling on Radxa Rock 5B via the provided PWM fan.
> >>=20
> >> Some RK3588 boards use separate regulators to supply CPUs and their
> >> respective memory interfaces, so this is handled by coupling those
> >> regulators in affected boards' device trees to ensure that their
> >> voltage is adjusted in step.
> >>=20
> >> This also enables the built-in thermal sensor (TSADC) for all boards
> >> that don't currently have it enabled, using the default CRU based
> >> emergency thermal reset. This default configuration only uses on-SoC
> >> devices and doesn't rely on any external wiring, thus it should work
> >> for all devices (tested only on Rock 5B though).
> >>=20
> >> The boards that have TSADC_SHUT signal wired to the PMIC reset line
> >> can choose to override the default reset logic in favour of GPIO
> >> driven (PMIC assisted) reset, but in my testing it didn't work on
> >> Radxa Rock 5B - maybe I'm reading the schematic wrong and it doesn't
> >> support PMIC assisted reset after all.
> >>=20
> >> Fan control on Rock 5B has been split into two intervals: let it spin
> >> at the minimum cooling state between 55C and 65C, and then accelerate
> >> if the system crosses the 65C mark - thanks to Dragan for suggesting.
> >> This lets some cooling setups with beefier heatsinks and/or larger
> >> fan fins to stay in the quietest non-zero fan state while still
> >> gaining potential benefits from the airflow it generates, and
> >> possibly avoiding noisy speeds altogether for some workloads.
> >>=20
> >> OPPs help actually scale CPU frequencies up and down for both cooling
> >> and performance - tested on Rock 5B under varied loads. I've dropped
> >> those OPPs that cause frequency reductions without accompanying=20
> >> decrease
> >> in CPU voltage, as they don't seem to be adding much benefit in day to
> >> day use, while the kernel log gets a number of "OPP is inefficient"=20
> >> lines.
> >>=20
> >> Note that this submission doesn't touch the SRAM read margin updates=20
> >> or
> >> the OPP calibration based on silicon quality which the downstream=20
> >> driver
> >> does and which were mentioned in [1]. It works as it is (also=20
> >> confirmed by
> >> Sebastian in his follow-up message [2]), and it is stable in my=20
> >> testing on
> >> Rock 5B, so it sounds better to merge a simple version first and then
> >> extend when/if required.
> >>=20
> >> [1]=20
> >> https://lore.kernel.org/linux-rockchip/CABjd4YzTL=3D5S7cS8ACNAYVa730WA=
3iGd5L_wP1Vn9=3Df83RCORA@mail.gmail.com/
> >> [2]=20
> >> https://lore.kernel.org/linux-rockchip/pkyne4g2cln27dcdu3jm7bqdqpmd2kw=
kbguiolmozntjuiajrb@gvq4nupzna4o/
> >>=20
> >> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> >> ---
> >=20
> > Hi Heiko,
> >=20
> > Do you think this can be merged for 6.11? Looks like there hasn't been
> > any new feedback in a while, and it would be good to have frequency
> > scaling in place for RK3588.
> >=20
> > Please let me know if you have any reservations or if we need any
> > broader discussion.

not really reservations, more like there was still discussion going on
around the OPPs. Meanwhile we had more discussions regarding the whole
speed binning Rockchip seems to do for rk3588 variants.

And waiting for the testing Dragan wanted to do ;-) .

So this should definitly make it into 6.11 though, as there is still
a lot of time.
=20

> As I promised earlier, I was going to test this patch series in detail.
> Alas, I haven't managed to do that yet, :/ due to many reasons, but
> I still remain firmly committed to doing that.
>=20
> Is -rc4 the cutoff for 6.11?  If so, there's still time and I'll do my
> best to test and review these patches as soon as possible.

As early as possible, the hard cutoff would be -rc6 though.
I guess I'll just start picking the easy patches from the series.


Heiko





