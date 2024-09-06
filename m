Return-Path: <linux-kernel+bounces-318572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C9C96EFFB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E12F1F2222D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D617A1C9870;
	Fri,  6 Sep 2024 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="Q8a3zPR7"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B161C8FA1;
	Fri,  6 Sep 2024 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725615845; cv=none; b=aLQlJV7MalCQ5keSDeg0tI+BrjeGPaS1FdEJjTfcfiv7G+QIGu8lBW4RIbpDDyp85HjJTsUOyRyG19cHVsaKTC1TLH614Z2HquBN8ZF4dMERpe95ixNU6w6Lx3J6zyoDZu+lWluGnPYsDCUiYamY9vVh7n8WtjzVNsLYRtdZpgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725615845; c=relaxed/simple;
	bh=snKPNgpRoW8rbLS6Fh9Ovkh7K72/cM9hEi/rFHeECxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=LYxRXAG4q6UJytH/oYvM3vexgXk8FnfN07sNs+2JHVwSili7VYHlKBlN0DRPjKcUDk4JcWRqJYGdqw+ABqeit+rL+n+JERSqT014Xfrw4IzbZJr1BNqPM6xL69zYNgaVWwOCK5weR2dKwvCP9H96ukoCopJ/ZcXy3mPkcBue3zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=Q8a3zPR7; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from [192.168.0.160] (unknown [14.155.100.110])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 145BF789FD;
	Fri,  6 Sep 2024 17:44:00 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 145BF789FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725615842;
	bh=iDtsoB4FhtzTth2ly/Rlt/UP3pyhI3sXe4qSViiTolE=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=Q8a3zPR7/zQ3WuGKSSNI6EovYNdPYoVsAkSOqIP/eSgLygYYugPgUU+w5Ap1NCWRz
	 aRobA0EoSl8ls8OMdl/KkELuvlnbYDVjkAhwkQquR6BfZs3exz0/iOQQBrcElmf1/f
	 48jsncK9Aq52wCuFqerA4GN9dyA5SHskbILqSugY=
Message-ID: <3d20a67e-c545-4491-b9a6-1a2b1c364a78@classfun.cn>
Date: Fri, 6 Sep 2024 17:45:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: rockchip: Add Ariaboard
 Photonicat RK3568
To: Chukun Pan <amadeus@jmu.edu.cn>
References: <20240906045706.1004813-3-bigfoot@classfun.cn>
 <20240906084005.74239-1-amadeus@jmu.edu.cn>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jonas Karlman <jonas@kwiboo.se>, Chukun Pan <amadeus@jmu.edu.cn>,
 FUKAUMI Naoki <naoki@radxa.com>, Dragan Simic <dsimic@manjaro.org>,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Junhao Xie <bigfoot@classfun.cn>
From: Junhao Xie <bigfoot@classfun.cn>
In-Reply-To: <20240906084005.74239-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/9/6 16:40, Chukun Pan wrote:
> Hi Junhao,
> 
>> +      - description: Ariaboard Photonicat RK3568
> 
> This should match the model name.
> 
>> +        items:
>> +          - const: ariaboard,photonicat
>> +          - const: rockchip,rk3568
>> +
> 

I will correct it in next version.
Thanks for your review.

Best regards,
Junhao

