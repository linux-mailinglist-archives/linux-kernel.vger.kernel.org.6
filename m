Return-Path: <linux-kernel+bounces-269350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5619431D7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B65511F23886
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B771B150E;
	Wed, 31 Jul 2024 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="cGSef8L/"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CB4DDAB
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435548; cv=none; b=aJk+c59dAEnPP1yXNQbbSuA6E4J7nPfQ8cQdGDA2Q55RxASN1EZJcMQmTNoZv+mGeRgepngCcoviLbK99gvK7rjL4ikvoYmk8fuYhytdZ3O5aeesXSYpiS1AN6lmObruzvSvRMf2g5FJpDWOrL1lkL1ILrJum6iT0H+Tgs5dBl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435548; c=relaxed/simple;
	bh=tw0+TCU4/jS0AandgOrW7tGxrTSxEhF7HElw2lzzHf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AnXZiOqJ9lmsJ5/1Ewf/7DB1oKQH2bt+g8QJHaMZn25bAksLo6sU7tDwkxkIuP7L7wFY3QNcigmAZy0Sd5tt10AdoWWjKpyEzpv2xN1iUqc3cbX9pove6m9bhsaKA0fVGIJCHDWbbzQ6uAc23ZEEmmVbv0wHLfI5mt+zepDMx+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=cGSef8L/; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6e7b121be30so3720008a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1722435545; x=1723040345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+olOBTdXwD+ptqnBW2bgMxBC/rcIDKTtdk5vVlb2vLI=;
        b=cGSef8L/s1Lz7tnsMq/Srg+DbX0JvQ85xZWg/quZewmByP3hc+13j3gA9Ge8vAizBG
         YJWkBbaMcSu0Efhz1XDd1fOMweqHNGOyAv1O2M7tAxoBTcjO4sAqhcTi1qzmnSLI6Rp5
         wCcJvbx6/FABBuuu+y3VfIAbehGQmTzuuLNou0qLzxCkqFh2BFHTsUo+EG5uqu05hInh
         aEjtsDAcywkn8W2YWLSXyhpd5xMZ0CMaHFJ7JQJOB4FiBiN54LlLkZwGXcktV7DILpUl
         cufSrdYujL39U00QfWTltWnMa4sVNyLiHhaQ51be9j1YDDDWRK2h2ykpuHGdN4kk/CvY
         yzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722435545; x=1723040345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+olOBTdXwD+ptqnBW2bgMxBC/rcIDKTtdk5vVlb2vLI=;
        b=OVDcHjznoG9I/eEzxsBynreU+AcWzHxiB+2BQ9foaD4zhAHx2YfqusG0YMamt3n8Iu
         WLP2dLpkPwbUZCzDYEMY26n/Xl3x7adfJ1+oatI6n/9DDo5qvLU+SVOw8yRRhd9dt57s
         vRVOy+0kHr2p1SeB7jazNcZmd/39bJXcDOHA1ENpa3yulFohXDSYuE02TW1DV8dluG59
         vFuONzcChQJgHErIMMuGug6apPiFU2mEiWGfagJauLhYc7kblDTxhe5xDqm5RnyA78kb
         iwwiAJOY3Jmw7p/Kl33MD3db0yWVwvePhS7VA3lj7beEucW9njB82r1n6MzU5beK51dx
         Kd+w==
X-Forwarded-Encrypted: i=1; AJvYcCUDdQ8UjfWTVEvKML7vMHBrk7JfrulelwEWRPbxitr+0B/zWp1dSqcidGhoLPXgJPrdXZZM9bOcvZ1jlPwDMm8Unh+GUwgHN/bueFxs
X-Gm-Message-State: AOJu0Yw3EN/rmy2tBykt67HklhrBuQ/IFuCZ8UiT0Ca+wWbRRqSVCJwF
	G+LV7Dj5oc6QHZJgcPGGXpJCfAy8Utq8AU9nrbQBJU6b6rXwJNlHRZmDIZD3HBCIBW+xHKf64OY
	iZShWgCl31919r2sK82JEcpTxaRqiG5Z056pIxA==
X-Google-Smtp-Source: AGHT+IHaZW7cYzfTwRhs0thFGwdQ+qUnbaCYCKW3CFQH5AqF78fGOWlCFqSVRRM9coxyRFyVVFHB6SQjD+FOOJIzTAI=
X-Received: by 2002:a17:90b:1d12:b0:2c9:6f53:1f44 with SMTP id
 98e67ed59e1d1-2cf7e09752amr13328867a91.3.1722435544643; Wed, 31 Jul 2024
 07:19:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730151639.792277039@linuxfoundation.org>
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 31 Jul 2024 23:18:53 +0900
Message-ID: <CAKL4bV6aU9vqkUtOZtL282sUFEKLmo=TpttMRN-Tt79P904GJA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/568] 6.6.44-rc1 review
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

On Wed, Jul 31, 2024 at 12:52=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.44 release.
> There are 568 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 01 Aug 2024 15:14:54 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.44-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.6.44-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.44-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.1.1 20240720, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Wed Jul 31 22:50:43 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

