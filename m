Return-Path: <linux-kernel+bounces-399887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEEC9C05DC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793741F23DFC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6C920D4F0;
	Thu,  7 Nov 2024 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="Px2gSJpk"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145081EF087
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730982649; cv=none; b=kJ9AmAtizslxv+IRR5hXLHiokQPJiGoLAwhFh6FVSYqq8st3eaj80oQ/FGYd23BulJMidCHeYVsSblRjBQ9cWErvImDf3FXNqoKp2oY3UlsDRqMqpsuLh6svYn/wsRfbAc4g6LcmGk4Bt1ZWg0Z1+SDWclH0Gik5HhvIwYxHjLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730982649; c=relaxed/simple;
	bh=Fdpm4FLE82MD1XDbrFQIihI7Gfg+HRHDdnITsdrbq74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLF/UqFZ23XNKB6TROU7onKclGpEzVeYPbFvsFj6xK6LwtdPAqkO2v4Gb9XzmQU7SPJ82au2c2f1jXZTa3tbvs+eWTdRZe3bTjYuTNSDtQ7cIWOJe9BmKb3PwEFcOHF0VbouH7kSaMWv6uW36EJhJpRVj6s2A5/ftlEfTozKncg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=Px2gSJpk; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7eda47b7343so660676a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 04:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1730982646; x=1731587446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HguBX7zMS72hjPxZuVUTMy+OmRB6kPtYztXecte9GL0=;
        b=Px2gSJpkfPsUbnLVSi8bGwMtCct4aDg905izC5Rs9f/dlVRdfMn2hQ9TeoU+RpnGPQ
         l5IKT1wKgtLL5IjtT36THWq4IQ/Uob41/KoMBONEMXhTYgau6gRjNLNGXrgnBeulgc2E
         1tr26LjKMx0O1+63ERVzOgKSCxYoZISoTHhFYceeq3nxdQ0+0yaLRAEy86yLXEaCMVXq
         7T/tu7F1Ek1F3b1oNnQ3hpULHyHV09ecLkbImReJ0lw80R071EZ2p0VuvSrV5uIORH7y
         SmcYOV7QEmQHolJYP7RmRVHnalnxk3RjAIjLOu/APRGmxFguLxBZQf32gBs4hWmAFI0U
         rV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730982646; x=1731587446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HguBX7zMS72hjPxZuVUTMy+OmRB6kPtYztXecte9GL0=;
        b=kswXSjvOBwFPu6FIe08qlvy7Mj5NrqegQ0mIY+Xj1OrBBhOvGbahR0ECtYghHzInnf
         /6MPokgNeT+F8C26o28cRGng/eL/+REHJGyERfrT8Fj57oyUB+5ZU7WljxIE7ex2DFHK
         i1gbFbysSa8HtYu+6MKKBKKI8nzCVMDgyNEt+2JeTIsoB/W9fyBU/JNBjaj9StmEc0Wi
         MrkYvxpJ2IosqNMH/e/hEFjE/Ny1t/gJXtJMiykKIrXmRMRDTl3X/EtkG+2jH0TfAtKS
         gvjuBgQ7IstJg9H923+YBXRgBeOSXlaxWXyqT66bOFckhsjBEbaxkk0zDINrOL0GJFf6
         Ca8g==
X-Forwarded-Encrypted: i=1; AJvYcCU0rUNnXM/BJ1e0BCMy9Gc69r70YBPA5e46Oe+K2pvwau62f8r+bErpSEqydkfInKhhxhE42CmSsbUglfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7rcQcwKIU82JTTcGdjPj3THBCXytfA3u/jR4kPe7BuMMkVts7
	rZRvNBQzJkblbfQCKtpyMrbMFzLYMR6g8EBlZTHOisZh2p53c0J3zbQRTZd3tjk4E+NIMkp6Y/l
	5cpEy3ipnv3UD6EUnuQ+hNB8xmw9y/Na0/N2b5Q==
X-Google-Smtp-Source: AGHT+IFuYCrgtftLSJSRbDtHKLCIhR89jTMV22jQXYNjvu3k10LIWdr4KCxiqdPjI/FxckDfOt8KKDQPO8snlswhv7I=
X-Received: by 2002:a17:90a:6341:b0:2e2:8f4b:b4b2 with SMTP id
 98e67ed59e1d1-2e8f11b9f74mr45004766a91.27.1730982646361; Thu, 07 Nov 2024
 04:30:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106120308.841299741@linuxfoundation.org>
In-Reply-To: <20241106120308.841299741@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 7 Nov 2024 21:30:35 +0900
Message-ID: <CAKL4bV5NcjMRzVmLDr6-_z3hxy_pBTJCmdQ_URbPKAuVmkMQfw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/151] 6.6.60-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hagar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Wed, Nov 6, 2024 at 10:01=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.60 release.
> There are 151 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 08 Nov 2024 12:02:47 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.60-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.60-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.60-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240910, GNU ld (GNU
Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Thu Nov  7 20:39:12 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

