Return-Path: <linux-kernel+bounces-524280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF4BA3E166
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 466A57A82C9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E62215072;
	Thu, 20 Feb 2025 16:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="Frzm7BDE";
	dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b="rE6oq4vS"
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFD9215054
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070068; cv=none; b=QC/jX6m/QpZmJSmuoMBstkZcz4tgggwz0jaX23GTPZNW3j3zmI6n172BU27+bz5mfGdEoCuBWA3Zbpv6a5ixBykEGjTSJ/Tcyc6QY7SavD5iHzBPeXyEcWeQKgXZD6nwO3RHQs2oJJ2EpVQhLB4TIHKeRtZMZX58lKNTT5gEO3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070068; c=relaxed/simple;
	bh=G8Rvj1+RYM5PtCvCGhsKpVb42PxUTrWVFF4NYbTXBoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uo+4GZcW8sBo7B921cKqLqkMc7lr6MaF4hlg7fzL1BbgMKloQSmNgz7cTLCca2TXIRi97Fz4vUA4t5GJf7ZsH9Pyjznh28SwpOO3JiqQY2WBDhZS2INhkr4ClPJSUsV9kNwr8/O/wpLR+r3q+4vWClmrMp9f5+b+sVpNarjsrLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=Frzm7BDE; dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b=rE6oq4vS; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 61D602A2EE1
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sladewatkins.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=selector-1739986532; bh=LvrmbHNdQa4JVysc/FIbRXhYNUaX8nkPjWm+cWDvugI=;
 b=Frzm7BDEU4kl2jqh8juk0J5UlPtaXXXlLuw8tOmbJq6uzNIeLF1assocYXiP/dKlrFBL1IwVTVTohchj7kFNkwYvLiDQiJ0q5c1fyNxEqGtK7OUWO1TFk4Es7QdSTqOyfOM8+kXtKWSH96FCguHwDI5zAVmm1o4nSFyhiZjI5LCk8QkcOW27vkmyxwLX3kFnH4njD2Ze+mD+Cf56VIr+nVRjy6pAI7B0zqtaq7BRWXYxP3Y/yNHXxsifzBsl5DVS06xwZk5j3lKtxBjrg2GGVQ/D+PLgiuwX1vdy1wmnlpqX+jtruy/s/NosjTMfPwBySVg72V5k3i1wHcQdApjeZw==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id C4676600099
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:47:22 +0000 (UTC)
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-abbe5ac36a9so139905566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=google; t=1740070041; x=1740674841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvrmbHNdQa4JVysc/FIbRXhYNUaX8nkPjWm+cWDvugI=;
        b=rE6oq4vSeCi9p/d7podF3IFvjyRo+tOoOeVs9e9qLaZdP9rXWZYIHaBMag0fR6Xlrz
         SEZfHMt5yeHhz/MUZcotDSXT/dn0UwMzl3HGZ4A/iQ7Tm9kDZJrwolda9kyg4Q3EEgQW
         sfvX1nTHGE9Y8qB2JgfMzAV+twQIi/m7iQYhEixBaeZRNhRt/vGC5Et9jWtW8RxFoHP7
         NC9a0FaE2LawZrWp1eqqlKpw7b+4kOjUA05VDXa1eecs6aGmacoM49ILohQasiS6ZPtm
         jOG4TI9codCZy8Lomq/vNoVkLf3ViUhNopKNhDKeF4FEHidPKTayp9w7DUjn4GYUpQFS
         PPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740070041; x=1740674841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LvrmbHNdQa4JVysc/FIbRXhYNUaX8nkPjWm+cWDvugI=;
        b=MoHe/4QNBPUGrmCfB3lhf4pj9N7HGwQnGMXEwAe8hvKN8ToOmg5cErqORhXXF7Pr9S
         i91yFUBHRr0luVt6Cl52KFMaiyHr23/ljgQzq61DLOXfn4u2yhamqpkG+87t688FZdyI
         d/Mt1sf37HZuzLjHySxxar+IAgSrWS+mMIg97qxy+O0e7L44Pf3OafAgpNNd3ajskjLh
         XjmVkeFYciQcX635AmiriLZl2MaNFaAPC6XHUeUCIoirE1PfivMqZUBlfb7pMYsR7UeL
         VKcrRydlfwBxfdK/IDCn5CcT8PNBsnGN8e5qzSP6MEGwNbHFNujD6gk7sgC8HPAPRP5S
         VUEw==
X-Forwarded-Encrypted: i=1; AJvYcCUok4P7DRgUppke0/hy1uQIRIUOKqPJp717iuw5c6sk768O2nV3RgSwp5qmLiwlVPyKvMQNlq3g+mfrC04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd/l/Z4SDl2m8YNQaSSLx//4QGhItEv7Raw1Ed8+Q1rHJtA9gP
	MdS2fMnPf7o5xXd/HCdiTSCjgm+ZPmvsVPoGEdOynRA4VCZoPWrKyXxoHLHDRJAniF+YkSFgERq
	oYyXUa71YocUmzmqgkihQE8AtEAghm4fJ1WEzHt+n9lBxU9rX1ORVIhINa2iAz/nIq6Q3PYOKqY
	JsXRVi9LzKuKUtdO9lFwAvibrRC/eOTaDP0nyWswnf6QJD1JzEGnkJkBRqcg==
X-Gm-Gg: ASbGnctibiJX97HFqowOrsIStrEsJifVNuIhqMdxhXjJMbRZd0xBgHrYBkjkW9IsRwp
	LSInAKn583TzXc1G3jfBtyX2lruBcnt24WnpKCyATj+JEZbGZpueTacOTNL/qpA==
X-Received: by 2002:a17:906:3083:b0:abb:83b9:4dbe with SMTP id a640c23a62f3a-abc09c0d19dmr509066b.47.1740070041336;
        Thu, 20 Feb 2025 08:47:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBCENTa9zojiB6+sevtUZcBrd1NLHq2XG6gSAX9QhN/ExTmOHUxbRZ1VeIW36PUVvO/3J3D44f/zHm02o796g=
X-Received: by 2002:a17:906:3083:b0:abb:83b9:4dbe with SMTP id
 a640c23a62f3a-abc09c0d19dmr506066b.47.1740070040871; Thu, 20 Feb 2025
 08:47:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220104454.293283301@linuxfoundation.org>
In-Reply-To: <20250220104454.293283301@linuxfoundation.org>
From: Slade Watkins <srw@sladewatkins.net>
Date: Thu, 20 Feb 2025 11:47:08 -0500
X-Gm-Features: AWEUYZklFFz99Wzn4U-bFKpzlTK9ociJQmc_XORzn4XFpW7PpwbbhCLQN7WTZQs
Message-ID: <CA+pv=HM=0yKe74WT8dDHYvxFvCSsHocGwjz-82mMU8oosn2mAA@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/225] 6.12.16-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MDID: 1740070043-Y5G8Jz-jxH4g
X-MDID-O:
 us5;ut7;1740070043;Y5G8Jz-jxH4g;<slade@sladewatkins.com>;c71d53d8b4bf163c84f4470b0e4d7294
X-PPE-TRUSTED: V=1;DIR=OUT;

On Thu, Feb 20, 2025 at 5:58=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.16 release.
> There are 225 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Hi Greg,
No regressions or any sort of issues to speak of. Builds fine on my
x86_64 test machine.

Tested-by: Slade Watkins <srw@sladewatkins.net>

All the best,
Slade

