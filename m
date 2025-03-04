Return-Path: <linux-kernel+bounces-543102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2C2A4D186
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 03:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE38188DD09
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B14156C40;
	Tue,  4 Mar 2025 02:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Vtk1JUvc"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1C713B29B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 02:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054419; cv=none; b=rR5kNDsVWw8SApS3a2ZJHzzLNmtlQ3SbW92k7BECZ90T1Yi+IHsVsGbzC19Pfg7cNmzlk3vPhl5Ye2EtCaEKTcvCLGm4wHOBwT+1+/1wNifyW+wITJx4926sW1l/lGU7hcJn6vQjygeDZTifjKeXPZsYEOmxqvdydisq67jys9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054419; c=relaxed/simple;
	bh=XdjYGNkCJLFebhJtPJNMrBtam1cgnlzw7fX78PFRfVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HVrG3zwLJVr8dqXIQf5c2nWlJzFlPx3QoLcD7UhP3UnHH7ia7+CkRJhFrGO8XTYlGhwWqRtxymKmTucg4QhD9AbTdakBOaaEcSBdJqZmR4Nf8FT/n0aDNNjd+P1G4UDq57zeGMuxUxRBgntl4mPmDylGi8LZGrAP9pKznL/jLh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Vtk1JUvc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741054416;
	bh=XdjYGNkCJLFebhJtPJNMrBtam1cgnlzw7fX78PFRfVk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vtk1JUvcwQXXuccAcQ2bDeCWgtnbd8VTwLWGoOdovN2NZRhzxK4BzeuIzBynEsUA/
	 70FS4aBc9QGY8fI44OrZOQeYlxzBiq425QJLuvB+tQMtwkvGWK+418pC4d9IR48FNP
	 wr71OMxLPj8yipt5Lw4aHRrZGwatH56QtT9qTbrt6AkGfBs7zOp0sSbz54jrjtS1w3
	 CujyTNsr/idHdxtJaR+lPQ55DLx/ocxXq/0Rv4sX2+WM3MXSpbh8QNVk7IovZwz+hb
	 8qxdEajGNJDePTKx/lc7LEHwm1bHbq5Cht1Xwb9P0CGlH+X4WXLnefcfPe5TKdejaF
	 2I5HM0wnpS5qg==
Received: from [192.168.1.90] (unknown [188.27.58.83])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8DFBF17E086B;
	Tue,  4 Mar 2025 03:13:35 +0100 (CET)
Message-ID: <94ef8866-eccb-497e-8279-a242bbe098d6@collabora.com>
Date: Tue, 4 Mar 2025 04:13:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] phy: rockchip: samsung-hdptx: Setup TMDS char rate
 via phy_configure_opts_hdmi
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>,
 Maxime Ripard <mripard@kernel.org>, kernel@collabora.com,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20250223-phy-sam-hdptx-bpc-v3-0-66a5c8e68327@collabora.com>
 <20250223-phy-sam-hdptx-bpc-v3-5-66a5c8e68327@collabora.com>
 <CAA8EJppjRFWXXYSp=SKPKBV-ceO7gu3n37k-5eUeYG_x6rOmsg@mail.gmail.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <CAA8EJppjRFWXXYSp=SKPKBV-ceO7gu3n37k-5eUeYG_x6rOmsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/24/25 1:38 AM, Dmitry Baryshkov wrote:
> On Sun, 23 Feb 2025 at 13:02, Cristian Ciocaltea
> <cristian.ciocaltea@collabora.com> wrote:
>>
>> The current workaround to setup the TMDS character rate relies on the
>> unconventional usage of phy_set_bus_width().
>>
>> Make use of the recently introduced HDMI PHY configuration API for this
>> purpose.  The workaround will be dropped as soon as the switch has been
>> completed on both ends.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 37 +++++++++++++++++------
>>  1 file changed, 27 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
>> index f9b5c96d6c789e435657e224032d35b5a6950945..dd91a7272e246b2133112effdb080a847fd15abe 100644
>> --- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
>> +++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
>> @@ -402,6 +402,9 @@ struct rk_hdptx_phy {
>>         int nr_clks;
>>         struct reset_control_bulk_data rsts[RST_MAX];
>>
>> +       /* PHY config opts */
>> +       unsigned long tmds_char_rate;
> 
> It's easier to embed struct phy_configure_opts_hdmi here, in the end
> you  add bpc here in one of the next patches.

Indeed, handled in [1], part of v4.
 
>> +
>>         /* clk provider */
>>         struct clk_hw hw;
>>         unsigned long rate;

[...]

>> @@ -1830,6 +1837,16 @@ static int rk_hdptx_phy_clk_set_rate(struct clk_hw *hw, unsigned long rate,
>>  {
>>         struct rk_hdptx_phy *hdptx = to_rk_hdptx_phy(hw);
>>
>> +       /*
>> +        * The TMDS char rate set via phy_configure(), if any, has
>> +        * precedence over the rate provided via clk_set_rate().
> 
> I think this is not so nice. It makes CCF desync from the actual rate
> programmed into the hardware. Maybe you can make the clock r/o?

Oh, you're right.  I should have added just a warning here, though I
haven't really noticed this in practice so far.

I ended up providing a new patch [2] to properly restrict altering 
the TMDS char rate.  As explained in the commit message, making the 
clock read-only is currently not feasible, but I'll revisit this as
soon as the switch to relying exclusively on the HDMI PHY config API 
for the rate setup gets completed on both ends.

Thanks for the review!

Regards,
Cristian
 
>> +        */
>> +       if (hdptx->tmds_char_rate && hdptx->tmds_char_rate != rate) {
>> +               dev_dbg(hdptx->dev, "Replaced clk_set_rate=%lu with tmds_char_rate=%lu\n",
>> +                       rate, hdptx->tmds_char_rate);
>> +               rate = hdptx->tmds_char_rate;
>> +       }
>> +
>>         return rk_hdptx_ropll_tmds_cmn_config(hdptx, rate / 100);
>>  }
>>
>>
>> --
>> 2.48.1

[1] https://lore.kernel.org/lkml/20250304-phy-sam-hdptx-bpc-v4-7-8657847c13f7@collabora.com/
[2] https://lore.kernel.org/lkml/20250304-phy-sam-hdptx-bpc-v4-9-8657847c13f7@collabora.com/

