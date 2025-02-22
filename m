Return-Path: <linux-kernel+bounces-527113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE121A40776
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 11:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D87D5423C1B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 10:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102B9207E1B;
	Sat, 22 Feb 2025 10:36:01 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA670206F01
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 10:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740220560; cv=none; b=aujDtTorOAGAqWRDF5wEhCCTZEq5soS9AaBKOp/4niwmiHuNZljy4lCDC4EOrH812NxizkrUYkiLqG6+Qd4gPOmLegPev5QsBjrqrdzdnOti3drOjG6XEBqjZkJILlfITZ+afmn1oS1XI24nbcF7hMslKktCPvWF6NLx6Vw0f0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740220560; c=relaxed/simple;
	bh=85+UA0bT74W/vqWSOeQ6T2bkue/x+GAOHvg/xJNMR94=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dGqAKWU69bOXfMB+VLj+eOHM+IjNt3c7gvBHsBx3Ci0OrQtr7cy4b3Xi/ktuLVd/UBQcQoggQg/KfqVfeau1RCvx3dNQori5WlbK3YonHh35fxGuhb15LqfTSOPb5VXcUnSImzoMYZlPYujMfJHTSnJG/jS0Vn8Fv7/Kmu6PNzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Z0NbD4fspz1ltY8;
	Sat, 22 Feb 2025 18:31:52 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 132A6140155;
	Sat, 22 Feb 2025 18:35:51 +0800 (CST)
Received: from [10.159.166.136] (10.159.166.136) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sat, 22 Feb 2025 18:35:49 +0800
Message-ID: <eef68fc7-30f4-4246-a82e-4f90cd6a665d@huawei.com>
Date: Sat, 22 Feb 2025 18:35:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 drm-dp 7/8] drm/hisilicon/hibmc: Enable this hot plug
 detect of irq feature
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <liangjian010@huawei.com>,
	<chenjianmin@huawei.com>, <lidongming5@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<shiyongbang@huawei.com>
References: <20250222025102.1519798-1-shiyongbang@huawei.com>
 <20250222025102.1519798-8-shiyongbang@huawei.com>
 <reqpxlbvlz5qssgy6gbjuou33h4zevo4xeztqbsr4keehplyhx@utv22a5ihohx>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <reqpxlbvlz5qssgy6gbjuou33h4zevo4xeztqbsr4keehplyhx@utv22a5ihohx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd500013.china.huawei.com (7.221.188.12)

>> +static int hibmc_dp_hpd_event(struct drm_client_dev *client)
>> +{
>> +	struct hibmc_dp *dp = container_of(client, struct hibmc_dp, client);
>> +	struct hibmc_drm_private *priv = to_hibmc_drm_private(dp->drm_dev);
>> +	struct drm_display_mode *mode = &priv->crtc.state->adjusted_mode;
>> +	int ret;
>> +
>> +	if (dp->hpd_status) {
>> +		hibmc_dp_hpd_cfg(&priv->dp);
>> +		ret = hibmc_dp_prepare(dp, mode);
>> +		if (ret)
>> +			return ret;
>> +
>> +		hibmc_dp_display_en(dp, true);
>> +	} else {
>> +		hibmc_dp_display_en(dp, false);
>> +		hibmc_dp_reset_link(&priv->dp);
>> +	}
> If I understand this correctly, you are using a separate drm_client to
> enable and disable the link & display. Why is it necessary? Existing
> drm_clients and userspace compositors use drm framework, they should be
> able to turn the display on and off as required.
>
Thanks for your asking, there are cfg/reset process when the connector 's pluging in/out.
We want to cfg DP registers again when the connector changes. Not only dp link training, but also cfg
the different video modes into DP registers.


>> +
>> +	return 0;
>> +}
>> +
>> +static const struct drm_client_funcs hibmc_dp_client_funcs = {
>> +	.hotplug = hibmc_dp_hpd_event,
>> +	.unregister = drm_client_release,
>> +};
>> +
>>   int hibmc_dp_init(struct hibmc_drm_private *priv)
>>   {
>>   	struct drm_device *dev = &priv->dev;
>> @@ -138,5 +193,11 @@ int hibmc_dp_init(struct hibmc_drm_private *priv)
>>   
>>   	drm_connector_attach_encoder(connector, encoder);
>>   
>> +	ret = drm_client_init(dev, &dp->client, "hibmc-DP-HPD", &hibmc_dp_client_funcs);
>> +	if (ret)
>> +		return ret;
>> +
>> +	drm_client_register(&dp->client);
>> +
>>   	return 0;
>>   }
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> index bc89e4b9f4e3..daed1330b961 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> @@ -71,4 +71,6 @@ int hibmc_dp_init(struct hibmc_drm_private *priv);
>>   
>>   void hibmc_debugfs_init(struct drm_connector *connector, struct dentry *root);
>>   
>> +irqreturn_t hibmc_dp_hpd_isr(int irq, void *arg);
>> +
>>   #endif
>> -- 
>> 2.33.0
>>

