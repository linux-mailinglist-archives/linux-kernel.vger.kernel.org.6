Return-Path: <linux-kernel+bounces-407696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FC99C713B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DA76B24D11
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9440B200127;
	Wed, 13 Nov 2024 13:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="vO1lNR4U"
Received: from pv50p00im-ztbu10011701.me.com (pv50p00im-ztbu10011701.me.com [17.58.6.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D471F4705
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 13:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731505380; cv=none; b=ltmpSNnpUmjBqb2ak7+DPUIn2jK2lSslKqd3QIrcJEmYmZyzzsklneW9Wq6HW6hDjjI0MT8GBffIawBaSspHALSS/r2NGfeYyAI5WDzsZdf2g4j1LiWQNdHx+SmKMCKZi7wG2hLY/wRmxJu8QGZoIozczWzJ3c70tgm3gqFsbdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731505380; c=relaxed/simple;
	bh=b8f/uIwMoiv+fUu44rI80UIPZELBGJvD2pyEWHPCobw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zze7UkZmy7huYXkG95sj55sxCLoiZV+wrWpah+9ZXLbgfZTly24SIDjb9icNSf190CHMPzL4VHmvcGr13bvD4RvmuvsDRbWvlaMFgsfutiUiwd52dKvTHAFfJDOTw8DitoAsNaEZ2pLfb1mKne1F4QEZg2STWBqXMU81dhZV5Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=vO1lNR4U; arc=none smtp.client-ip=17.58.6.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1731505377;
	bh=BQ0nRqA8tf4463i4+IeVTSFdjma9nDLdlLthif5eCdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=vO1lNR4UUEte/81l+GZyocp0L1IIJ+26pYh1lEOc09MYQrcGMJTix/pEbkGIEmhTk
	 Tb9VPwfxYVeB5uYdaVUBbTID4gdW7i9xVkEdpebbCd4WqDgZ8x7aWnvrdfNm+bZSze
	 cWcIYt56HFT0OVAfoIIamJtGCzfqrNvV6rfS7wrV0U/5SE+9CzxM6bsSsvX4XrQ6NJ
	 EcTV+OdzrUM2vfJRhhdorkPVw0Z2Nji0fgLKWrp4v3WHZf65PgHJUUmZb/7THOo5x2
	 jjjAFfc5XOr+EtB2I2+Nk4od1wD2r7aCtMABvZDNHHmvNR0mdgGeBLN9WcWTahGQxs
	 E4Bc+Dqvp6XaA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztbu10011701.me.com (Postfix) with ESMTPSA id 4C4A3740203;
	Wed, 13 Nov 2024 13:42:54 +0000 (UTC)
Message-ID: <e35bb0d3-6628-4cab-910c-cf4e437be939@icloud.com>
Date: Wed, 13 Nov 2024 21:42:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 0/2] driver core: bus: Fix issues related to
 bus_rescan_devices_helper()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20241022-bus_match_unlikely-v2-0-1a6f8e6839a0@quicinc.com>
 <2024111228-snowcap-counting-b833@gregkh>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2024111228-snowcap-counting-b833@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jvmHbs0PxOYn4fOep1_CC_QZsZqwoVgW
X-Proofpoint-ORIG-GUID: jvmHbs0PxOYn4fOep1_CC_QZsZqwoVgW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_09,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411130117

On 2024/11/12 19:48, Greg Kroah-Hartman wrote:
> On Tue, Oct 22, 2024 at 07:18:00PM +0800, Zijun Hu wrote:
>> This patch series is to fix issues related to bus_rescan_devices_helper().
>>
>> The function is improperly used for 2 incompatible scenarios as
>> explained below:
>>
>> Scenario A: scan drivers for a single device user specify
>>  - user may care about precise synchronous scanning result, so the
>>    function can not collapse error codes.
> 
> I do not understand this, what is wrong that this is fixing?
> 

for scanning drivers for single device, it gives user wrong scanning
result(success or failure).

patch 1/2 is a concrete example.

>> Scenario B: scan drivers for all devices of a bus
>>  - user may need to scan drivers for a bus's devices as many as
>>    possible, so the function needs to ignore inconsequential error
>>    codes for a device in order to continue to scan for next device.
> 
> How often is that needed?  And why can't that still work with the
> existing code?
>

1) API bus_rescan_devices() invokes it and can't achieve its design
purpose due to error described above.

2) as shown by recent mainlined commit, usage of API
bus_rescan_devices() have been dropped due to some bugs.
Commit: 3d6ebf16438d ("cxl/port: Fix cxl_bus_rescan() vs
bus_rescan_devices()")

3) there are only 2 usages for the API now.
// does not do what the comments say
https://elixir.bootlin.com/linux/v6.11/source/drivers/pcmcia/ds.c#L725
// do multi repeated iterating, can be simplified if fix the API bugs
https://elixir.bootlin.com/linux/v6.11/source/drivers/hid/hid-core.c#L2967

4) i have more reply in below link about the API's bugs.
https://lore.kernel.org/all/20240913-bus_match_unlikely-v2-2-5c0c3bfda2f6@quicinc.com/

> thanks,
> 
> greg k-h


