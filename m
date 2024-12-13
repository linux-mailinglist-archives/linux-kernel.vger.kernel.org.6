Return-Path: <linux-kernel+bounces-445507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD689F1710
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFB7F161698
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27ECE19149F;
	Fri, 13 Dec 2024 19:58:46 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80C518FC92;
	Fri, 13 Dec 2024 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119925; cv=none; b=nxG7w8SfmZrBNiUhkGZjkQMNcCMxnquxp9Q6qgZM/lxk59Zu7lVCs8RjQo/C3SldSrzJnXkXtNIPRVhiXP0MmxlLpmKGOFTykrsdbxBlyQu19+e9TIwgbPk/wOvcBhmqBVpXi3F1whwmnGV6otrjRiUXIcPcPb2VeY/SMigNqMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119925; c=relaxed/simple;
	bh=yXz/ZArx/CIwOD9NJ+qcdUlQuOZ6GiFR00uSRHphH3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qhJ6afCjlWYvqkxwASU8yt9tEdKXa+y3BO5cvhpEFUbigQzUCl59riFgI47PhDk4hU1KTmwc8nafMzYFnRtiexlkNRRVV4YhVI7japxi6VgjaL3lJhS1NlA1e1aZgb4Z6W/6yjX4d+POAuNa4DVVv/g1i4P1XoqDTTzmTlsHX+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from [IPV6:2605:59c8:31de:bf00:37c2:fe62:c21b:ab46] (unknown [IPv6:2605:59c8:31de:bf00:37c2:fe62:c21b:ab46])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 457CAB4B2F92;
	Fri, 13 Dec 2024 20:58:31 +0100 (CET)
Message-ID: <e4e19875-c02c-4673-814b-86090223b55d@freeshell.de>
Date: Fri, 13 Dec 2024 11:58:29 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: dts: starfive: Fix a typo in StarFive JH7110 pin
 function definitions
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Emil Renner Berthing <kernel@esmil.dk>, Conor Dooley <conor@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Hal Feng <hal.feng@starfivetech.com>,
 Jianlong Huang <jianlong.huang@starfivetech.com>,
 Conor Dooley <conor.dooley@microchip.com>, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241210042002.165297-1-e@freeshell.de>
 <oacmcw5yvdlsmvqbt4dbdmsx6rvd6x43qv2ejmypw57jgraqu7@txhhsxdg2agq>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <oacmcw5yvdlsmvqbt4dbdmsx6rvd6x43qv2ejmypw57jgraqu7@txhhsxdg2agq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 12/13/24 01:37, Krzysztof Kozlowski wrote:
> On Mon, Dec 09, 2024 at 08:19:56PM -0800, E Shattow wrote:
>> Fix a typo in StarFive JH7110 pin function definitions for GPOUT_SYS_SDIO1_DATA4
>>
>> Fixes: e22f09e598d12 ("riscv: dts: starfive: Add StarFive JH7110 pin function definitions")
>> Signed-off-by: E Shattow <e@freeshell.de>
>> Acked-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
> 
> Why are you sending the same multiple times? Where is the changelog and
> proper patch versioning?
> 
> Best regards,
> Krzysztof
> 

I did respond to Hal's comment that the patch is missing a commit title 
description and that I would re-send. How instead should the message be 
formatted so the patch commit title description is changed but the patch 
is not the same being sent multiple times?  And now, again, based on 
your comment that this is not a typo I will again change the commit 
description but I don't know how to do that without sending again as a 
duplicate.

Thank you for the review and for your patience with me when I am 
learning how to participate.

-E


