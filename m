Return-Path: <linux-kernel+bounces-201302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4928FBCB8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EE281F2384B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FD514B09C;
	Tue,  4 Jun 2024 19:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Fe0wWaxK"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23271B644;
	Tue,  4 Jun 2024 19:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717530250; cv=none; b=t4Yatz5EYT+xncHP7++G6ZuTY6+MJLDzosHmi+XOnhCfXcLSh+MfA7qC1pUxF2iRqIwg1KAWmKgfiea8dqSFkYPYVr4AYH9D9sRiRkLkVRNkxx5aoVEptrKvcTzuzbcBohhRP1cO4zaDSkSsf3iMpbJRAjHhdoH6a9qxNxIVHNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717530250; c=relaxed/simple;
	bh=oGz3iRzmdqum59ggsBZtJboMbceE1QjBtHdfjHHfQLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cto8RPkN4WuzBYSRq9FIRuR8QqCMglv9pYDHRdOKQy5IrhIdBRdyHa23AvTgwjs0FO/b/pd67W9IUk7m/e0IM+6qoTFLzAa3692iyAcSDMlgfxsR95Dq0KPBy9jiJiI5hOyXXv4bXg2mhHCeOV7W2uPmIgwVzcCKbLRAc/xRWrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Fe0wWaxK; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717530247;
	bh=oGz3iRzmdqum59ggsBZtJboMbceE1QjBtHdfjHHfQLs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Fe0wWaxK5i/OnnlAWeSBrvGQEwhZIT2S2xwBn9HEJab+3UIrADowsdecA4JA22FXh
	 w9b7Oy0FXpEWDWqVYyje3Kvb5rl/4nvNyh+w0w8hWYPNyoBG3DP6g5vsaiMh8/gp8q
	 /OsEgimp++IEeQuz8wrh9Ms2tw7kKECrNuP0iZpcYq49qyduwajbXfFkFk3C1k/d0B
	 WyWtko6z9NySVS5p/dRimGdJhs0xcLSqqYFYANANHYRz9KrToiMNCGn0MyrwJow/Ac
	 PK2ugOK2mxf/0gFtgLLxeyPcl31CDzcOajWN2uBQQNTYG4u0LGjXdvHrIzH15S9bbN
	 206gavtDqdMHw==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 33EFE3782146;
	Tue,  4 Jun 2024 19:44:05 +0000 (UTC)
Message-ID: <892b2070-2fd0-42b2-a8c2-811dc7382b0c@collabora.com>
Date: Tue, 4 Jun 2024 22:44:04 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] Add initial support for the Rockchip RK3588 HDMI TX
 Controller
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, kernel@collabora.com,
 Alexandre ARNOUD <aarnoud@me.com>, Luis de Arquer <ldearquer@gmail.com>,
 Algea Cao <algea.cao@rock-chips.com>
References: <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>
 <a5jlj5hncv2p7lxk6pbgynkqfovlg3lzz2muzrbrkd73afiopu@n5tmd4zfyeik>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <a5jlj5hncv2p7lxk6pbgynkqfovlg3lzz2muzrbrkd73afiopu@n5tmd4zfyeik>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/1/24 7:32 PM, Dmitry Baryshkov wrote:
> On Sat, Jun 01, 2024 at 04:12:22PM +0300, Cristian Ciocaltea wrote:
>> The RK3588 SoC family integrates a Quad-Pixel (QP) variant of the
>> Synopsys DesignWare HDMI TX controller used in the previous SoCs.
>>
>> It is HDMI 2.1 compliant and supports the following features, among
>> others:
>>
>> * Fixed Rate Link (FRL)
>> * 4K@120Hz and 8K@60Hz video modes
>> * Variable Refresh Rate (VRR) including Quick Media Switching (QMS)
>> * Fast Vactive (FVA)
>> * SCDC I2C DDC access
>> * TMDS Scrambler enabling 2160p@60Hz with RGB/YCbCr4:4:4
>> * YCbCr4:2:0 enabling 2160p@60Hz at lower HDMI link speeds
>> * Multi-stream audio
>> * Enhanced Audio Return Channel (EARC)
> 
> It would be really nice if you can take a look at using the HDMI
> connector framework (landed few days ago) with adaptations for the
> drm_bridge / drm_bridge_connector ([1]). Your comments for the
> drm_bridge patches would be defeinitely appreciated.
> 
> [1] https://lore.kernel.org/dri-devel/20240531-bridge-hdmi-connector-v4-0-5110f7943622@linaro.org/

I will definitely check and try to use it, but I'd rather wait a bit
until this gets stabilized and focus instead on the mandatory changes
required to upstream this driver. That's mostly because my limited
availability and expertise on the matter, while trying to unblock other
work depending on this.

Thanks,
Cristian

