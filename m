Return-Path: <linux-kernel+bounces-193977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF30F8D34DC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30BB1C23A2C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D083217B4FD;
	Wed, 29 May 2024 10:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="hSU+aTn5"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648B315B97D;
	Wed, 29 May 2024 10:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716979567; cv=none; b=JtMuUldAu2aBfXo22jeEhEHfqQB2uH2iNQS4eZE3LzGo1LK7hkqyCLT6FjNp3+ImW+Hn+oBGKXTAGBt4VNZBxSnhp4A+mOJ6/K8CRo7WKf+/643XNi9YD3/Jg0J3T7bnzZHMyyrzdUtemvkt9vHk9xEK1XOFnqvs+oT3R1bQFmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716979567; c=relaxed/simple;
	bh=HOoSo4pjtbV3Ghqme+A3tnlPor4EsiKnQdDkwiDHfjo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=HyaVgde2rJUaV3S0O3O7FhZ6ziDlO5HRwFqFLfKdR5+LzfIS3HLGluGKdRsijAdgQ+lJHgRwWNt4ZYeqNnOvfQBrrdq/2+o3rWtqzjsgNdz8JRBJohMGbLV/Tvm0S8Uf5nVHF9gxO/Cq9XdyRtgsZTwpSrxAfYc5BBb/Y8KOk5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=hSU+aTn5; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716979558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Im5u80iUUUUe5XP9ygdhbOcswtgjuo6Kj8ktu/o5Yl0=;
	b=hSU+aTn5RwXlGNSAyaP2tG53Qb6mBmC1Vq/EoedF0Ql0LshpsBgmuuWToSvR/6VWE4f4lC
	4TvUyRvdxIvBD44HcjttDavxiv+04zShXuN9z7NdWzSJUAdpTkdgS2VG7OpOKpbDhD6k8j
	vsI3Y/F2+zdqqFr+cFNYg3Ut0NVTqGUs7JqezsM/af+NcaIzupekL684mX3/VXDNt+i+px
	2B++7PUHXYeSJ0TA0Vumrdujwu5dtBBW4O2jMaQ/qmNBHst47shFzeNI9LTUuSgAT5DkRK
	GxYBkZbZAyqM/Z9Of52F6kA1jHiXfq8dPE5GD8SwPN2Qn0P332DP4H0EUJ9piQ==
Date: Wed, 29 May 2024 12:45:57 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh+dt@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, quentin.schulz@cherry.de, wens@kernel.org,
 daniel.lezcano@linaro.org, didi.debian@cknow.org,
 krzysztof.kozlowski+dt@linaro.org, viresh.kumar@linaro.org
Subject: Re: [RFC PATCH] arm64: dts: rockchip: Make preparations for
 per-RK3588-variant OPPs
In-Reply-To: <CABjd4YxD41DEkBCZfkznLboEY9ZVOfTCLcj4S_kkcsVswbANyQ@mail.gmail.com>
References: <673dcf47596e7bc8ba065034e339bb1bbf9cdcb0.1716948159.git.dsimic@manjaro.org>
 <CABjd4YxD41DEkBCZfkznLboEY9ZVOfTCLcj4S_kkcsVswbANyQ@mail.gmail.com>
Message-ID: <8f8623e29a479c4108141302e708dc3b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Alexey.

On 2024-05-29 11:57, Alexey Charkov wrote:
> On Wed, May 29, 2024 at 6:14 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> 
>> Rename and modify the RK3588 dtsi files a bit, to make preparations 
>> for
>> the ability to specify different CPU and GPU OPPs for each of the 
>> supported
>> RK3588 SoC variants, including the RK3588J.
>> 
>> As already discussed, [1][2][3] some of the different RK3588 SoC 
>> variants
>> require different OPPs, and it makes more sense to have the OPPs 
>> already
>> defined when a board dts includes one of the SoC dtsi files 
>> (rk3588.dtsi,
>> rk3588j.dtsi or rk3588s.dtsi), rather than requiring the board dts 
>> file to
>> also include a separate rk3588*-opp.dtsi file.  The choice of the SoC 
>> variant
>> is already made by the inclusion of the SoC dtsi file, and it doesn't 
>> make
>> much sense to, effectively, allow the board dts file to include and 
>> use an
>> incompatible set of OPPs for the already selected SoC variant.
> 
> Indeed, including just one .dtsi for the correct SoC variant and not
> having to bother about what other bits and pieces are required to use
> the full SoC functionality sounds great! Thanks for putting this
> together so promptly!

