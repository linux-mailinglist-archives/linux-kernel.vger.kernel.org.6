Return-Path: <linux-kernel+bounces-370695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFCB9A30D7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 00:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F86D2861A1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 22:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A891D86CB;
	Thu, 17 Oct 2024 22:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="CCemoVVQ"
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3011D86F1
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 22:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729204631; cv=none; b=s1sBH1n7o2GMrnUKJDOFGVPeXIEi8WZdoXiQT/+RwMSRcsOncODIpZ/MgZfdiVs9/SfWGpxEL3Aa6QObyJO5Gkyt8Z9OgmXYJlhF0Q7jSnUn8D637he0cVj7JI+b0O0m9B4MCSU6Q+RGqyGEpzSLvHH1hKBdi1C/WivXlKRpOgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729204631; c=relaxed/simple;
	bh=e5pZTJmxra79rtc8Bo4QvJuGghd9hDPDNd73bDBArb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QexOUh7dbWODpIRK/ucMTllHT4+2FHKh+K55ys2rDGZRBXND3aU0rQgNZzQUS6sYLKECb2s8UIYRYSTWNtfV69dOMWyapFolcOkLdDwhM5zZb5aFcw659vdR7Kr7xgixqcKLSn+665GYt+uNo2Zuv6q8CroMaq5JdaozT1kck9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=CCemoVVQ; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1729204626;
	bh=QDCKgxN1Mmg+bV+sZKLPCm9wm4bY0vVIBMoIIGdNbIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=CCemoVVQvHyplbLmB61sz1qUCqRoAPahY3yfL9/3W7eQSzn+r1psDEX1/dxTnYDja
	 VLH92uKbg3KO13oIcN3zvcM9rKqH0hzVK/FatmGnCuTFlwuSzTtK199JrhMXOv4ro1
	 tObl9knqb60xV3GbFDTTN3acoCVTf0x8b77HO8LGQPCoaN5UQ5DNdwSjVDiu/ql5cz
	 IwxO+n+R6yeCoQswNw8SCVEMyD/k0Q2O3Gps8sJIfVLTfc6Bcw/9dn5jzDZn9SwG5Y
	 fURzR6sWeRuv1ndikai5hRnSX38msFU+7Jx/4VD4rF3JCpzPL8lSmG0OjeS8zvITXn
	 f4mB4k+xLbkJA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 6069B4A01B1;
	Thu, 17 Oct 2024 22:37:02 +0000 (UTC)
Message-ID: <07f223e0-9a42-4637-a081-a057025e216f@icloud.com>
Date: Fri, 18 Oct 2024 06:36:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] genirq/devres: Simplify API devm_free_irq()
 implementation
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20241017-devres_kernel_fix-v1-1-4aa0d7c4fee4@quicinc.com>
 <87y12m8o76.ffs@tglx>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <87y12m8o76.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8YRhZ8o7DdNcAWwIyusUMaVYFUVhsuRu
X-Proofpoint-GUID: 8YRhZ8o7DdNcAWwIyusUMaVYFUVhsuRu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_25,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 mlxlogscore=700
 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410170153

On 2024/10/18 04:33, Thomas Gleixner wrote:
> On Thu, Oct 17 2024 at 23:16, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> Simplify devm_free_irq() implementation by dedicated API devres_release()
>> which have below advantages than current devres_destroy() + free_irq().
>>
>> It is simpler if devm_free_irq() is undoing what any devm_request_irq()
>> variant did, otherwise, it can avoid wrong and undesired free_irq().
> 
> This is confusing at best. What's the wrong an undesired free_irq()?
> 

thanks for code review.

for current devm_free_irq(..., irq_A, ...):
it is undesired if irq_A is requested by request_irq().
it is wrong and dangerous if irq_A was never requested.

sorry to have confused commit message.
any suggestion to correct it ? (^^)

> Thanks,
> 
>         tglx


