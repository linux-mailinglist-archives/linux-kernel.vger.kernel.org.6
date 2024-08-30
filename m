Return-Path: <linux-kernel+bounces-309518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEDB966C36
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77514284286
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B9E1C1AA8;
	Fri, 30 Aug 2024 22:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b="ft7x5kfX"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D3B136337;
	Fri, 30 Aug 2024 22:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725056563; cv=pass; b=Pubc11FeNvog2tQUvyrXdWMChxAQDMQhLCd8aNAxNLcNGmptXn93R3KgKrYE7OK0cEm3Uqu3xqexjW/hk9J1VJayjPqCppMQRqkyhhnzXJwa7uWosnsRIjfFPyH41loEhYqxsyC1VdAxigVt5bPwgl4OmARQ+f8YP6t55C5K1/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725056563; c=relaxed/simple;
	bh=8KdzrkiTCS4+gtZ06eotVmsrEANc5d+xnrjxoY3+PP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gtnphKLVudzrX+narZMF1kBdvA7CFef26cnI4Ks0lcBb78gpQUUOVUoIuHFUtNz76Qqkt7ISP2GhVJ+Bx3unEIKVJw54AokUmVM9x414nrlQO4LOrO429FXwjT3oGfvX2Kb+tweYzuFtuV8moczUA2AUNCkjClzjVep+BQi7SwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b=ft7x5kfX; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1725056517; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VP8/aryapCMCOF1SvDqoG+mRd3WtRhCLgjOtagvUQv3gqKX4nVkiuEvUgItXy/JgzrdG3C5lJxhaCzEFhCN9V2fPKpzRLSqDac2xAP6Bs9VpQuoldASU00MihKa733wg54HZlQi6dH9O0yjl5DTZqDLownvRG3jYFfyQ4JwpHHw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725056517; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LhR+kXGC+DFHGvsEu1DDE6tCIMiI45kjz9hxbZ3s88o=; 
	b=OHX6tglUjZBxq6KskH5aloVBl/7MZVJGxFkVt83NERgb20gLMVjBDUECe1g53MSgXD1ofJUCXTWs9xoGXYd4IG10yS3JTp/nn63ANpsMMXAXWFa3a5CeIqj/DME/Zq0A22S0OIyhg8WonQpkORQycXgUzBDx1l8i9F6Ka3d3+PQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=cristian.ciocaltea@collabora.com;
	dmarc=pass header.from=<cristian.ciocaltea@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725056517;
	s=zohomail; d=collabora.com; i=cristian.ciocaltea@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=LhR+kXGC+DFHGvsEu1DDE6tCIMiI45kjz9hxbZ3s88o=;
	b=ft7x5kfX3ak042gww8Zh/AvfQWRO3NFXaFPMO99JnFMaRWRXu0K0NgTlk+aX4t/c
	5h6Wjxh83wq2oxv5xioutYFwnVetxj1ZXfwqzmWCxrsq2oNLsYfeGUYpCzKLsBc85fQ
	N40NdU5mslkZ/wmUBzKgqD58Ro1Gtdi3G9LRZPIU=
Received: by mx.zohomail.com with SMTPS id 1725056516094200.5079858589844;
	Fri, 30 Aug 2024 15:21:56 -0700 (PDT)
Message-ID: <34422b7a-ce70-445d-a574-60ac36322119@collabora.com>
Date: Sat, 31 Aug 2024 01:21:48 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] drm/bridge: synopsys: Add DW HDMI QP TX Controller
 support library
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 kernel@collabora.com, Alexandre ARNOUD <aarnoud@me.com>,
 Luis de Arquer <ldearquer@gmail.com>, Algea Cao <algea.cao@rock-chips.com>
References: <20240819-b4-rk3588-bridge-upstream-v4-0-6417c72a2749@collabora.com>
 <20240819-b4-rk3588-bridge-upstream-v4-2-6417c72a2749@collabora.com>
 <20240827-armored-magnificent-badger-ffb025@houat>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20240827-armored-magnificent-badger-ffb025@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 8/27/24 11:58 AM, Maxime Ripard wrote:
> On Mon, Aug 19, 2024 at 01:29:29AM GMT, Cristian Ciocaltea wrote:
>> +static irqreturn_t dw_hdmi_qp_main_hardirq(int irq, void *dev_id)
>> +{
>> +	struct dw_hdmi_qp *hdmi = dev_id;
>> +	struct dw_hdmi_qp_i2c *i2c = hdmi->i2c;
>> +	u32 stat;
>> +
>> +	stat = dw_hdmi_qp_read(hdmi, MAINUNIT_1_INT_STATUS);
>> +
>> +	i2c->stat = stat & (I2CM_OP_DONE_IRQ | I2CM_READ_REQUEST_IRQ |
>> +			    I2CM_NACK_RCVD_IRQ);
>> +
>> +	if (i2c->stat) {
>> +		dw_hdmi_qp_write(hdmi, i2c->stat, MAINUNIT_1_INT_CLEAR);
>> +		complete(&i2c->cmp);
>> +	}
>> +
>> +	if (stat)
>> +		return IRQ_HANDLED;
>> +
>> +	return IRQ_NONE;
>> +}
> 
> If the scrambler is enabled, you need to deal with hotplug. On hotplug,
> the monitor will drop its TMDS ratio and scrambling status, but the
> driver will keep assuming it's been programmed.
> 
> If you don't have a way to deal with hotplug yet, then I'd suggest to
> just drop the scrambler setup for now.

Thanks for the heads up!

HPD is partially handled by the RK platform driver, which makes use of
drm_helper_hpd_irq_event(). Since the bridge sets DRM_BRIDGE_OP_DETECT
flag, the dw_hdmi_qp_bridge_detect() callback gets executed, which in turn
verifies the PHY status via ->read_hpd() implemented as
dw_hdmi_qp_rk3588_read_hpd() in the platform driver.

During my testing so far it worked reliably when switching displays with
different capabilities.  I don't have a 4K@60Hz display at the moment, but
used the HDMI RX port on the Rock 5B board in a loopback connection to
verify this mode, which triggered the high TMDS clock ratio and scrambling
setup as well.

I just submitted v5 [1] where I reworked a bit the scrambling handling,
which allowed for some code simplification.

[1] https://lore.kernel.org/lkml/20240831-b4-rk3588-bridge-upstream-v5-0-9503bece0136@collabora.com/

Regards,
Cristian


