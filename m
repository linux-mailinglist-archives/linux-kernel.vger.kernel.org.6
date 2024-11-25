Return-Path: <linux-kernel+bounces-420975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E159D8532
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F5EDB2BA89
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686C3199E9A;
	Mon, 25 Nov 2024 12:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hzW/1zTy"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FC713774D;
	Mon, 25 Nov 2024 12:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732536170; cv=none; b=VYO26KbeMQ1/mLcAWH4TJBY5vFYMtp4Pp8I/bwvoY2I+rivsq/O6jAKnIh+67VN4RKtZPQ9GbYgvMVjIGdQ//1ArvGuqCqDJ0yvnoHrZT2vfyE7oZ4SBAApmdjG1kzp9hfLC9WNuyjAxfMktNzKBEt2BhKVN1cgHctSK7bXyqgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732536170; c=relaxed/simple;
	bh=gxiRcxKvp8H8c5I9uyu/kGel1w+XZC9NNckUo3rp8Yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iW84vZ9RN0wrm3WsfVDIQdP8ITHxTNOiCDgvL2AqM+BDc6MQp4kJiwXmcxqXOVuZQHo7On1xGxRkndyv8FhQH+j3VqJawlNyu0nrzNWAoSqNRGhdHeita2pXwQpglvxVCIMLAyuYXlB+r6Wy0M507SdOIxsLce6ytNTtIwoSau8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hzW/1zTy; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732536166;
	bh=gxiRcxKvp8H8c5I9uyu/kGel1w+XZC9NNckUo3rp8Yk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hzW/1zTyPhc5CY+K1YFF0vVdJ48e7GtTa97Ty0SbZXrBLuOcS7S4PthIq1BF5UANT
	 2y0RPkUsLsvoQiuBgNO6Smzp4hQ/PhA9ctV7wgeJs6JZgtTJZ7CG0461NCXwa7DYmH
	 jgOuuhS3XcLkpztbDSucQeCntedd1DujZ1vjq7zIJSGXUD/YleahzRhUiXmY7MurxZ
	 iiD/jxVYjBC9HwR8qDcVAbo61fP+phLLa5wt4xJhzennSqlNaVpquaDMTprF2bb9jv
	 yy+cRd96DKKwdHTydmT+dfvtTZueHLhyIZCf9MKOnO9JLHCYqYS4l+XenGWfIlGhpK
	 UEF+lvR3ba/yQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 346EB17E3620;
	Mon, 25 Nov 2024 13:02:46 +0100 (CET)
Message-ID: <cf8f6348-0073-4fde-95a3-63d9a9bd61c8@collabora.com>
Date: Mon, 25 Nov 2024 13:02:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] of: Add Google Juniper to excluded default cells list
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>,
 Conor Dooley <conor@kernel.org>
References: <20241125113151.107812-1-krzysztof.kozlowski@linaro.org>
 <c97c05cf-9cf2-40e7-8f50-2f438721c394@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <c97c05cf-9cf2-40e7-8f50-2f438721c394@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/11/24 12:38, Krzysztof Kozlowski ha scritto:
> On 25/11/2024 12:31, Krzysztof Kozlowski wrote:
>> Google Juniper platforms have a very old bootloader which populates
>> /firmware node without proper address/size-cells leading to warnings:
>>
>>    Missing '#address-cells' in /firmware
>>    WARNING: CPU: 0 PID: 1 at drivers/of/base.c:106 of_bus_n_addr_cells+0x90/0xf0
>>    Modules linked in:
>>    CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0 #1 933ab9971ff4d5dc58cb378a96f64c7f72e3454d
>>    Hardware name: Google juniper sku16 board (DT)
>>    ...
>>    Missing '#size-cells' in /firmware
>>    WARNING: CPU: 0 PID: 1 at drivers/of/base.c:133 of_bus_n_size_cells+0x90/0xf0
>>    Modules linked in:
>>    CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.12.0 #1 933ab9971ff4d5dc58cb378a96f64c7f72e3454d
>>    Tainted: [W]=WARN
>>    Hardware name: Google juniper sku16 board (DT)
>>
>> The platform won't receive updated bootloader/firmware so add it to
>> excluded platform list to silence the warning.
>>
>> Reported-by: Sasha Levin <sashal@kernel.org>
>> Closes: https://lore.kernel.org/all/Z0NUdoG17EwuCigT@sashalap/
>> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Cc: Matthias Brugger <matthias.bgg@gmail.com>
>> Cc: Chen-Yu Tsai <wenst@chromium.org>
>> Cc: Conor Dooley <conor@kernel.org>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   drivers/of/base.c | 26 ++++++++++++++++++++++++--
>>   1 file changed, 24 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index a8b0c42bdc8e..13f0b2877ee0 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -56,6 +56,16 @@ DEFINE_MUTEX(of_mutex);
>>    */
>>   DEFINE_RAW_SPINLOCK(devtree_lock);
>>   
>> +/*
>> + * List of machines running old firmware without explicit #address-cells and
>> + * #size-cells values for parent nodes, which are most likely not going get any
>> + * update.
>> + */
>> +static const char * const excluded_default_cells_compats[] = {
>> +	"google,juniper",
>> +	NULL
>> +};
>> +
>>   bool of_node_name_eq(const struct device_node *np, const char *name)
>>   {
>>   	const char *node_name;
>> @@ -91,6 +101,17 @@ static bool __of_node_is_type(const struct device_node *np, const char *type)
>>   	IS_ENABLED(CONFIG_SPARC) \
>>   )
>>   
>> +static bool excluded_default_cells_machines(void)
>> +{
>> +	/* Do not repeat the machine checks for every bus */
>> +	static int excluded_machine = -1;
>> +
>> +	if (excluded_machine < 0)
>> +		excluded_machine = of_machine_compatible_match(excluded_default_cells_compats);
>> +
>> +	return !!excluded_machine;
>> +}
>> +
>>   int of_bus_n_addr_cells(struct device_node *np)
>>   {
>>   	u32 cells;
>> @@ -103,7 +124,7 @@ int of_bus_n_addr_cells(struct device_node *np)
>>   		 * is deprecated. Any platforms which hit this warning should
>>   		 * be added to the excluded list.
>>   		 */
>> -		WARN_ONCE(!EXCLUDED_DEFAULT_CELLS_PLATFORMS,
>> +		WARN_ONCE(!EXCLUDED_DEFAULT_CELLS_PLATFORMS && !excluded_default_cells_machines(),
>>   			  "Missing '#address-cells' in %pOF\n", np);
>>   	}
>>   	return OF_ROOT_NODE_ADDR_CELLS_DEFAULT;
>> @@ -125,12 +146,13 @@ int of_bus_n_size_cells(struct device_node *np)
>>   	for (; np; np = np->parent) {
>>   		if (!of_property_read_u32(np, "#size-cells", &cells))
>>   			return cells;
>> +
> 
> 
> This was not intentional, I'll fix it in v2.
> 
> Obviously this code is not really SMP aware, but even with store tearing
> I don't think it will be issue. Worst case the
> of_machine_compatible_match() will be called more than one, which is not
> fatal and might not justify atomics or locks.
> 
> Best regards,
> Krzysztof


For v2, feel free to add my

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

