Return-Path: <linux-kernel+bounces-367750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A23259A063A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33CFDB24983
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C2620695F;
	Wed, 16 Oct 2024 09:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PS0AuZKY"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A6F199944;
	Wed, 16 Oct 2024 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072637; cv=none; b=J9jKvuzrqrHFUlRTqiEr78aJUROve73v0NPRFSwsHrJg8/HD9YwT2G04uCD5yy2CSPsve0iTKq833G5VgkxsxT/pL8BxEV/2D3bZbcEem2G5R8+I07HXrq8kFtzqLF0vEN5UJ+ib/TQsgPtRs6LricmZ8MKOGpfX1ZdngnVYDJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072637; c=relaxed/simple;
	bh=uu+U0uRS375aOOnTfp2lQZkaCO+LNb9NDegcLXMQKmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6TTMqW+ZLr7ehmnk0X8TFdiIhWc3KHnF92t+9cFJXjNSkHTmMkJdH5nQXNxWE0UBBqNzJMowUAMK4oGAW9EYCiZSOJ8XnwgP5CdSMH1mZt7eOSmUuHJZrqX9azhc9pcFml19vFufkLWZX9BpppDV3hGlxeI/4RuGtSnXNKz47Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PS0AuZKY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729072634;
	bh=uu+U0uRS375aOOnTfp2lQZkaCO+LNb9NDegcLXMQKmI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PS0AuZKYJrVCCKK3XrKXDQ2QvAaUaIhz6w/fnaVnD56CR3D7SwRzySU1u504gbkTM
	 DftKNAs0B+AjaTuQ8nBWKarGOSOG28HEjev+LaTX/vTpunXEsGVGk6JvgbTq7wSCqu
	 BNsrhQ670FUq+THX3CAVAoVAkQ60PXjjdo6TYdFRbk7ukUprFgiRpsTo8W/w4Y+hgu
	 KlEeKnHWRbL8tJKFxOJN0DhTfYfaq1XmhcFFzLZtcQZBWmmi3GmUgRc7c6zhKam96T
	 la2mItUZHVjK3JCjuUKUySZZ/RY91VyeOP+0wuP7tik/gcQJIUMOzqko4LKG0G+0gf
	 T+jqqL4Cb0LXQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3EF4517E124E;
	Wed, 16 Oct 2024 11:57:13 +0200 (CEST)
Message-ID: <ad000fdb-4474-49c4-9357-f23491231b07@collabora.com>
Date: Wed, 16 Oct 2024 11:57:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] clk: mediatek: Add drivers for MediaTek MT6735
 main clock and reset drivers
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Yassine Oudjana <yassine.oudjana@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Sam Shih <sam.shih@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Yassine Oudjana <y.oudjana@protonmail.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20241010132659.81606-1-y.oudjana@protonmail.com>
 <20241010132659.81606-3-y.oudjana@protonmail.com>
 <vn466kmo2uqrf6ap54oat2bipj4lsfri7asnsrptrlthva6j5m@dop6xit2pzjk>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <vn466kmo2uqrf6ap54oat2bipj4lsfri7asnsrptrlthva6j5m@dop6xit2pzjk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 16/10/24 11:28, Uwe Kleine-König ha scritto:
> Hello,
> 
> On Thu, Oct 10, 2024 at 04:26:57PM +0300, Yassine Oudjana wrote:
>> +static struct platform_driver clk_mt6735_apmixedsys = {
>> +	.probe = clk_mt6735_apmixed_probe,
>> +	.remove_new = clk_mt6735_apmixed_remove,
>> +	.driver = {
>> +		.name = "clk-mt6735-apmixedsys",
>> +		.of_match_table = of_match_mt6735_apmixedsys,
>> +	},
>> +};
> 
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers. Please just drop "_new".
> 

Oh wow, I didn't notice that during my review. Sorry about that.

Cheers,
Angelo

