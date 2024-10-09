Return-Path: <linux-kernel+bounces-357038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A24996ABB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4923B24F63
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815E71A2631;
	Wed,  9 Oct 2024 12:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="WXkKs/76"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3799A198E77
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478096; cv=none; b=WIJseqO7SXH6d8R5FstpYdO7pUuCp/SJoo1xF5R5FF3j3xN68EUBeBpnf8ox4dhBJ+h/N4n+FoV21YkHx//s1KN2tXNeTEb4Nixjz2yvzRyroIzk4BUkYXRD98jtwefqmRvapomdDjT7PYUWUNMLewRJwOpY3sbcKvXYI2k/48A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478096; c=relaxed/simple;
	bh=pt4BlrCslRjBhho4c9a7N8znV+5Jcpu6Z3Ru5pIj9xs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=siRz1TbC4r6CLc4lgS2CL3AptKqmbZRwR6u0Zl2MoC/sweo6QedO5K7O98dAMbyFYLdbJE2NgfTXekJar/el1KXE65N4b79M8T4438H78s89DNGpI5M1cx/TOfo1SEXo5fnZ3gpyKqx4HS2BXG5S0oRCC0OmWwrlLNh0wwFYS4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=WXkKs/76; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37cd26c6dd1so6385648f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 05:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1728478093; x=1729082893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVzlhFZ7VYm/3cAm2m85K08t6/C9UqqQc41M0VjSFTk=;
        b=WXkKs/76ob0PZTh29sy1A6C3QQ2UnJ17pJsZ2OSM0P0I5H2gAIyw/Prv3p94yZ+a8Z
         6cl1RIf7RvSsiAU4C0cArmaKksS9qC/Bw+IfgzvT749z/C1wIKmlUYTDXrByAaxTkB/C
         GmVm40mUU8KdzXE0d4oPJoO1AsyvJ8kGwAcGrSOgxUG8g7EtGBLtLlDWzaxXd5g8X6LQ
         0B/IK6qrFT4UBvdYo7FsGDvvpp0IPEfSXN4v/QHRnKoGwfpj44PPmmnPeP1SR7leM/wr
         t4M6+qP8ek6+evSeiicXUsWiXXX0jJ3SckNqNV+nAHLzM8dmJ+E6JZY4Oz2ENWniWX/H
         a3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728478093; x=1729082893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVzlhFZ7VYm/3cAm2m85K08t6/C9UqqQc41M0VjSFTk=;
        b=tC/Jo/8d10MkfKDoYLDjvROnlp6xY7X6qwb1PJIl196/bY2DueFvX2Eb99XlRvzLhR
         X5syJWyhUzeEqYNlVdwfVUHNMtfLWwK946eLhy6thWmgcf89w2FvymjI8omoQLhMJUMX
         3B0r4uUjFg4j1woQSV1BAH1WUTzkcCsV2j5NAt6Lgx9O7mnusqvvrY49GPLicMtotXfS
         5w9OflHAEBBYi6nV+ul3ISDwxYzgs0+CMwoEd9zkkCsFgcUYa+pElKmrRXsMJ8F3hM88
         vj21j+E59N6qFpPrhseeBeM0kjbMsWJ/yetPfvVUakdIDWM24d7i/8aRGRLD7DwPrWuG
         HFTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb9e10pnC+aTncL8aWlpf2HdP8WzIcham96+IcjrnxL9+fwhTSkZe3XqwhGZOy2JAn5ViEmQhEDJufnMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqKALRA9eco/iYFeQLlX4O/tODMVM5fSd1CLFC6nWHAmd4IaeN
	oKKthC+p+BlTv5vAGCz4aW/DdEhsHBQgFyvN4KPWLB4fJ1zSG+96/OP0JQlTcCQ9vMHUlqG7muE
	OPp3XxceD6S8TvmtqDuID27j9xJRy0BgKG27PGA==
X-Google-Smtp-Source: AGHT+IHuUtJxYouoqf+oCUX6eRYDEQZBxX8IakgpdyX+VxZ5ozg9KjIGdyHqZMwBodfK+iJ1Ts5g04QJNMfKXZ1v+c8=
X-Received: by 2002:a5d:4384:0:b0:374:c3e4:d6b1 with SMTP id
 ffacd0b85a97d-37d3aae2f31mr1784150f8f.44.1728478093253; Wed, 09 Oct 2024
 05:48:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008115629.309157387@linuxfoundation.org>
In-Reply-To: <20241008115629.309157387@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 9 Oct 2024 21:48:02 +0900
Message-ID: <CAKL4bV5cRzNbEX9dGn7ZxWZpmV5YUDtawtEMrvMnn4Bakg4Omw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/386] 6.6.55-rc1 review
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

On Tue, Oct 8, 2024 at 10:10=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.55 release.
> There are 386 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Oct 2024 11:55:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.55-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.6.55-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.55-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240910, GNU ld (GNU
Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Wed Oct  9 20:12:56 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

