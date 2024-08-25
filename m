Return-Path: <linux-kernel+bounces-300596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8EA95E5A3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 01:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 408EE1F21512
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 23:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A3078283;
	Sun, 25 Aug 2024 23:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cyji7UKL"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE10940855;
	Sun, 25 Aug 2024 23:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724626989; cv=none; b=smf2x1bRViksNQ2u9MaNwaEjL0XVcAnglseG7ehbgE6J4JkBqYmlbdrYd6Pru+Qykwh+EP65S77ht9apHogSzQaMZdTtpgLP7znANKFEam9en2Q1RkZeHzrJ/iZMGovRCdLpYlTCvC72A3gdzjLr0CsjhcyxbkCoNnzrFdtU4ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724626989; c=relaxed/simple;
	bh=0hyqfZXyzsVQguBaCCyrtVOvKwHyyW5Je/1xW+LrwJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qtFkhSqiS36djwxTezuwsKNGwItkjMUg7xb5A3CIyuKgt6x3rQsrssdAdpupNsw9Lv9X4/JDGBelbNgswoh+GAz/FSEbyI7QEarYu/Mp7Coqt2+2DnKC6Dz458CTZy3+GZaHxL0bTDQinF6k4uMSRFytI7kHEs4C+VEBGZe2Qds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cyji7UKL; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d3da054f7cso2493716a91.1;
        Sun, 25 Aug 2024 16:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724626987; x=1725231787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=9xLSTg0lgGIAXGxaiAuzz/wbWnPchBb+YdXnSFs36xY=;
        b=Cyji7UKLkZtf2YPjPBl/eVgEqOcxv7xnrbwjvxufqxYcv843zlZ81bY1UiJfocZogF
         xVZS9m10oE2JgB1LwlqZ0YkNHBizoV3V5ySDdKdIwCOQIpYM+6w2VzUxwHGQO/7rVqhF
         ++sFjMJP0wZmCqzQpqqrheSd8ntBgD5ukcT1UCNK6e5B8oX5cGm3P7/k1A+TnWVgBWjT
         P9bowQZTx/s4je9NWt2RQEgY2B98c1Afnm01p+XK3qOckt68r1Mv0ROsncvVjmIC+xDX
         mhUdi1u/7u6VknO3ZY/y6/+yKYrJOVO89VeJYFdNBrVCQiEl3I4j8zAvzlcmVA/qfSLY
         45jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724626987; x=1725231787;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xLSTg0lgGIAXGxaiAuzz/wbWnPchBb+YdXnSFs36xY=;
        b=OTdeeieen0TNGFGISw3lP4nvSrwNjEujMZY01UXRTynT746qEOCXp885ggqgYWq9QU
         OJHkUK7pnwere2KKm2U3I/LIeYvY/hiuO3AV5kGLgvsezj/px4sthD8jYDeTSPSJ/YTk
         +iEOg16T9dqxi8LgQWur+qudJdK/9Th8fM9EXpcayxJ5N3QObxhVSgfKtNjU+znnk3Fu
         HF3MYqIZz9GOE0sggDiGftJIDkOT6WLdGo+MmfFQZaAtH5bvDtBczmIA9a0+KfXa6VEM
         PFBR4kthVqPFaSfsv2ul2ZAfRmVzZA10HbNDeRn+dfrxT6CtJNWUqMChoYaRsy7v8vWx
         Q/HA==
X-Forwarded-Encrypted: i=1; AJvYcCUYSJN4l46lA4RvuncDPpV7AP+Rqh4CUWC+SWLsYm5u0+gBcrAMncwTs9y7goi43qkjVwmPLOAuVkEa4CM=@vger.kernel.org, AJvYcCVm5dD84jF2jQyT0gldJTNG9MbTJWJopPNIwGRLFWVAxGSl10T3yRkv/UE00bgFBPlSM2jzJwrsbxHK0/m/@vger.kernel.org, AJvYcCXWH6MUnDbnTOb1eLaTJQJQ0BzJs85B+mceEz55EeFEcBDwQJmmHWFlVTGsgynJG9LSyXAYsbZGFWSG@vger.kernel.org
X-Gm-Message-State: AOJu0YyQwpH4PRrn0M4dmsCAqOzp4awosypRUELjUmcfYCMEk4osV4en
	N8CXbAr+LE+lmzh4b0BWy0XNEMi5/D2a1/z5jDA4Txs4R7M25DYd
X-Google-Smtp-Source: AGHT+IEETF/dvyyyD4yaTj4pECOy8bhNc33aAWnWLpRwp1FUK/qRdfrGuddO+SecpClJ/n2sHiyyaw==
X-Received: by 2002:a17:90a:1b81:b0:2c8:87e:c2d9 with SMTP id 98e67ed59e1d1-2d646d6f98dmr7273455a91.39.1724626986870;
        Sun, 25 Aug 2024 16:03:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5ebbe29bcsm10651379a91.55.2024.08.25.16.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 16:03:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <22f0484c-52da-4845-9c6a-8041d424d775@roeck-us.net>
Date: Sun, 25 Aug 2024 16:03:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] dt-bindings: hwmon/regulator: Convert ltc2978.txt
 to yaml
To: Frank Li <Frank.li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 imx@lists.linux.dev
References: <20240819190652.373222-1-Frank.Li@nxp.com>
 <bea0d3be-6b2a-41a7-8644-44b17d3a26dc@sirena.org.uk>
 <ZsOfeimD94+mh5gt@lizhi-Precision-Tower-5810>
 <e63f6e5b-09a8-400f-8425-8dac4284fc9d@roeck-us.net>
 <ZsO86HQKxmV/xFV9@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZsO86HQKxmV/xFV9@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/24 14:45, Frank Li wrote:
> On Mon, Aug 19, 2024 at 02:37:00PM -0700, Guenter Roeck wrote:
>> On Mon, Aug 19, 2024 at 03:39:38PM -0400, Frank Li wrote:
>>> On Mon, Aug 19, 2024 at 08:11:46PM +0100, Mark Brown wrote:
>>>> On Mon, Aug 19, 2024 at 03:06:51PM -0400, Frank Li wrote:
>>>>
>>>>> change from v1 to v2
>>>>> - maintainer change to Mark Brown <broonie@kernel.org> (regulator maintainer)
>>>>
>>>> I also shouldn't be the maintainer for this specific binding, it should
>>>> be someone with knowledge of the devices.  This is a requirement imposed
>>>> by the DT people, I'd be happy to just not list a specific maintainer.
>>>
>>> I remember 'maintainer' is required property for yaml.
>>> Look like Guenter Roeck contribute many code for this driver.
>>>
>>
>> Yes, but I do not maintain code or documentation outside the hardware
>> monitoring or watchdog subsystems. You want this file attached to the
>> regulator subsystem, so you'll have to find a maintainer from that
>> subsystem or sign up to maintain it yourself.
> 
> How about just leave in origial place? I think you are more familar than
> me about this controller!
> 

I really do not want to be involved in this discussion any further.
You insisted in moving the file, so you should be willing to bear
the consequences (meaning: add yourself as maintainer), or at least
find someone who does. Please keep in mind that the maintainer will have
to coordinate future patch series if changes to both the devicetree
property descriptions and to the driver are needed.

Guenter


