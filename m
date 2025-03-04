Return-Path: <linux-kernel+bounces-544132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37380A4DDBA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E29F7A9113
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDF5202F61;
	Tue,  4 Mar 2025 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NmRVOV/x"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D66E20298E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741090825; cv=none; b=OuNUx+zMSpq3Qmv8rgiuGqrxnzrI7VdhB+gyPuCNxkw9IoKI/DPqO22fMyQ+SN682QbCGc1dgXt84kjg9Hhwc+OtIuDIQS8dBjKiV0aL1vNmvTD8qSklMuQn85YgNL2/VmfdDwnaDEKE6znobgzWd4eL2rGuERAv/gX19Bky0jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741090825; c=relaxed/simple;
	bh=PUBEhxWckZa+nMU3VKaHI27uqQbQR5AaVBf7PjPU6tE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A8OJTdL8aK4SrvBaD7OhBS1pa6bVQOnLv4T/7fukdlW6IlliJ5S9kF0LfQhrzJzvKdQ4VBCfqnnChXNVBNv9MACkm75k77jMYK+GSvNrIan/WjETjnk48foAr6JwVyejAWLWpI2cAqB6cOAyK2YPx1RIGY3hS/537wIOkVgO3cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NmRVOV/x; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741090821;
	bh=PUBEhxWckZa+nMU3VKaHI27uqQbQR5AaVBf7PjPU6tE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NmRVOV/xONIj5eHdISMlWCxuRIK24rWjtoMvWosf2uKorM4q3XE9Ra1osDQbdKEj8
	 QBE8WZ5Rv6zcpjxfbcklLn01z4tMsBJz2L0WlcZc6o9n4BACYWHiOYCeEfTh1MLSQG
	 c3TB4Cl/CHtTAn0aF1rjXhf5cceZLUsSSSK0jZ85uuhhCgQPUgl1aniuCHyhes0upn
	 CD1q5CnHeMntxl15d1wQcRMsgqa3nRSgsZ/jUHUzunHeyDGNdAlV+l//85TuNDMv56
	 sOveCklQ/dQEHKUFEHqfdWrAOb7ZPJDYpOin+UoCO2Im+HyKYIWeLE8nIc8ysIhRkv
	 IFUsSIZhI4w+Q==
Received: from [192.168.1.90] (unknown [188.27.58.83])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B85C517E068F;
	Tue,  4 Mar 2025 13:20:20 +0100 (CET)
Message-ID: <bee17643-e0b4-467b-a632-06f91ac7fc3a@collabora.com>
Date: Tue, 4 Mar 2025 14:20:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/12] phy: rockchip: samsung-hdptx: Provide config
 params validation support
To: Maxime Ripard <mripard@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, kernel@collabora.com,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20250304-phy-sam-hdptx-bpc-v4-0-8657847c13f7@collabora.com>
 <20250304-phy-sam-hdptx-bpc-v4-8-8657847c13f7@collabora.com>
 <20250304-romantic-truthful-sambar-deaab1@houat>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <20250304-romantic-truthful-sambar-deaab1@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/25 10:18 AM, Maxime Ripard wrote:
> On Tue, Mar 04, 2025 at 03:44:07AM +0200, Cristian Ciocaltea wrote:
>> Implement the phy_ops.validate() callback to allow checking the PHY
>> configuration parameters without actually applying them.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>
>> diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
>> index 7e1d1c10758249aa5bbddbdaae0108bba04f30df..47db1395051f5d900197871694bab90ca4d6e38e 100644
>> --- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
>> +++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
>> @@ -1482,6 +1482,17 @@ static int rk_hdptx_phy_verify_hdmi_config(struct rk_hdptx_phy *hdptx,
>>  	if (!hdmi->tmds_char_rate || hdmi->tmds_char_rate > HDMI20_MAX_RATE)
>>  		return -EINVAL;
>>  
>> +	u32 bit_rate = hdmi->tmds_char_rate / 100;
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(ropll_tmds_cfg); i++)
>> +		if (bit_rate == ropll_tmds_cfg[i].bit_rate)
>> +			break;
>> +
>> +	if (i == ARRAY_SIZE(ropll_tmds_cfg) &&
>> +	    !rk_hdptx_phy_clk_pll_calc(bit_rate, NULL))
>> +		return -EINVAL;
> 
> What are you calling bit_rate here? If anything, I'd expect the bit_rate
> to be a multiple of the char rate, not a divisor.

This is just an unfortunate naming of the search key in struct
ropll_config, inherited from downstream, given in hHz rather than Hz.
I've already renamed it in the last patch, while getting rid of those
annoying unit conversions.

