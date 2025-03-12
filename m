Return-Path: <linux-kernel+bounces-558158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB09FA5E267
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE50D7A5844
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3051824419B;
	Wed, 12 Mar 2025 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hAAe1Szk"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FF11D618E;
	Wed, 12 Mar 2025 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800008; cv=none; b=LVbISqxeVuiQcBK4/bNL4Z6Uwho5aKVPUJxqBogVgs1+mA6HKP2umzObgXB3+E7IDqLEljWOtGPDLv4/2DD2nDAmsrvIu8ZbfYqe23Y2+9/uhcvGnUUUcK5LUfmB/adF5XHSad9T8GbWht3P904VSLXlkZNpIkSibluMiH4enHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800008; c=relaxed/simple;
	bh=PXXAL+wAm6QaYU/gT6snMc/Zu8ONlhZRGmWPNfVGUuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=p1HHbCKtIpHyxZMqhEI2q04Q5feMPCLp/SI4lv/VcPELnLiRmiiWCKKYrnQf2IAd5q+UexAgUFUnY/rZQI7VkcLzSSCY6Ola9SVrUIjT2R6h4020AguSI3Z8H/MSiPqFqRXnD02ndQECKpF0X66tlmC61SsnjUzE3w5EtmH+I28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hAAe1Szk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id DDC54210B144; Wed, 12 Mar 2025 10:20:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DDC54210B144
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741800006;
	bh=8t8Qck3OK+mqnyrM/lx4bqh1qgvMY7xZIfxxCR3feRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hAAe1SzkxauidIbsOJ+qC6UFS2/tkAfyPxviyx1aTMFpnusRdm5WTD0Lg7E/HFBm4
	 WyZmBbHh8KOOH2sU5u3gdhVxVFnmvfKDFJmLYMM5bx6mmBhlgNJ1tTda6owU+hmUfJ
	 ha10e/fdxfn5YEpWZdOxdfWlv+7gkuRZRtmD5J9g=
From: Hardik Garg <hargar@linux.microsoft.com>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	hargar@microsoft.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@denx.de,
	rwarsow@gmx.de,
	shuah@kernel.org,
	srw@sladewatkins.net,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 6.13 000/207] 6.13.7-rc1 review
Date: Wed, 12 Mar 2025 10:20:06 -0700
Message-Id: <1741800006-17418-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250310170447.729440535@linuxfoundation.org>
References: <20250310170447.729440535@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.13.7-rc1 on x86 and arm64 Azure VM.

Kernel binary size for x86 build:
text      data      bss      dec       hex      filename
29937422  17837074  6320128  54094624  3396b20  vmlinux

Kernel binary size for arm64 build:
text      data      bss      dec       hex      filename
36684450  15081117  1054416  52819983  325f80f  vmlinux



Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

