Return-Path: <linux-kernel+bounces-334842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8276197DD43
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 14:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39381C20D84
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 12:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD550156C7B;
	Sat, 21 Sep 2024 12:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="GB+uyXdY"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DD838DE1;
	Sat, 21 Sep 2024 12:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726922260; cv=none; b=SGlkeFdoSvn15qRJXdBLtrMo/E56OIBIXWy/0rWPyUlMJ39WeeHiODqwjIHnNT6WvF+hMmwhhGFoGOYfK79sEMsdkDcnHy+pgX26KwyxJM9y1QcvQUlZ8oY+mp8CCwlEhb2xsp6G516u9b22d8v9FvAc1UeffT8I9o0emmhCErE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726922260; c=relaxed/simple;
	bh=vAPIl4pwG8XIOK0ubXrjS3Bek6TxDXFPz8Bm4puAIkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RSan6ZZQTLVg8vUjSMJbKrN1PJKFJJXtG3jqVMPJBa8/sYgQAVm80WpTD/hXO1u3Rv14/ZZPp4+hvqUOkSZ/uXp323rEfXrB1lvHStl/sFe7LDmYzQiAcaceUdmNvI8DkVqodJqgvYA5Eb+ZuKm6TIYSuzTcaToAQAEzeqLBDuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=GB+uyXdY; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from [192.168.0.160] (unknown [120.40.111.43])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id D4ECF7887A;
	Sat, 21 Sep 2024 20:37:25 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn D4ECF7887A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1726922247;
	bh=zcS472w9hdKS/lPmVwyG5rcF8C7SmDI7kxfAxfhqsnY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GB+uyXdYfJRz0dXGsIXpKaiDqbDCUJEP+daNCcKr1frd4VfcjjR1/iJL9FFTflSUo
	 jn9mbTwOOCE2H1lmqvyBnyODxmkQ/KwwX1fEtG4aqButCTKdxHSrbcCLjoesVTiO1u
	 GWb9kKBgVJg0nikD0p2AL5V5uC1YGIm2H7Lt+3GQ=
Message-ID: <2ff6ab4b-14a6-40ac-beb6-9c21e50cf7fe@classfun.cn>
Date: Sat, 21 Sep 2024 20:37:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: add dts for Ariaboard
 Photonicat RK3568
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, dsimic@manjaro.org,
 heiko@sntech.de, jonas@kwiboo.se, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Junhao Xie <bigfoot@classfun.cn>
References: <1a7d017a-8317-462b-8698-03cc7099a74f@classfun.cn>
 <20240918022005.487551-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Junhao Xie <bigfoot@classfun.cn>
In-Reply-To: <20240918022005.487551-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/9/18 10:20, Chukun Pan wrote:
>> I seem to have misunderstood the rules in dt-bindings before.
>> The following looks better:
> 
> Please also update other regulators to unify the naming.
Thanks, I will update in PATCH v5.

Best regards,
Junhao


