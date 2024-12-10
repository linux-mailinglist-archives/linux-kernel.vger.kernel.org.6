Return-Path: <linux-kernel+bounces-439655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC1F9EB245
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF17D16516E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F51F1AA1F6;
	Tue, 10 Dec 2024 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="fzW4BzaS"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EE022087;
	Tue, 10 Dec 2024 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838785; cv=none; b=t56f+iv6VnlpjzGyLuTMkW0t+oAWlwLodc/OVCHYprAn1KZQd8yMQWvVQj6E6+yas33pgqLopntHwh9cfd2z4Xq3VVYkn6utuFO0g8WRIRnxt7XtamBoNGMd0ZAGpFfdQGJblvD3AFQBGRFI+ZGxMd3ugjIwPDBFbZl1toysCnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838785; c=relaxed/simple;
	bh=qELiax9ehKofEkO2EAIdQsE2Y4hzFitBCVK/w3l/Ml4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=VurjLr7jfiGKA1r+LsYoeeoCKdSRnjZBr0H8QNtZ+gyYiHfGvXaEvwLCf4QQpWWXiB7EKlqxpJDXZyYdhqUGcZ3tBB4oH8WPomKy/NHJlHaQIjGcVYYwrwgjqo978n9QZAX4OEbthZkAKtPSJO46vxgIhaGQFxccVFgFqgaLfe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=fzW4BzaS; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1733838781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4HuyGQ9BIUtmSl7RlIuvQXneAnQFAJ8SshLEhAtYpg4=;
	b=fzW4BzaSnzstzxXv1KEIfRoWbbgMFMx3sgsdnLgtZ4FDeGfdKq5w0JA9VsYNnk0IJ2Fm60
	Y2MU7IQjSej2pP3bSUnfZzeMLIHYiWUKK9NzLA4y39egUYVqfBfd+f27g97u6tz8lsckWR
	G7wUQsnhTqhWdFQ9kmCHAhzgkLYGCrPRd6XrD5k0PGjvbBksxnUS2hRFxqKf3m7/hTOsZS
	iHegBt647qaaB+/ZQGP9OsG5rdbPT2wxWKuj38DMdxHWxUlNN4eYWSGGw8+Mw4dMuy1nvp
	X5mgK8LBqyiUHtt/ll0uc4VxGYcfEbCFfQlt2lCYV5RyTtYtWwDgbw0jFGTeBw==
Date: Tue, 10 Dec 2024 14:53:00 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Peter Geis <pgwipeout@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Alex Bee <knaerzche@gmail.com>, Conor
 Dooley <conor+dt@kernel.org>, Diederik de Haas <didi.debian@cknow.org>,
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Liang Chen <cl@rock-chips.com>, Rob Herring
 <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, shironeko <shironeko@tesaguri.club>
Subject: Re: [PATCH 4/6] arm64: dts: rockchip: add hevc power domain clock to
 rk3328
In-Reply-To: <CAMdYzYquvGBzfWqvUOku7m1sM9qxmBHAL95cANDViUCT1oEEhQ@mail.gmail.com>
References: <20241210013010.81257-1-pgwipeout@gmail.com>
 <20241210013010.81257-5-pgwipeout@gmail.com>
 <e32fa593abfa6d08202b4f929e0b4bdb@manjaro.org>
 <CAMdYzYp+MQVYr1tOMEOn62vXZGVEYrtd1p9vn6YQzXdrJgSdyA@mail.gmail.com>
 <CAMdYzYquvGBzfWqvUOku7m1sM9qxmBHAL95cANDViUCT1oEEhQ@mail.gmail.com>
Message-ID: <8c604ada27457698ad6d33d22a39b45a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Peter,

