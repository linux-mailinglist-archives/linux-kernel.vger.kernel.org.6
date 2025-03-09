Return-Path: <linux-kernel+bounces-553062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0211A582F1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 11:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F31016A97F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B30017A309;
	Sun,  9 Mar 2025 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kt31JYZ9"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0497FEAC7
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 10:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741515330; cv=none; b=qkPZdVPp+DmUO+6V3stYmHTjs5slCbxhjEvAt+BHrD7ZYRP6rhgV5h2yL5lw6T1wHWITKDEdvpD9PoRsdPoLN6zl9/XeLmmxg3fU+8nQ8l/yes/flyzYEIE+PM1Eabar/cQX8YyE85RJjvF7NCAQWRyLM/6Z4q680/oMLx2/aCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741515330; c=relaxed/simple;
	bh=oZ8C4AaMiVHmMJORqt5AWEOKtdlWfOlHyHmfVChKc1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JFy73BpzY3N3wwTOs0e32T27Pk61esRx2DqHXlAL/xvwfx4vK1tu2WkJOOB+GYgjSnPCrkTVz4Z+Y37qCdCazLB4/R13JVW7M3e8NDwC/5y5bA5h78CRw0k8D2YE/Xwpffm2PMPqA1DxsWoSqbQNLz3/UmNokrBnB5dJcNfQKLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kt31JYZ9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741515327;
	bh=oZ8C4AaMiVHmMJORqt5AWEOKtdlWfOlHyHmfVChKc1U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kt31JYZ9VhyffLJqINjL3ma4HlprQIzm1kXb5xwSrKVixrFY0S4xQ46uHwyyy7zrj
	 VDS/ABfcbF+SNYC0XnIuKcJwsZw0XeJDxuCS7btaTr7aHwHsGT933/P5x9YbOY83lB
	 6296esN7JZGKt7Nw2o1lkH8nkokaCX3hgc+NHZmDpOTASAdqXhrKfAIKKtly8Ro/pB
	 s7MU3+r3qrEexwgh0MUc1g9M8Y3lDtY4VnRhvvCqs45Ya0zOyqzDmbLVYsiSKgVfy1
	 vt+eY2fQRXJuaJ7CnlGe+RAjhzQKUlymDVizx3or2loibSl6MJtpaLGy26SsIwhXne
	 dPGcN1kMJAHgw==
Received: from [192.168.1.90] (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A925017E0B25;
	Sun,  9 Mar 2025 11:15:26 +0100 (CET)
Message-ID: <6caefe9f-1b15-41c1-94f2-9a2a92aeec67@collabora.com>
Date: Sun, 9 Mar 2025 12:15:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/12] phy: rockchip: samsung-hdptx: Setup TMDS char
 rate via phy_configure_opts_hdmi
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>,
 Maxime Ripard <mripard@kernel.org>, kernel@collabora.com,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20250308-phy-sam-hdptx-bpc-v5-0-35087287f9d1@collabora.com>
 <20250308-phy-sam-hdptx-bpc-v5-8-35087287f9d1@collabora.com>
 <CAA8EJpoGu4Tq-wt09Jj+b+=eJ3dNXhPWVOg4DyCQxrJbFNFfYw@mail.gmail.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <CAA8EJpoGu4Tq-wt09Jj+b+=eJ3dNXhPWVOg4DyCQxrJbFNFfYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/9/25 11:26 AM, Dmitry Baryshkov wrote:
> On Sat, 8 Mar 2025 at 14:21, Cristian Ciocaltea
> <cristian.ciocaltea@collabora.com> wrote:
>>
>> The current workaround to setup the TMDS character rate relies on the
>> unconventional usage of phy_set_bus_width().
>>
>> Make use of the recently introduced HDMI PHY configuration API to
>> properly handle the setup.  The workaround will be dropped as soon as
>> the switch has been completed on both ends.
>>
>> Rename rk_hdptx_phy_verify_config() to rk_hdptx_phy_verify_dp_config()
>> and introduce the rk_hdptx_phy_verify_hdmi_config() helper to check the
>> HDMI parameters during phy_configure().
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 64 +++++++++++++++++------
>>  1 file changed, 47 insertions(+), 17 deletions(-)
>>
> 
>> @@ -1469,8 +1474,27 @@ static int rk_hdptx_phy_power_off(struct phy *phy)
>>         return rk_hdptx_phy_consumer_put(hdptx, false);
>>  }
>>
>> -static int rk_hdptx_phy_verify_config(struct rk_hdptx_phy *hdptx,
>> -                                     struct phy_configure_opts_dp *dp)
>> +static int rk_hdptx_phy_verify_hdmi_config(struct rk_hdptx_phy *hdptx,
>> +                                          struct phy_configure_opts_hdmi *hdmi)
>> +{
>> +       int i;
>> +
>> +       if (!hdmi->tmds_char_rate || hdmi->tmds_char_rate > HDMI20_MAX_RATE)
>> +               return -EINVAL;
>> +
>> +       for (i = 0; i < ARRAY_SIZE(ropll_tmds_cfg); i++)
>> +               if (hdmi->tmds_char_rate == ropll_tmds_cfg[i].rate)
>> +                       break;
> 
> return 0;
> 
>> +
>> +       if (i == ARRAY_SIZE(ropll_tmds_cfg) &&
> 
> Then you can drop the first clause in the if

Sure, will do!

Thanks,
Cristian

