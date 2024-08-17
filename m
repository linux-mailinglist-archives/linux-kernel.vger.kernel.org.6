Return-Path: <linux-kernel+bounces-290627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C667D955688
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 10:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04BC31C20DB9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 08:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C66145FE8;
	Sat, 17 Aug 2024 08:59:07 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.124.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE814C97;
	Sat, 17 Aug 2024 08:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.124.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723885146; cv=none; b=STeLzM+mpf5gNWDNgPFFmz4zQnJ+ZBlz8C6DkkUU2VK4t5UOxZDUI81Q241xGoVsNqyoK8li3JRJmbCgmM4TQL8Z8JMxyG/HPdxgiZXCLlgXjTJj6qQpxf1kR4YNcDVnhi4aXhThbJ4S7WyDBqbJ8S4nXa2+5dXpsLlCoayOrNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723885146; c=relaxed/simple;
	bh=Xq+RJ5SRjykEaDIy/uWtRVtiwMYL9WQHZhXmiVV4j7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=u5hLwHwxdZjCe4B4QA5yP+9P7NDH55bdfgefunYr43Qbt44fm7FblLD+rQ5N9o7cMFt4Pi6ZoysfeCEucDUZwPFGytwxaqebG9BgHNoMb6+CNBMNi5gJAB5m4wDhoAIcnGGmXvOeIoMGM9JLmr2jd0zyaRgmMMjUCxv18BNM3ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=114.132.124.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: bizesmtpsz6t1723885106tbdpzxz
X-QQ-Originating-IP: kn3ghW7P3vsFGXrWzxvEGp8DaBzE1pQqarSllkcDdT4=
Received: from [192.168.2.20] ( [183.15.205.136])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 17 Aug 2024 16:58:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9089768555492761139
Message-ID: <D2E5D3206EC74463+e6e4d3ab-67f2-42e5-93c6-30feb63c7d78@radxa.com>
Date: Sat, 17 Aug 2024 16:58:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: serial: option: add MeiG Smart SRM825L
To: yt@radxa.com
References: <0041DFA5200EFB1B+20240803074619.563116-1-yt@radxa.com>
Content-Language: en-US
Cc: Johan Hovold <johan@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
From: ZHANG Yuntian <yt@radxa.com>
Organization: Radxa Computer Co., Ltd
In-Reply-To: <0041DFA5200EFB1B+20240803074619.563116-1-yt@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1

This was my first submitted patch so I forgot to run get_maintainer.pl 
and collect the CC list, so I'm sending this out as a reminder.

qmi_wwan part was accepted a while ago:

https://git.kernel.org/netdev/net/c/1ca645a2f74a

On 2024/8/3 15:46, ZHANG Yuntian wrote:
> Add support for MeiG Smart SRM825L which is based on Qualcomm 315 chip.
> 
> T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=5000 MxCh= 0
> D:  Ver= 3.20 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
> P:  Vendor=2dee ProdID=4d22 Rev= 4.14
> S:  Manufacturer=MEIG
> S:  Product=LTE-A Module
> S:  SerialNumber=6f345e48
> C:* #Ifs= 6 Cfg#= 1 Atr=80 MxPwr=896mA
> I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> E:  Ad=81(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=84(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
> E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=86(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
> E:  Ad=05(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=88(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
> E:  Ad=89(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
> E:  Ad=8e(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=0f(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> 
> Signed-off-by: ZHANG Yuntian <yt@radxa.com>
> ---
>   drivers/usb/serial/option.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 311040f9b9352..6811dbd2f4c08 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -621,6 +621,8 @@ static void option_instat_callback(struct urb *urb);
>   #define MEIGSMART_VENDOR_ID			0x2dee
>   /* MeiG Smart SLM320 based on UNISOC UIS8910 */
>   #define MEIGSMART_PRODUCT_SLM320		0x4d41
> +/* MeiG Smart SRM825L based on Qualcomm 315 */
> +#define MEIGSMART_PRODUCT_SRM825L		0x4d22
>   
>   /* Device flags */
>   
> @@ -2366,6 +2368,9 @@ static const struct usb_device_id option_ids[] = {
>   	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff, 0, 0) },
>   	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, LUAT_PRODUCT_AIR720U, 0xff, 0, 0) },
>   	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SLM320, 0xff, 0, 0) },
> +	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x30) },
> +	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x40) },
> +	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x60) },
>   	{ } /* Terminating entry */
>   };
>   MODULE_DEVICE_TABLE(usb, option_ids);

-- 
Best regards,

ZHANG, Yuntian

Operating System Developer
Radxa Computer Co., Ltd
Shenzhen, China

