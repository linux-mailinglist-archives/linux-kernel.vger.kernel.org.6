Return-Path: <linux-kernel+bounces-260130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AF893A383
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 161B4B2233D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC8E157470;
	Tue, 23 Jul 2024 15:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MNVOINAr"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC59156F23;
	Tue, 23 Jul 2024 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721747385; cv=none; b=ucYeCC0FO9A8MtI9SEiDAaXWCj9LTp/3RLbIWM8rDAi7gOT4u/Exoa/b8rWJ34ivOvojLKQ/nuHrNEtFg/XHGB+zQH/BB01tVMEl0hyLppbk1qfun3eRUgfseTsR9D7Ug3dxReMYrxOdjoxGIyYU3/PenE1dW8zI757AzLk1+Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721747385; c=relaxed/simple;
	bh=IFA0f0H2+BKUdtT7ASlZ9IlkMsU/NNr/hRsLL9ngWBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=szxXGqOy3//3iKm8/o+aVVZWUxMLTTZ/Ssi5ag9PCscOBnXE4v7jBLF+qPki9OEm24/a3lgN0i4iJ+E+SmYtu/nDOa7k6FiStj5t+Izh+De+XX38t+rm29aW628mQtN8TklqsL0AZTNmwL1nc14VnxeL3pKH2Or19ebWy3uDcKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MNVOINAr; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721747381;
	bh=IFA0f0H2+BKUdtT7ASlZ9IlkMsU/NNr/hRsLL9ngWBo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MNVOINArCTbTOujGas+WJjwodQFIc0zvFc7Xy9rkyRHfS/9IIdjtqmjybqodXl00x
	 Ltx/jB5BV16CLDad5v65fBk5etR9p6Vd5crB1mE0JLLPww6itC/j+tR9gPNC+swjfj
	 mDG1VdZPTHxWWO0pA963vZKiujzOPpfDogzGJUqZUlSn1F5ugkIqm98J5i+jYUKKTl
	 CEfp2di0KcDEXGXcDvnnTQ3yJnHrht0JEg3LK1L5AvLXvBwL140CUT4Kb0/mjgSW/G
	 vd2fuMg/lzLE1x9UWulYLDW4imSkDITqR8nNnsDJY9UbePOpzGKShjj2QKGe/pWqA4
	 fwAHLs51ueOKw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 22C4137804D4;
	Tue, 23 Jul 2024 15:09:41 +0000 (UTC)
Message-ID: <0e278e57-139b-4074-ab3a-d35cef79e7f8@collabora.com>
Date: Tue, 23 Jul 2024 17:09:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: mediatek: reset: Remove unused
 mtk_register_reset_controller()
To: Fei Shao <fshao@chromium.org>
Cc: sboyd@kernel.org, matthias.bgg@gmail.com, mturquette@baylibre.com,
 p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-clk@vger.kernel.org, kernel@collabora.com
References: <20240718082528.220750-1-angelogioacchino.delregno@collabora.com>
 <CAC=S1nhmuGfaQrK-3TZzY3-c1_cDbB5g_Zp2nXOzg6zQZ-j4Lw@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAC=S1nhmuGfaQrK-3TZzY3-c1_cDbB5g_Zp2nXOzg6zQZ-j4Lw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 18/07/24 11:41, Fei Shao ha scritto:
