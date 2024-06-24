Return-Path: <linux-kernel+bounces-226516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F16913F91
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 02:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A76412817D2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 00:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEC41C2E;
	Mon, 24 Jun 2024 00:35:11 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4B2646;
	Mon, 24 Jun 2024 00:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719189311; cv=none; b=cs1c3uIcjs/YTFwSt6mrOdh9nWA5VCeZU1PMBHo0TjKDC60MjmwLYh2uhYPDGKsn+6/CNQ2oUD2x4UqZrKOobIlbqtNXjxIYN/wrUz5SQbtlUlLomUc0Z8nLLIYTXXgnBd3fLE75TDpNjGfW02WrrVEsDEYHnevLLiJ3+hr5JMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719189311; c=relaxed/simple;
	bh=3lSzublKdlhnIF8lHSe7BLk/CTyH+T1oOQ9ZcOTKUOs=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=DjrXMqEkL8v7MHPOYpAcKOdEw7wz/1eSUNHCRZQJDYbGakdBRzbk27qfIYMS5TZn58kdZzfEbFD+Yiv9DWBD52A2n8mFbqUEGEhiPqC8CQuilqv/hzewXEVULzXYJ74c+bYRjn93bXu8cWoGua6oTpxDUiSoZ0wXY++47DEh550=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W6prd0wKlznX5W;
	Mon, 24 Jun 2024 08:34:57 +0800 (CST)
Received: from kwepemd500014.china.huawei.com (unknown [7.221.188.63])
	by mail.maildlp.com (Postfix) with ESMTPS id 9CBEC1400D6;
	Mon, 24 Jun 2024 08:34:59 +0800 (CST)
Received: from [10.67.121.2] (10.67.121.2) by kwepemd500014.china.huawei.com
 (7.221.188.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 24 Jun
 2024 08:34:59 +0800
Message-ID: <6678BF32.10609@hisilicon.com>
Date: Mon, 24 Jun 2024 08:34:58 +0800
From: Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Carvalho Chehab <mchehab+huawei@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 1/2] dt-bindings: soc: hisilicon: document hi3660-usb3-otg-bc
References: <20240518204443.122586-1-krzysztof.kozlowski@linaro.org> <171914563307.48201.2100106894701016613.b4-ty@linaro.org>
In-Reply-To: <171914563307.48201.2100106894701016613.b4-ty@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd500014.china.huawei.com (7.221.188.63)

Hi Krzysztof,

On 2024/6/23 20:27, Krzysztof Kozlowski wrote:
> 
> On Sat, 18 May 2024 22:44:42 +0200, Krzysztof Kozlowski wrote:
>> Add dedicated bindings for the Hisilicon Kirin 960 USB OTG Syscon,
>> to fully document the block and also fix dtbs_check warning:
>>
>>   hi3660-hikey960.dtb: usb3_otg_bc@ff200000: compatible: ['syscon', 'simple-mfd'] is too short
>>
>>
> 
> One month waiting, so I'll take this one as well.
> 
> Applied, thanks!

Fine to me.
Thanks!

Best Regards,
Wei

> 
> [1/2] dt-bindings: soc: hisilicon: document hi3660-usb3-otg-bc
>       https://git.kernel.org/krzk/linux-dt/c/7613195d37d69ff92c9bc55599037615212ce19c
> [2/2] arm64: dts: hisilicon: hi3660: add dedicated hi3660-usb3-otg-bc compatible
>       https://git.kernel.org/krzk/linux-dt/c/bc9ec165d066af29661ece91f9cbf74e18ec0a5a
> 
> Best regards,
> 

