Return-Path: <linux-kernel+bounces-224454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D58FF9122A3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0A01C23853
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D416172BB2;
	Fri, 21 Jun 2024 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IvGc4VTR"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005A0171E5F;
	Fri, 21 Jun 2024 10:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966477; cv=none; b=tyVlLLl83cWSMYtfF5gg+0Eu0HshpHNiuYMwb8107SanY/DM/l7L0uIhkYPzNw75u/lGYDwW/PjK9jnkceEIjIfMngqhwXIGpPa/H/ctK5wnYcOQ8JfrrFUze8gc+rUR2GyoomeG8V7cKXbyHkbX81PQriHqaUS/QtycVTc3tFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966477; c=relaxed/simple;
	bh=QA/ECOiW7LO2h3JGhUWNamHoY/9STnydEktx1YMzCR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sZguMKWNxWwoFHbSr2Re4N4iLCEsPq3gX2n7B90vS0okQtSoMCXGYZkmmDYbNTaMHSL1VdrwgO4qmx2tb4NyAYGHxmLHynchzYXz5gsRMXnZjhTMns4bqGi+gVSHbC7y7hhPjUgkPTmimMPJgQMWCmIilT8DLlmON0xlGcP7vwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IvGc4VTR; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718966474;
	bh=QA/ECOiW7LO2h3JGhUWNamHoY/9STnydEktx1YMzCR4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IvGc4VTR712DS5g1jTbuHnqrwc3JALxrH4F7HXvLbCeglCN6OODo6QCzXYJqDmMcx
	 23oVpVl187Me9ecYa9uNAaa5aeco5NXkmt3H727NLVgYTpGbLgdQDZc4EHKeK4vzXm
	 HLWHag+i9es9mrCxy3oZ6MN2qnADZEcMIGAKXcvkTJSmCfOLCYUJe4StRDlz8y26Fu
	 qo8QiSoGE0JYXc1xU8jZ7X3Gy/rOGJrKcgPWfLeqSuM58TrX5StmZN33ZE3ri2K7FS
	 GMcICgjdOxoNg+g4sqrS5FG/hD6tfkZW8H7cQtj4uUH2ebGMXWHPdqjPmOZMgK1TXn
	 wsyB94Tzv0GEw==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1F1303781144;
	Fri, 21 Jun 2024 10:41:13 +0000 (UTC)
Message-ID: <4195a878-6436-4dff-a90c-03c019e98181@collabora.com>
Date: Fri, 21 Jun 2024 13:41:12 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] dt-bindings: mfd: rk809: Add missing audio codec
 properties
To: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Chris Zhong <zyw@rock-chips.com>, Zhang Qing <zhangqing@rock-chips.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Furkan Kardame <f.kardame@manjaro.org>,
 Michael Riesch <michael.riesch@wolfvision.net>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240619-rk809-fixes-v1-0-fa93bc5313f4@collabora.com>
 <20240619-rk809-fixes-v1-2-fa93bc5313f4@collabora.com>
 <fdf4da20-93a8-45c3-84cf-fd3fdc500f2b@kernel.org>
 <0f8e127f-0159-4263-8582-5eccaae21dd7@kernel.org>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <0f8e127f-0159-4263-8582-5eccaae21dd7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 6/21/24 1:18 PM, Krzysztof Kozlowski wrote:
> On 21/06/2024 12:16, Krzysztof Kozlowski wrote:
>>> +    type: object
>>> +    additionalProperties: false
>>> +    properties:
>>> +      rockchip,mic-in-differential:
>>> +        type: boolean
>>> +        description:
>>> +          Describes if the microphone uses differential mode.
>>
>> No resources? Then it goes to parent.
> 
> Ah, I missed explanation in commit msg, this was already since few
> years. It's fine.

I mentioned in one of the previous messages that both rockchip,rk817 and
rockchip,rk809 files share most of the content, and I'd like to take
this opportunity to merge them into a single schema.

If there are no objections, I'm ready to send v2 with this change.

Thanks for reviewing!

Cristian

