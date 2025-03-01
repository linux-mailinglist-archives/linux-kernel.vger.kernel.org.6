Return-Path: <linux-kernel+bounces-539847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D7AA4A9D3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 09:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F8C3B8E22
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 08:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AAD1C6F70;
	Sat,  1 Mar 2025 08:45:49 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B8D1B2194
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 08:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740818748; cv=none; b=nG2+pMf92DWOoWosoUDpRYPAxTbw/LFKUdTezkyQThn28a4UjjhqLTdxGomYkNSk1FOxrZtr8+lKZU6QIXr19goTFz0aPzvJwQcOfjyA5LP9frzbOFBZgxn9Le2FOGMG2uBiO5OBMBEJYZKqS9jgdtXfF2TjQ4NmUqnsUR+qXcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740818748; c=relaxed/simple;
	bh=nLxEc6zu28Bu+eBW/a0EfLQhAwkIHSjeW9RQLQdjpl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ofRBiy1jX9cPFaP+xdjAACF6YEZ7+styisjsocUnW2Y916umwLvKY/cvDx+KiSBvqVyfjAAkO/V6Xp4Qqt0akVyRRmsspk3jJk9LGRZJO3eX22ymsGPl64YWqyq3CNpzRD9HgUyfZ4Pltt8VC2ZM8QYZLOLLyYj8VrbVkEhIWiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Z4dqV6B47zCs6g;
	Sat,  1 Mar 2025 16:42:14 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id C029C140203;
	Sat,  1 Mar 2025 16:45:42 +0800 (CST)
Received: from [10.159.166.136] (10.159.166.136) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sat, 1 Mar 2025 16:45:41 +0800
Message-ID: <6506e448-3851-436f-9354-42f9ef844d27@huawei.com>
Date: Sat, 1 Mar 2025 16:45:40 +0800
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
 <eef68fc7-30f4-4246-a82e-4f90cd6a665d@huawei.com>
 <6jx5ldpidy2ycrqognfiv5ttqr5ia4dtbryta3kc2mkndrvvgo@qzuakucz765k>
 <6634386b-afc1-4e31-a2f4-9c1afed2d1d8@huawei.com>
 <CAA8EJpqHmhUxLE57XNeh-nVtSP7WvtBE=FiFWk9kqM_P+AC=0A@mail.gmail.com>
 <5af62fa9-e71b-412f-8640-502f03fcaa52@huawei.com>
 <vrsy4hao4qu3hlcbmjyfyibeearhhjgtik3e6o3v2eyzkatdve@kdb7cyvl45tu>
 <ade54ddd-79ea-4335-9058-c17e4525e83f@huawei.com>
 <4hicem4rbz5l7wnzaaz3krrl3euh2dmvlah2rb7errrdq5fann@44dvdxirkuzh>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <4hicem4rbz5l7wnzaaz3krrl3euh2dmvlah2rb7errrdq5fann@44dvdxirkuzh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd500013.china.huawei.com (7.221.188.12)


> On Thu, Feb 27, 2025 at 09:46:10PM +0800, Yongbang Shi wrote:
>>> On Tue, Feb 25, 2025 at 09:57:17PM +0800, Yongbang Shi wrote:
>>>>> On Mon, 24 Feb 2025 at 16:03, Yongbang Shi <shiyongbang@huawei.com> wrote:
>>>>>>> On Sat, Feb 22, 2025 at 06:35:48PM +0800, Yongbang Shi wrote:
>>>>>>>>>> +static int hibmc_dp_hpd_event(struct drm_client_dev *client)
>>>>>>>>>> +{
>>>>>>>>>> +  struct hibmc_dp *dp = container_of(client, struct hibmc_dp, client);
>>>>>>>>>> +  struct hibmc_drm_private *priv = to_hibmc_drm_private(dp->drm_dev);
>>>>>>>>>> +  struct drm_display_mode *mode = &priv->crtc.state->adjusted_mode;
>>>>>>>>>> +  int ret;
>>>>>>>>>> +
>>>>>>>>>> +  if (dp->hpd_status) {
>>>>>>>>>> +          hibmc_dp_hpd_cfg(&priv->dp);
>>>>>>>>>> +          ret = hibmc_dp_prepare(dp, mode);
>>>>>>>>>> +          if (ret)
>>>>>>>>>> +                  return ret;
>>>>>>>>>> +
>>>>>>>>>> +          hibmc_dp_display_en(dp, true);
>>>>>>>>>> +  } else {
>>>>>>>>>> +          hibmc_dp_display_en(dp, false);
>>>>>>>>>> +          hibmc_dp_reset_link(&priv->dp);
>>>>>>>>>> +  }
>>>>>>>>> If I understand this correctly, you are using a separate drm_client to
>>>>>>>>> enable and disable the link & display. Why is it necessary? Existing
>>>>>>>>> drm_clients and userspace compositors use drm framework, they should be
>>>>>>>>> able to turn the display on and off as required.
>>>>>>>>>
>>>>>>>> Thanks for your asking, there are cfg/reset process when the connector 's pluging in/out.
>>>>>>>> We want to cfg DP registers again when the connector changes. Not only dp link training, but also cfg
>>>>>>>> the different video modes into DP registers.
>>>>>>> Why? The link training and mode programming should happen during
>>>>>>> pre_enable / enable stage (legacy or atomic).
>>>>>> Hi Dmitry,
>>>>>>
>>>>>> Right, that's what I'm curious about. It won't call encoder enble/disable functions when I triggered HPD.
>>>>>> And I'm sure the drm_connector_helper_hpd_irq_event() is called. So I add a drm_client for it.I
>>>>> It should be userspace, who triggers the enable/disable (or it should
>>>>> be the in-kernel fbdev / fbcon, which interface through the generic
>>>>> drm_fbdev client).
>>>> Right, I knew it. When I insmode my driver firstly (or restart display service), it will call disable, modeset and enable,
>>>> by user, but it won't call when HPD triggered .
>>> - Is HPD even properly delivered to userspace? What kind of compsitor
>>>     are you using? Is .detect working properly and reporting a correct
>>>     plug-in state?
>> Thanks for your answering. I'm not very good understanding about userspace in framework. In my opinion, when I call
>> this drm_connector_helper_hpd_irq_event(), the HPD will deliver to userspace.
>> I use Xorg, and the display service is GDM.
>> The .detect is called and the getting modes info is correct.
>> I find that it would only trigger(disable, modeset and enable), when I changed resolutions, restart display service and insmod driver.
> You can go to the display settings in GDM. It would be interesting to
> observe if it notes the second monitor or not. Last, but not least, you
> can use a simple tool like 'xrandr' under your XOrg session to set the
> display resolution.

Thank you for your advice!
Right, there are DP and VGA two monitors. I tried to totally remove the vga connector in driver, the problem is gone.
So do I need to clear the vga connector, if dp is plugged in?
And also, I used xrandr to set modes after 'startx'. Changing resolutions works,
but there are errs when set some low resolutions.



