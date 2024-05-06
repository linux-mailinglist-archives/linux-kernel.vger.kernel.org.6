Return-Path: <linux-kernel+bounces-170026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5538BD0C4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331361F22A67
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C87A153812;
	Mon,  6 May 2024 14:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iA/8VuBf"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE7A13BAC7
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715007105; cv=none; b=PNpcrWc2wG6NayJIXiJY2IfWPXEjpFxEY12wJjM7NPGLZAJwPsok+AmO3ZXeXF8kINvioaOlTgbYUhYCcu5H68FjcRC4u0tF7cVlGpobgfEZ+duUMr9ERY3E9tFdxwAvprmw5fyRSuUdcTQus8gCd6S1q0iM9xdaoZvZRi9BOCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715007105; c=relaxed/simple;
	bh=zNRbPoGDo3HrrdK55EDrje2YLapHPeVNDdjBeQjXIl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+3wgMPVhWRVHOLunBm67o2oym28cFdUzgBBGrhzDMUZoNLUkyLoxataN/10LZFiUR5IYhlNOTIqkzaZqoR3uuo3Ba6oJIx4nIRdNFKy+IcP3GG8hQkmrJ+jM3OP6fc4D5OijTfddtHPQZLJBeQfVqj+Rr3O1/LqMbeWLezq7Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iA/8VuBf; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c5b749c4-5277-46f9-8218-a56e63dc9028@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715007101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U8GrcUQlowClA2iRoj1euDYQxhz+hiklndiBkUyOg9A=;
	b=iA/8VuBfhygfV8H8eY9CJJjdeBDene9JYvUSfuRX7OJInUCUrR7JH14EgIlJrnWvraa54T
	LsEqO6jhYWi06ZEidIiKOS8RrrlhWhYDXWgjp216mHK7zDvJWs0XlZJC/2t6CzKTNQ5fjP
	c33ldu3yKYw7Nh7C8WIJ6hMMAbU1jtU=
Date: Mon, 6 May 2024 10:51:38 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] phy: zynqmp: Add debugfs support
To: Vinod Koul <vkoul@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 Michal Simek <michal.simek@amd.com>, linux-arm-kernel@lists.infradead.org,
 Kishon Vijay Abraham I <kishon@kernel.org>
References: <20240422185803.3575319-1-sean.anderson@linux.dev>
 <20240422185803.3575319-4-sean.anderson@linux.dev> <ZjYjAjPlM5ClOGa4@matsya>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <ZjYjAjPlM5ClOGa4@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/4/24 07:58, Vinod Koul wrote:
> On 22-04-24, 14:58, Sean Anderson wrote:
>> Add support for printing some basic status information to debugfs. This
>> is helpful when debugging phy consumers to make sure they are configuring
>> the phy appropriately.
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>> 
>>  drivers/phy/xilinx/phy-zynqmp.c | 54 +++++++++++++++++++++++++++++++++
>>  1 file changed, 54 insertions(+)
>> 
>> diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
>> index 08c88dcd7799..e2e86943e9f3 100644
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
>> @@ -122,6 +123,15 @@
>>  #define ICM_PROTOCOL_DP			0x4
>>  #define ICM_PROTOCOL_SGMII		0x5
>>  
>> +static const char *const xpsgtr_icm_str[] = {
>> +	[ICM_PROTOCOL_PD] = "powered down",
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
>> @@ -768,6 +778,48 @@ static struct phy *xpsgtr_xlate(struct device *dev,
>>  	return ERR_PTR(-EINVAL);
>>  }
>>  
>> +/*
>> + * DebugFS
>> + */
>> +
>> +static int xpsgtr_status_read(struct seq_file *seq, void *data)
>> +{
>> +	struct xpsgtr_phy *gtr_phy = seq->private;
>> +	struct clk *clk;
>> +	u32 pll_status;
>> +
>> +	mutex_lock(&gtr_phy->phy->mutex);
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
>> +static int xpsgtr_status_open(struct inode *inode, struct file *f)
>> +{
>> +	struct xpsgtr_phy *gtr_phy = inode->i_private;
>> +
>> +	return single_open(f, xpsgtr_status_read, gtr_phy);
>> +}
>> +
>> +static const struct file_operations xpsgtr_status_ops = {
>> +	.owner = THIS_MODULE,
>> +	.open = xpsgtr_status_open,
>> +	.release = single_release,
>> +	.read = seq_read,
>> +	.llseek = seq_lseek
>> +};
> 
> There are debugfs simple helpers which should help you avoid all this
> open coding and just have the read call

I assume you mean debugfs_create_devm_seqfile.

>> +
>>  /*
>>   * Power Management
>>   */
>> @@ -917,6 +969,8 @@ static int xpsgtr_probe(struct platform_device *pdev)
>>  
>>  		gtr_phy->phy = phy;
>>  		phy_set_drvdata(phy, gtr_phy);
>> +		debugfs_create_file("status", 0444, phy->debugfs, gtr_phy,
>> +				    &xpsgtr_status_ops);
> 
> generic status does not make sense, how about device-name-status

This file lives in the phy's debugfs directory already. The full path is

/sys/kernel/debug/phy/phy-fd400000.phy.0/status

so there is no need to add the phy name yet again.

--Sean

