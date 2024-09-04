Return-Path: <linux-kernel+bounces-315434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A66196C2B2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18467281E49
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268DC1DEFCE;
	Wed,  4 Sep 2024 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="rqSGbcW4"
Received: from pv50p00im-zteg10021301.me.com (pv50p00im-zteg10021301.me.com [17.58.6.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8C91EC017
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464574; cv=none; b=iG0qiOzj2Iksg/sg0XrltVVSLNVNz6VSW89nzFrs04mMvhSV0+6n5vIMh3Y4s+EQcPlS5NnjBG8y/A/70zMG2e8apHIZwyw3sDC6qvqVbk4N4hW8ow7rsApO61tX9L6SknDRD2OztBGLUIFXjL9FzIR0fxY5bsaxmPg2RHnscBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464574; c=relaxed/simple;
	bh=c47YgnVj7bLi89JJ+f8/PcYHC/sb8Dn8Ph7vHEJCWIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L+lHR1aKodE+eh2HBvlmcknFmjXQ2Nf8wUXhf/DlHjJFz3NnY3SLKIHauOddLhhwhccNslIIAjSepMeQuaYmNuPzgMWLrHyoxy5OyqR71rg4iZI1uaMoKvlnNaMOuwVrgczpgqk4tIitC4XS4J9KGfRfDHVNQQ6ATyNGW8CJo+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=rqSGbcW4; arc=none smtp.client-ip=17.58.6.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1725464572;
	bh=KUEEThO+wIFUIInS4RaKW89uvFojRITiRf5ABc/++DU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=rqSGbcW4ynU8oAbm8CZuQw/TlVJfgaCUoHHbQjJxC1HzP6pQxohxjpbrD53O5sHJl
	 4SvSCUX1oCeXD3OdXeu+L6qkSHGiWouhYiOhEtsDhsaxWz1QLidYFaEGXFpWvJADKk
	 Y708jZ/y586E8XKboy0d1n3ST2ZbXqKLR3G+gbPhoLLYsCtpPElUeZUu2I1o9vrQZX
	 XYVgHjgFbMMDHiA4mcZbidMZa5WoNmvp20AeZGgfIUAV0Ji96bRTM3S/D0QyYdM/D3
	 t1pu9p64vGUrg5p+LJuN8iTCh4IY4jcy9iRyOyCju0lNf0CszoRtIElmNPbFtORe82
	 clENC0QPoYBaQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021301.me.com (Postfix) with ESMTPSA id 30242500113;
	Wed,  4 Sep 2024 15:42:47 +0000 (UTC)
Message-ID: <b4106831-f1bd-44d9-aed7-18097d3ddead@icloud.com>
Date: Wed, 4 Sep 2024 23:42:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] driver core: bus: Correct API bus_rescan_devices()
 behavior
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240904-bus_match_unlikely-v1-0-122318285261@quicinc.com>
 <20240904-bus_match_unlikely-v1-3-122318285261@quicinc.com>
 <2024090403-viewing-snagged-4249@gregkh>
 <1b79fb55-26d7-4966-9260-d3cdf3e0e8c8@icloud.com>
 <2024090410-earphone-financial-9b72@gregkh>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2024090410-earphone-financial-9b72@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: nAeTjKo62a6CMd1-c-HiD1nxya89IJ1a
X-Proofpoint-ORIG-GUID: nAeTjKo62a6CMd1-c-HiD1nxya89IJ1a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_13,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2409040119

On 2024/9/4 22:44, Greg Kroah-Hartman wrote:
> On Wed, Sep 04, 2024 at 10:26:39PM +0800, Zijun Hu wrote:
>> On 2024/9/4 21:54, Greg Kroah-Hartman wrote:
>>> On Wed, Sep 04, 2024 at 08:56:44PM +0800, Zijun Hu wrote:
>>>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>
>>>> API bus_rescan_devices() should ideally scan drivers for a bus's devices
>>>> as many as possible, but it really stops scanning for remaining devices
>>>> even if a device encounters inconsequential errors such as -EPROBE_DEFER
>>>
>>> -EPROBE_DEFER should not be an issue for scanning the bus, that's only
>>> for probe errors, so who is returning that mess today?  Let's fix that
>>> up please.
>>>
>>
>> drivers/amba/bus.c:
>> struct bus_type amba_bustype = {
>> ...
>>         .match          = amba_match,
>> ...
>> };
>> amba_match() may return -EPROBE_DEFER.
> 
> Why?  That feels wrong.
> 

i have below understanding after reading drivers/amba/bus.c.

amba_device_add() needs to read ID from device to add device.
but resources such as clocks may be not ready to read ID at that time

so it registers a empty amba_driver @amba_proxy_drv which will trigger
reading ID within bus_type match() when add a device by amba_device_add()

bus_type match() will defer device probe when resources is not ready
during match().

at deferral probe() time, match() is able to read ID since resources is
ready at that time, and it notify device adding by uevent to user.

user loads matched driver for the device which has ID read out.

>> you maybe also look at below AMBA bus related commit.
>> Commit: 656b8035b0ee ("ARM: 8524/1: driver cohandle -EPROBE_DEFER from
>> bus_type.match()"
> 
> Ah, ick, clocks.  What a mess.
> 
> I don't think we need this anymore with the genric device link stuff
> anymore, but I'm not quite sure.
> 
yes, i agree with you.

>> is it proper to change bus_type match()'s return value type to bool type
>> back if this issue is fixed?
> 
> Yes, I would like to.  Care to look into it, odds are you can test this
> better than I can :)
> 
actually, i also does not have AMBA test environment. let me send a AMBA
patch to start a topic to check if AMBA maintainers have good ideas to
help us at spare time.

> thanks,
> 
> greg k-h


