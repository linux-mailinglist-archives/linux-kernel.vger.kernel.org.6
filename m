Return-Path: <linux-kernel+bounces-333436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014C097C897
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 13:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3406E1C24741
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 11:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776C719D096;
	Thu, 19 Sep 2024 11:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="D1Tb7bJu"
Received: from pv50p00im-ztdg10021101.me.com (pv50p00im-ztdg10021101.me.com [17.58.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C35199FD0
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 11:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726745236; cv=none; b=hcso66HANvNk7584AD+45xiEY63Q5rinje4/Ya4VSgDA0+Y2uU0/t68Uon0eqX5FRlyARiCGPr19TVql7nTh4+m0HMTl83FXpY+IskH4/xvOx0/aGSP4L2JVcI/eC5HM0X1ZGxvgLcLqKIXF/L/7UW9cYvasDqSI9NKDNlT6xkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726745236; c=relaxed/simple;
	bh=fgVpUcAySeIBeP8k8gsO91t2btH/xXxOVxiOXuh+m1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kdCOEbevqTn7XM3RHiHLR4g4U0mGEZ/paS8B02Kj+YazhHM+uMuHuIxCRt7yC13tQ0wFGJhpdJizZfxMdIKSC4aVFYPArpnP4UyVxJOJ6q69OZjc68a3duGey/AIaaQmm/5eWmBJueJGCXcSmMfh9oWE0cMEmhr0hwDXThATL+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=D1Tb7bJu; arc=none smtp.client-ip=17.58.6.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1726745235;
	bh=KdTvDYdRoGxP0L4oFQjsqH/WGJexNKEo7pYA5j9xk5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=D1Tb7bJu98fN+lzZqsHWZHZzF4uly7VEXIjKR+QB6Koljsz6pVl4XVP2TVn1jvvaK
	 OedVePhQ01AmvUXM8IKlq7nqcVYec5mn6ftTUsljra5n3MFBXRKYq16gw6hx+8dzxR
	 KArX3A/0/Qw2PyzOlo1SmHQQAcr+4OweDcwEpZSPsAZ4n6RN8f4QhusISYIqeEiXJj
	 TKViU8my938iLuUZbKNkmSAgC/1+iFSD9IRN8I2U348kB61d8RCaBbcsFWTfeCztiy
	 HIv39jKSCCRlIL+nzkkEE+G8kcjO+lIv+PXJuHQNDqENLpmsWFYHhdX5XMQP5KLAw2
	 AuOvNOJBsIixw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021101.me.com (Postfix) with ESMTPSA id E4C75D0032F;
	Thu, 19 Sep 2024 11:27:09 +0000 (UTC)
Message-ID: <f70ca3a8-2fe8-404c-8ead-7e7bc5417f52@icloud.com>
Date: Thu, 19 Sep 2024 19:27:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5] net: qcom/emac: Find sgmii_ops by
 device_for_each_child()
To: Paolo Abeni <pabeni@redhat.com>, Timur Tabi <timur@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240917-qcom_emac_fix-v5-1-526bb2aa0034@quicinc.com>
 <9b668881-b933-4bae-a0da-a107d2b531e9@redhat.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <9b668881-b933-4bae-a0da-a107d2b531e9@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HNOrW86dCj3dHNWGypTol5F5ngsr9IqW
X-Proofpoint-ORIG-GUID: HNOrW86dCj3dHNWGypTol5F5ngsr9IqW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-19_08,2024-09-18_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409190074

On 2024/9/19 16:26, Paolo Abeni wrote:
> On 9/17/24 03:57, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> To prepare for constifying the following old driver core API:
>>
>> struct device *device_find_child(struct device *dev, void *data,
>>         int (*match)(struct device *dev, void *data));
>> to new:
>> struct device *device_find_child(struct device *dev, const void *data,
>>         int (*match)(struct device *dev, const void *data));
>>
>> The new API does not allow its match function (*match)() to modify
>> caller's match data @*data, but emac_sgmii_acpi_match(), as the old
>> API's match function, indeed modifies relevant match data, so it is
>> not suitable for the new API any more, solved by implementing the same
>> finding sgmii_ops function by correcting the function and using it
>> as parameter of device_for_each_child() instead of device_find_child().
>>
>> By the way, this commit does not change any existing logic.
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> 
> ## Form letter - net-next-closed
> 
> The merge window for v6.12 and therefore net-next is closed for new
> drivers, features, code refactoring and optimizations. We are currently
> accepting bug fixes only.
> 
> Please repost when net-next reopens after Sept 30th.
> 
> RFC patches sent for review only are obviously welcome at any time.
>

thanks for your remainder. will post it after merge window is opened again.

and always welcome code reviewers to give comments before that.

(^^).

> See:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle


