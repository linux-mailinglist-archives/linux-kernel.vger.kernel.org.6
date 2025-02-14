Return-Path: <linux-kernel+bounces-514161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ACFA3534E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 01:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54EBC18905A8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 00:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B5210A3E;
	Fri, 14 Feb 2025 00:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Msx1jMh+"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42F653BE;
	Fri, 14 Feb 2025 00:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739494656; cv=none; b=nvBTlhRAgTqZoUHGfyv1tP9htVMIrEdJRY7VQ51ZP2ZZ7OucM1rtkH1HQ2D2WXEqIsUKBWQINe8hjAU+UKQKkHQH7NlO/Q80GBNHlJVum9oTzNm0UfJW5D0jcR3E5TcocyI4apuCt4SbUjHhzz8VCUYG0LABXEUCiNOc/aIjqQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739494656; c=relaxed/simple;
	bh=3qq0Ly0A5tAnGRZdCfCjmcPf5YsBZ2tYnOLJcQ1cHuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Zo+iTzDWUbt1CPS/NDg5Qpk7svyCNKGsjWOLyL5RmDnFn9+RmMRM47VghvRk1lJrPGKl35Ji6yu/Fly7oKRpQyxD4rKVcWZmTG4DJSokJP78/r6PFJHuj/5EjCsq0vd0Tu/ef5VsiYVtR/zkpQhoaGop8r5cNUDTBGOHFWwQdjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Msx1jMh+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 20F34203F3CB; Thu, 13 Feb 2025 16:57:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 20F34203F3CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739494654;
	bh=/KYFxEWn48rDfElAYqCxOYlGTKfeD8A10IqJCEDMArA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Msx1jMh++zsTo0r1Pu1E9z6Nvh2L7Myh8p6of45pLfh5VMW2qquTwWIH3jAWy9bbb
	 txr4RGVXx5CydVSb/jYJIFmIhxPPH+5j01AVtJVu9DXffRPMRFAnIzP1RNmpaxfEBf
	 Dtnn8Qa6R7aI6kpHemGlrqi6CvK1l9minR5UEK28=
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
Subject: Re: [PATCH 6.12 000/583] 6.12.14-rc1 review
Date: Thu, 13 Feb 2025 16:57:34 -0800
Message-Id: <1739494654-24752-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250213142436.408121546@linuxfoundation.org>
References: <20250213142436.408121546@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.12.14-rc1 on x86 and arm64 Azure VM.

Kernel binary size for x86 build:
text      data      bss      dec       hex      filename
27753180  17708790  6397952  51859922  31751d2  vmlinux

Kernel binary size for arm64 build:
text      data      bss     dec       hex      filename
36370736  14991857  1052816  52415409  31fcbb1  vmlinux

Tested-by: Hardik Garg <hargar@linux.microsoft.com>



Thanks,
Hardik