You're welcome. :)

> Some considerations below.
> 
>> No intended functional changes are introduced.  (Still to be 
>> additionally
>> verified if the patch moves forward from the RFC state.)
>> 
>> [1] 
>> https://lore.kernel.org/linux-rockchip/646a33e0-5c1b-471c-8183-2c0df40ea51a@cherry.de/
>> [2] 
>> https://lore.kernel.org/linux-rockchip/CABjd4Yxi=+3gkNnH3BysUzzYsji-=-yROtzEc8jM_g0roKB0-w@mail.gmail.com/
>> [3] 
>> https://lore.kernel.org/linux-rockchip/035a274be262528012173d463e25b55f@manjaro.org/
>> 
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>  ...inctrl.dtsi => rk3588-common-pinctrl.dtsi} |    0
> 
> Renaming the pinctrl includes seems superfluous - maybe keep them as
> they were to minimize churn?

Believe it or not, the same thoughts crossed my mind.  However,
after thinking a bit about it, I concluded that renaming the pinctrl
dtsi files as well makes the overall naming of the reworked RK3588
dtsi files more consistent.

It's also rather neat to have the "common" and "fullfat" file pairs
together in the arch/arm64/boot/dts/rockchip directory listing, when
it's sorted by the file name, which is the default in most (if not
all) environments.

>>  .../{rk3588s.dtsi => rk3588-common.dtsi}      |    2 +-
>>  ...nctrl.dtsi => rk3588-fullfat-pinctrl.dtsi} |    0
>>  .../{rk3588.dtsi => rk3588-fullfat.dtsi}      |    4 +-
> 
> To me, "fullfat" doesn't look super descriptive, albeit fun :)

Yeah, I resorted to "fullfat" as some kind of a funny option. :)
That's for the "beefy" SoC variants, so it kind of fits well. :)

> How about we rename the existing rk3588.dtsi and rk3588s.dtsi to
> something like rk3588-devices.dtsi and rk3588s-devices.dtsi
> (preserving the inheritance between them), and then I add
> rk3588s-opp.dtsi and rk3588j-opp.dtsi in a follow-up patch?

The trouble with including "devices" into the filenames is, well,
the fact that those files isn't about any devices, but about the
SoC variants.  Thus, "devices" simply wouldn't fit there.

Moreover, in the envisioned scheme there should be no separate
OPP .dtsi files;  the OPP data should go directly into the new
rk3588.dtsi, rk3588s.dtsi and rk3588j.dtsi files, where it actually
belongs.  That's why those .dtsi files exist and are mostly empty,
at least the way I see it.  I'll get back to this below.

> Then we keep "thin" versions of rk3588.dtsi, rk3588s.dtsi and
> rk3588j.dtsi for board files to include. The mix-and-match of
> different on-chip devices and different OPPs then gets transparently
> represented within those "thin" .dtsi, something like this:
> 
> rk3588.dtsi:
> #include "rk3588-devices.dtsi"
> #include "rk3588s-opp.dtsi"
> 
> rk3588s.dtsi:
> #include "rk3588s-devices.dtsi"
> #include "rk3588s-opp.dtsi"
> 
> rk3588j.dtsi:
> #include "rk3588-devices.dtsi"
> #include "rk3588j-opp.dtsi"

Such a layout, in general, has also crossed my mind, but my conclusion
was that having the per-SoC-variant OPP data specified directly in the
reworked rk3588.dtsi, rk3588s.dtsi and rk3588j.dtsi files is a better
option in the long term, even if we end up that way with rk3588.dtsi and
rk3588s.dtsi repeating most (if not all) of the same OPP data.

That way we'll have no roadblocks if, at some point, we end up with 
having
different OPPs defined for the RK3588 and the RK3588S variants.  Or 
maybe
even for the RK3582, which we don't know much about yet.

>>  arch/arm64/boot/dts/rockchip/rk3588.dtsi      |  414 +--
>>  arch/arm64/boot/dts/rockchip/rk3588j.dtsi     |    6 +-
>>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 2671 
>> +----------------
> 
> Rename detection didn't do a particularly great job here - wonder if
> we can do anything about it to minimize the patch size and ensure that
> the change history is preserved for git blame...

Yeah, that bothered me as well. :/  Unfortunately, I don't think that
much can be done there, but I'll try fiddling with the values for the
--find-renames parameter for git-diff(1).

