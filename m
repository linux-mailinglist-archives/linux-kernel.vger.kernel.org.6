Return-Path: <linux-kernel+bounces-323049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C1C9736F7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3075CB21464
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1F318C34D;
	Tue, 10 Sep 2024 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="rMwrteU8"
Received: from pv50p00im-zteg10021401.me.com (pv50p00im-zteg10021401.me.com [17.58.6.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C00184535
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 12:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725970632; cv=none; b=GJl3cTJi45Sq4yCiuA/pwOby9+oB8PELrRLMABVhyJl19/FMnkPsMhvLmX1fKiqFI+OtyhfXaeFjIhmt2Feq4pfFXLmTM56YZbfdMNbNYBaDGwtSwVWAKvLruBtIP+PhNjlOqsaWH2zuYy0Jyt3RV2i3PD2deDHWc4PechDd5Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725970632; c=relaxed/simple;
	bh=n8ccMPdrqjWagb7Gnusd0ZEmZYWOHUlDblW9jJvz3XM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dvhdqCUDWXN9eC//MyEm9Jhk1LTG53VA9z2SKdYIy7rGbxy2VuMepo0w4F2Y8E6FvlI+LPYf76edxftnCgmhyltJDx22+GSKIn5F0zAyYTlshsLyev70qMFArDAWo4kqbzcn+7FhJZlu28C2sKey7b68vjAeV8/7RFtRD6C6o3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=rMwrteU8; arc=none smtp.client-ip=17.58.6.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1725970630;
	bh=VdbQWCifCXTK345XinwfONjo5u30zhHADcq684HbxNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=rMwrteU8nFvpBMjkRyCGZ4zqtVZDPLtZ1N9MZ7XqAdf3RIaKhu5gOVYMehAAWjXdX
	 dgdrpImlXHybFpLSYzy8zgLDhjV58mr5dXjHcSFHrLKp/f091bErujHYPQOe05tagm
	 p+tozQF13vsKachWc9pFTpAszKz8FZxsAfnfzENCnoyQoRkBf9L83AfbZKjgU4yNph
	 dD3oGpRAWDFs/JfbJ24giUuOM64zY9kX0FPAxjS7bJTjg2X4m1jcTGSLi+JeiqsCWQ
	 qF2U4hQruYlihzNl90b5aMuo9DhKo7HAxR6nY9TYlDDVYin/Roxp+YjTefuYaoIBNp
	 u3719KzkJm9LA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021401.me.com (Postfix) with ESMTPSA id 1AF548E05E8;
	Tue, 10 Sep 2024 12:17:05 +0000 (UTC)
Message-ID: <a4cf15fb-bbaa-4ed0-a1d5-c362b7a5c6e2@icloud.com>
Date: Tue, 10 Sep 2024 20:17:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] amba: bus: Move reading periphid operation from
 amba_match() to amba_probe()
To: Saravana Kannan <saravanak@google.com>
Cc: Russell King <linux@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Isaac Manjarres <isaacmanjarres@google.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240909-fix_amba-v1-0-4658eed26906@quicinc.com>
 <CAGETcx9X0m3=8PPtVsHp=AAjyCoUZ0-53H5RzVd4HCDtWRS0Fw@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <CAGETcx9X0m3=8PPtVsHp=AAjyCoUZ0-53H5RzVd4HCDtWRS0Fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lwr0WyOi-HHk38bBnKuWCMo9Hvp5I_Fo
X-Proofpoint-ORIG-GUID: lwr0WyOi-HHk38bBnKuWCMo9Hvp5I_Fo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_04,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 clxscore=1015
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409100091

On 2024/9/9 15:24, Saravana Kannan wrote:
> On Sun, Sep 8, 2024 at 4:38 PM Zijun Hu <zijun_hu@icloud.com> wrote:
>>
>> This patch series is to make amba_match(), as bus_type @amba_bustype's
>> match(), also follow below ideal rule:
>>
>> bus_type's match() should only return bool type compatible integer 0 or
>> 1 ideally since its main operations are lookup and comparison normally.
>>
>> Which has been followed by match() of all other bus_types in current
>> kernel tree.
> 
> The intent or need for this patch series is completely unclear. The
> code you are moving around was also pretty delicate and hard to get
> right.
> 
> Without a much better description for why we need this, I'd like to
> give this a NACK.
> 
> Also, patch 3/3 is not at all easy to understand and seems to be doing
> way more than what the commit message is trying to do.
> 

thanks for your code review.

let me explain the issue here firstly to go on with discussion, will
correct it by next revision.

amba_match(), as bus_type @amba_bustype's match(), operate hardware to
read id, may return -EPROBE_DEFER consequently.

this design is not very good and has several disadvantages shown below:

1) it is not good time to operate hardware in a bus_type's match().
   hardware is not ready to operate normally in a bus_type's match()
   as driver_probe_device() shown, there are still many preparations
   to make hardware to operate after a bus_type's match(), for example,
   resuming device and its ancestors, ensuring all its suppliers have
   drivers bound, activating its power domain, ...

2) it should not operate hardware in a bus_type's match().
   a bus_type's match() will obviously be triggered frequently, and
hardware operation is slow normally, it will reduce efficiency for
device attaching driver if operate hardware in a bus_type's match().

   a bus_type's match() will become not reentry for a device and driver
   if operating hardware is failed but can't recover initial hardware state.

3) for driver_attach(), a bus_type's match() are called without
   device_lock(dev) firstly, it often causes concurrent issue when
operate hardware within a bus_type's match(), look at below AMBA related
fix:
   Commit: 25af7406df59 ("ARM: 9229/1: amba: Fix use-after-free in
amba_read_periphid()")
   which introduce an extra @periphid_lock to fix this issue.

4) it may not be proper for a bus_type's match() to return -EPROBE_DEFER
which will stop driver API bus_rescan_devices() from scanning other
remaining devices, that is not expected as discussed by below thread:

https://lore.kernel.org/all/20240904-bus_match_unlikely-v1-3-122318285261@quicinc.com/

5) amba_match() is the only bus_type's match which breaks below ideal
rule in current kernel tree:
   bus_type's match() should only return bool type compatible integer 0
or 1 ideally since its main operations are lookup and comparison normally.


Our purpose is to solve this issue then enforce the ideal rule mentioned
in 5).

so we send this patch series to start a topic about how to solve this
issue (^^).

> -Saravana
> 



