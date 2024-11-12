Return-Path: <linux-kernel+bounces-405453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C69379C519B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B752282F63
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13AF20CCFD;
	Tue, 12 Nov 2024 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JXwMu+2z"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B311A0721
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731402824; cv=none; b=sQoBxzENZilY4IzHXHUql0nGQH5d0Rac2BnUvnumurcbTEOOaj0p6UmRiepe/wEJWIjWUzNetQMISD2CwVSbDIT2bI+uYJOPDyhmi3zOH24dEzWlyJCVETAaxfj3y49xE4ahFyiptNFbrO4lugbLtWdfnGeGQl/A4DTFRyJ6Ez0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731402824; c=relaxed/simple;
	bh=CjyMiucagoBnkHV1XxcHOZfxB6tqD8jaUgODn8w3BTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/t/7OLoBy9cTGajoI3wK4mLIeiEfS18QPyy59UzSW1UAT/aRQ8oB0hyhhOMb/zGgVsXjAsk9gNn74yDOTiggNwnrfD2BqSP/owGrN4p6GIf8nB8/mDzgOjEwzTWRwlrLuRUuowWgPS5wePRnLOZuAUJU01EZ+e1ms89SZM/rkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JXwMu+2z; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 04880FF809;
	Tue, 12 Nov 2024 09:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731402819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ER+7FX/9Nod9Sg27NegOBZNs3ThKfuC8FsDnwd7chh0=;
	b=JXwMu+2zLmBEwJaGScgEpZDGC5L5SS5w6DhO5OXn/6y8de1s7tROrsKtOVa7hdLwXZgOxo
	ILO3TronxMnvpYWCnC1Bg4pLJuP6Gqvb3RFMh8LJ/0h7K9dQ/i0wxKNapvK27dyPZmUSiH
	a/01UKFt+/LbyFTEw9/hibgyD/iDRd9ASygWUFpFDv4+0dJrvwUkN5V63jWenKv1X48kh8
	QXsbZCLnGmqN0pnfgaejBudtYfrouqT4+h7K4Vew3GjYOnOhU6qXYaKoY9kn5T9vE+n0ll
	50ZbwK1Zp2SGNa2IXa/c5aKTTtaio1wZvSIB2V4EO/8pJWtorhl2gq9EzmndYg==
Message-ID: <07cd5d53-ce99-4ada-a7f1-53795eff5c42@bootlin.com>
Date: Tue, 12 Nov 2024 10:13:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] memory: ti-aemif: Export aemif_set_cs_timings()
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Christopher Cordahi <christophercordahi@nanometrics.ca>
References: <20241106085507.76425-1-bastien.curutchet@bootlin.com>
 <20241106085507.76425-3-bastien.curutchet@bootlin.com>
 <87ttcdr2ym.fsf@bootlin.com>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <87ttcdr2ym.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Miquèl,

On 11/11/24 8:21 PM, Miquel Raynal wrote:
> 
> Hello Bastien,
> 
> On 06/11/2024 at 09:55:03 +01, Bastien Curutchet <bastien.curutchet@bootlin.com> wrote:
> 
>> Export the aemif_set_cs_timing() symbol so it can be used by other
>> drivers
>>
>> Add a spinlock to protect the CS configuration register from concurrent
>> accesses.
> 
> What concurrent accesses are you trying to protect yourself against?
> I fail to see the use case, but TBH I haven't tried hard enough maybe.
> 

The register that handles the CS configuration belongs to the AEMIF 
component but it will also be accessed by the AEMIF 'children' with the 
aemif_set_cs_timing() function. So far, concurrent accesses shouldn't 
occur because the AEMIF configures the CS timings only once and does so 
before probing its 'children'; but I don't know how things can evolve in 
the future.

> Also, what justifies the use of a spin-lock in this case?
> 

TBH, I always struggle to choose between mutexes and spin-locks. I chose 
spin-lock because it only protects one memory-mapped register so I think 
it doesn't worth going to sleep when waiting for the lock.


Best regards,
Bastien

