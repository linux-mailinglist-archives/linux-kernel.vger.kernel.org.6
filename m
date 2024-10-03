Return-Path: <linux-kernel+bounces-349094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9F898F0B4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22AF1F21C00
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B0419D063;
	Thu,  3 Oct 2024 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="x5Fj9Lgx"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5F819C57F
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 13:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727963103; cv=none; b=fCUDqUgNO6LZ12MPelqa8K2O+1VTEzlGO0H5u610AEmvKd4HZaHaDInnPlE9hT9MzPgbR+tfKo7wzRQiLjgpHoHGxztMLOpB5sxQtYjxcS+RLvsZpeBZXfHQC5euDA7QKCDj3qaOwPxIGFUte3lsTfrBjXzDMLj9MxH9Y6g6MDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727963103; c=relaxed/simple;
	bh=RD9U78fWEr2OLYZ3hHe/2YSy67zB7CeCkzI3wXX48WM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/a9izKMgYG8WPTr1ZbFQKRE27cDVbjWYEnxGFCDPsiiqlR36UDBaWJVzwYtuV1pxe53ZjLWO2EAD2mOvknOSdJMu7QGp2LJdv2nJXUVVr0hxAhN/oQ73pd6Xx78+IAQpd8d5lkrUoWAkGqRg+3eDvxE3OO69YBqWST1pIOVDwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=x5Fj9Lgx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cb58d810eso12324195e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 06:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1727963099; x=1728567899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwqEYZax0+DPVB+o/bD03kfHhlCvltBh2zIbh2geEME=;
        b=x5Fj9LgxTSx5AcNidou4LGv3bltkp4PLejDiuFwKMAC7vJ3G9nyza/rh+4GE2ErNcH
         lFepYchrVhd0oKzrJ2XpYd6D56MypMpTly43hGuIAVUne44DukgaKe7JGHosT6wMR27D
         g/GDWqdpbova69+qTpwkfZ5dBuIiZ/3qrNyYLF25skfFnKjIzL5R4P59oZ6CeygEdQFu
         s/DxBpOnIJlzksd1QhjANei5NgXFABUHtoN8H8ZB+ZGx17BiGy7a8Jr0VZqnwZzrRsmL
         LjFSHsaPF6LKKrlLNdaD45A2J7Fkmf9FZAuSxuHDB79iC5u3F/TwaSB7u1idvRNe0PE1
         FzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727963099; x=1728567899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwqEYZax0+DPVB+o/bD03kfHhlCvltBh2zIbh2geEME=;
        b=XVTO9M9TI+jtd14Vfrq6DOxugvMHVoyJSi9p8oZXHsisRo+4xBpczOauztMP/oe43P
         fSUkeLqq4Cl6mf6rrCdmYBpe4iBfkipDSCJW69Hz1VSmG3076LRhqF5x0HpE1sb3iMhn
         DgP8K1MT374r1hNff/xS5TANZvBJwT9sgQ8dofYaxEWTj8PkEdT7qnwPZdoN2MQDSuLG
         GYosTn1l6kHTx7whR2HmTPMPGMAGAXrSjE6+f7tFzNsAvyRLBlCvGVL4y/wE+LsxerhB
         tJFI/S1k8MPCD6M7ofWI4hUYUBRG9MbyT67k0PxizgkIA1uG3oYBqvZ6XjXfjWr5+b3l
         wcQw==
X-Forwarded-Encrypted: i=1; AJvYcCU9776Ruj59cg09NHGeFJnq+tP9EbryO6gB8Nt9+5EeFO/uRuA93j0o/J3enBoJPjo6TZ3hS+RN2mZ4gDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLmdnRuG0Ib2D03su/Oq91RBq9z5amxc5f5seATMWWf9cuVSgz
	QZROlfVmXbnniiHP/sJPFRtBhfqtF/8tlV78klSMJkRvcU0uvVrB9fZ+A18GF/mvxJJXiQ8JkNk
	vhp27ow1sH70UHWlCA21Q/qvFbAAwSUdmUYf0iQY31m8j+VBZ0PXrzg==
X-Google-Smtp-Source: AGHT+IHmzkBQRnjRJ/DhHK4cysIpn8dwbmzLNUFnK46MKOshNcu+lFN6+0HCNvQiySIFkEeJ468TQlxLcdVB1Cj84vU=
X-Received: by 2002:a5d:550a:0:b0:37c:ccdf:b69b with SMTP id
 ffacd0b85a97d-37d04a5a005mr2036695f8f.32.1727963098488; Thu, 03 Oct 2024
 06:44:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003103209.857606770@linuxfoundation.org>
In-Reply-To: <20241003103209.857606770@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 3 Oct 2024 22:44:47 +0900
Message-ID: <CAKL4bV5zK5k7uX1DhT-3=AiK1XWzsQe-V-d-vXpyJ31NSHOTLg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/533] 6.6.54-rc2 review
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

On Thu, Oct 3, 2024 at 7:33=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.54 release.
> There are 533 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 05 Oct 2024 10:30:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.54-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.54-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.54-rc2rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240910, GNU ld (GNU
Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Thu Oct  3 21:30:01 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

