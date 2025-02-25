Return-Path: <linux-kernel+bounces-532224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE227A44A47
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9712189E9E4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16A41A38E1;
	Tue, 25 Feb 2025 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="QR//+EyH";
	dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b="iB8MwbB9"
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4157D19992E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507891; cv=none; b=WfVPAOLZfMuhoF666OpW6hW33QJ4iO7xCYhPSz+yJHnlC6Y0WZxd2saNF+wsZUBS6K5fxu2CRXKxEu2PVY4t/yTNE5CtygLqznUn5/7OoRer39Tfr5dfMxPKEY99xdN4TWL4DOhmBDgZRV/NPxTi71QqpiFcxC8M+WVwSMLVsH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507891; c=relaxed/simple;
	bh=iaATjlHw3bgNn21HkdEj8ENv2eXuMLNnP7ErX/r4HX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cM5b+o9ZLcDsKSv5CZ3tnGV2QC1rf36jCus9vVpr5OH+Lot/JsSM0qdo3ht7MgEsaj+FOAC3SWCTley6GR3Hi/iRBofHt7qDTgCu74sSIECf76H36qF1xcTGaBmGutoCcY6erWrgrAZlaPoYLCDMOB6KbUCaFvFxGF2u/pRGiAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=QR//+EyH; dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b=iB8MwbB9; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sladewatkins.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=selector-1739986532; bh=zvdOm4mAruYAiRh7E0H4Wg6vrM/6S5lC+mbY/6dX+X4=;
 b=QR//+EyHJ7GX3lk4e/xxvIwd69YF8khMAXS/JI3TYUveIPt2lWGwshDMEgvahttoXalpxAFGT0IduR/MuG5kJT30P4OG9OmLQleOxheRLiriZ9Vl4e5d5rjxuqNJa5ghiSkX1RqURqWh8grI99mJFxcNIRE9XZfD6MIOcAR7nWfRM3IPCms1zsx9YNu+Nf+hMrxZ2R2n7ieQus/QAIFmPeI0BBraPqU7Mm7LIjWX5Gte9F/4C0IPV+K8ml9e4zViFk2TV6tw/ZzDPmvPgjECvyYqAxrkrcZZadmdlj7ZfkCWUN75zz1yH/CZrodlbBf0l2Lx2tweckJQH9yU2BsMUg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 2C3C13C0091
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:24:47 +0000 (UTC)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e637c24051so106620786d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=google; t=1740507887; x=1741112687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zvdOm4mAruYAiRh7E0H4Wg6vrM/6S5lC+mbY/6dX+X4=;
        b=iB8MwbB9+OumtIVEqO4Q0wJHMlaUaOoWW7O3cEKCBOUnNMX8tysTW5BG9BlMjx3fsd
         HRTFqDcH4iJHwHe8Pu8Va/8ClhcmvzwYqpnsDOfv7qXd7RC8fmgjF7jCF/hjSUxiM2we
         P1QXrz64ltzRiLRvFW3IMTkdj8uMT/x0MDuI6Opz7JZ28K17X44ucSl5FP/kl1hXVJKn
         97G5yRnKfbzL5dichvIEy3nOipm2Z4Hx/sSkLOW0D7tm3o/9Vz2lTeGm91Hud4icekQs
         VPF9X1vRbc8yB3mpgQHuJev/9IhroFySuZFpZ1EiEcVrTFZBmHpoYd4ynrfe0Tlriygd
         cIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740507887; x=1741112687;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvdOm4mAruYAiRh7E0H4Wg6vrM/6S5lC+mbY/6dX+X4=;
        b=qExRCC2I0dFtO2maQUjdTGXt8+5rU3zlaw9Y4hIX5U/XtGJvkZGICzhOY4rhfs5Fqx
         Buz1uSHkwRZabkpT0FLpI2o6iNpEXEhbQFDrhciU2MW/Vk57wGhu2IQNSgboeF8mzfuW
         bJdTFKLb1uzcYXk/TZjhZ3uo/nt0bPaQIxo+hPei+uAj8jsflRMniJwzaaKLxh2CbmUX
         MHoUBmTGcNuyJxZ9FqRTJ5LeMocomK3+v+SUPXOs0uXcQi++0NatszJkmPmc7ifmjSH3
         595L/cGoCNq5U05I9tq1t/eZijDp8G+2Wjd07FbJATu1DtGJK1JKDooRUghj7WEsA7uN
         /cJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWB2yMJNXs++d0+aoEGLgwOdHSN0u1kDIQjWE+5X2aCk9OUTGrJVajQHvuEivmJW9GRkMJB2cDVsoqZts=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpw3GiFd4eS1iGVrdy1Uo6lpJmeTnLR9nzXAsGPLsz5IkPa9fS
	kvBitI9AeQvHVLOxi/o1ZD7ZoIp/MnCho0S1JMq6W4tuj9fQH/+vFiGiShISNepaIQdmT4okLW+
	BZs70w4VP6xmYvAOjWcIvj9duj9vUicf07rkp42VJR1pJgwBN9of+QrEdWOZ8xdzOSIi8keSv0I
	KaOivt634=
