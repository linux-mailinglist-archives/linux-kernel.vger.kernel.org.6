Return-Path: <linux-kernel+bounces-527583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A38A0A40CE3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 07:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0BB189008D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 06:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2C21D7E4A;
	Sun, 23 Feb 2025 06:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="BDKiCpJZ";
	dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b="OG7RGScJ"
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B25194A45
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 05:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740290400; cv=none; b=atC75n3m/nZVxoKhXIqrpEQ6868vxbapUUsACTDGsI3lKT7Fz7sCqdE+DQ7GoYGT/Yrvv76wijHN33i8pmgBPGoe6Rnxe8Pe4jqC0I+DMqwf1ufgi+aMzXG3zJNp4GnGigCM7pW4DO/aOL0oBsyNzp1mJClCI7sVJoyZTsqCfmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740290400; c=relaxed/simple;
	bh=fj7RisvRvN/Ru1b9MEQfvgWitMFnjkTjvreUFCCxdfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DwN4H5phY5shzfIGntiGiua9hvamQRQhP6n20aejtbEUZeeujBIoqDHbp4jun9JWzGvcrmtQ9ktOidunAiTl99oL/ivXp+ESXI7cideLfr9PPPLsR6ucWQfujzs1H3xoFR7VKXR09gLtJygZFLGRpPIeSIZ59j9C6gOV3VlfgnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=BDKiCpJZ; dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b=OG7RGScJ; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sladewatkins.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=selector-1739986532; bh=tL+mVeQMxkFXhPRf8l5PyJu7sCPJ52EsfXLbcrTR+QY=;
 b=BDKiCpJZcHVNtp9XhIZUjCzWBmNxRliQMBGWvI4JMHvuxv1LWDeJ+MxP/hc5OP9+gGr6H7POsveQG6FYx7O6FDEGEll8LRjmos1viL2GVUI1yuxAqO0aBmvC9aRK0FmNPDhvm3CdwOw9od61u24oRhJ3jpK9q9aEyQgJuhKSX2uby/W4iDl2cBmwNmZwFcJYXumd5xeAgPTJ+4rd33dfYhfrl0QKxuhraXjW1w1y/M75NQkcfMWBu3BlC6qaLmdmL48isPiMSYmeGfeqjdy3cIznWW77VYg4qyZFEIchgvi/8UtTMNVmihQo2Cm5K/dNJCl/C61wk7GtK9cggDm/bg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 2F238100067
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 05:59:49 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-471f21160a9so1895961cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 21:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=google; t=1740290388; x=1740895188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tL+mVeQMxkFXhPRf8l5PyJu7sCPJ52EsfXLbcrTR+QY=;
        b=OG7RGScJRnYQGBhwXGz5eDRRr/yj4bYmojxWXwesOfPpoeV0i4m0ePKVHYL6RhwQj3
         js+TGB/nxMRX8Yt13VKmSNcWz3Pp5eoDSeyVpvt4E0SqO8kXagoJPn52LPDADckyYX0G
         qqEA/SoZa+AKkc7+G2QBbEzyRwqw+Wi/HSed92bEDX2DjrO4MGM7YfJTDq7JzmhdyvBw
         VfCYHWO7eBAUvSLX7Wy1wjzWqyxdibsHDVz5OR5ywkt1T2KMQs6s0Ys5kHMsj/lsQgdR
         yNRUmcP6Jz0Zuh18N3PFe90+qSjMmybZJFG7kiO6ljR9cuiWhcUaiLTwlyfJsGJn9x7R
         U2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740290388; x=1740895188;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tL+mVeQMxkFXhPRf8l5PyJu7sCPJ52EsfXLbcrTR+QY=;
        b=GEdM/nupHADyyyIpCBmdxXTN7Ijk7m+hTJCDOn6JFl6wWmnndQqrxDgVvvF8JrKrsM
         rO1/l0GC+rMHoz6gVUHQSSSk6dtpMtn8Y1o8ORIimpzUNtxONAJowj8yzkRtWSsU0iM6
         XZQmYKZLkJexxtnZOlX4cq4AGW1xpR5ut7SdzRaoCODhTXuvfmKccax616ac21k0RtJu
         dE8wINWt3DNjzEbCV51Cr8+h1OZHVf166LmwFj0tqBj/SJkAk7JFB5Ls3aZnF00A+aDc
         tRE8ALRJH2SxYZKUDsDl1TE3DZRJ5v4arvwcHTnbsZwE6EMS+HcDSe862zU5xHDl+6Pg
         8d1w==
