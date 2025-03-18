Return-Path: <linux-kernel+bounces-566177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB9FA67443
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2164D3BAD79
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F09320C477;
	Tue, 18 Mar 2025 12:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jux5qC1P"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532C7209F56
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742302098; cv=none; b=ToYpeyaAZIRueWmHkjffmk+ZaFUtezy+vexbo1kCzgH9MyhK5s6JPvCZaFZbPqejFkvy21UoFKycvEIcEGDtcduVetMkO6kRjd9OdqLp1OdZpfymI5uQhdO+qW8R1g8VTMNQohG7XUvGJjRH03f4KWzcoKd6X2VuvHQPbnL5gGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742302098; c=relaxed/simple;
	bh=1brdAVEecCGu0q3JZDffnzT7ixMtvQ/GFCymcYGLKrY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Wi/stSter0pr8g/uG3+Vn7RB1NnBo4gCyb/WMkLD22ms1INKm/kM4adHAbexa3rTO224DhglSiVNDr32zkpK14rvHlxSusURcK6umt3VJMIDnIKYbW0DmM+srPe3E9ulspkBlkFOdUzScGVzOAD5cc78q6gHl9dXfh7aaDO2LAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jux5qC1P; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742302091;
	bh=1brdAVEecCGu0q3JZDffnzT7ixMtvQ/GFCymcYGLKrY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=jux5qC1PNeu/TbmQK+KES3ko+a5iDs1NIgc0uj5XFRcAUYKALK8FH/Ksr7nOFzguE
	 eW4VCpV57aKc4kEpvNk4uWOTzNdu164IAw+3y3+/j4QP++ImoOiWUd+R/1YkEh7RJk
	 ql65VX28rqB0M1vOVrjhjNV3mfUIefw2P/9fLEV5VdiuiJr27haDRJlHNARtknjEBv
	 FYS6z8qqwy7MQUE0gnSE7KSiQ8yLmIq/TTSj1eiIIBMV7DNNSJ0aAZqZp+wvKu6/UB
	 hXU35iJyJORsLixZcrAbqLlawwgYbVQ07Cq3lN7chVrS5byN9hgG8o4d5+0hoslCur
	 OSnLY9XarvzVQ==
Received: from [192.168.1.90] (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E490817E0385;
	Tue, 18 Mar 2025 13:48:10 +0100 (CET)
Message-ID: <5e9516bc-66ac-4583-b949-5714e89d73ee@collabora.com>
Date: Tue, 18 Mar 2025 14:48:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/12] phy: rockchip: samsung-hdptx: Setup TMDS char
 rate via phy_configure_opts_hdmi
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>,
 Maxime Ripard <mripard@kernel.org>, kernel@collabora.com,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20250308-phy-sam-hdptx-bpc-v5-0-35087287f9d1@collabora.com>
 <20250308-phy-sam-hdptx-bpc-v5-8-35087287f9d1@collabora.com>
 <CAA8EJpoGu4Tq-wt09Jj+b+=eJ3dNXhPWVOg4DyCQxrJbFNFfYw@mail.gmail.com>
 <6caefe9f-1b15-41c1-94f2-9a2a92aeec67@collabora.com>
Content-Language: en-US
In-Reply-To: <6caefe9f-1b15-41c1-94f2-9a2a92aeec67@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/9/25 12:15 PM, Cristian Ciocaltea wrote:
> On 3/9/25 11:26 AM, Dmitry Baryshkov wrote:
>> On Sat, 8 Mar 2025 at 14:21, Cristian Ciocaltea
>> <cristian.ciocaltea@collabora.com> wrote:
>>>
>>> The current workaround to setup the TMDS character rate relies on the
>>> unconventional usage of phy_set_bus_width().
>>>
>>> Make use of the recently introduced HDMI PHY configuration API to
>>> properly handle the setup.  The workaround will be dropped as soon as
>>> the switch has been completed on both ends.
>>>
>>> Rename rk_hdptx_phy_verify_config() to rk_hdptx_phy_verify_dp_config()
>>> and introduce the rk_hdptx_phy_verify_hdmi_config() helper to check the
>>> HDMI parameters during phy_configure().
>>>
>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>> ---
>>>  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 64 +++++++++++++++++------
>>>  1 file changed, 47 insertions(+), 17 deletions(-)
>>>
>>
>>> @@ -1469,8 +1474,27 @@ static int rk_hdptx_phy_power_off(struct phy *phy)
>>>         return rk_hdptx_phy_consumer_put(hdptx, false);
>>>  }
>>>
>>> -static int rk_hdptx_phy_verify_config(struct rk_hdptx_phy *hdptx,
>>> -                                     struct phy_configure_opts_dp *dp)
>>> +static int rk_hdptx_phy_verify_hdmi_config(struct rk_hdptx_phy *hdptx,
>>> +                                          struct phy_configure_opts_hdmi *hdmi)
>>> +{
>>> +       int i;
>>> +
>>> +       if (!hdmi->tmds_char_rate || hdmi->tmds_char_rate > HDMI20_MAX_RATE)
>>> +               return -EINVAL;
>>> +
>>> +       for (i = 0; i < ARRAY_SIZE(ropll_tmds_cfg); i++)
>>> +               if (hdmi->tmds_char_rate == ropll_tmds_cfg[i].rate)
>>> +                       break;
>>
>> return 0;
>>
>>> +
>>> +       if (i == ARRAY_SIZE(ropll_tmds_cfg) &&
>>
>> Then you can drop the first clause in the if
> 
> Sure, will do!

I actually ended up submitting v6 [1] without these changes, since the last
patch "phy: rockchip: samsung-hdptx: Add high color depth management" would
need to revert them, i.e. it extends the verification and cannot really do
"return 0;" early.

[1] https://lore.kernel.org/lkml/20250318-phy-sam-hdptx-bpc-v6-0-8cb1678e7663@collabora.com/

