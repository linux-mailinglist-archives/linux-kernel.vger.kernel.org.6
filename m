Return-Path: <linux-kernel+bounces-439010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4D99EA977
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D18E0286508
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8B722CBF3;
	Tue, 10 Dec 2024 07:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TxR6h4p7"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C2122CBFF
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733815400; cv=none; b=Xou/MHcVCd2OeAtWz7ktGNAxNkqPtugyVpQHkF57XG1CHJZ8lprAHOO559WPTvLC0/DZuIho3XvFuJNo126ki+thmBZ5JgMmVZtzbOpinxHl/tBTxVQt7hxc9pl5lRxrZT+7sPgahauncP4UXWeF3WPsoXJV0AjiFv8K42UIQus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733815400; c=relaxed/simple;
	bh=RwcdaKvMoRltDrKKDq6amieJKv8mDl3l5An8pCvOOlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dqO1TcwMYZTvwteu4ceF5z2nwcyJO1CWkUB9rtnIvlU9tTpxW6SGv/jp/Ay8S94jm7QkKt6F8sEhc287hRzegrk+wD8LmbC27H0gD+p3YqiznfyYvh9yFr7BQ54noMJpKx4Cs+oQ275WT4ospX8NZHzqVzMHvnL2OgmgmiNXai0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TxR6h4p7; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ACCFFC0008;
	Tue, 10 Dec 2024 07:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733815394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJup6Kt/wB1cEq9cKIKkxDbK2vt8HvtMBETNBzBxQvI=;
	b=TxR6h4p7DBcdg93eZFIJAeI29MrAgY3+xCMsExXD4gP39rlYMHGXsuEUXv4sNFlHvzDgR6
	jldEAxbGzMYfQeu4hYfP68mQrviPswWMsAgsu6aAjv9zz5y3bF3BAZojfqQnsAqVmGvFkU
	TJqmKA8EeDwDBGsNMmdVxRT4ezbB0Cpu6vxZ5D5ey6q6zWvv1eZU8qjBPpdlBXfZLXsLIC
	4YUVjsgtjmyFglLvfaMn5LQ4fTkkfaHd97qPkaNFeVpa1dupvdeNE+XVOAgoFxjlBTfi/M
	CNfaYDkgQFhlD/yZKW8HX1ozr41tCygUNu1dej/f7QTzvevBC5D6xjI6yErM6Q==
Message-ID: <3405febf-63ce-4ce8-80b9-1d0da7436333@bootlin.com>
Date: Tue, 10 Dec 2024 08:23:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] memory: ti-aemif: Create aemif_set_cs_timings()
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Christopher Cordahi <christophercordahi@nanometrics.ca>
References: <20241204094319.1050826-1-bastien.curutchet@bootlin.com>
 <20241204094319.1050826-6-bastien.curutchet@bootlin.com>
 <82276301-970e-427b-9fb2-8866881fb487@kernel.org>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <82276301-970e-427b-9fb2-8866881fb487@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Krzysztof,

On 12/9/24 8:41 PM, Krzysztof Kozlowski wrote:
> On 04/12/2024 10:43, Bastien Curutchet wrote:
>> Create an aemif_set_cs_timings() function to isolate the setting of a
>> chip select timing configuration and ease its exportation.
>>
>> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
>> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> ---
>>   drivers/memory/ti-aemif.c | 65 +++++++++++++++++++++++++++++----------
>>   1 file changed, 49 insertions(+), 16 deletions(-)
> 
> ...
> 
>>   
>>   /**
>>    * struct aemif_cs_timings: structure to hold CS timings
>> @@ -165,6 +165,44 @@ static int aemif_check_cs_timings(struct aemif_cs_timings *timings)
>>   	return 0;
>>   }
>>   
>> +/**
>> + * aemif_set_cs_timings() - Set the timing configuration of a given chip select.
>> + * @aemif: aemif device to configure
>> + * @cs: index of the chip select to configure
>> + * @timings: timings configuration to set
>> + *
>> + * @return: 0 on success, else negative errno.
>> + */
>> +static int aemif_set_cs_timings(struct aemif_device *aemif, u8 cs, struct aemif_cs_timings *timings)
> 
> In the future, please stick to 80-char wrapping unless exceeding makes
> code more readable (see Coding style). I fixed it up while applying.
> 

Ok, thank you.


Best regards,
Bastien

