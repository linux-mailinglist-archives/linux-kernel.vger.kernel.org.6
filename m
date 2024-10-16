Return-Path: <linux-kernel+bounces-368697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F28F79A1380
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E475B2295A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA23212EF5;
	Wed, 16 Oct 2024 20:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GQUKy8HH"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2673612E4A;
	Wed, 16 Oct 2024 20:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109518; cv=none; b=mM4NB5VcQAiBhz/TkhlkLUn3/hw7s1pobBhmWBfVf17V21HgoQRPQacoYwNx+MYkDfaZ/UOmvoXhSanAkk+ZijyuKogGgVL8bMwxmTh2mnWcIvILltR1BLFpOeNQYcy5Be/Yqn3KdirUzXRXouB+GG7FGnCMLw9rXAMr0J7Nf6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109518; c=relaxed/simple;
	bh=wMMMSBEtO//hNRrqnvuJxHE7i3VytWAet/SFOjJlcPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NgHcYYwb6POmAIBtrKZc18k8IVXB4yaAl4pQR+b4hDB3EW1fy01HulcDRox6g6mp+E0XLChH99AHbEMxMLeie5bEZGy/0GhO1S8oRIfQb7073x9PbTweiZS1wNnpuK0PfRZSrUkRwjDknuVbgqtsAbqRc5NfmCm/dA1QqOzMgoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GQUKy8HH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729109515;
	bh=wMMMSBEtO//hNRrqnvuJxHE7i3VytWAet/SFOjJlcPg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GQUKy8HHXHg7k/uaFBtaX446bbWo/EEXU6VejI+SL02D40oY3f7hd8BrPBJneJ49n
	 nIqJEy+sYkmmtf7b1az/b7AqehAGL7655wy8z9kKk8mFlswhgOVESkCcB9hlYIPxKt
	 UNo2Y/MYZq/OniClYOj+6fyg0U7ZR4wXwaSJjEExoyZRgNcLklnlTqwsDVGe/hFHfW
	 uoCc5Q2knfDiTQU93gJipKttIHVonkViRijZ854hekKLuMg0hSJ8IWae4vj0pxSGrF
	 kMEP+25j9Ezqu3ryUSSoy0YQR/TyNzCqPMnaHC+uV2QLPLLgUuyzUWZU9IytQ05024
	 NvbjuwNpSueUg==
Received: from [192.168.1.90] (unknown [188.24.146.62])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F1F5D17E36CA;
	Wed, 16 Oct 2024 22:11:53 +0200 (CEST)
Message-ID: <e5f1d4ea-4b8d-4f42-9025-5291baddf7e5@collabora.com>
Date: Wed, 16 Oct 2024 23:11:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/3] drm/rockchip: Add basic RK3588 HDMI output support
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Simona Vetter <simona@ffwll.ch>,
 Simona Vetter <simona.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 kernel@collabora.com, Alexandre ARNOUD <aarnoud@me.com>,
 Luis de Arquer <ldearquer@gmail.com>, Algea Cao <algea.cao@rock-chips.com>
References: <20241010-b4-rk3588-bridge-upstream-v9-0-68c47dde0410@collabora.com>
 <20241010-b4-rk3588-bridge-upstream-v9-3-68c47dde0410@collabora.com>
 <3wjk75z2ozz2lg7qx6by3phjoe2brov6rz4jezpowrreedjua6@wt2js5hzqqdi>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <3wjk75z2ozz2lg7qx6by3phjoe2brov6rz4jezpowrreedjua6@wt2js5hzqqdi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 10/16/24 12:27 PM, Uwe Kleine-König wrote:
> Hello,
> 
> On Thu, Oct 10, 2024 at 01:40:51AM +0300, Cristian Ciocaltea wrote:
>> +struct platform_driver dw_hdmi_qp_rockchip_pltfm_driver = {
>> +	.probe  = dw_hdmi_qp_rockchip_probe,
>> +	.remove_new = dw_hdmi_qp_rockchip_remove,
>> +	.driver = {
>> +		.name = "dwhdmiqp-rockchip",
>> +		.pm = &dw_hdmi_qp_rockchip_pm,
>> +		.of_match_table = dw_hdmi_qp_rockchip_dt_ids,
>> +	},
>> +};
> 
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers. Please just drop "_new".
> 
> Additionally I suggest to drop one of the white spaces between .probe
> and =.

Handled both in v10 [1].

Thanks,
Cristian

[1] https://lore.kernel.org/all/20241016-b4-rk3588-bridge-upstream-v10-0-87ef92a6d14e@collabora.com/

