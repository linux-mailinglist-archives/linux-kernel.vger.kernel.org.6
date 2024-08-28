Return-Path: <linux-kernel+bounces-305610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3277963122
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D292286804
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292171ABED0;
	Wed, 28 Aug 2024 19:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLeGeDkZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EA31AAE29;
	Wed, 28 Aug 2024 19:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724874281; cv=none; b=jCzarwUKybeK5R+he63XnUjFCjsJFQZdYEqfWcgeBe8Pcx3UoD2qBctBNULoCigosZ6DedPgRa1iS20dEF2jV+FbWo0nNkUPMTgdeJ7pDCvMebn2olTy/qBhhGu62BFD1vI384raHTaBGnugzKbWhaLRLw+D8EkLPkDQ5a/fxPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724874281; c=relaxed/simple;
	bh=z+DN7pQDTPTfVhhxP/6pUWvaEtfsBhIDxLbuBJvw8VY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HfLTrwgV6x9M2Fu2bwhPRO6M8Bg6HCVqDMt9iSn+/uWXYBVtWNMIF39gCV8jbUWrdSj2nUSXDPpalF7L33VLlcW0I4ARif6oXi2zL1uBlSLaDYA8E7bXVHl7/EUeaxlC1SO1ExGWzFRJkqU7mydsTCgOXI4bLd/B7reE38K66es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLeGeDkZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9DEC4CEC0;
	Wed, 28 Aug 2024 19:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724874281;
	bh=z+DN7pQDTPTfVhhxP/6pUWvaEtfsBhIDxLbuBJvw8VY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pLeGeDkZuR89DglWmSXQWT13UbzmiskpP0ALuIO7PMVFcIfhosqBN2QS/d5ZBUFIb
	 IdTBo/fG1Mw6Uq05oORGuwmqLnASSCvyHceY0Hzj7tGOmCzvMGp1HneD08E0BQVdJ4
	 xmds8YyVur5Agnpbk6vnoQFWj9VMR2hqR+5aYN5/VaOrAEyEX8HSzd2spSl1mdkIsD
	 EGKfo3fMur3U1fUefHsTM+QjYm5oa/ARGYuRhjIl/beCif/DoQSOPEND0QtiCmdvUz
	 9vQrdmlbRiP5hJS1+6u4LQUSeTzYIeXRWtS0VqbeT+To/WJe09GlNCRNn6lSNc3ugS
	 5ehuboREuAgpA==
Message-ID: <87752439-1b41-4f4b-9e94-5c2a43fab4f4@kernel.org>
Date: Wed, 28 Aug 2024 22:44:34 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: ti: Add k3-am67a-beagley-ai
To: Robert Nelson <robertcnelson@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 Nishanth Menon <nm@ti.com>, Andrew Davis <afd@ti.com>,
 Jai Luthra <j-luthra@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Jared McArthur <j-mcarthur@ti.com>, Jason Kridner
 <jkridner@beagleboard.org>, Deepak Khatri <lorforlinux@beagleboard.org>,
 Drew Fustini <drew@beagleboard.org>
References: <20240822170440.265055-1-robertcnelson@gmail.com>
 <20240822170440.265055-2-robertcnelson@gmail.com>
 <2774e7e5-8c03-4f38-90c3-b414bc6af255@kernel.org>
 <CAOCHtYhK36QyKOmQhY+Q31rB23ASoxUXTX+0R1tzK-ZhvvWSLA@mail.gmail.com>
 <CAOCHtYiPdxpxz9oPO-deLMMgMZtjCjtEMqPARAPtqMKg8JxOhQ@mail.gmail.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <CAOCHtYiPdxpxz9oPO-deLMMgMZtjCjtEMqPARAPtqMKg8JxOhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 28/08/2024 17:33, Robert Nelson wrote:
> On Fri, Aug 23, 2024 at 10:33 AM Robert Nelson <robertcnelson@gmail.com> wrote:
>>
>>>> +
>>>> +&cpsw3g {
>>>> +     pinctrl-names = "default";
>>>> +     pinctrl-0 = <&rgmii1_pins_default>, <&gbe_pmx_obsclk>;
>>>
>>> Why do you need OBSCLK for Ethernet MAC?
>>> The OBSCLK is connected to the Ethernet PHY via C406 which is not even populated.
>>> It seems that the PHY is clocked by a crystal oscillator X5 so doesn't really
>>> need OBSCLK in the stock configuration?
>>
>> Ah crap, I'll take a look at this... I bet it's left over from the
>> first pcb, (all my first rev pcb's are now locked up so i don't use
>> them anymore)..  Seeed/BeagleBoard was playing it safe and designing
>> in both options.. Once the internal clocks were verified newer
>> revisions removed the external clock.
>>
>> Yeah, I'm pretty sure final production boards removed every external
>> clock option.
> 
> Yeap, external clock is the default for all production boards, i
> removed this internal clock configuration.

Did you mean internal clock is the default?
Earlier you mentioned
"after verification newer versions removed the external clock"

-- 
cheers,
-roger

