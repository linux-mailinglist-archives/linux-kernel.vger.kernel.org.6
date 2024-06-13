Return-Path: <linux-kernel+bounces-213485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6C09075E9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66411F23568
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B881494A0;
	Thu, 13 Jun 2024 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dnRQCXmW"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC781494A5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290947; cv=none; b=uFzXoP25BZrAAe94qH6MZRreJYn1dBjg6KANRV/0LtpHazFfsyO1GTjlfXHxmdqtn5VuTY6reRBqPsuAiTg4f9jT5byp7Z+gveFb7OceBupGOe8c8GrU6q8jRSNhDAiveE0ofSdjtB/CxJsmQUzjM6U1tEeVYusDbRVpbq5Yc+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290947; c=relaxed/simple;
	bh=V5AteabZhVyZ3nyzkEAKPmkKwl9XMFh6GfZxRBuBQ9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KMkAt0nn1g4DfNz/2qR8z5PCYrcd7cTPvckkk8zWdmQGNXft3enuMK1gmw58r1qOx1gaEg9hxuCyFriWlG97C3FuXxeGKKMl0tpldzwt7dJjkxCt83AWj39XREPFQDs8gqdw/CR8Arr46NnalYkAYzxOpEgi9hsCyhZFn1uiDvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dnRQCXmW; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: radhey.shyam.pandey@amd.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718290942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JEBRwGHuYYeaiNTmDNEUKdsVRARs0SvHUnnIMjbyCE4=;
	b=dnRQCXmWGraLUliXWOcCW9NwR9J69w4NkRGqqRYDwsNfThTkQMQDJuIO/PWh2XM9B0pMZ5
	i0Tdf37wyFJYrle1RU5KtND6cmEm506iyx8qtvQsKI8PVU3I9gwBEp9awJx55G6JGaLJKC
	qm5hTtyZMNMp2XCXIy23MzRJZpsSp3A=
X-Envelope-To: laurent.pinchart@ideasonboard.com
X-Envelope-To: linux-phy@lists.infradead.org
X-Envelope-To: vkoul@kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: kishon@kernel.org
Message-ID: <8349516a-84bc-45bf-a84c-ff05d8f50bf7@linux.dev>
Date: Thu, 13 Jun 2024 11:02:15 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/4] phy: zynqmp: Add debugfs support
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
Cc: Vinod Koul <vkoul@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Simek, Michal" <michal.simek@amd.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>
References: <20240506170110.2874724-1-sean.anderson@linux.dev>
 <20240506170110.2874724-5-sean.anderson@linux.dev>
 <MN0PR12MB5953519A685A222CC603A2FEB7C12@MN0PR12MB5953.namprd12.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <MN0PR12MB5953519A685A222CC603A2FEB7C12@MN0PR12MB5953.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/13/24 05:20, Pandey, Radhey Shyam wrote:
