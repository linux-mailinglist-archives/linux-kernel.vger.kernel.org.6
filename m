Return-Path: <linux-kernel+bounces-318952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A898D96F589
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9301F250C4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459DE1CE710;
	Fri,  6 Sep 2024 13:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="jRtVNlBZ"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5DE1CCEEA
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725629943; cv=none; b=N2nne/2k0yP6ze2gzame6t+2HbCw9+92JcYBngJNlq/PXWIHgh2jFonEHQe/fEhn1eid0QXk3Kz0ZpFdqcAzAM8B0cRHQm4p9Ku/uFhAzDjZlOjBs68PJVQSiEBJP0eEdtq557NlPc16naU4ze1/mmSgoE/FzYtMhcxAWLmc1X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725629943; c=relaxed/simple;
	bh=QVsf0P+mtHtWmnrlhDzcepBHBPQIrcMSAMHPNfjf9QU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7enYfgxXjGTFKKd7i8FFtWb2IS6jrxyftDRT7tgR3nmya2LIkxU/ePmBY7FoH5QCX/7x3OMqSf22QOcLlg6fUy9KD/7iAg4t6ryG0tPtkVY12nh5//VQ7rHhrCvU2jF81RZBoNECkmKpmnVH07fLBefbospG2JFUhh9plkghAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=jRtVNlBZ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-374d29ad8a7so1318653f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 06:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1725629940; x=1726234740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+AqCSr8HoChcAFGwGiSrmlNcV3RopcVFPKN/wyqjkU=;
        b=jRtVNlBZ7YUs+KA+YzHMAK684kWKTs5liS3psRTCm+7hcq0Yj3zmnozCbmfJfiL1x7
         trc63GAMoggQhKF5i2tjwWsPoaWojr1TGNKkgiyvn3e3CsbuPj5AlVkPI8WTfM7lIAe5
         Xz/hjZ/JssrgIecFuBAnDhv9/BaYbppJglB5Mdq5og1aRGIk7Zd5kmxMZW4I43POPNOj
         uk9LPJmdiGH5BefoqjMVEoiuwi/cxU+nJFndhL7bTyw4ae53n+JKeZKxoDU9KSQmxSyl
         twz0p6MhCbCIhAPvIk8uwXhfX3Lz+WEFR4l2/PyNyiFxWliCFDoTnNZDRyK1n/IqtM3K
         0OtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725629940; x=1726234740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+AqCSr8HoChcAFGwGiSrmlNcV3RopcVFPKN/wyqjkU=;
        b=pL5/3Zg8ntzPxxMpnBfCGkiWwuRj8N0B6/5TxRltPhq9JSOHJQ/8zYni9EpSVDM4hs
         grlOqfOWcv5CEu3QFaXyhirTWHfhkRWKTMriMgrGIpPu1tOBdgj+B+4OlgClgccVfWj0
         IpraVtAk/bFkS5thy6jOVGD+TcaMuHOGRM9JMBbmecmEokAYpt9xDDyxmx6fuea47arR
         ay0l4fqu0/BHMRfE1+iVlUoDFaOv5dJYe7HUnaWMC2G2NVSnbnJ2N2sWVtTl6cjtkxLK
         qrA7sMcYymzxX9hMjD6uYMuvbpkvNQKBLaXLAoudYWS5RW7S/6JU6o39DwTVMHD9iZsD
         Ccbg==
X-Forwarded-Encrypted: i=1; AJvYcCUGsEwgIXnBJpsyl09Ok9HvJTLzDAPWFirWxUvT6KzeRsmaEujSMTYiYAO6GMhVNB20psre84w1oNoTndI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIMXIwL2j24iylC3OdoKKAUnnf6ip9keC5ESYkcibf0oSWMPmV
	8hwU/0X4ZLMmbqLDSnK81xQ+7LLEmCWQf6H7+CDu+GV7bk5yzJiaN9/81iF+61g4F2OKfOF8cUw
	kXxofm8jQCx3q1plyxFLcIyY8Ptr189NmLNOKLw==
X-Google-Smtp-Source: AGHT+IEs0TymDN0qb1H6KzoG9uLNWYfnTI5aRT0d/XNeG7DXuzTNxv/klqY7eBy6ztM2Bw2F4aZOLOo9bzWg7LFprN0=
X-Received: by 2002:a5d:69cf:0:b0:374:b71f:72c9 with SMTP id
 ffacd0b85a97d-378895ca1a2mr1946306f8f.16.1725629939583; Fri, 06 Sep 2024
 06:38:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905163540.863769972@linuxfoundation.org>
In-Reply-To: <20240905163540.863769972@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 6 Sep 2024 22:38:48 +0900
Message-ID: <CAKL4bV4GT2R5WZqzTXkAkY6d8eL5PLnnTKoDK-XXL9pCzj5nbQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/131] 6.6.50-rc2 review
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

On Fri, Sep 6, 2024 at 1:36=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.50 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 07 Sep 2024 16:35:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.50-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.6.50-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.50-rc2rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240805, GNU ld (GNU
Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Fri Sep  6 21:24:14 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