X-Gm-Gg: ASbGnculw1mdZt57WxRHpzQYTjdsOHC9/YgsttGTIIg4Z/ooFe4WPZjkWDBudTQvuCe
	Nzyjq8l7lRxWiKf/R5tPWEi6+7suQCL6GFqCcWRPRWzQ1oU5gSlVJ9ETn390/8dor+X7ZD1WOq3
	ldBaCoFliN+sPzNqumdubElW+DDjZyJ3zlSRLypnyo5wA7GwF+JVwtnERDwzbq3Bc6QcNIUBfZm
	1PURgOpst5wPHZru4RrAx8sL7ZTKkHY982MFGqmxQIrys9LipZl6oi4HD402JN1h4oyBEx1edI1
	mMzkWh/wJlEkZRuUk3iV0fTtSJ9J0Wf9zYbBBRiG2SD9sCykn1Yo0KKFRRcGDSVUziwGI6BVQwC
	FIXNev0VpBo1GEXspAnA3ruQ0g3PcdUhGWQdY
X-Received: by 2002:a05:6214:19c4:b0:6e4:2dd7:5c88 with SMTP id 6a1803df08f44-6e6b01d7816mr281052686d6.38.1740507886705;
        Tue, 25 Feb 2025 10:24:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0ZNnvyi/eJtx6eJsBbumH8T1fTQzPvXG7ciwKqR2L/Gj19h/DZglqhJSSfN/X1QoEIlljUQ==
X-Received: by 2002:a05:6214:19c4:b0:6e4:2dd7:5c88 with SMTP id 6a1803df08f44-6e6b01d7816mr281052126d6.38.1740507886368;
        Tue, 25 Feb 2025 10:24:46 -0800 (PST)
Received: from ghostleviathan.computer.sladewatkins.net (syn-076-037-141-128.res.spectrum.com. [76.37.141.128])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b17103bsm12158536d6.94.2025.02.25.10.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 10:24:46 -0800 (PST)
Message-ID: <25f0b81c-21e3-4021-ae53-cb54b6c06324@sladewatkins.net>
Date: Tue, 25 Feb 2025 13:24:44 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 000/137] 6.13.5-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250225064750.953124108@linuxfoundation.org>
Content-Language: en-US
From: Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <20250225064750.953124108@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1740507887-0k8QgexbT2qC
X-MDID-O:
 us5;at1;1740507887;0k8QgexbT2qC;<slade@sladewatkins.com>;c71d53d8b4bf163c84f4470b0e4d7294
X-PPE-TRUSTED: V=1;DIR=OUT;


On 2/25/2025 1:49 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.5 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Feb 2025 06:47:33 +0000.
> Anything received after that time might be too late.

Hey Greg,
No regressions or any sort of issues to speak of. Builds fine on my 
x86_64 test machine.

Tested-by: Slade Watkins <srw@sladewatkins.net>

All the best,
-slade

