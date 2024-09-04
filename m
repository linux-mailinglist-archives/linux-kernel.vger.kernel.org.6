Return-Path: <linux-kernel+bounces-315136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B79B96BE6C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E996F1F25B2A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4E61DA310;
	Wed,  4 Sep 2024 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Le3ZznkA"
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D8D1CF7D3
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725456337; cv=none; b=rXw5rTT2sVHcP/xkPSz6xCtgK42ulVwxXw9WPG3/RQ5pxhyo6iBFuC8129Y8bBcX3pXeAIW5tT0BfK3tU+sIggqAPEBns3wma8V02NQSdu0h0gNihiHsiozAdkjS+ISYDn2HkB2BfRlnCt5xWw3mW4IAGEooJhLS036/gmAip2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725456337; c=relaxed/simple;
	bh=FlgrDQcSxKgRgYoRbHOBjlo5GcyidQXFR1nRBrqJves=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XF3g+zigGNTkEQajald0y0tZukzSwA1KP5DC9mg3+MtXp/w/uWPPjKpUYSp0kssklHDNa3RfKktP0yC5oLa3AKRNi6MOV2nW1qkFv7gCjAmykcZtIu5K+F8cbgV2GkvGRzvHbJzr8cgbzSsLQ1qhjdK7aubFQAhSuzzliMdR8cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Le3ZznkA; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1725456335;
	bh=9w93ipmSizYx7nnXuIs7RbvWhktaSVpFbcAyHKmit/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=Le3ZznkAhT1TXvKsnY1WY3pUUnyPE7wOhZVvQFODZc2WwMM2VSnRiW2nx5YORrbR8
	 4Vuw8jydzmfIChxn87a2IJ4ExZD8w6dtACB90RWN47jBxi9qeaDnI+wZIwC44/uJRf
	 qxVSDljf4j0WCCEvKr/ibOeTqkGBl0TD7cDvq2hKX+btB7BWojslj2Slnw76+ur66E
	 0zFhC2iH+jnKjLpO3pe68ZhnIGo03w2DMom9FnvjtqH8UqXF/Wu67WQaGyLlI0EnQU
	 jQUPgL/dW1JDGXEjB2QPPwvVLOA0NR63yiOvTtvfARPmc15grOBkQU+dQQUwOBFvGO
	 NsxFqkJgk43tA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id BC7D44A02C6;
	Wed,  4 Sep 2024 13:25:32 +0000 (UTC)
Message-ID: <902c26ff-0fe7-4976-9dae-290e9afdaafa@icloud.com>
Date: Wed, 4 Sep 2024 21:25:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: Enable UHID as module
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240807-uhid_arm64_defconfig-v1-1-4b8de59a2d5e@quicinc.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20240807-uhid_arm64_defconfig-v1-1-4b8de59a2d5e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: hJ2QX5YEIbsU9kk6QLJ5XeY3tebIWZGS
X-Proofpoint-ORIG-GUID: hJ2QX5YEIbsU9kk6QLJ5XeY3tebIWZGS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_11,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1015
 mlxlogscore=887 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2409040101

On 2024/8/7 19:26, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Enable UHID as module to use Bluetooth mouse and keyboard.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 7d32fca64996..5607cb7fa580 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1043,6 +1043,7 @@ CONFIG_SND_SOC_LPASS_TX_MACRO=m
>  CONFIG_SND_SIMPLE_CARD=m
>  CONFIG_SND_AUDIO_GRAPH_CARD=m
>  CONFIG_SND_AUDIO_GRAPH_CARD2=m
> +CONFIG_UHID=m
>  CONFIG_HID_MULTITOUCH=m
>  CONFIG_I2C_HID_ACPI=m
>  CONFIG_I2C_HID_OF=m
> 

BTW, UHID is required for both linux OS and Android to use
Bluetooth mouse and keyboard.

> ---
> base-commit: d4560686726f7a357922f300fc81f5964be8df04
> change-id: 20240807-uhid_arm64_defconfig-40b1e360b4e2
> 
> Best regards,


