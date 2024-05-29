Return-Path: <linux-kernel+bounces-194025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CDF8D359B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93CC01C22F83
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA0A17F39A;
	Wed, 29 May 2024 11:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="jX0GXW6x"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6A717DE23;
	Wed, 29 May 2024 11:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716982384; cv=none; b=Xt3Cbm6r8EiCwWFDVYhQyaMNhhXpmXtZ2h8/8P8QZqhWnU8h/LmEaag2HWZVguOFxg7Mjojt9RV1y2HhvHgleiVXSMgBUxssy5x1VLZY/RwBRJw7KOa2BE/4p5YgB3bknui9fTsg8aKNJaBef6E4lBe7yrWfJ1D45gTRrbdoPAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716982384; c=relaxed/simple;
	bh=ruQRWCCZf8B8ww4BsJjOV7mk4YxiLsCQNQSSS+0ddos=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=CjgEF2g7y/O8uuWI6eomb8AQf10VDvw9Y8G6HFrKuc2gxj3nR+m4rT85eOhPPubwTNwKZ/pieWqOcNTdDaCA28vt1UlUARU0W+fGs/QOKha3ZYlmMGgyqbgPfhEoIljFnie1pV0bvOQ8F8mx1p3kLkZdQyPggOJNN/GoQGqALHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=jX0GXW6x; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716982380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XD6qFBUR2LMAzuud7DLI1RG/etW0Y6sDMxEesleKjgM=;
	b=jX0GXW6xG4OGQpfXVaa2sVekk2pzKX9V22lDNuH2xkO1eEhPzR+XCEwcjbqDnRQJoBmhgH
	gDxGB6fMJCDAJIGqeUlhzf8nN0IjDv37RkhOsD3lAcW4DN6nieWj3KU2ZM+MCZeRzvSXI+
	iHtTKvtT6xta9SjbVxY+Kmm2enP2DEQBqQXDo9gCuWgS6VnskSNBFRa35qkMLiOlINYNzp
	fIy+yCV3KAGaoscZeZ3W5mbl3b6KhnI4H2TaeOhsdIbWi325MkOOXACXYo0am9TZYPqXI0
	nOg5MZRRI6FV8wiGAUOL3cZZUnYpkX0arGlObQex2DenoNH/tDHdOz5RdtOWGQ==
Date: Wed, 29 May 2024 13:33:00 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Alexey Charkov <alchark@gmail.com>, linux-rockchip@lists.infradead.org,
 heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org, quentin.schulz@cherry.de,
 wens@kernel.org, daniel.lezcano@linaro.org,
 krzysztof.kozlowski+dt@linaro.org, viresh.kumar@linaro.org
Subject: Re: [RFC PATCH] arm64: dts: rockchip: Make preparations for
 per-RK3588-variant OPPs
In-Reply-To: <9996796.SDjBYy7pSV@bagend>
References: <673dcf47596e7bc8ba065034e339bb1bbf9cdcb0.1716948159.git.dsimic@manjaro.org>
 <CABjd4YxD41DEkBCZfkznLboEY9ZVOfTCLcj4S_kkcsVswbANyQ@mail.gmail.com>
 <9996796.SDjBYy7pSV@bagend>
Message-ID: <511137f077495007f467d5927f42f85d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Diederik,

On 2024-05-29 13:09, Diederik de Haas wrote:
> Hi Dragan,
> 
> I think the idea is very good.
> I do have some remarks about its implementation though.

Thanks for your feedback!

> title: s/Make preparations/Prepare/

Or even better: "Prepare RK3588 SoC dtsi files for per-variant OPPs"

> On Wednesday, 29 May 2024 11:57:45 CEST Alexey Charkov wrote:
>> On Wed, May 29, 2024 at 6:14 AM Dragan Simic <dsimic@manjaro.org> 
>> wrote:
>> > Rename and modify the RK3588 dtsi files a bit, to make preparations for
>> > the ability to specify different CPU and GPU OPPs for each of the
>> > supported RK3588 SoC variants, including the RK3588J.
> 
> "Rename the RK3588 dtsi files in preparation of the ability to specify
> different
> CPU and GPU OPPs combinations for all the supported RK3588 SoC 
> variants."?
> 
> There's no partial renaming of things. That you then also change the 
> include
> files to match, is implied.
> The "modify ... a bit" implies you'll do something else (too), which 
> should be
> in its own separate patch (if that were actually the case).