> On Thu, Jul 18, 2024 at 4:26 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Now that all clock controllers have been migrated to the new
>> mtk_register_reset_controller_with_dev() function, the one taking
>> struct device node is now unused: remove it.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/clk/mediatek/reset.c | 59 ------------------------------------
>>   drivers/clk/mediatek/reset.h | 10 ------
>>   2 files changed, 69 deletions(-)
>>
>> diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
>> index 290ceda84ce4..069f9e909cb0 100644
>> --- a/drivers/clk/mediatek/reset.c
>> +++ b/drivers/clk/mediatek/reset.c
>> @@ -110,65 +110,6 @@ static int reset_xlate(struct reset_controller_dev *rcdev,
>>          return data->desc->rst_idx_map[reset_spec->args[0]];
>>   }
>>
>> -int mtk_register_reset_controller(struct device_node *np,
>> -                                 const struct mtk_clk_rst_desc *desc)
>> -{
>> -       struct regmap *regmap;
>> -       const struct reset_control_ops *rcops = NULL;
>> -       struct mtk_clk_rst_data *data;
>> -       int ret;
>> -
>> -       if (!desc) {
>> -               pr_err("mtk clock reset desc is NULL\n");
>> -               return -EINVAL;
>> -       }
>> -
>> -       switch (desc->version) {
>> -       case MTK_RST_SIMPLE:
>> -               rcops = &mtk_reset_ops;
>> -               break;
>> -       case MTK_RST_SET_CLR:
>> -               rcops = &mtk_reset_ops_set_clr;
>> -               break;
>> -       default:
>> -               pr_err("Unknown reset version %d\n", desc->version);
>> -               return -EINVAL;
>> -       }
>> -
>> -       regmap = device_node_to_regmap(np);
>> -       if (IS_ERR(regmap)) {
>> -               pr_err("Cannot find regmap for %pOF: %pe\n", np, regmap);
>> -               return -EINVAL;
>> -       }
>> -
>> -       data = kzalloc(sizeof(*data), GFP_KERNEL);
>> -       if (!data)
>> -               return -ENOMEM;
>> -
>> -       data->desc = desc;
>> -       data->regmap = regmap;
>> -       data->rcdev.owner = THIS_MODULE;
>> -       data->rcdev.ops = rcops;
>> -       data->rcdev.of_node = np;
>> -
>> -       if (data->desc->rst_idx_map_nr > 0) {
>> -               data->rcdev.of_reset_n_cells = 1;
>> -               data->rcdev.nr_resets = desc->rst_idx_map_nr;
>> -               data->rcdev.of_xlate = reset_xlate;
>> -       } else {
>> -               data->rcdev.nr_resets = desc->rst_bank_nr * RST_NR_PER_BANK;
>> -       }
>> -
>> -       ret = reset_controller_register(&data->rcdev);
>> -       if (ret) {
>> -               pr_err("could not register reset controller: %d\n", ret);
>> -               kfree(data);
>> -               return ret;
>> -       }
>> -
>> -       return 0;
>> -}
>> -
>>   int mtk_register_reset_controller_with_dev(struct device *dev,
>>                                             const struct mtk_clk_rst_desc *desc)
> 
> I guess that means the "_with_dev" suffix here becomes redundant and
> therefore can be removed.
> Do you want to update it all together?
> 

Makes sense to add another commit that performs the rename... yeah.

Cheers,
Angelo

> Regards,
> Fei
> 
> 
>>   {
>> diff --git a/drivers/clk/mediatek/reset.h b/drivers/clk/mediatek/reset.h
>> index 6a58a3d59165..562ffd290a22 100644
>> --- a/drivers/clk/mediatek/reset.h
>> +++ b/drivers/clk/mediatek/reset.h
>> @@ -59,16 +59,6 @@ struct mtk_clk_rst_data {
>>          const struct mtk_clk_rst_desc *desc;
>>   };
>>
>> -/**
>> - * mtk_register_reset_controller - Register MediaTek clock reset controller
>> - * @np: Pointer to device node.
>> - * @desc: Constant pointer to description of clock reset.
>> - *
>> - * Return: 0 on success and errorno otherwise.
>> - */
>> -int mtk_register_reset_controller(struct device_node *np,
>> -                                 const struct mtk_clk_rst_desc *desc);
>> -
>>   /**
>>    * mtk_register_reset_controller - Register mediatek clock reset controller with device
>>    * @np: Pointer to device.
>> --
>> 2.45.2
>>
>>



