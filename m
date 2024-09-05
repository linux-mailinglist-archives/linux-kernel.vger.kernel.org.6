Return-Path: <linux-kernel+bounces-317119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7251D96D972
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322D7283B43
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A96819D88C;
	Thu,  5 Sep 2024 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="g5QQ/1Mn"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF8119AD48;
	Thu,  5 Sep 2024 12:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540847; cv=none; b=WcRkhcY0PcLLueFVuzSDywJk05I9SMFoJaTUoJAOO+QUMPQouexmnysWOJzLNr8oQedxTORhQ/87kKJEnDl3gzG/mz1UoJIJBjYjJ0DfHEqbHTBXPpi4LOa04Djt/DufjtzM9stXzUU2rECwzQmHOyB1JqydVoEaxU6rIxXXws8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540847; c=relaxed/simple;
	bh=9PiVTuS8Gxkr/+Fe8T+LFEESvRnP0eN8b+UZS525hDY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Cv1PV2et6hArvHarcipttNLVB5WkaudbqeZ/mfF0jnqnPehne2wZKiu33EwnOJ9TGzX+Gvo3Y1WsZA8D83GYi2i1jo07EhxNvzwSqSB/4xQ/ba50Ay1j4Fbpd7Pr1OYwafK+fI8OkzUveHYFfV0I/Awdl+FABkDswwqyDxJ6SOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=g5QQ/1Mn; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1725540843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4mq+B9gm9fV2NDBLUNaSg7uppvTNJbTcEl31DoYeJNU=;
	b=g5QQ/1MnOxqB0Gc02A8EZvhIWisBgrZN65FPfeFJ4/4WDS8V/NkhSSrmL7o86KiARqRBx+
	wTEFqPzMwnC14cSkwJ6D6OBo+O5OBeM/ksZEPsjFV90tp85PzFdehiKiNiVTz8tJ7ZoXAU
	A+dfiHo9nAd5s1n7H1MuCKk7SxJkYlbUhMye22x5OiEdX6uG31T/HxKBNU41viuIq+1kQU
	6TdEdLOpte7Zrzt3GRP9KeRQaLebzf08C4Slp9gZGJvc+vDJRYzTKWQC89cH0OoxVDjrKe
	VYksRylsFzOBw+WTD60tawSBwawI3slTeJ7KyYQkY8I6g4abexRdZif7re4FlA==
Date: Thu, 05 Sep 2024 14:54:03 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev,
 jernej.skrabec@gmail.com, samuel@sholland.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Move CPU OPPs to the SoC dtsi
 file
In-Reply-To: <20240905134254.6e15a1e5@donnerap.manchester.arm.com>
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
Message-ID: <8a80465aaa4b7dc4c8c15d7a73944cfd@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-09-05 14:42, Andre Przywara wrote:
> On Thu, 05 Sep 2024 14:38:53 +0200
> Dragan Simic <dsimic@manjaro.org> wrote:
> 
>> Hello Andre,
>> 
>> On 2024-09-05 14:34, Andre Przywara wrote:
>> > On Thu, 5 Sep 2024 20:26:15 +0800
>> > Chen-Yu Tsai <wens@csie.org> wrote:
>> >
>> >> Hi,
>> >>
>> >> On Thu, Sep 5, 2024 at 8:17 PM Dragan Simic <dsimic@manjaro.org>
>> >> wrote:
>> >> >
>> >> > Hello,
>> >> >
>> >> > Just checking, any further thoughts about this patch?
>> >>
>> >> Sorry, but I feel like it's not really worth the churn. There's not
>> >> really a problem to be solved here. What you are arguing for is more
>> >> about aesthetics, and we could argue that having them separate makes
>> >> it easier to read and turn on/off.
>> >
>> > Yeah, I agree. If a board wants to support OPPs, they just have to
>> > include
>> > a single file and define the CPU regulator, and that's a nice opt-in,
>> > IMHO.
>> > But having this patch would make it quite hard to opt out, I believe.
>> > For
>> > Linux there are probably ways to disable DVFS nevertheless, but I am
>> > not
>> > sure this is true in an OS agnostic pure-DT-only way.
>> 
>> Thanks for your response.  The only thing that still makes me wonder
>> is why would a board want to opt out of DVFS?  Frankly, I'd consider
>> the design of the boards that must keep DVFS disabled broken.
> 
> Yes! Among the boards using Allwinner SoCs there are some, say 
> less-optimal
> designs ;-)

I see, but such boards could simply disable the "cpu0_opp_table" node in
their dts(i) files, for the encapsulated CPU OPPs scenario, and 
everything
would still work and be defined in a clean(er) way.

I mean, if there are some suboptimal designs, perhaps the defaults 
should
be tailored towards the good designs, and the suboptimal designs should 
be
some kind of exceptions.

>> > This could probably be solved, but same as Chen-Yu I don't see any good
>> > enough reason for this patch in the first place.
>> >
>> >> And even though the GPU OPPs are in the dtsi, it's just one OPP acting
>> >> as a default clock rate.

