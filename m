Return-Path: <linux-kernel+bounces-449803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A259F5652
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8D817A3A3F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC451598F4;
	Tue, 17 Dec 2024 18:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="mAVt18oh"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EFB442F
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 18:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734460269; cv=none; b=guj5KTWmH7Ih65ac4DrvdwhUICCP1ogHO2czHd1EMx9eD4TeYUMT+s+9lUEYuaFtDTialjvndUtJH+y34vCxzVoOxSW2V5MV4spRaZQkWaybGsHeFxqf8cqkLUZPhCsveStQSOo9DxoY3YRNR91Glerhy1kxCs7/SQmEXfA5hUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734460269; c=relaxed/simple;
	bh=Pe6tvbhsMmToE+mb1CKNBDUIKPcCIvGQehInaITBRSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A5HqOz7Z4Z8Fp8wlAuUoNa4hJwblD9wkXsZtedDcck9YYuSC4RNqH4uN4w6dPBKRBfe8gc9/N82lr+/BRXU/XL0y3TAkWsVWfKq0GYKovyrgBuGrU0CuDdZhudaxwg22dqtJ0qY4YuxrXQoq2idcRXCNgAi36kdvSCVvs4LhdPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=mAVt18oh; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id NE1XtdprYvH7lNcLTtLeDs; Tue, 17 Dec 2024 18:31:00 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id NcLStobmOWvXpNcLTt9HSr; Tue, 17 Dec 2024 18:30:59 +0000
X-Authority-Analysis: v=2.4 cv=LtdZyWdc c=1 sm=1 tr=0 ts=6761c363
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GtNDhlRIH4u8wNL3EA3KcA==:17
 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=7T7KSl7uo7wA:10 a=NEAV23lmAAAA:8
 a=_Wotqz80AAAA:8 a=VwQbUJbxAAAA:8 a=Eymyif60OLRgAUHZ3uAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=buJP51TR1BpY-zbLSsyS:22 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=E2r8Z9qRGeJk2+J3GMCUCiaRUUtYxFm6EV4/xEqs6Fg=; b=mAVt18ohtS0DMAjMZPXetI/HfX
	TouWZY9yaGjH2qj1txnaY+qsuiZnYDbaSi6nulYgSXo41wWXAO4dUeQuxAULAJI90MsXDroCQMqM/
	s3Btq9PysEbDnNeHiXpyjunMCceryvc1OCOSBpBO84cWF3Ksxk+ryqNScvpucJIFrD9zZOE/SiOyQ
	4P6zGezbDP0385nZ2T5iP2BJHIrEwYo1P8c8Wt4Z9K5uaxYIKhdkvX4ysxxhcZzCRD/Tuj8gZg4ik
	iMSBFKAWZ94dk3PhFgI8Z4+zsG5nnGle/zni3te70RMW7GyLGdiRuG6NLZgEyExnKEwlOhmw5jtC2
	ln+oR60g==;
Received: from [177.238.21.80] (port=16484 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tNcLR-001oj4-2N;
	Tue, 17 Dec 2024 12:30:57 -0600
Message-ID: <49add42f-42d9-4f34-b4ad-cff31e473f40@embeddedor.com>
Date: Tue, 17 Dec 2024 12:30:54 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] UAPI: net/sched: Open-code __struct_group() in flex
 struct tc_u32_sel
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 cferris@google.com, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20241217025950.work.601-kees@kernel.org>
 <f4947447-aa66-470c-a48d-06ed77be58da@intel.com>
 <bbed49c7-56c0-4642-afec-e47b14425f76@embeddedor.com>
 <c49d316d-ce8f-43d4-8116-80c760e38a6b@intel.com>
 <ff680866-b81f-48c1-8a59-1107b4ce14ff@embeddedor.com>
 <b9a20b9e-c871-451d-8b16-0704eec27329@intel.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <b9a20b9e-c871-451d-8b16-0704eec27329@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.21.80
X-Source-L: No
X-Exim-ID: 1tNcLR-001oj4-2N
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.21.80]:16484
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBJ5Vhu1ri58UTYPGlgPTdUiHCae1WYSR6Zu68StlHLgJ5pUSCsFtZvXIVi3MTLQERCqIM8W/yuIuBEutjlgS7qO1aXj9FmOBF4kFGQozF52Fr62fw5O
 GQoCNJ54ibtj6ZwGZuofm+UaiT4n54vyHEM4P8Zam6P9gNVKRpEc0S0KmDBnrRwQozQffy48JATSOz+Tnvz3D6+j11zhZiwCTB+sRw840Ww+0ZiTlpw6UYSd



On 17/12/24 10:54, Alexander Lobakin wrote:
> From: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Date: Tue, 17 Dec 2024 10:25:29 -0600
> 
>>
>>
>> On 17/12/24 10:04, Alexander Lobakin wrote:
>>> From: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>> Date: Tue, 17 Dec 2024 09:58:28 -0600
>>>
>>>>
>>>>
>>>> On 17/12/24 08:55, Alexander Lobakin wrote:
>>>>> From: Kees Cook <kees@kernel.org>
>>>>> Date: Mon, 16 Dec 2024 18:59:55 -0800
>>>>>
>>>>>> This switches to using a manually constructed form of struct tagging
>>>>>> to avoid issues with C++ being unable to parse tagged structs within
>>>>>> anonymous unions, even under 'extern "C"':
>>>>>>
>>>>>>      ../linux/include/uapi/linux/pkt_cls.h:25124: error: ‘struct
>>>>>> tc_u32_sel::<unnamed union>::tc_u32_sel_hdr,’ invalid; an anonymous
>>>>>> union may only have public non-static data members [-fpermissive]
>>>>>
>>>>> I worked around that like this in the past: [0]
>>>>> As I'm not sure it would be fine to fix every such occurrence manually
>>>>> by open-coding.
>>>>> What do you think?
>>>>
>>>> The thing is that, in this particular case, we need a struct tag to
>>>> change
>>>> the type of an object in another struct. See:
>>>
>>> But the fix I mentioned still allows you to specify a tag in C code...
>>> cxgb4 is for sure not C++.
>>
>>
>> Oh yes, I see what you mean. If it works, then you should probably
>> submit that
>> patch upstream. :)
> 
> I added it to my CI tree and will wait for a report (24-36 hrs) before
> sending. In the meantime, feel free to test whether it solves your issue
> and give a Tested-by (or an error report :)).

Hopefully, Christopher can confirm whether this[0] resolves the issue he's seeing.

> 
> BTW, I mentioned in the commit message back in 2022 that some C++
> standards support tagged structs with anonymous unions (I don't remember
> that already). Would it make sense to use a separate #define not for the
> whole __cplusplus, but only for certain standards?

I'd say entirely preventing C++ from seeing the tag is cleaner and safer for
now.

Thanks
-Gustavo

[0] https://github.com/alobakin/linux/commit/2a065c7bae821f5fa85fff6f97fbbd460f4aa0f3

