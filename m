Return-Path: <linux-kernel+bounces-371580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 640169A3CDD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931901C25CE7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F3720264A;
	Fri, 18 Oct 2024 11:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="CnXiQb3C"
Received: from mr85p00im-ztdg06011101.me.com (mr85p00im-ztdg06011101.me.com [17.58.23.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13079202625
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 11:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729249718; cv=none; b=BystRihcibzT4A4vnIK9D6/XAYVP2EDaHQxtOWvEc8xVJKxBJUDfniwybsrZd2TZP9ql8UnBDFNMUAZrYTjf/ZcwUxmWMfFfUpm6vd/K8AAzCFw8guGfqx8eV5xRM1upgzIZTYyTlQQqCpqD01V/Q/oExsLcDkTBZ/sNOXFzEo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729249718; c=relaxed/simple;
	bh=Mxf9I4r4giEtDh12J5oq7uYcjW/h34xDjYgPAK9SPHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gobQx53Eq9eyRta8rBmo8HJ0FAB0xwtw4CnUAqz5MTlgNzKgWOX/c0v81keEKUv0sI/Emeo3iSLnG0jCgd4FWyqhuCTlE87d++E0km3wk3CzZx81r4s6cClH8Zk7hbZQn3YTrd0CatUayFEzFWIgOXzUyLcy6t2Smr/w7C6G/9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=CnXiQb3C; arc=none smtp.client-ip=17.58.23.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1729249716;
	bh=FLdIyu97O2rmgekrw7fmsFrdbuoso+fiNKTZ3MkeyjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=CnXiQb3CmsMpAs6jshES3YoWBDRKXojnEPJpxWn3PVuk91U+aWU3fuyz69BrF0x30
	 8j9GFHFrAZrWLIsidwzOSDy4UTSZShORNvOISymOw0JJg999Jy4QH5xPF1GhHhCNYj
	 L0cadrroj7VKbvT2ISlXaZHDvtNhbDMGkw8v8Stx5i3Uf6bN/ZWBkfu1e3yZEcMuoF
	 mSzfRdvifdD8jdSMmmnjNLYv7S7mZYzhf/QHAlJSl7DpIS1rKqtasDGRXvF5E1hPQb
	 AcZVyo78BQbtO29Hhqw/RA0pXsECfCqKZYqzCxqDXOREL7cAi4zZavee6Oc+knFgfP
	 8HqYioDivvBfg==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011101.me.com (Postfix) with ESMTPSA id C6254DA02BC;
	Fri, 18 Oct 2024 11:08:34 +0000 (UTC)
Message-ID: <d55840b8-4cc8-4bac-bb20-6aa155688fdb@icloud.com>
Date: Fri, 18 Oct 2024 19:08:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] genirq/devres: Simplify API devm_free_irq()
 implementation
To: Thomas Gleixner <tglx@linutronix.de>,
 quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: linux-kernel@vger.kernel.org
References: <20241017-devres_kernel_fix-v1-1-4aa0d7c4fee4@quicinc.com>
 <87y12m8o76.ffs@tglx> <07f223e0-9a42-4637-a081-a057025e216f@icloud.com>
 <87sest94ag.ffs@tglx> <fa7268e4-24a9-4ddb-8477-e4959a6105ad@quicinc.com>
 <87plnx8yot.ffs@tglx>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <87plnx8yot.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: -keJ7pxBqHUTq0BPtxV2uWwON18x0bXU
X-Proofpoint-GUID: -keJ7pxBqHUTq0BPtxV2uWwON18x0bXU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_06,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015 mlxscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=818 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410180071

On 2024/10/18 18:58, Thomas Gleixner wrote:
> On Fri, Oct 18 2024 at 17:28, quic zijuhu wrote:
>> On 10/18/2024 4:57 PM, Thomas Gleixner wrote:
>> if irq to free was ever requested by devm_request_irq()
>> then both logic is exactly same.

[snip]

>> if (irq is not requested by devm_request_irq() {
>> 	warn;
>> 	return;
>> }
>>
> 
> Ah, you are right. I thought there is a return there.
> 
> So you want to explain it maybe this way:
> 
>    If devres_destroy() does not find a matching devres entry, then
>    devm_free_irq() emits a warning and tries to free the interrupt.
> 
>    That's wrong as devm_free_irq() should only undo what
>    devm_request_irq() set up.
> 
>    Replace devres_destroy() with a call to devres_release() which only
>    invokes the release function (free_irq()) in case that a matching
>    devres entry was found.
> 

thank you. good proposal, let me update commit base on it and send v2.

> Or something like that.
> 
> Thanks,
> 
>         tglx


