Return-Path: <linux-kernel+bounces-365896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C57799EDAB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446191C20FC4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363AD14A60D;
	Tue, 15 Oct 2024 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="yR6xUNes"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C3E136E28
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728999197; cv=none; b=YtpR8NY55hhS3WAOucnBbBNH8hIMkJDMkEU3uRkg8sGkdmmHfsDG4JpkTLWgjlZk9DBDORbGr0XjzYdR4IjPcc/V8V555SgYDDM/V6Hq0BA5VgHn2zuQKp4IGEkaP8QaFXk/JnmjNPYLYNhDg5lCLH3wHAoLEi5papS4qqGV/oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728999197; c=relaxed/simple;
	bh=UJEXxmod9hwkTENeMk5+2g6dtyvgZ2h1Duc4mV+05xs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hL4eTtwkmtS+XhO5QYh9Iytv7uBP4vgwAqPIsCwBkz11ipAK3Ual+ATriJ7edUDDalbX/0C1vp7TxYqCENNFQZaDAJrTYXFoPmEDtW/CqfweJlYVs8CuryZktg3AnBeVFfjKA1FJEEAX5wtn6cOUdqnaUXlZnfmrvRn1KhFOAD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=yR6xUNes; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d6a2aa748so1587515f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 06:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1728999194; x=1729603994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QS14/1rLrV66qDBatRYaujSeYfhdUS/QKbwUq4VPEjM=;
        b=yR6xUNestIQGqBoSQFhtGQjPFxM9n+m00oG5Q59JZY+IvJzy8ovCaEtrdvoui88wTX
         iTW1SFaPzwv2+izGsC+m+jLcbRbKIzqlooLTGirJn4OFNvV4tdiGZIRETlj7f6GdJzb1
         fBqv/qKigSKqUGU7leP2VupPKGFskUESTg9rFQ2uafJCi4GuXc66x7zeTeur24uK0ewJ
         8p2eILLqoH/CIFPFGo1RHzLSg7LUDd1HrNic8JwMZJAf6xyDpZLJNfSqOiXF+foVWC1+
         Q61+bKkGETiQFmmh50M5gkvCS+JDkJaSZLT5jjcUXHWwxRSSPzBBo9/POyMmIz8boJN3
         4Lig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728999194; x=1729603994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QS14/1rLrV66qDBatRYaujSeYfhdUS/QKbwUq4VPEjM=;
        b=OT+M4ucBHAmr2mUe5SCWXJSeWogU7O3YHE7WDnv+poWnrp291OoDdr8QkxAhjW0F7x
         QLSWui8rNINWUt1+d05VmIO3cYyY72kguPOm4FcyCvxXNKmK/I0z27B47puPY3ev4PUP
         mqiL0+SCg2mhAztQ/pBrHY3BDHeIOnjQmavsTjZ6hnRYy7x6O1qA1vrzr1Kv3cEQ56Eb
         savrqDSY7r6+USBpPNDN1LqJfI/W2MtuixTINLU6ycMgK8t/wN8UsCVfryo5PDP5Q4Jf
         pJB+8LqMgfvfcxiNPjNmMbamSR6hH5lvZ/MEXcDpMVWbkkbxEi98lTVaqS+rprtu4yR+
         btug==
X-Forwarded-Encrypted: i=1; AJvYcCVd816RJ3zrRGi5Y1SfXQ3DTW8ivWYyVA8ymgpP2C93kkhdJu/38C5VW/uANYj+WXX3n/rmrF2g2Mly8Oc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoso3ZA3bPvn0FR0gSWI5+RCkoeBeeVpY1hEXcRoL1/ersHxvN
	fZeGxqCjueoD1I3ngkYqGQTSmkVhEW7scL3u16vKddJJQEHfoZ8vzZnxfBWcozZPmozACMYd/8t
	hyLwAzvrG8rd53c2Jd3XhYJbqlRIRGp2cjwxOiA==
X-Google-Smtp-Source: AGHT+IGNradBs7hA6tXJ03WnMFyglMyY4jCHENeRjpb48YC3HbpmmRPnxpuAwooOcuGkZlLWRPIWTDx0C/YHIDf8Dy4=
X-Received: by 2002:adf:f304:0:b0:37d:4fb1:4fab with SMTP id
 ffacd0b85a97d-37d601d21bemr6228186f8f.57.1728999194068; Tue, 15 Oct 2024
 06:33:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015112327.341300635@linuxfoundation.org>
In-Reply-To: <20241015112327.341300635@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 15 Oct 2024 22:33:02 +0900
Message-ID: <CAKL4bV7WGcKbkCkfG-J8UtrKt5MM5dObr1c5RoKmm-TxfAVVkQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/211] 6.6.57-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Tue, Oct 15, 2024 at 8:26=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.57 release.
> There are 211 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 17 Oct 2024 11:22:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.57-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.57-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.57-rc2rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240910, GNU ld (GNU
Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Tue Oct 15 22:09:26 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

