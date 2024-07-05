Return-Path: <linux-kernel+bounces-242940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11772928F55
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 00:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3837A1C22E4D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 22:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7F61459FF;
	Fri,  5 Jul 2024 22:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="GB5Z5Bej"
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AD913A416
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 22:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.177.23.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720218510; cv=none; b=Tw6SnNME2frJqSjoI3kEvPKwytSa1uJney+x1O39w92nOQvCutm275czJTv0FgrD3PqGNMvHcMsIgSR+CvBLZgDFom0CZm3gyCUbAopoA2bJ/R46OyJJxFaQX/xa1iPoAlBdarf8O7U7QWzYBcNJre/GiDAY8udt/2aDH3TubEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720218510; c=relaxed/simple;
	bh=5ue+wY5EFTCDa/SLwCcR80f0/DdzCrYSEcPJdhD1g5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oVpCTw68a49SzF/vADttSZcQqKJYtQeTaB5IqWJquWacku2ORVoe7cUErAQHS2a3QNu1gYw6xFwlwmugSLIqb7rqS4trnxYPSzSAiAE+7tTgTUpTSI3FVSiu2/Bgy4cgIpXg3tBz/aks+qYW4a9iafZ4H3gGLCQ+x+DRcZ31Y18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=GB5Z5Bej; arc=none smtp.client-ip=89.177.23.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Received: from [192.168.1.102] (76-224-187-148.lightspeed.sntcca.sbcglobal.net [76.224.187.148])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id E149C161F17;
	Sat,  6 Jul 2024 00:28:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1720218506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aYC2YRuBUI1QvLpokDSQ4OY136UY5NRmCx8TBd+ejTg=;
	b=GB5Z5Bejj+hXPEZAfQppppK6tVw+pmeZto+KfI2TuSj/7K7piLSzyC++uwQrPcK2V7E4OL
	C4mqC2xy6n1jV4YezyxuwKnGtEsL+GNt0HOHFakM0KNVePAUMWAQU2mY6f3DJHWleGmNHD
	fsUo+rRLvyXGohVDRl4UWKIM7WTU358=
Message-ID: <b67f3997-5110-4a22-9cbb-10b7fecf7ccc@ixit.cz>
Date: Fri, 5 Jul 2024 15:28:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 01/10] x86/Kconfig: enable X86_X2APIC by default and
 improve help text
To: =?UTF-8?Q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 linux-kernel@vger.kernel.org, mingo@redhat.com, rdunlap@infradead.org,
 tglx@linutronix.de, x86@kernel.org, yinghai@kernel.org
References: <20220911084711.13694-2-mat.jonczyk@o2.pl>
 <d6a06044-4137-46d7-a755-050846d8988c@ixit.cz>
 <332bd358-95cc-4343-bff8-cc6e8c62ff89@o2.pl>
Content-Language: en-US
From: David Heidelberg <david@ixit.cz>
In-Reply-To: <332bd358-95cc-4343-bff8-cc6e8c62ff89@o2.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Mat,

do you have ETA on v3?

Thank you
David

On 15/02/2024 13:10, Mateusz Jończyk wrote:
> W dniu 2.02.2024 o 15:08, David Heidelberg pisze:
>> Hello Mat,
>>
>> any chance you would incorporate feedback and respin the series or/and at least X2APIC parts?
>> For recent HW it becoming really necessary to have this option enabled.
>>
>> Thank you
>> David
>>
> Hello,
>
> OK, I'll rebase, update and send the X2APIC patch. Can't give you an ETA though.
>
> I have mostly gave up kernel development, but you keep me motivated.
>
> Greetings,
>
> Mateusz
>
-- 
David Heidelberg