X-Forwarded-Encrypted: i=1; AJvYcCW+1lmTDzyix6XVhusVjUniN/QRERWXsIoRGOMZj1S5DRKgkCiLbmMEu6ieZZ7hE4ObrBmrT1sgha1cgB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWrIP+1JxvSz5Q8j1wLxkeBCA2eo0nObyHixHNvvANF1Pi4cwH
	hrIqowYIGLj10bVVn5rE6Z2kH3zyFwim9dGZkoMsMbe1zkvfp1y1jnOQrIjz/2whVSVIqz1ddud
	RFbxjSM5A6yYue8V5PJIoZRCiwRe/YibThz1hIHzXSu0z+h/CJIZLuC5HDBqrgcheB6xDCjGEuv
	jL0OCHkBk=
X-Gm-Gg: ASbGncu+ydqaLu0uP4MnH6WLeQZ3T9tUH4ZZjs7E+L8M3qifWYoHCQ7y5I2Wnm0nPAa
	bavrBBjf7LA3yzanBlIvuQyTyHNn8Ql8iVece3YSXfL87DOfam8ST7zG83wIllAPLk5ZQsp+20S
	/xqwcSGzwwBolzC9PL0OCi/AOzz9TXr9aqI7dthLzS70zn2edoc6olvZf4o3ReaPABVpQWrpJgw
	9p2rPtUC1XtTHG5sH/M5w+CL4rm8NVzDnHui1BV7fJWGUWeesH6SCn7XLOCdJzknVqLaMWvUsN/
	OgddXqBtwObdq4pfRpYvIMGmPIGnhcQvBWYx2hv4w4gNr/afXtFEUITExAbBNsk+Yqhy2n0Kfmq
	Z1Bg=
X-Received: by 2002:ac8:5943:0:b0:471:ef27:a313 with SMTP id d75a77b69052e-472228e0cd8mr132522301cf.23.1740290388337;
        Sat, 22 Feb 2025 21:59:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHobZoEPNEVbzAjy+6qRcpI57LJnIrUU7nIRUOKBrAOd5qMdLhrdrimMqYyYbwOoH1p1MYTJQ==
X-Received: by 2002:ac8:5943:0:b0:471:ef27:a313 with SMTP id d75a77b69052e-472228e0cd8mr132522181cf.23.1740290388021;
        Sat, 22 Feb 2025 21:59:48 -0800 (PST)
Received: from [192.168.86.23] (syn-076-037-141-128.res.spectrum.com. [76.37.141.128])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47207d1dc11sm53927831cf.6.2025.02.22.21.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2025 21:59:47 -0800 (PST)
Message-ID: <4569fa6a-cee5-4499-964e-b1e9e1aef474@sladewatkins.net>
Date: Sun, 23 Feb 2025 00:59:44 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Please backport "drm: select DRM_KMS_HELPER from
 DRM_GEM_SHMEM_HELPER" to 6.13.x
To: NoisyCoil <noisycoil@disroot.org>
Cc: stable@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, arnd@arndb.de
References: <bfd2258b-9bbe-42e6-89aa-1bd77a58983b@disroot.org>
Content-Language: en-US
From: Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <bfd2258b-9bbe-42e6-89aa-1bd77a58983b@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1740290389-qnQJev41zlob
X-MDID-O:
 us5;ut7;1740290389;qnQJev41zlob;<slade@sladewatkins.com>;c71d53d8b4bf163c84f4470b0e4d7294
X-PPE-TRUSTED: V=1;DIR=OUT;


On 2/22/2025 8:20 PM, NoisyCoil wrote:
> The build (actually, linking) failure described in [1] affects current 
> stable (6.13.4). Could the commit that fixes it in mainline, namely, 
> c40ca9ef7c5c9bbb0d2f7774c87417cc4f1713bf ("drm: select DRM_KMS_HELPER 
> from DRM_GEM_SHMEM_HELPER") be backported to 6.13.x, please?

+Arnd?

-slade

