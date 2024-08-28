Return-Path: <linux-kernel+bounces-305298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC38C962C8E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A366287222
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC227188CAF;
	Wed, 28 Aug 2024 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Yj45Lnl+"
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424D613C3D5
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859543; cv=none; b=KHbSqfNntsnVepZJtjaEMEoP8fnnXSVxySK1sQ7MHHXshgl5TcZ/KgQ9RTfQ4QL8rT/d5w992vchEN6Du6ZJm94/age97mpPWkixbA2ipDD+o7SMPcIjWqR52k/UjUnGDqIcPww6/ekid4hQjuAFVodWVA+HfSWqAthzP4JLkRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859543; c=relaxed/simple;
	bh=z3T/P26kCWt0cF5LnrM2IPK6DiNjzaAJMPDCeCPObCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tUGfvqLNULiUqmwjLjhjQ+BXOkLR1VqwILbgC5Q/WmVcu/bEw0GDDmd+kZ/dsT1tjd9kjiLWx4sTvzDvc8+K8VIngAlj059kvwGVdINH49jii5CvX+Wsd09LU4B1kPn+T7DK1GLqasagZROnklqmZv1tD31EvXgB6pHmU34ZgO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Yj45Lnl+; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1724859514;
	bh=oVnFuXZSAxbQ3NtiLiMpquUs3FMfEmgMHUpg/XfODWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Yj45Lnl+kTK3NV+uWm88Y1pkN9bL46RCe4RBqZrz8hdqVp0RreO8Ym2zd61Pi9uDT
	 nfGmyNVsjRBwCOobL9hDIhhMleQjj0HuWzMlsBsANDYPjkjGMuAy0bZTDMhHqWnHg6
	 RiIUm2XWm5Z6ZW/9V0tipTnx9i8+nvrPdTMZU4iY=
X-QQ-mid: bizesmtp81t1724859480t6l336za
X-QQ-Originating-IP: 0HJh7Yo1Jx8Lr3Nkdfttu+na0dkmiIavMKazTlQ2IrU=
Received: from [10.20.53.89] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 28 Aug 2024 23:37:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1561753365197894062
Message-ID: <23CC94B2018EE36C+e1d82597-6adf-4bcf-8e63-df788eb81bd0@uniontech.com>
Date: Wed, 28 Aug 2024 23:37:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdgpu: disable amdgpu_dpm on THTF-SW831-1W-DS25_MB board
To: Mario Limonciello <mario.limonciello@amd.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 daniel@ffwll.ch, lijo.lazar@amd.com, le.ma@amd.com, Jun.Ma2@amd.com,
 hamza.mahfooz@amd.com, andrealmeid@igalia.com, wenlunpeng@uniontech.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, guanwentao@uniontech.com, zhanjun@uniontech.com
References: <3EA7C2B9E8C4D00A+20240828105938.37674-1-wangyuli@uniontech.com>
 <e3122e5c-a6dd-4228-84ab-04747a3df265@amd.com>
From: WangYuli <wangyuli@uniontech.com>
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
In-Reply-To: <e3122e5c-a6dd-4228-84ab-04747a3df265@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1


On 2024/8/28 23:19, Mario Limonciello wrote:
> This is production hardware?

Unfortunately, this device was released quite a while back.
>
> Have you already checked whether a BIOS upgrade for the device could 
> help this issue?


Sadly, there's no BIOS update to address this problem. It seems to be a 
persistent issue across all BIOS versions for this motherboard.

>
> Just to clarify did you guys co-work on this patch, or are you 
> submitting on behalf of wenlunpeng?  It right now shows up as you 
> submitting on behalf of wenlunpeng.  If you co-worked on it you should 
> also use a Co-Developed-by tag.


No, the entirety of this bugfix is attributable to wenlunpeng.

>
> As this is suspected to be a BIOS issue, I would like to better 
> understand if the BIOS upgrade fixes it.  If it does but you would 
> still like a quirk for the system it should include the BIOS version 
> here.
>
>
Unfortunately again. There's not much we as kernel developers can do 
when devices behave unpredictably.

-- 

*WangYuli
*



