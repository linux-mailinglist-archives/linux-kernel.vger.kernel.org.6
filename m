Return-Path: <linux-kernel+bounces-435443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E8C9E77BD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDBD9282A64
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD4D1F63FD;
	Fri,  6 Dec 2024 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XXqaqVzj"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA3313BAE4
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733507703; cv=none; b=Anmk71VeHA5c17cc8cPqVKhTbU/qy85G1EyvppLZU2L3vNHRG+ub01QCUOubj958lJi7me5q5rQNZwibhLJ3Y4XgkJSQd5MFMP6eD2j3B7qNY04nhQV1MnkI9W7x1RxiE/CmliaOWdO+Tr/EtlpSRkLM3xineD3TFeH6iABNVsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733507703; c=relaxed/simple;
	bh=nQDvlQxYe4jehSwcFykn5ppWSMSEf/GkFb7QmH9D0uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=geJ6O6LuPNZooHj3PfNMPUyDFZBU2HIeAsu+W3BhksP81eSnEUnaXJwr6tc0omshAf1OrPUInDx54IP8jf/rC7OKdN/e5piKEF3MEKKuJXEOmTyOAKBj2wNLLNlIRb/5zlyM2WTOjjFngTZiKoCQNWhsR3gO+ywjBgg3MPC9gbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XXqaqVzj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733507692;
	bh=nQDvlQxYe4jehSwcFykn5ppWSMSEf/GkFb7QmH9D0uc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XXqaqVzj0/ntiUpR9BzunQyfF7MDb6HwPnXr+cbB6M6+XhWHl81G0cXsMe+OyMrJ5
	 YEnrK0VuK9JgrhDoYyshWF8aE6XQr/WpOye+Yl2GpuM83cyx3UE1BvJnqQybn8slyB
	 DMhqrRts1Mf6RoYNIzY/EbDqpb0VEKhSZA0Ks6kZ8+NQPmh5QIhjkyYdpA+xPBsE7z
	 SA8JP/b+yV4MWkLxRxkahg6YF4TJuQKE94URcm9DO8sl6TxS50rGuoElpvPHySptKV
	 SM/zljXYl9sox62rExqncHtUmiA7/VYcAwoUQQo5rAxO/ji+gZk778ut2K5yMJeRyZ
	 Cve9K6MapYkMw==
Received: from [192.168.1.90] (unknown [188.27.48.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DE65017E37C2;
	Fri,  6 Dec 2024 18:54:51 +0100 (CET)
Message-ID: <7081d3ec-1a7f-48d9-a20d-7518445ed5bd@collabora.com>
Date: Fri, 6 Dec 2024 19:54:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] phy: phy-rockchip-samsung-hdptx: annotate regmap
 register-callback
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, vkoul@kernel.org,
 kishon@kernel.org
Cc: linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 quentin.schulz@cherry.de, Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20241206103401.1780416-1-heiko@sntech.de>
 <20241206103401.1780416-2-heiko@sntech.de>
 <e6172204-2f3f-4a9c-892c-be85d19ad031@collabora.com>
 <2287157.Dhsi8hcfAM@diego>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <2287157.Dhsi8hcfAM@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/6/24 7:36 PM, Heiko Stübner wrote:
> Am Freitag, 6. Dezember 2024, 12:18:56 CET schrieb Cristian Ciocaltea:
>> On 12/6/24 12:34 PM, Heiko Stuebner wrote:
>>> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>>>
>>> The variant of the driver in the vendor-tree contained those handy
>>> comments in the regmap register callback. Having the different ranges
>>> describe what they are looks helpful.
>>>
>>> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
>>> ---
>>>  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 14 +++++++-------
>>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
>>> index 4ced1479e2dc..c5c64c209e96 100644
>>> --- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
>>> +++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
>>> @@ -766,13 +766,13 @@ static struct tx_drv_ctrl tx_drv_ctrl_hbr2[4][4] = {
>>>  static bool rk_hdptx_phy_is_rw_reg(struct device *dev, unsigned int reg)
>>>  {
>>>  	switch (reg) {
>>> -	case 0x0000 ... 0x029c:
>>> -	case 0x0400 ... 0x04a4:
>>> -	case 0x0800 ... 0x08a4:
>>> -	case 0x0c00 ... 0x0cb4:
>>> -	case 0x1000 ... 0x10b4:
>>> -	case 0x1400 ... 0x14b4:
>>> -	case 0x1800 ... 0x18b4:
>>> +	case 0x0000 ... 0x029c: /* CMN Register */
>>> +	case 0x0400 ... 0x04a4: /* Sideband Register */
>>> +	case 0x0800 ... 0x08a4: /* Lane Top Register */
>>> +	case 0x0c00 ... 0x0cb4: /* Lane 0 Register */
>>> +	case 0x1000 ... 0x10b4: /* Lane 1 Register */
>>> +	case 0x1400 ... 0x14b4: /* Lane 2 Register */
>>> +	case 0x1800 ... 0x18b4: /* Lane 3 Register */
>>>  		return true;
>>>  	}
>>>  
>>
>> Nice finding!  The HDMI variant of the driver which I used as an
>> implementation reference (i.e. phy-rockchip-samsung-hdptx-hdmi.c)
>> doesn't provide these comments.
> 
> yep, those comments were in the displayport variant of the phy-driver ;-) .
> I don't really understand why the vendor tree contains 2 separate drivers

Yeah, I asked myself the same question a while ago - I'd assume the
(initial) development happened in parallel, but the final sync/merge was
never done.

> written by two different people, but at least it looks like we're getting
> one driver in mainline, thanks to Damon's work :-)

Indeed, we're eventually getting there.. :-)

