Return-Path: <linux-kernel+bounces-531536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DADEA441AA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10FD41898E60
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DA226A092;
	Tue, 25 Feb 2025 13:57:32 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFFD267B7A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491852; cv=none; b=elh1iVhTwHipy5p2H3ijCDXs9GkztQNgfi8VfbnZ4IBF972HQU4tkvRKtPCK5tgDrBdYc4oSKTsUf2TV20etvrglxAP3qNJbfMtJl2sxG1K1NlAwvry5T/ghSHzfR6ICnnwttiMaRJDq2f50dFBEf/vksIKFUtXZFe2ANbOvZ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491852; c=relaxed/simple;
	bh=/n43L72p4QWHQ0l/XbEWfrpxt1o63AU+mWLY2OxSBzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Oj2DBjo3lAlxb2JE0BJ38Jn3aFC5IjNgOIu7Pyk4QwBdLcMKOkhOj5C/UGEfP5XbdmsCXAD9P1czT8DZi3EBEqAtfY2QU8kpJhdHf3yNHDvOiGbAIxrHuyJXzV+abxhKRJTMX0X2rzwDhLGQGNb3D+Qs0dDnj/dmav9etrWqwqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Z2Jwb2NXRzvWr2;
	Tue, 25 Feb 2025 21:53:35 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A17E180330;
	Tue, 25 Feb 2025 21:57:19 +0800 (CST)
Received: from [10.159.166.136] (10.159.166.136) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Feb 2025 21:57:17 +0800
Message-ID: <5af62fa9-e71b-412f-8640-502f03fcaa52@huawei.com>
Date: Tue, 25 Feb 2025 21:57:17 +0800
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
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <CAA8EJpqHmhUxLE57XNeh-nVtSP7WvtBE=FiFWk9kqM_P+AC=0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd500013.china.huawei.com (7.221.188.12)

> On Mon, 24 Feb 2025 at 16:03, Yongbang Shi <shiyongbang@huawei.com> wrote:
>>> On Sat, Feb 22, 2025 at 06:35:48PM +0800, Yongbang Shi wrote:
>>>>>> +static int hibmc_dp_hpd_event(struct drm_client_dev *client)
>>>>>> +{
>>>>>> +  struct hibmc_dp *dp = container_of(client, struct hibmc_dp, client);
>>>>>> +  struct hibmc_drm_private *priv = to_hibmc_drm_private(dp->drm_dev);
>>>>>> +  struct drm_display_mode *mode = &priv->crtc.state->adjusted_mode;
>>>>>> +  int ret;
>>>>>> +
>>>>>> +  if (dp->hpd_status) {
>>>>>> +          hibmc_dp_hpd_cfg(&priv->dp);
>>>>>> +          ret = hibmc_dp_prepare(dp, mode);
>>>>>> +          if (ret)
>>>>>> +                  return ret;
>>>>>> +
>>>>>> +          hibmc_dp_display_en(dp, true);
>>>>>> +  } else {
>>>>>> +          hibmc_dp_display_en(dp, false);
>>>>>> +          hibmc_dp_reset_link(&priv->dp);
>>>>>> +  }
>>>>> If I understand this correctly, you are using a separate drm_client to
>>>>> enable and disable the link & display. Why is it necessary? Existing
>>>>> drm_clients and userspace compositors use drm framework, they should be
>>>>> able to turn the display on and off as required.
>>>>>
>>>> Thanks for your asking, there are cfg/reset process when the connector 's pluging in/out.
>>>> We want to cfg DP registers again when the connector changes. Not only dp link training, but also cfg
>>>> the different video modes into DP registers.
>>> Why? The link training and mode programming should happen during
>>> pre_enable / enable stage (legacy or atomic).
>> Hi Dmitry,
>>
>> Right, that's what I'm curious about. It won't call encoder enble/disable functions when I triggered HPD.
>> And I'm sure the drm_connector_helper_hpd_irq_event() is called. So I add a drm_client for it.I
> It should be userspace, who triggers the enable/disable (or it should
> be the in-kernel fbdev / fbcon, which interface through the generic
> drm_fbdev client).

Right, I knew it. When I insmode my driver firstly (or restart display service), it will call disable, modeset and enable,
by user, but it won't call when HPD triggered .



