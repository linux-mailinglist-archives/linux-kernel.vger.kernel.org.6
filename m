Return-Path: <linux-kernel+bounces-184348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 611058CA5CA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15EBC281995
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 01:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5274C138;
	Tue, 21 May 2024 01:32:33 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B958814;
	Tue, 21 May 2024 01:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716255153; cv=none; b=BB90kgXWymFvChLWbmGTAiNWKJRk2fq1jynntzXTaRwn9Y4lK9ckZyKj3MkILTSjFdyziJlxrCJ+nsFLOJ0Q7Oqpvnkm6ampjteftPU3JNX8p2+rI5ESC0RFY4VIJB6L1hUlglOcxvVNUVfS6iAHqn911zf6ITFajob+L/cP6/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716255153; c=relaxed/simple;
	bh=IvdU1mR04Rm53UqVrqrAsPcYHZm2yrWPQHcHxfLoVq8=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=obLiVHJ6KRU40TJemutEA8j2oQd1AdC1CGp+Dc60HmIqXX0ZNxU8eOhO6yk/dwb+EpRtTtsedZWQrfGTY3BqoXcK/VbX/1dAzdp4lRy+Jp4tw6ji4aGs9oG/Vlfua7Z4yWmP18Y925AIIhPAy58ok8qE+bFOda14gu9YtlHTO4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Vjxff6Rs0z2Cj9t;
	Tue, 21 May 2024 09:28:58 +0800 (CST)
Received: from kwepemd500014.china.huawei.com (unknown [7.221.188.63])
	by mail.maildlp.com (Postfix) with ESMTPS id A27421A0188;
	Tue, 21 May 2024 09:32:26 +0800 (CST)
Received: from [10.67.121.2] (10.67.121.2) by kwepemd500014.china.huawei.com
 (7.221.188.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 21 May
 2024 09:32:26 +0800
Message-ID: <664BF9A9.3020206@hisilicon.com>
Date: Tue, 21 May 2024 09:32:25 +0800
From: Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Conor Dooley <conor@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Carvalho Chehab
	<mchehab+huawei@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 1/2] dt-bindings: soc: hisilicon: document hi3660-usb3-otg-bc
References: <20240518204443.122586-1-krzysztof.kozlowski@linaro.org> <20240520-bronzing-crumpet-c7b54753d2f1@spud>
In-Reply-To: <20240520-bronzing-crumpet-c7b54753d2f1@spud>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd500014.china.huawei.com (7.221.188.63)

Hi Conor,

On 2024/5/21 1:10, Conor Dooley wrote:
> On Sat, May 18, 2024 at 10:44:42PM +0200, Krzysztof Kozlowski wrote:
>> Add dedicated bindings for the Hisilicon Kirin 960 USB OTG Syscon,
>> to fully document the block and also fix dtbs_check warning:
>  
>>   hi3660-hikey960.dtb: usb3_otg_bc@ff200000: compatible: ['syscon', 'simple-mfd'] is too short
> 
>> +title: Hisilicon Kirin 960 USB OTG Syscon
>> +      - const: hisilicon,hi3660-usb3-otg-bc
> 
> I know you got it from the node name, what does "bc" mean here?

I think it might be the USB Battery Charging Specification.

Best Regards,
Wei

> Otherwise,
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 

