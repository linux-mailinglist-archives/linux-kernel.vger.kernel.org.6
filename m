Return-Path: <linux-kernel+bounces-243551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00963929793
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 13:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA2C1C20977
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 11:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF71D1C287;
	Sun,  7 Jul 2024 11:12:03 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275B9125DB;
	Sun,  7 Jul 2024 11:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720350723; cv=none; b=kHsTKtF9tttUbfVQdQSQ8IaXVQeEe2qj1eyITdTPMlyQtcNayvWSGycBkI56cQxKjx0impgmMXHHNAJyrDeaXJcYLEnf4wlJ8tpixg1uYq8i1SuIWQjXf9sdpkwBRIN8/PhXUBdRxiUyuKsZwXV/suuGTXgTaKJhZtZBW6jXkTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720350723; c=relaxed/simple;
	bh=Q9SjyPgvaHl3vXTYNqVYNgJq0a0fLsJyDb8/VUfmeT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NDs9H0by1sid9pcoBuWzppJCgyKoSaVLg6P9paB7Y/Onf/BiRdfDODXQHC/bapKSitPDw4EAeL3DLSTFYLciM4uSbs7lCv7Cplr4SnjK4/STeUN2SbDVI+oVWadqzvjdR+yAVWU1Jv0HF89fqHuWTQU0EuzpEtiWhh4fPZnbicA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a87.versanet.de ([83.135.90.135] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sQPnv-0007PA-Vn; Sun, 07 Jul 2024 13:11:40 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Alexey Charkov <alchark@gmail.com>,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Chen-Yu Tsai <wens@kernel.org>, Diederik de Haas <didi.debian@cknow.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/8] RK3588 and Rock 5B dts additions: thermal,
 OPP and fan
Date: Sun, 07 Jul 2024 13:11:38 +0200
Message-ID: <2236519.ZfL8zNpBrT@diego>
In-Reply-To: <0418B5BB-6759-4BFA-BE6E-F5C7FA0CBF4F@gmail.com>
References:
 <20240617-rk-dts-additions-v5-0-c1f5f3267f1e@gmail.com>
 <0418B5BB-6759-4BFA-BE6E-F5C7FA0CBF4F@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hey,

Am Sonntag, 7. Juli 2024, 11:39:57 CEST schrieb Piotr Oniszczuk:
> Alexey,
> I=E2=80=99m playing with this series on rock5c on 6.10-rc6.
>=20
> Is code in this series enough to get working pwm-fan on rock5c?
> (of course after adding required changes from rokc5b dts to rock5c dts)
>=20
> In my case i=E2=80=99m getting constantly full speed of fan on my rock5c.
>=20
> hw seems ok as echo 96 > /sys/devices/platform/pwm-fan/hwmon/hwmon0/pwm1 =
changes fans speed as expected.
>=20
> May you pls hint me what i=E2=80=99m missing here?

at least on my rock 5 itx patches, I get varying fan-speeds.
The fan starts high and then lowers its speed once the cpu-regulators
and every is set up.

While I was working on the dts and the cpu-supplies were not yet working,
the fan speed stayed high, so maybe check that frequency scaling actually
works? And of course you need the thermal map to handle the fan.

Also of course I don't see a rock5c patch anywhere, so where did that
board dts come from?=20


Heiko

> > Wiadomo=C5=9B=C4=87 napisana przez Alexey Charkov <alchark@gmail.com> w=
 dniu 17.06.2024, o godz. 20:28:
> >=20
> > This enables thermal monitoring and CPU DVFS on RK3588(s), as well as
> > active cooling on Radxa Rock 5B via the provided PWM fan.
> >=20
> > Some RK3588 boards use separate regulators to supply CPUs and their
> > respective memory interfaces, so this is handled by coupling those
> > regulators in affected boards' device trees to ensure that their
> > voltage is adjusted in step.
> >=20
> > This also enables the built-in thermal sensor (TSADC) for all boards
> > that don't currently have it enabled, using the default CRU based
> > emergency thermal reset. This default configuration only uses on-SoC
> > devices and doesn't rely on any external wiring, thus it should work
> > for all devices (tested only on Rock 5B though).
> >=20
> > The boards that have TSADC_SHUT signal wired to the PMIC reset line
> > can choose to override the default reset logic in favour of GPIO
> > driven (PMIC assisted) reset, but in my testing it didn't work on
> > Radxa Rock 5B - maybe I'm reading the schematic wrong and it doesn't
> > support PMIC assisted reset after all.
> >=20
> > Fan control on Rock 5B has been split into two intervals: let it spin
> > at the minimum cooling state between 55C and 65C, and then accelerate
> > if the system crosses the 65C mark - thanks to Dragan for suggesting.
> > This lets some cooling setups with beefier heatsinks and/or larger
> > fan fins to stay in the quietest non-zero fan state while still
> > gaining potential benefits from the airflow it generates, and
> > possibly avoiding noisy speeds altogether for some workloads.
> >=20
> > OPPs help actually scale CPU frequencies up and down for both cooling
> > and performance - tested on Rock 5B under varied loads. I've dropped
> > those OPPs that cause frequency reductions without accompanying decrease
> > in CPU voltage, as they don't seem to be adding much benefit in day to
> > day use, while the kernel log gets a number of "OPP is inefficient" lin=
es.
> >=20
> > Note that this submission doesn't touch the SRAM read margin updates or
> > the OPP calibration based on silicon quality which the downstream driver
> > does and which were mentioned in [1]. It works as it is (also confirmed=
 by
> > Sebastian in his follow-up message [2]), and it is stable in my testing=
 on