Oh, the entire description of the patch was cobbled together in a rather
"relaxed" way, because it was past 2 AM over here, :) and because it's 
just
an RFC patch.  For the final version of the patch, if we agree upon 
moving
it forward from the RFC status, I'll prepare a more "formal" description
that will be much more detailed and more accurate.

> If you mention one variant but not (any) others, makes people like me 
> wonder:
> why is RK3588J treated differently then f.e. RK3588M?
> In this case I don't see a reason to single out one variant.

Good remark.  Will be described in the final patch description.

>> > As already discussed, [1][2][3] some of the different RK3588 SoC variants
>> > require different OPPs, and it makes more sense to have the OPPs already
>> > defined when a board dts includes one of the SoC dtsi files (rk3588.dtsi,
>> > rk3588j.dtsi or rk3588s.dtsi), rather than requiring the board dts file to
>> > also include a separate rk3588*-opp.dtsi file.
>> 
>> Indeed, including just one .dtsi for the correct SoC variant and not
>> having to bother about what other bits and pieces are required to use
>> the full SoC functionality sounds great! Thanks for putting this
>> together so promptly!
> 
> Indeed :)

Thanks. :)

>> > No intended functional changes are introduced.
> 
> ...
> 
>> >  ...inctrl.dtsi => rk3588-common-pinctrl.dtsi} |    0
>> 
>> Renaming the pinctrl includes seems superfluous - maybe keep them as
>> they were to minimize churn?
> 
> The reason for that wasn't clear to me either. If there is a good 
> reason for
> it, then a (git commit) message specify *why* is appreciated.

Another good remark.  Will be addressed in the final patch description.

>> >  .../{rk3588s.dtsi => rk3588-common.dtsi}      |    2 +-
>> >  ...nctrl.dtsi => rk3588-fullfat-pinctrl.dtsi} |    0
>> >  .../{rk3588.dtsi => rk3588-fullfat.dtsi}      |    4 +-
>> 
>> To me, "fullfat" doesn't look super descriptive, albeit fun :)
> 
> Agreed with the non-descriptive part. Please choose a different name.

I'll think about it.  I'm not crazy about "fullfat" either.

> And document in the git commit message why it was renamed and what is 
> expected
> to be in the new dtsi file, but would be incorrect for the old dtsi 
> file.
> 
> That you went from rk3588s.dtsi to rk3588-common.dtsi (I miss the 's') 
> should
> be described (assuming that was intentional and not a typo).

Omitting the "s" wasn't a typo.  It's just that rk3588s.dtsi served as
the base for other .dtsi files before, but it's now called 
rk3588-common.dtsi,
which makes its purpose a bit more self-descriptive, and separates it
from the actual SoC variants (S, J, M), which should also help a bit
with its self-descriptiveness.

Note that "common" is already used in the .dtsi filenames for some other
SoC families, which I actually took inspiration from.

> IOW: let this commit (message) describe what should and should not go 
> in the
> respective dtsi files, which can then be used as reference for future 
> rk3588
> board additions.

Of course.  Again, more material for the final patch description.

>> How about we rename the existing rk3588.dtsi and rk3588s.dtsi to
>> something like rk3588-devices.dtsi and rk3588s-devices.dtsi
> 
> Whether it's '-devices' or '-common', I think it's impossible for a 
> (short)
> name to be fully self-descriptive.
> Thus document what you mean by it in the commit message.

Agreed.  Once again, more material for the final patch description.

> Then we can use those 'rules' to consistently apply them.
> 
>> >  arch/arm64/boot/dts/rockchip/rk3588.dtsi      |  414 +--
>> >  arch/arm64/boot/dts/rockchip/rk3588j.dtsi     |    6 +-
>> >  arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 2671 +----------------
>> 
>> Rename detection didn't do a particularly great job here - wonder if
>> we can do anything about it to minimize the patch size and ensure that
>> the change history is preserved for git blame...
> 
> +1
> The diff does look awfully big for a rename operation, which was 
> supposed to
> (also only) "modify ... a bit".

I also don't like the size of the patch.  I just tried playing with
specifying different values for the --find-renames and --find-copies
options, but with no good results.  I'll have a look into the Git
source later, to see what's actually going on with those options.

