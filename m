Return-Path: <linux-kernel+bounces-295169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BE4959816
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7346E1C21B9F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C55191F6A;
	Wed, 21 Aug 2024 08:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ULWCheHT"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19AD1AF4CE
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724230400; cv=none; b=mdjewe6qOvdI1UQb9F59tVwRA9mBE+BppJYFSjlDWoVirKU1Y6/hPTmMOczcIh5NAuD1Nl1Os/0JAyL/CKjdJiNxiDU9ds/UYgU55aBMUE+6hPakBeLG3DtugHy6NEE/DsCfuNnwYeqJgBKd2EQbIMZ18PF5E/Hbog17N9Ka+EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724230400; c=relaxed/simple;
	bh=RhVqydFKtwprBAaV1tlmoTsEuH4pau4cHXwu/l8a8vE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=a9rndXgB8ZHBdx2ppzPU7YesGL7RLkapN8P+1foF6wJsK0N6uzLZQnmjdV9llDsHcxpt12sFUXJAzH/Sgkz8YktdlGP17aY3HDlHS+sXQJBffjvI2Hw11kmk4WEya6dCaFYfS9aWwbigLBTx67bpHYWV0eE7qGP5atdEjMH7SlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ULWCheHT; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1724230395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=me2bazh1+XWM3oC6fY5BIO7VytdUgoc5JECJvjoPUzo=;
	b=ULWCheHThawcPG+AyC/53aQI+sHKckvEBHPdwDjlQDS3N7u4edYLeuV2XTFididXOS2f8O
	mCeDJS5Q3Buf3Yj/s0AxkoIMPZEagEqboFqCVnd6QijhF8JVGToQs07waDJ7yacEmiFWSz
	9jptrljyfbl5a7AbH8neI8Rk962fOEuXhT+VJNStlqb6lpBWe/AuamKmzRJUueMzlddf9C
	0XOatZ2wb48e5ML3NmdNRn7vLu1bETbQjK4N8WWj+2OlfEISqswUNLrqqPd53ev4GhNtEY
	sQaXMAnVPpJo/B0VHpbM98QqERp4ildDkw4inNxaQ55nNypq+MyYQVHZr6q2Lw==
Date: Wed, 21 Aug 2024 10:53:14 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
 vkoul@kernel.org, kishon@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] phy: phy-rockchip-inno-usb2: Perform trivial code
 cleanups
In-Reply-To: <5307900.6fTUFtlzNn@diego>
References: <cover.1724225528.git.dsimic@manjaro.org>
 <14167d6b025e18d2a06ee429feea6551ef6f9c44.1724225528.git.dsimic@manjaro.org>
 <5307900.6fTUFtlzNn@diego>
Message-ID: <83a33b5ad6dd13668b6d8733f5546725@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Heiko,

On 2024-08-21 10:39, Heiko Stübner wrote:
> Am Mittwoch, 21. August 2024, 09:37:53 CEST schrieb Dragan Simic:
>> Perform a few trivial code cleanups, e.g. to obey the reverse 
>> Christmas tree
>> rule, to avoid use of "{ ... }" code blocks where they aren't really 
>> needed,
>> or to avoid line wrapping by using the 100-column width better.
>> 
>> No intended functional changes are introduced by these code cleanups.
>> 
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> 
>> @@ -445,7 +445,6 @@ static int rockchip_usb2phy_extcon_register(struct 
>> rockchip_usb2phy *rphy)
>>  	}
>> 
>>  	rphy->edev = edev;
>> -
>>  	return 0;
>>  }
> 
> depending on how nitpicky we want to be, I'm not very fond of this 
> change.
> Assigning the extcon-dev and returning "0" are two different actions, 
> and
> I think most drivers do actually use a blank line between those.
> 
> But that really is just a style preference for me, so anyway
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Thanks for your review; I had similar thoughts, believe it or not. :)  
If
there will be v3, I'll bring the empty separator line back.