>> -----Original Message-----
>> From: Sean Anderson <sean.anderson@linux.dev>
>> Sent: Monday, May 6, 2024 10:31 PM
>> To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>; linux-
>> phy@lists.infradead.org
>> Cc: Vinod Koul <vkoul@kernel.org>; linux-arm-kernel@lists.infradead.org;
>> linux-kernel@vger.kernel.org; Michal Simek <michal.simek@amd.com>;
>> Kishon Vijay Abraham I <kishon@kernel.org>; Sean Anderson
>> <sean.anderson@linux.dev>
>> Subject: [PATCH v2 4/4] phy: zynqmp: Add debugfs support
>> 
>> Add support for printing some basic status information to debugfs. This
>> is helpful when debugging phy consumers to make sure they are configuring
>> the phy appropriately.
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>> 
>> Changes in v2:
>> - Use debugfs_create_devm_seqfile
>> 
>>  drivers/phy/xilinx/phy-zynqmp.c | 40
>> +++++++++++++++++++++++++++++++++
>>  1 file changed, 40 insertions(+)
>> 
>> diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-
>> zynqmp.c
>> index b86fe2a249a8..2520c75a4a77 100644
>> --- a/drivers/phy/xilinx/phy-zynqmp.c
>> +++ b/drivers/phy/xilinx/phy-zynqmp.c
>> @@ -13,6 +13,7 @@
>>   */
>> 
>>  #include <linux/clk.h>
>> +#include <linux/debugfs.h>
>>  #include <linux/delay.h>
>>  #include <linux/io.h>
>>  #include <linux/kernel.h>
>> @@ -123,6 +124,15 @@
>>  #define ICM_PROTOCOL_DP			0x4
>>  #define ICM_PROTOCOL_SGMII		0x5
>> 
>> +static const char *const xpsgtr_icm_str[] = {
>> +	[ICM_PROTOCOL_PD] = "powered down",
> 
> Protocol saying powered down seems confusing.
> Should we say None or None(power down)?

Either works I guess. I'm just matching the define.

>> +	[ICM_PROTOCOL_PCIE] = "PCIe",
>> +	[ICM_PROTOCOL_SATA] = "SATA",
>> +	[ICM_PROTOCOL_USB] = "USB",
>> +	[ICM_PROTOCOL_DP] = "DisplayPort",
>> +	[ICM_PROTOCOL_SGMII] = "SGMII",
>> +};
>> +
>>  /* Test Mode common reset control  parameters */
>>  #define TM_CMN_RST			0x10018
>>  #define TM_CMN_RST_EN			0x1
>> @@ -788,6 +798,34 @@ static struct phy *xpsgtr_xlate(struct device *dev,
>>  	return ERR_PTR(-EINVAL);
>>  }
>> 
>> +/*
>> + * DebugFS
>> + */
>> +
>> +static int xpsgtr_status_read(struct seq_file *seq, void *data)
>> +{
>> +	struct device *dev = seq->private;
>> +	struct xpsgtr_phy *gtr_phy = dev_get_drvdata(dev);
>> +	struct clk *clk;
>> +	u32 pll_status;
>> +
>> +	mutex_lock(&gtr_phy->phy->mutex);
> 
> Do we see any need for this lock? This function simply read hw register 
> /phy members and decodes it.

It's to protect against modifications to gtr_phy->refclk and ->instance.

These are accessed under lock elsewhere; this is not a fast path and I don't
want to have to reason about the semantics when using a mutex is definitely
correct.

--Sean

>> +	pll_status = xpsgtr_read_phy(gtr_phy, L0_PLL_STATUS_READ_1);
>> +	clk = gtr_phy->dev->clk[gtr_phy->refclk];
>> +
>> +	seq_printf(seq, "Lane:            %u\n", gtr_phy->lane);
>> +	seq_printf(seq, "Protocol:        %s\n",
>> +		   xpsgtr_icm_str[gtr_phy->protocol]);
>> +	seq_printf(seq, "Instance:        %u\n", gtr_phy->instance);
>> +	seq_printf(seq, "Reference clock: %u (%pC)\n", gtr_phy->refclk, clk);
>> +	seq_printf(seq, "Reference rate:  %lu\n", clk_get_rate(clk));
>> +	seq_printf(seq, "PLL locked:      %s\n",
>> +		   pll_status & PLL_STATUS_LOCKED ? "yes" : "no");
>> +
>> +	mutex_unlock(&gtr_phy->phy->mutex);
>> +	return 0;
>> +}
>> +
>>  /*
>>   * Power Management
>>   */
>> @@ -937,6 +975,8 @@ static int xpsgtr_probe(struct platform_device *pdev)
>> 
>>  		gtr_phy->phy = phy;
>>  		phy_set_drvdata(phy, gtr_phy);
>> +		debugfs_create_devm_seqfile(&phy->dev, "status", phy-
>> >debugfs,
>> +					    xpsgtr_status_read);
>>  	}
>> 
>>  	/* Register the PHY provider. */
>> --
>> 2.35.1.1320.gc452695387.dirty
> 


