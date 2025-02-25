Return-Path: <linux-kernel+bounces-531325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A721A43F0B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F2A63B0712
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3B8267731;
	Tue, 25 Feb 2025 12:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="e+uRd4ZU"
Received: from pv50p00im-tydg10021701.me.com (pv50p00im-tydg10021701.me.com [17.58.6.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263551DD874
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740485857; cv=none; b=B/IY15L82itr18cp15hOdxUf5pnEJL0khHyM2p7NoefLO35TeDTq/2CQCnkhXiyBj2HC2BWEXdX+pzD5r2xjRvmLNUcU2EakkTdrPenqFc+mhha0O7Rpy+rZFKZEoDzfHFfrWkX2vRzcEyZ7eyKCWLonzanEpJ0cD7roGuX0138=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740485857; c=relaxed/simple;
	bh=icoN91cmWBN01191An2uItH1mFg3GCSkgD5Hl99R4Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XXv1XvTwDA10gDdRzeAZy4GhjX8waQR9SJTugR7ScG2P1+tiTzJY0czAqMDDutPan83Iek/tkuCDG5ZSs2784oTNu4ZM1XV3WG8z3k+9ieKa3fXkdl8GhM4sh2MaX4e2Xwi4wytQv7D7gq15VdpdlHsLLJhI6ci3RRTumNkFTWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=e+uRd4ZU; arc=none smtp.client-ip=17.58.6.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=tQVDiJM72BgasMuPn0E8GujAR5KguG27heLo2tUkt5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=e+uRd4ZU1VAu519YY62aDnwBuPiGbz+bWxHHbAjdrshEv4Kcxex2SYMGVfqezk73J
	 ygl2jG3IJjwWNCQJDuTijwEP73BcKmDpsXY9dWTUMIiCIw2HfIPvW0ML+Bp1eDcN3q
	 F/8OifILc0jpE5naSoXySxq9cjW49Cp+w39hqL2vtbOWy9n67r0c+fDCd1v5BeQNMY
	 IJ3sUJnuAawDrU0UTfM2LMRHKhYdtrQZ7lgpyjL1MtLd6lJyv8sfYsUZ+aeNFGICwv
	 xmNNQQaHwQYTR4vI4Xvma20mtK3cWNHiGEIQnuKbPXZfxZ50zM0apj/r5fznqVezNT
	 2EKweQKkHkG5Q==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id 45652CC6951;
	Tue, 25 Feb 2025 12:17:28 +0000 (UTC)
Message-ID: <4e6ed786-4e72-4f22-9ce1-cdf6c384a5bb@icloud.com>
Date: Tue, 25 Feb 2025 20:17:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] of: fix bugs about refcount
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>,
 Stefan Wiehler <stefan.wiehler@nokia.com>, Tony Lindgren <tony@atomide.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Julia Lawall <Julia.Lawall@lip6.fr>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>,
 stable@vger.kernel.org
References: <20250209-of_irq_fix-v2-0-93e3a2659aa7@quicinc.com>
 <20250224232645.GA117818-robh@kernel.org>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20250224232645.GA117818-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: buODABNUr5CF9BrUMMIQ-7sGwBIbv_Rh
X-Proofpoint-ORIG-GUID: buODABNUr5CF9BrUMMIQ-7sGwBIbv_Rh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=834
 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502250086

On 2025/2/25 07:26, Rob Herring wrote:
>> ---
>> Zijun Hu (9):
>>       of: unittest: Add a case to test if API of_irq_parse_one() leaks refcount
>>       of/irq: Fix device node refcount leakage in API of_irq_parse_one()
>>       of: unittest: Add a case to test if API of_irq_parse_raw() leaks refcount
>>       of/irq: Fix device node refcount leakage in API of_irq_parse_raw()
>>       of/irq: Fix device node refcount leakages in of_irq_count()
>>       of/irq: Fix device node refcount leakage in API irq_of_parse_and_map()
>>       of/irq: Fix device node refcount leakages in of_irq_init()
>>       of/irq: Add comments about refcount for API of_irq_find_parent()
>>       of: resolver: Fix device node refcount leakage in of_resolve_phandles()
>>
>>  drivers/of/irq.c                               | 34 ++++++++++---
>>  drivers/of/resolver.c                          |  2 +
>>  drivers/of/unittest-data/tests-interrupts.dtsi | 13 +++++
>>  drivers/of/unittest.c                          | 67 ++++++++++++++++++++++++++
>>  4 files changed, 110 insertions(+), 6 deletions(-)
> I've applied the series. I made a few adjustments to use __free() 
> cleanup and simplify things.

thank you, LGTM for all adjustments but perhaps a mistake fixed by
https://lore.kernel.org/all/20250225-fix_auto-v1-1-cf8b91a311dd@quicinc.com/

