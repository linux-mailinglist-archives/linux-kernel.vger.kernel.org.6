Return-Path: <linux-kernel+bounces-295714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 465C795A06E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8DD41F23D57
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC371B1D73;
	Wed, 21 Aug 2024 14:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="JV7CeYCS"
Received: from pv50p00im-tydg10011801.me.com (pv50p00im-tydg10011801.me.com [17.58.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DD11B1D64
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251924; cv=none; b=u2+FRtJqgodxX5twN/0ahf6V2a+iAAx4uWoiE5+QSw96BOt6Iu15IcI+ZT1fMZ1hvqKwyFR1JmeiF4lg8WCVoZK5gvX5mwhxBxB0O0AksZWTRTuKZdniYpJQ9RrudJdtd++Sp28ZAKmm7YKpB57/dLoKf8sbOwrbeIcpQsFa0XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251924; c=relaxed/simple;
	bh=cAe4zutHiTFOldOw8OIYeP6nHglezjVJDH5hwaR2zow=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OquAfIjGtxzS+TgGUtyCjHG3v2dMBLFLAoBiByQOLEnXHUcCn966XSzpItXQVijpLuiWrR7N8n1iBw+UI8SzJWunhfRoEGfVUq6koFJ36e8Z7XgI71sN6MgLgqcSlDhWzT+gQhP6lzJcpt6mTVYX9045239nFKg57Nya/Lv2Fyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=JV7CeYCS; arc=none smtp.client-ip=17.58.6.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1724251923;
	bh=1qzVLmPcfgqexViD0ryfRgr8EsvTrfZVm2NgxJ3Vfss=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=JV7CeYCSvOqGF6F1mkrkdnHPOqbAi2jUmZdbAsHABUP/qrkVPAGHeINAobgsapwHH
	 n1jIjIeJM+xqU5Cxy71HWCsEh+E7eNzhsVqOb3MmoAYuUGOn/69uYpbXufa1PGuB2y
	 kUrFvyMgDrKCoiPP3jmLTUNFbadvOdY6uiZpAtpwXangRs6r8MJUMCgh76yrZygndK
	 C/DcX65+acZpaUUN98FT6sw90kyGZVXJDANePUzdg6BUD3iCeHL1dbBWJPIOdUDLWm
	 wjRhFFjxhAHsVg6nssPv53YmujEVmvd7/EPOHDOlRFlAldXhoe/zNt2TbCM2C8fpuM
	 ZdXcpaLcYvg0g==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10011801.me.com (Postfix) with ESMTPSA id 709FE800301;
	Wed, 21 Aug 2024 14:51:58 +0000 (UTC)
Message-ID: <225214d0-e51e-4a9e-a600-fcea304d5c64@icloud.com>
Date: Wed, 21 Aug 2024 22:51:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] firewire: core: Prevent device_find_child() from
 modifying caller's match data
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240815-const_dfc_prepare-v2-0-8316b87b8ff9@quicinc.com>
 <20240815-const_dfc_prepare-v2-3-8316b87b8ff9@quicinc.com>
 <20240821142920.GB48808@workstation.local>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20240821142920.GB48808@workstation.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6oU8H3gEjzIZmwIG8KaaQKuN4ZK_lrFn
X-Proofpoint-ORIG-GUID: 6oU8H3gEjzIZmwIG8KaaQKuN4ZK_lrFn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_11,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408210108

On 2024/8/21 22:29, Takashi Sakamoto wrote:
> Hi,
> 
> On Thu, Aug 15, 2024 at 10:58:04PM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> To prepare for constifying the following old driver core API:
>>
>> struct device *device_find_child(struct device *dev, void *data,
>> 		int (*match)(struct device *dev, void *data));
>> to new:
>> struct device *device_find_child(struct device *dev, const void *data,
>> 		int (*match)(struct device *dev, const void *data));
>>
>> The new API does not allow its match function (*match)() to modify
>> caller's match data @*data, but lookup_existing_device() as the old
>> API's match function indeed modifies relevant match data, so it is not
>> suitable for the new API any more, fixed by implementing a equivalent
>> fw_device_find_child() instead of the old API usage.
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>  drivers/firewire/core-device.c | 37 +++++++++++++++++++++++++++++++++++--
>>  1 file changed, 35 insertions(+), 2 deletions(-)
> 
> Please drop this patch from your series since I applied another patch[1] to
> for-next branch.
> 

okay, let me declare [PATCH v2 3/4] are abandoned here now.

i will drop it from the next version patch series (^^).

> 
> [1] https://lore.kernel.org/r/20240820132132.28839-1-o-takashi@sakamocchi.jp
> 
> Thanks
> 
> Takashi Sakamoto


