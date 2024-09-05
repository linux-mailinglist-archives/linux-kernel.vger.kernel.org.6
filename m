Return-Path: <linux-kernel+bounces-317066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4175096D8C7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A552888CD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4B119B3D7;
	Thu,  5 Sep 2024 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="kB85xrYt"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88AD83CC1;
	Thu,  5 Sep 2024 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539938; cv=none; b=rt3GwtSzlcEqVhqWAviuSoDCfvuyGjsB1ov1PDLIwD1Aod5pomqpgHsBIdwDW6RRtRh8WV3MlBfHGbovMlBjCjnKp6TO8JkbQgbpKxcvFMit/wa+rkZnJOf2NT540TqqWo4CAQEdqVdfHbug+HSvRwkFvgNCIQ5D8Pz8jeEYPe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539938; c=relaxed/simple;
	bh=1TRvvmWO0MW5CntQv7pLz+ViK7vl3Ios2JulN/xl4Vc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=AAACSxdOzQbDJpzu4DcuP504pAWiKTpiXBracGTol3XYfdEh855J0kvXN7a0MZKGn0rQeO3ApL545xngzLBk4hklycSxfpvY6QsHovRojT6WMUSg5b/Jb34vJHFAPcGioCBBK4iaR9YLN8crzGSZc5Aeq3hQhYO7ym3RMLRxMVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=kB85xrYt; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1725539934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0dWXQ8uXxTsUng+Z7yBJoOLelaxiBjqcire+DINUVv0=;
	b=kB85xrYtcoKUq0Q/7bpKO+BjGGnitX3Efdr7ChhAAZpyKGmftoeVDX33yKz3AICZh08fXV
	JCbdZc57RWlndM49YrTu37cR7Cv8mQiezZ733I6bIXRNcDXBD8G0cLMqBt3g4eFKN/HOep
	kh7mG1eE23T2kHdcJbLnsI4XeCfVPowsSCNU2fysTbH6hTwXYFy1HO0i8AXsmGlK36kCUS
	aNFJ5E/RZjLGg2PYwmJtxGXiIsdVzQ3cVaEEVGzEmOHViirdhgTZfPl4RtnMKsy+wIXYjV
	pehUwep/sBi/3L+lfRuZ1n7AjwUTJ5S6I8tDtYrPx2MUnv9sqUGoHNGI4TomcA==
Date: Thu, 05 Sep 2024 14:38:53 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev,
 jernej.skrabec@gmail.com, samuel@sholland.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Move CPU OPPs to the SoC dtsi
 file
In-Reply-To: <20240905133412.6ba050de@donnerap.manchester.arm.com>
References: <92ebc9cba6eb669df73efd478e4f5745056a4ce5.1723614345.git.dsimic@manjaro.org>
 <CAGb2v678Z8TMKZmBmmd5hW9XBdKw9KD+JgrsMm5e8sSoYOq3wA@mail.gmail.com>
 <21d6e75bc33ef2b7f27932fee1b8de05@manjaro.org>
 <20240815181508.6800e205@donnerap.manchester.arm.com>
 <06cec3fc98e930bedc8ea5bfde776b3d@manjaro.org>
 <0fc37f3074a3e99c15a2f441194b7032@manjaro.org>
 <CAGb2v65h8zaxoEKeqdT8BZD9t=4gf0QM7zBnhuDoiEhHQLKduw@mail.gmail.com>
 <20240905133412.6ba050de@donnerap.manchester.arm.com>
Message-ID: <b07f1365a6f942297f7a3308fa628187@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Andre,

On 2024-09-05 14:34, Andre Przywara wrote:
> On Thu, 5 Sep 2024 20:26:15 +0800
> Chen-Yu Tsai <wens@csie.org> wrote:
> 
>> Hi,
>> 
>> On Thu, Sep 5, 2024 at 8:17 PM Dragan Simic <dsimic@manjaro.org> 
>> wrote:
>> >
>> > Hello,
>> >
>> > Just checking, any further thoughts about this patch?
>> 
>> Sorry, but I feel like it's not really worth the churn. There's not
>> really a problem to be solved here. What you are arguing for is more
>> about aesthetics, and we could argue that having them separate makes
>> it easier to read and turn on/off.
> 
> Yeah, I agree. If a board wants to support OPPs, they just have to 
> include
> a single file and define the CPU regulator, and that's a nice opt-in,
> IMHO.
> But having this patch would make it quite hard to opt out, I believe. 
> For
> Linux there are probably ways to disable DVFS nevertheless, but I am 
> not
> sure this is true in an OS agnostic pure-DT-only way.

Thanks for your response.  The only thing that still makes me wonder
is why would a board want to opt out of DVFS?  Frankly, I'd consider
the design of the boards that must keep DVFS disabled broken.

> This could probably be solved, but same as Chen-Yu I don't see any good
> enough reason for this patch in the first place.
> 
>> And even though the GPU OPPs are in the dtsi, it's just one OPP acting
>> as a default clock rate.

