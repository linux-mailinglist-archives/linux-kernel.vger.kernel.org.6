Return-Path: <linux-kernel+bounces-544146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8326A4DDE5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B95C7A384F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E607E202989;
	Tue,  4 Mar 2025 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bHuJpAX9"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8F478F4C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741091321; cv=none; b=aBFY676eNGQVvhsICMiUf3N+Xkc0bzTF8OUKAIS/0RvMTUaJct81FhwJUQUvXjcZgoGw5BZKjD0wXJmiCxTFpUbJoP5i7uL3G11XXPfkQp59eJpnONkcpYoCQJ9luwuJCOiqTPDrEFGEdsmdN+cDcUJCHeIpEYkWoZUuWGpf/ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741091321; c=relaxed/simple;
	bh=hXQr2JDc6VwEA4oybx8Hdat3clPEU6hQMlM5Zb8perI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=spb5kE1gy8plvumHJwg4Qk6dyYcFjj+iOV7UsGzHOMbAW5wdLLGQ3U7QZ5KSombkj1YfPL3SjDyVtO72AH4mda2rE/oLnzjNnfBIeikF6nHu5M/5GFwV34ymd9C30Sv7T0xmqmMY+9hSVD65i3Xr0UjjJGszgjVB9wF2Q7Qrb+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bHuJpAX9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741091317;
	bh=hXQr2JDc6VwEA4oybx8Hdat3clPEU6hQMlM5Zb8perI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bHuJpAX9EfysrAFIJ7eOaGldWtzuqJalISkcLY5g2SWE1mKHj9jqimeQs3+Jvcw4T
	 ZV1mKQoV93K5Ht1KNnpsCHAoy0BU3MBHK5Nq+21BJ7GwQLXNlovFdBooRbUVYMJF0+
	 Y8WMkrFaN+eEhGbUETuiDaEw5j2dwwhnbKQBw9ETrTf8vygNidVwR+NR/H0T5iSGEK
	 QpeUzBshEZA3zEGQBTxkHzCP7SnRpW7guG6rGi+X9ovR1MpfN/wyQhkJMps8NJa2jo
	 ngkL+2r1eGG0fnzr6ry9DMggnE9kDyyEt7ATTGggwWsvddy88+AcZ9FtBj+cftlAk2
	 8+axtikx2WJYA==
Received: from [192.168.1.90] (unknown [188.27.58.83])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 36ACC17E023F;
	Tue,  4 Mar 2025 13:28:37 +0100 (CET)
Message-ID: <71817739-7ecd-478d-ae57-d764e21c8dd9@collabora.com>
Date: Tue, 4 Mar 2025 14:28:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/12] phy: rockchip: samsung-hdptx: Add high color
 depth management
To: Maxime Ripard <mripard@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, kernel@collabora.com,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20250304-phy-sam-hdptx-bpc-v4-0-8657847c13f7@collabora.com>
 <20250304-phy-sam-hdptx-bpc-v4-10-8657847c13f7@collabora.com>
 <20250304-delicate-crazy-tuatara-5ea4d3@houat>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <20250304-delicate-crazy-tuatara-5ea4d3@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/4/25 10:21 AM, Maxime Ripard wrote:
> On Tue, Mar 04, 2025 at 03:44:09AM +0200, Cristian Ciocaltea wrote:
>> @@ -1480,12 +1484,12 @@ static int rk_hdptx_phy_power_off(struct phy *phy)
>>  static int rk_hdptx_phy_verify_hdmi_config(struct rk_hdptx_phy *hdptx,
>>  					   struct phy_configure_opts_hdmi *hdmi)
>>  {
>> -	if (!hdmi->tmds_char_rate || hdmi->tmds_char_rate > HDMI20_MAX_RATE)
>> -		return -EINVAL;
>> -
>>  	u32 bit_rate = hdmi->tmds_char_rate / 100;
>>  	int i;
>>  
>> +	if (!hdmi->tmds_char_rate || hdmi->tmds_char_rate > HDMI20_MAX_RATE)
>> +		return -EINVAL;
>> +
>>  	for (i = 0; i < ARRAY_SIZE(ropll_tmds_cfg); i++)
>>  		if (bit_rate == ropll_tmds_cfg[i].bit_rate)
>>  			break;
> 
> Why is that change needed?

Oh, that was supposed to be a fixup for "phy: rockchip: samsung-hdptx:
Provide config params validation support" to keep variable declaration
section on top.  Not sure how I missed it, probably I chose the wrong
commit hash while focusing on some other changes during the rebase.

Will sort this out in v5.

Thanks for spotting it,
Cristian

