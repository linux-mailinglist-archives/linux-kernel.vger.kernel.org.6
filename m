Return-Path: <linux-kernel+bounces-322427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E8B9728DC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26A21F22223
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E91D16C850;
	Tue, 10 Sep 2024 05:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="r47X2Z2M"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF9344C7C;
	Tue, 10 Sep 2024 05:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725945486; cv=none; b=jXkZNj4khiHrhqFbVcd0AGLePK+6LrtOBAMplrfF5cYiDe8jgAXpPxdHf+JsArqKl9HR/D1KIoT3PVGJHnX3vTgOcPlx7+TR7c8yE7ZDEO0rgnYKwDuGt+IpfOBMwZWcDF9gPKBdJUE7uOGGNjJ8qF6LPHdXyCIUp7pTKdkAzMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725945486; c=relaxed/simple;
	bh=hAhZ364znAxgZljeJw5JgixjqcAtcGqnXZpvX0S0/bM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=eE+fuiKkeEb6Z7iLZDF/iEmZMo8X56uZWMl+BziImvqH2C35bSy8bWb10lk7gB9CiQ6SPd1EQT7Z8FukrayU/90PGbhvnm01kh05V8SLnH8Mym4SLp3T29eV1Nl5XxK0R0KrMjICcdyMXT5NS9OHq1An/+ct3/0gFjX+FlE+d+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=r47X2Z2M; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1725945475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fstbatTWWnEJ/CPU36BeADiwbLC59NJU+ju1hfFIVHI=;
	b=r47X2Z2MMM1xhMaCrEtYPgpc8/OcQV9kKz7r6HsZdO9e5QaSwEuq8CMsipUK+XW/iL+seF
	vixilZs1VMO9MF2aWH5CgXsO3wFzYyj6HEqMQ6tdEvo+8quK8s/m9IT3fJsqhDOWP6nRSw
	C4c+Ftg6UjqmMM1pQkMVBsdp8vn9W1XGOvEFQ+aP4g5oXIzrLQXUZGG/T/wdSSUq+5UbeY
	I/g3A8SlApHx5OlYi6YRCSdsWdTKjYK+2EuKRahnnUPuCxcadIRG9V9c2gaWwLp3MSLIRt
	o2wMnBTSvkFBaN/p/Zw+I9qOA1Bg/A0AdRlC6D8lDHDbs5kHdD4Wi56ZPEQR9w==
Date: Tue, 10 Sep 2024 07:17:55 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev,
 jernej.skrabec@gmail.com, samuel@sholland.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Move CPU OPPs to the SoC dtsi
 file
In-Reply-To: <20240905142054.58194beb@donnerap.manchester.arm.com>
References: <92ebc9cba6eb669df73efd478e4f5745056a4ce5.1723614345.git.dsimic@manjaro.org>
 <CAGb2v678Z8TMKZmBmmd5hW9XBdKw9KD+JgrsMm5e8sSoYOq3wA@mail.gmail.com>
 <21d6e75bc33ef2b7f27932fee1b8de05@manjaro.org>
 <20240815181508.6800e205@donnerap.manchester.arm.com>
 <06cec3fc98e930bedc8ea5bfde776b3d@manjaro.org>
 <0fc37f3074a3e99c15a2f441194b7032@manjaro.org>
 <CAGb2v65h8zaxoEKeqdT8BZD9t=4gf0QM7zBnhuDoiEhHQLKduw@mail.gmail.com>
 <20240905133412.6ba050de@donnerap.manchester.arm.com>
 <b07f1365a6f942297f7a3308fa628187@manjaro.org>
 <20240905134254.6e15a1e5@donnerap.manchester.arm.com>
 <8a80465aaa4b7dc4c8c15d7a73944cfd@manjaro.org>
 <20240905142054.58194beb@donnerap.manchester.arm.com>
Message-ID: <df8b774e10a0dbe5c01dc39d3cbd92fd@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Andre,

On 2024-09-05 15:20, Andre Przywara wrote:
> On Thu, 05 Sep 2024 14:54:03 +0200 Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-09-05 14:42, Andre Przywara wrote:
>> > On Thu, 05 Sep 2024 14:38:53 +0200
>> > Dragan Simic <dsimic@manjaro.org> wrote:
>> >> On 2024-09-05 14:34, Andre Przywara wrote:
>> >> > On Thu, 5 Sep 2024 20:26:15 +0800
>> >> > Chen-Yu Tsai <wens@csie.org> wrote:
>> >> >> On Thu, Sep 5, 2024 at 8:17 PM Dragan Simic <dsimic@manjaro.org>
>> >> >> wrote:
>> >> >> > Just checking, any further thoughts about this patch?
>> >> >>
>> >> >> Sorry, but I feel like it's not really worth the churn. There's not
>> >> >> really a problem to be solved here. What you are arguing for is more
>> >> >> about aesthetics, and we could argue that having them separate makes
>> >> >> it easier to read and turn on/off.
>> >> >
>> >> > Yeah, I agree. If a board wants to support OPPs, they just have to
>> >> > include
>> >> > a single file and define the CPU regulator, and that's a nice opt-in,
>> >> > IMHO.
>> >> > But having this patch would make it quite hard to opt out, I believe.
>> >> > For
>> >> > Linux there are probably ways to disable DVFS nevertheless, but I am
>> >> > not
>> >> > sure this is true in an OS agnostic pure-DT-only way.
>> >>
>> >> Thanks for your response.  The only thing that still makes me wonder
>> >> is why would a board want to opt out of DVFS?  Frankly, I'd consider
>> >> the design of the boards that must keep DVFS disabled broken.
>> >
>> > Yes! Among the boards using Allwinner SoCs there are some, say
>> > less-optimal designs ;-)
>> 
>> I see, but such boards could simply disable the "cpu0_opp_table"
>> node in their dts(i) files, for the encapsulated CPU OPPs scenario,
>> and everything would still work and be defined in a clean(er) way.
> 
> I agree, and I was already about to suggest this as a reply to your 
> initial
> post, but I think I tried that, and IIRC this doesn't work: the 
> "status"
> property is not honoured for this node.
> But please double check that.

I apologize for my delayed response.

Perhaps a safer approach could be to introduce a new dtsi file, named
sun50i-a64-cpu-opps-disabled.dtsi, with the following contents:

/delete-node/ &cpu0_opp_table;

&cpu0 {
	/delete-property/ operating-points-v2;
};

&cpu1 {
	/delete-property/ operating-points-v2;
};

&cpu2 {
	/delete-property/ operating-points-v2;
};

&cpu3 {
	/delete-property/ operating-points-v2;
};

The purpose of this new file would be to delete the CPU OPPs for the
suboptimally designed boards, when included into their dts(i) files,
while the CPU OPPs would be "encapsulated" into the SoC dtsi.

Though, I'm not sure how much cleaner this approach would be, but
I think it would fit rather well with the suggested approach of having
such suboptimal board designs treated as an exception that would be
handled in some special way.  As a bonus, it would also make locating
dts(i) files for such suboptimal designs a bit simpler, by grepping
for "cpu-opps-disabled".

>> I mean, if there are some suboptimal designs, perhaps the defaults
>> should be tailored towards the good designs, and the suboptimal
>> designs should be some kind of exceptions.
>> 
>> >> > This could probably be solved, but same as Chen-Yu I don't see any good
>> >> > enough reason for this patch in the first place.
>> >> >
>> >> >> And even though the GPU OPPs are in the dtsi, it's just one OPP acting
>> >> >> as a default clock rate.