On 2024-12-10 14:23, Peter Geis wrote:
> On Tue, Dec 10, 2024 at 8:13 AM Peter Geis <pgwipeout@gmail.com> wrote:
>> On Tue, Dec 10, 2024 at 5:04 AM Dragan Simic <dsimic@manjaro.org> 
>> wrote:
>> > On 2024-12-10 02:30, Peter Geis wrote:
>> > > There is a race condition at startup between disabling power domains
>> > > not
>> > > used and disabling clocks not used on the rk3328. When the clocks are
>> > > disabled first, the hevc power domain fails to shut off leading to a
>> > > splat of failures. Add the hevc core clock to the rk3328 power domain
>> > > node to prevent this condition.
>> > >
>> > > rcu: INFO: rcu_sched detected expedited stalls on CPUs/tasks: { 3-....
>> > > }
>> > > 1087 jiffies s: 89 root: 0x8/.
>> > > rcu: blocking rcu_node structures (internal RCU debug):
>> > > Sending NMI from CPU 0 to CPUs 3:
>> > > NMI backtrace for cpu 3
>> > > CPU: 3 UID: 0 PID: 86 Comm: kworker/3:3 Not tainted 6.12.0-rc5+ #53
>> > > Hardware name: Firefly ROC-RK3328-CC (DT)
>> > > Workqueue: pm genpd_power_off_work_fn
>> > > pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> > > pc : regmap_unlock_spinlock+0x18/0x30
>> > > lr : regmap_read+0x60/0x88
>> > > sp : ffff800081123c00
>> > > x29: ffff800081123c00 x28: ffff2fa4c62cad80 x27: 0000000000000000
>> > > x26: ffffd74e6e660eb8 x25: ffff2fa4c62cae00 x24: 0000000000000040
>> > > x23: ffffd74e6d2f3ab8 x22: 0000000000000001 x21: ffff800081123c74
>> > > x20: 0000000000000000 x19: ffff2fa4c0412000 x18: 0000000000000000
>> > > x17: 77202c31203d2065 x16: 6c6469203a72656c x15: 6c6f72746e6f632d
>> > > x14: 7265776f703a6e6f x13: 2063766568206e69 x12: 616d6f64202c3431
>> > > x11: 347830206f742030 x10: 3430303034783020 x9 : ffffd74e6c7369e0
>> > > x8 : 3030316666206e69 x7 : 205d383738353733 x6 : 332e31202020205b
>> > > x5 : ffffd74e6c73fc88 x4 : ffffd74e6c73fcd4 x3 : ffffd74e6c740b40
>> > > x2 : ffff800080015484 x1 : 0000000000000000 x0 : ffff2fa4c0412000
>> > > Call trace:
>> > > regmap_unlock_spinlock+0x18/0x30
>> > > rockchip_pmu_set_idle_request+0xac/0x2c0
>> > > rockchip_pd_power+0x144/0x5f8
>> > > rockchip_pd_power_off+0x1c/0x30
>> > > _genpd_power_off+0x9c/0x180
>> > > genpd_power_off.part.0.isra.0+0x130/0x2a8
>> > > genpd_power_off_work_fn+0x6c/0x98
>> > > process_one_work+0x170/0x3f0
>> > > worker_thread+0x290/0x4a8
>> > > kthread+0xec/0xf8
>> > > ret_from_fork+0x10/0x20
>> > > rockchip-pm-domain ff100000.syscon:power-controller: failed to get ack
>> > > on
>> > > domain 'hevc', val=0x88220
>> > >
>> > > Fixes: 52e02d377a72 ("arm64: dts: rockchip: add core dtsi file for
>> > > RK3328 SoCs")
>> > > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
>> >
>> > While I was unable to formally verify this clock assignment,
>> > i.e. by using the RK3328 TRM or the downstream kernel source
>> > from Rockchip, it makes perfect sense to me.  Thanks for the
>> > patch, and please feel free to include:
>> >
>> > Reviewed-by: Dragan Simic <dsimic@manjaro.org>
>> 
>> It is unfortunate the TRM doesn't include the clock maps, because they
>> are extremely helpful when one can acquire them. It also doesn't help
>> that the TRM register definition only referred to this as "pll". I was
>> sent specifically the usb3 phy clock map for my work on the driver,
>> which had the location of each switch and divider along with the
>> register and bit that controlled it. That combined with the TRM
>> register map allowed me to find this error.
> 
> Apologies, that's the wrong response for this one.

No worries.

> This patch was the result of educated guess combined with testing. I
> grabbed all of the clocks that looked like they could affect things,
> then tested them one at a time until I isolated them to this clock. It
> lives alone with cpll as the parent and has no children according to
> the clock summary. (Though the writeup i mistakenly included above
> proves the clock map isn't always accurate).

I see, thanks for all your work on this patch!  It surely took quite
a lot of time to perform all the testing.

>> > > ---
>> > >
>> > >  arch/arm64/boot/dts/rockchip/rk3328.dtsi | 1 +
>> > >  1 file changed, 1 insertion(+)
>> > >
>> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> > > b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> > > index 0597de415fe0..7d992c3c01ce 100644
>> > > --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> > > +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> > > @@ -333,6 +333,7 @@ power: power-controller {
>> > >
>> > >                       power-domain@RK3328_PD_HEVC {
>> > >                               reg = <RK3328_PD_HEVC>;
>> > > +                             clocks = <&cru SCLK_VENC_CORE>;
>> > >                               #power-domain-cells = <0>;
>> > >                       };
>> > >                       power-domain@RK3328_PD_VIDEO {

