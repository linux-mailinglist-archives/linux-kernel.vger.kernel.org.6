Return-Path: <linux-kernel+bounces-388696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C809B6332
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 484371F21A3F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905271E882B;
	Wed, 30 Oct 2024 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bcAFvYMC"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6441E4AE
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 12:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730291967; cv=none; b=tEbw38VGK6Zht/QG4J+JdP0RDPQyEWDUERs0Q4ItSNNscvo0mj2iBrFV7zlbGjhIo7JFXx9FDBqwFKrUzttFOFZdMK1d2Fjv9DX04qugHKahgPI4aYWxd7FC6K6uTZ2VaNngrLAiItwZ6XbO6MYG3PnMraqmoudCY+oY2Omm5Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730291967; c=relaxed/simple;
	bh=evsbQuE5KlminpWigsLOo6kybKyr+k0GSUf5MvO+Trs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nKR63HAYuIxrWcsgXdo9MAFQJLPHxV/CTr0YTHlqx5qwVY+7763YDv/eEv2C9r9W+67BWvhVBSgI8nV8t59udatqn6drpSN6quAgsWGymJryVbxAJg6dN3Ffq/CtkRiszBVISCZSGfonANNM64aVln28rxthTukTGkXcFhtw/Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bcAFvYMC; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AAD87FF807;
	Wed, 30 Oct 2024 12:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730291963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RhyPbAq58zDiCBw+D6bNpgM3r5/2NHM3HBjd+pUlFJA=;
	b=bcAFvYMCOgJmIyfQ6Od4D2NGh+yjgIYJBJxQUg3qQ+o60UW1DOpKVDktiyak3n+VQmdnsa
	EJVpA5uzPUgwZ/aiFVUuPY5y568dqlVkwqY4MND5o9cSwedrlU4yZBBeiy2VzqXnxSd15L
	pYNcEs7l8n7rOxbLUHeIM6ZfHwPwn8igcGwixykhVoxiYeeBLSTzanW+379WNS5zIhXq3k
	xXiou0bBC7aVj/1q85EW1Yhacm5WyLlHhaosYG9CmkclLmr6Sd3i4LKiRTh1z0kozvMEsA
	lKJ3MVYa+bpSUoJZkkxLdBPUfrQ5V3XE4CqDYgk3/EHjeCSmGwvGH2BkWKljtQ==
Message-ID: <fdf3d305-d6a9-47bb-b474-92da43b8d557@bootlin.com>
Date: Wed, 30 Oct 2024 13:39:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Implement setup_inteface() in the DaVinci NAND
 controller
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Christopher Cordahi <christophercordahi@nanometrics.ca>
References: <20241030104717.88688-1-bastien.curutchet@bootlin.com>
 <f1078ec6-209c-41bb-9a72-ee6e045231b4@kernel.org>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <f1078ec6-209c-41bb-9a72-ee6e045231b4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Krzysztof,

On 10/30/24 12:17 PM, Krzysztof Kozlowski wrote:
> On 30/10/2024 11:47, Bastien Curutchet wrote:
>> Hi all,
>>
>> This patch series aims to implement the setup_interface() operation in
>> the DaVinci NAND controller to enable the use of all ONFI modes and
>> improve the NAND access speed.
>>
> 
> Your changelog is supposed to explain also merging dependencies. Within
> patchset or external.

I'm not sure I understand what you mean here. Do you mean that I need to 
explicitly state that the patches in the 
drivers/mtd/nand/raw/davinci_nand.c depend on the ones in 
drivers/memory/ti-aemif.c ?

There isn't any external dependency on this patch series. The ONFI modes 
are already managed by the NAND core driver (in 
drivers/mtd/nand/raw/nand_base.c). If a NAND controller wants to benefit 
from all the ONFI modes, it needs to implement the setup_interface() 
operation; otherwise it can only use the mode 0 which is the slowest.

> 
>> This NAND controller is present in the DaVinci (OMAP L138) and Keystone2
>> SoCs and functions as a 'child' of the AEMIF controller. So its timings
>> are set by the AEMIF controller itself from device-tree properties.
>> Implementing the setup_interface() callback implies being able to update
>> dynamically these timings, so the first two patches of the series modify
>> the AEMIF driver to provide its 'children' a way to modify their chip
>> select timing configuration. To do so, I add a ti-aemif.h header, I'm not
>> sure whether this header should be located in include/memory or in
>> include/linux/memory. I put it in include/memory because the folder
>> already exists while include/linux/memory doesn't.
> 
> All Linux headers go to include/linux/, so this one should as well.
> 

Ok thank you, I'll move it there in V2.


Best regards,
Bastien

