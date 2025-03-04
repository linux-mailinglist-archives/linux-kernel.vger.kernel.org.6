Return-Path: <linux-kernel+bounces-543107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25595A4D197
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 03:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F6B3AB839
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311FD17C7CA;
	Tue,  4 Mar 2025 02:23:23 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547A13C6BA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 02:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741055002; cv=none; b=BjBoZ2rmZqcvXSKo6OM5VAmroPTxn1+i756AtWT6YokTTCM5i+URjTrnKl3AqpGBIrfKtptc0ieBW3nfIXhzbPCPOFsI6VgAACnErWJyGNZwGSB4WsZPlukt+CFIpG/I8pPHeKIs9v84qMFGfU4nHKxsbg1nA1yiBPAu84cBop4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741055002; c=relaxed/simple;
	bh=lTLe8as+VCR92Mx4madXaiO+ags5AfU9/UlYBjKlYgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=og4Af3Zaat+FiNflgGkBxEnMqTcFhfqUP0A7HqOMv6dfTrrNgwci6Sl51c/b2ZoCHOpf8Ba2W9/RSYQEeLi6pHX1jPlTbrYx7rQkfr3M97pnscVucUCVQUCVJeu5zZk8F/OZokcG+Qzm2rAIEfgZZe8iVq1gaZOZr5EZ0UyMv94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Z6KF549xCzpbWH;
	Tue,  4 Mar 2025 10:21:45 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 779DF18009E;
	Tue,  4 Mar 2025 10:23:16 +0800 (CST)
Received: from [10.159.166.136] (10.159.166.136) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 4 Mar 2025 10:23:14 +0800
Message-ID: <fce2e5e8-ba38-474d-891c-f8ab0de8d07e@huawei.com>
Date: Tue, 4 Mar 2025 10:23:14 +0800
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
References: <CAA8EJpqHmhUxLE57XNeh-nVtSP7WvtBE=FiFWk9kqM_P+AC=0A@mail.gmail.com>
 <5af62fa9-e71b-412f-8640-502f03fcaa52@huawei.com>
 <vrsy4hao4qu3hlcbmjyfyibeearhhjgtik3e6o3v2eyzkatdve@kdb7cyvl45tu>
 <ade54ddd-79ea-4335-9058-c17e4525e83f@huawei.com>
 <4hicem4rbz5l7wnzaaz3krrl3euh2dmvlah2rb7errrdq5fann@44dvdxirkuzh>
 <6506e448-3851-436f-9354-42f9ef844d27@huawei.com>
 <njnz5hxumrvqrgsfq7zlunle3jgfan3be34ao5xtkmzczpi6af@waywds2ww6qw>
 <c87613aa-1d17-4a88-acce-269ea9eddc22@huawei.com>
 <CAA8EJpo71m_ae9siT7f4Tsfr0C4XeoraqPYPsPp0gz-N+oMOjw@mail.gmail.com>
 <6e54c88f-dfaf-462d-b66b-c237d19faec6@huawei.com>
 <zzi2h52xiernm32h7i7xtrlnjwaqc3n2tx33ypmhw6quoi5qyg@pilzj5zantii>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <zzi2h52xiernm32h7i7xtrlnjwaqc3n2tx33ypmhw6quoi5qyg@pilzj5zantii>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd500013.china.huawei.com (7.221.188.12)

