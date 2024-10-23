Return-Path: <linux-kernel+bounces-377177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7519ABADC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 03:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C966284DE5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 01:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7785E208A5;
	Wed, 23 Oct 2024 01:12:56 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6211C687;
	Wed, 23 Oct 2024 01:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729645976; cv=none; b=EYFW53dbFTBCRnjM72+f0vzVh+szWbMIPCGfZ0vvfHQwoJKeA36NOuSCGJLiRkBLbLG1hpd3J2wpNHPQL3XT+TLh8cD2pVV2XVyX82TChOoy9dTKNW+7F7t11L/0PdWg8+f4trLuslCRQAqdPAxKyjI1WR84VUEnmxpHJsYI0tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729645976; c=relaxed/simple;
	bh=1CRyGpFPXnZ3EeTDtQQ//Q62U5p5ZIRBi44cv20mdJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZwVE8iInixWyIFUAipKOk9yyu2qs5wdKZ47fYfZV9wy7IkeoRX8+hN2AT+Gp7iJNdvMEuKyLxVTAtE9ObLUrRqZO5+aDnhD92HB2zEextIRaRcW+pTnZj8R9hLEwqju5ZmjgTiVCH+/GVd2FsKRstSPcxQSWhFgruDnYPjDplHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from [IPV6:2605:59c8:31de:bf00:37c2:fe62:c21b:ab46] (unknown [IPv6:2605:59c8:31de:bf00:37c2:fe62:c21b:ab46])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id B9AB0B4B04E6;
	Wed, 23 Oct 2024 03:12:46 +0200 (CEST)
Message-ID: <434a7a39-de2d-4053-aed7-df556b5c385d@freeshell.de>
Date: Tue, 22 Oct 2024 18:12:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: dts: starfive: Update ethernet phy0 delay
 parameter values for Star64
To: Conor Dooley <conor@kernel.org>
Cc: Henry Bell <dmoo_dv@protonmail.com>,
 Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241022061004.62812-1-e@freeshell.de>
 <20241022-amusement-overreach-c5d1d7fd797b@spud>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20241022-amusement-overreach-c5d1d7fd797b@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/22/24 09:41, Conor Dooley wrote:
> On Mon, Oct 21, 2024 at 11:09:51PM -0700, E Shattow wrote:
>> Improve function of Star64 bottom network port phy0 with updated delay values.
>> Initial upstream patches supporting Star64 use the same vendor board support
>> package parameters known to result in an unreliable bottom network port.
> Should I add:
> Fixes: 2606bf583b962 ("riscv: dts: starfive: add Star64 board devicetree")
> CC: stable@vger.kernel.org
> ?
>
> "unreliable" sounds to me like something that is worthy of going to
> fixes/stable

Applying as a fix to stable sounds reasonable, thanks. The bottom 
network port has always been known by Star64 users in reviews and 
discussions to be affected by dropped packets and low network 
throughput. If we want to prove correctness does this require expertise 
and use of an oscilloscope to characterize the signal timing? Though I 
am not sure I got it right, it's not worse than previously was on any of 
these Star64 boards in the wild and probably is better for at least some 
(if not all).

Notable aside is to mention the re-worked motorcomm driver of 
more-recent Linux kernel releases (when compared to the vendor board 
support package) dropped the Fast Ethernet configuration parameters on 
the reasoning that Fast Ethernet (as compared to Gigabit Ethernet) is 
relatively slow enough of a signal that a default delay parameter is 
good enough for all use cases. The non-default Fast Ethernet delay 
parameter values missing from the upstream effort are not possible to 
implement or test for in my effort here, but are no worse or better for 
having this patch applied.

-E