> > Rock 5B, so it sounds better to merge a simple version first and then
> > extend when/if required.
> >=20
> > This patch series has been rebased on top of Heiko's recent for-next br=
anch
> > with Dragan's patch [3] which rearranges the .dtsi files for per-varian=
t OPPs.
> > As a result, it now includes separate CPU OPP tables for RK3588(s) and =
RK3588j.
> >=20
> > GPU OPPs have also been split out to accommodate for the difference in =
RK3588j.
> >=20
> > [1] https://lore.kernel.org/linux-rockchip/CABjd4YzTL=3D5S7cS8ACNAYVa73=
0WA3iGd5L_wP1Vn9=3Df83RCORA@mail.gmail.com/
> > [2] https://lore.kernel.org/linux-rockchip/pkyne4g2cln27dcdu3jm7bqdqpmd=
2kwkbguiolmozntjuiajrb@gvq4nupzna4o/
> > [3] https://lore.kernel.org/linux-rockchip/9ffedc0e2ca7f167d9d795b2a8f4=
3cb9f56a653b.1717923308.git.dsimic@manjaro.org/
> >=20
> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > ---
> > Changes in v5:
> > - Rebased against linux-rockchip/for-next with Dragan's .dtsi reshuffli=
ng on top
> > - Added separate OPP values for RK3588j (these also apply to RK3588m)
> > - Separated GPU OPP values for RK3588j (RK3588m ones differ slightly, n=
ot included here)
> > - Dragan's patch: https://lore.kernel.org/linux-rockchip/9ffedc0e2ca7f1=
67d9d795b2a8f43cb9f56a653b.1717923308.git.dsimic@manjaro.org/
> > - Link to v4: https://lore.kernel.org/r/20240506-rk-dts-additions-v4-0-=
271023ddfd40@gmail.com
> >=20
> > Changes in v4:
> > - Rebased against linux-rockchip/for-next
> > - Reordered DT nodes alphabetically as pointed out by Diederik
> > - Moved the TSADC enablement to per-board .dts/.dtsi files
> > - Dropped extra "inefficient" OPPs (same voltage - lower frequencies)
> > - Dropped second passive cooling trips altogether to keep things simple
> > - Added a cooling map for passive GPU cooling (in a separate patch)
> > - Link to v3: https://lore.kernel.org/r/20240229-rk-dts-additions-v3-0-=
6afe8473a631@gmail.com
> >=20
> > Changes in v3:
> > - Added regulator coupling for EVB1 and QuartzPro64
> > - Enabled the TSADC for all boards in .dtsi, not just Rock 5B (thanks C=
henYu)
> > - Added comments regarding two passive cooling trips in each zone (than=
ks Dragan)
> > - Fixed active cooling map numbering for Radxa Rock 5B (thanks Dragan)
> > - Dropped Daniel's Acked-by tag from the Rock 5B fan patch, as there's =
been quite some
> >  churn there since the version he acknowledged
> > - Link to v2: https://lore.kernel.org/r/20240130-rk-dts-additions-v2-0-=
c6222c4c78df@gmail.com
> >=20
> > Changes in v2:
> > - Dropped the rfkill patch which Heiko has already applied
> > - Set higher 'polling-delay-passive' (100 instead of 20)
> > - Name all cooling maps starting from map0 in each respective zone
> > - Drop 'contribution' properties from passive cooling maps
> > - Link to v1: https://lore.kernel.org/r/20240125-rk-dts-additions-v1-0-=
5879275db36f@gmail.com
> >=20
> > ---
> > Alexey Charkov (8):
> >      arm64: dts: rockchip: add thermal zones information on RK3588
> >      arm64: dts: rockchip: enable thermal management on all RK3588 boar=
ds
> >      arm64: dts: rockchip: add passive GPU cooling on RK3588
> >      arm64: dts: rockchip: enable automatic fan control on Rock 5B
> >      arm64: dts: rockchip: Add CPU/memory regulator coupling for RK3588
> >      arm64: dts: rockchip: Add OPP data for CPU cores on RK3588
> >      arm64: dts: rockchip: Add OPP data for CPU cores on RK3588j
> >      arm64: dts: rockchip: Split GPU OPPs of RK3588 and RK3588j
> >=20
> > .../boot/dts/rockchip/rk3588-armsom-sige7.dts      |   4 +
> > arch/arm64/boot/dts/rockchip/rk3588-base.dtsi      | 197 ++++++++++++++=
+++----
> > .../dts/rockchip/rk3588-edgeble-neu6a-common.dtsi  |   4 +
> > arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts   |  16 ++
> > arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts   |   4 +
> > arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi       | 190 ++++++++++++++=
++++++
> > .../arm64/boot/dts/rockchip/rk3588-quartzpro64.dts |  12 ++
> > arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts    |  34 +++-
> > .../arm64/boot/dts/rockchip/rk3588-toybrick-x0.dts |   4 +
> > .../arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi |   4 +
> > arch/arm64/boot/dts/rockchip/rk3588.dtsi           |   1 +
> > arch/arm64/boot/dts/rockchip/rk3588j.dtsi          | 141 +++++++++++++++
> > arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts   |   4 +
> > arch/arm64/boot/dts/rockchip/rk3588s.dtsi          |   1 +
> > 14 files changed, 577 insertions(+), 39 deletions(-)
> > ---
> > base-commit: 5cc74606bf40a2bbaccd3e3bb2781f637baebde5
> > change-id: 20240124-rk-dts-additions-a6d7b52787b9
> >=20
> > Best regards,
>=20
>=20





