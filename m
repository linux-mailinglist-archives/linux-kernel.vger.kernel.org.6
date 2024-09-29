Return-Path: <linux-kernel+bounces-343115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C747C9896E3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 20:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 830A3281938
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 18:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AB66F307;
	Sun, 29 Sep 2024 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="okskZXYK"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A535FDA7
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 18:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727635951; cv=none; b=P6C1kSVWoFQR8+JSfJNph5IfnlVpVx8ATjMqaKRCEXw4BrhjcB7UOSgbF3UDpqWW+Gezc10EHti2Uut0LvT126yXJD1DS7rVxBq3qonH5XerZCOnCkUd+chnclQDNJTziW9ehaqFbmbTbZ+GVtfbqs47B7lML52FkdSN5YVGK/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727635951; c=relaxed/simple;
	bh=kVfeflwXH6Kh5KE7YwpqIIpnxAMaIFEAhhFsU51ELQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nqxmdck5qz4Hkiy2G7MFK42LTst0RbO3NKPOVsjpc2F2xOdZPrHFPNUPwfOEl7ab/vEdDBmNisp2LSZ5fDUquCBlTRUghQB8JRlOUmQO7K8rXGzDNBtmtsrGB79WtCJIhrkdGfZ3ZP1L6ykOtxMJBx4jVJjZPUpepSOlldFmY0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=okskZXYK; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 79E19880D8;
	Sun, 29 Sep 2024 20:52:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727635948;
	bh=YU8L+6JDbb4tJqh0JpDU77dzxF7kj5LAZ1t5CtSsbCs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=okskZXYK/UgpCItQ3w8pMcTaxVUDVsOlVb7MUkOQW1rLUHfi7MK0YwEWi8pYLQXv6
	 nnd4IY0jAulgdILSef2NwhIXoXsoxqbM5ZMDBHdZMu1uJ3iqadTflfAXVwbKmCYohZ
	 1I0Y0gOzuRFGRAunXYp8SyG7ukavCtCEk3Jnfsm2+lFCA1w4H3MaVQBLf5L+UsQY7Q
	 Ruz93F/z7YUScRtZanHqfgaAUaDfDFo8QCa6EVQiqytBSjlGc7SzAacAeNuhrqHgGX
	 CxgO8Exlxc24qRrIjyXkdcT0oQRdZDL1zPB9IAqu53rb3Uy6GKZkpYrTYBSlIi98VV
	 D19ZTQRPG0QCA==
Message-ID: <51a87d3e-7a9c-4709-ab64-d869dca28b0a@denx.de>
Date: Sun, 29 Sep 2024 20:47:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] soc: imx8m: Probe the SoC driver as platform
 driver
To: Saravana Kannan <saravanak@google.com>
Cc: linux-arm-kernel@lists.infradead.org, kernel@dh-electronics.com,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <festevam@gmail.com>,
 Jeff Johnson <quic_jjohnson@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240926213729.2882045-1-marex@denx.de>
 <CAGETcx-q7+DGhPYd3QrsPh7O_0HU7T=NhaJYp0Fu7YW2zwbo7Q@mail.gmail.com>
 <e32ed329-b012-44f2-854b-80a8b0efc4e6@denx.de>
 <CAGETcx95ZMBJR0F-3Cr8++1_MwiMCPHiwfdx7m5q0XDAiGG75A@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAGETcx95ZMBJR0F-3Cr8++1_MwiMCPHiwfdx7m5q0XDAiGG75A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/28/24 12:27 AM, Saravana Kannan wrote:

[...]

>>> I'm glad it's working for you, but I think there might still be a race
>>> that you are just lucky enough to not hit. I think you still need to
>>> fix up drivers/base/soc.c to return -EPROBE_DEFER when
>>> soc_device_match() is called but soc_bus_type has no devices
>>> registered. That way any drivers that try to use that API will defer
>>> probe until this device gets to probe.
>>
>> soc_device_match() returns a pointer to soc_device_attribute or NULL, do
>> you have some other function in mind ?
> 
> No, I'm talking about the same function. I'm asking to change it to
> return ERR_PTR(-EPROBE_DEFER) instead
> of NULL if no soc device has been registered yet.
> 
> And you'll also go change all the drivers that use that API and are on
> the IMX boards supported by this soc driver, to handle the
> -EPROBE_DEFER correctly.
> 
> And this error will only get returned for boards that do async probing
> and using a platform device to register the soc device. So it's
> not going to break everyone if you do this change.
It seems the imx8m has no users of this, so I created a local patch, but 
I'll send a V4 of this series first.