> On Mon, Mar 03, 2025 at 01:02:44PM +0800, Yongbang Shi wrote:
>>> On Sat, 1 Mar 2025 at 11:54, Yongbang Shi <shiyongbang@huawei.com> wrote:
>>>>> On Sat, Mar 01, 2025 at 04:45:40PM +0800, Yongbang Shi wrote:
>>>>>>> On Thu, Feb 27, 2025 at 09:46:10PM +0800, Yongbang Shi wrote:
>>>>>>>>> On Tue, Feb 25, 2025 at 09:57:17PM +0800, Yongbang Shi wrote:
>>>>>>>>>>> On Mon, 24 Feb 2025 at 16:03, Yongbang Shi <shiyongbang@huawei.com> wrote:
>>>>>>>>>>>>> On Sat, Feb 22, 2025 at 06:35:48PM +0800, Yongbang Shi wrote:
>>>>>>>>>>>>>>>> +static int hibmc_dp_hpd_event(struct drm_client_dev *client)
>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>> +  struct hibmc_dp *dp = container_of(client, struct hibmc_dp, client);
>>>>>>>>>>>>>>>> +  struct hibmc_drm_private *priv = to_hibmc_drm_private(dp->drm_dev);
>>>>>>>>>>>>>>>> +  struct drm_display_mode *mode = &priv->crtc.state->adjusted_mode;
>>>>>>>>>>>>>>>> +  int ret;
>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>> +  if (dp->hpd_status) {
>>>>>>>>>>>>>>>> +          hibmc_dp_hpd_cfg(&priv->dp);
>>>>>>>>>>>>>>>> +          ret = hibmc_dp_prepare(dp, mode);
>>>>>>>>>>>>>>>> +          if (ret)
>>>>>>>>>>>>>>>> +                  return ret;
>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>> +          hibmc_dp_display_en(dp, true);
>>>>>>>>>>>>>>>> +  } else {
>>>>>>>>>>>>>>>> +          hibmc_dp_display_en(dp, false);
>>>>>>>>>>>>>>>> +          hibmc_dp_reset_link(&priv->dp);
>>>>>>>>>>>>>>>> +  }
>>>>>>>>>>>>>>> If I understand this correctly, you are using a separate drm_client to
>>>>>>>>>>>>>>> enable and disable the link & display. Why is it necessary? Existing
>>>>>>>>>>>>>>> drm_clients and userspace compositors use drm framework, they should be
>>>>>>>>>>>>>>> able to turn the display on and off as required.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Thanks for your asking, there are cfg/reset process when the connector 's pluging in/out.
>>>>>>>>>>>>>> We want to cfg DP registers again when the connector changes. Not only dp link training, but also cfg
>>>>>>>>>>>>>> the different video modes into DP registers.
>>>>>>>>>>>>> Why? The link training and mode programming should happen during
>>>>>>>>>>>>> pre_enable / enable stage (legacy or atomic).
>>>>>>>>>>>> Hi Dmitry,
>>>>>>>>>>>>
>>>>>>>>>>>> Right, that's what I'm curious about. It won't call encoder enble/disable functions when I triggered HPD.
>>>>>>>>>>>> And I'm sure the drm_connector_helper_hpd_irq_event() is called. So I add a drm_client for it.I
>>>>>>>>>>> It should be userspace, who triggers the enable/disable (or it should
>>>>>>>>>>> be the in-kernel fbdev / fbcon, which interface through the generic
>>>>>>>>>>> drm_fbdev client).
>>>>>>>>>> Right, I knew it. When I insmode my driver firstly (or restart display service), it will call disable, modeset and enable,
>>>>>>>>>> by user, but it won't call when HPD triggered .
>>>>>>>>> - Is HPD even properly delivered to userspace? What kind of compsitor
>>>>>>>>>        are you using? Is .detect working properly and reporting a correct
>>>>>>>>>        plug-in state?
>>>>>>>> Thanks for your answering. I'm not very good understanding about userspace in framework. In my opinion, when I call
>>>>>>>> this drm_connector_helper_hpd_irq_event(), the HPD will deliver to userspace.
>>>>>>>> I use Xorg, and the display service is GDM.
>>>>>>>> The .detect is called and the getting modes info is correct.
>>>>>>>> I find that it would only trigger(disable, modeset and enable), when I changed resolutions, restart display service and insmod driver.
>>>>>>> You can go to the display settings in GDM. It would be interesting to
>>>>>>> observe if it notes the second monitor or not. Last, but not least, you
>>>>>>> can use a simple tool like 'xrandr' under your XOrg session to set the
>>>>>>> display resolution.
>>>>>> Thank you for your advice!
>>>>>> Right, there are DP and VGA two monitors. I tried to totally remove the vga connector in driver, the problem is gone.
>>>>>> So do I need to clear the vga connector, if dp is plugged in?
>>>>> Unless your hardware can not manage two outputs at the same time, no,
>>>>> you don't have to. Just check how it behaves on x86 systems. Ideally
>>>>> your driver should have the same behaviour.
>>>> Our hardware cannot support two outputs with different timing, so I used the one crtc and one plane that DP and VGA share. And just add a new DP connector
>>>> with a encoder, just like the previous VGA's code logic. But the HPD problem makes me feel confused, should I change the framwork structure to slove this problem?
>>> I think registering a single CRTC is a correct way. Then it is logical
>>> that there is no mode set on the DP when you connect it. The userspace
>>> can not output any data. However if you disconnect VGA and connect DP
>>> then it should become active and should output your desktop
>>> environment.
>> Okay, Thank you for your guidance. So I need to disconnect VGA when I get the HPD (plugged in) , then
>> userapce will active and enanble DP, right?
> Yes.

I'm sorry for that, just wanna make sure one more thing. I found if I only set the VGA connector's status to disconnected when HPD plugged in, it won't be active.

And If I add drm_cleanup_connector() for VGA, it work. So is this okay that I use this cleanup in HPD?


>>
>>>> And also, I will check whether this driver works good on the x86 server. Right now, I'm testing on arm64 server.
>>>>
>>>>>> And also, I used xrandr to set modes after 'startx'. Changing resolutions works,
>>>>>> but there are errs when set some low resolutions.
>>>>> That's a separate topic, most likely related to timing or to some other
>>>>> issues. You can fix that separately (but please do, switching modes
>>>>> should work).
>>>> Okay!
>>>>
>>>>

