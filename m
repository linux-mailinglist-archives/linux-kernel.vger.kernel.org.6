Return-Path: <linux-kernel+bounces-577477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B840A71DB6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57AE33AAC7E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CDF1F8721;
	Wed, 26 Mar 2025 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="M9WGQumN"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925A71F6699;
	Wed, 26 Mar 2025 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743011055; cv=none; b=b2rs93dns/4JVmThKVqQLBb5lSJOSlh7V+FVDix1G6Eed+ekbKMM7RXRM72eldOjTSzAYK9C7i6VAf1m8NOJoSUsFgRyLsaKbapo3lnZ/z8+Rj9tgGK582IrEln1jda95/9Sv/oSkeE7PfZyGA+nc+/yMei076B+5h9+EJeCw/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743011055; c=relaxed/simple;
	bh=c1Wbi75LGrSeGt/aV3kfRa3hRUD3htYxVSNPBoaB634=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Y51HAv7prCcHCTvNmR9IhjDJP5Z2ysjIZAMxPdR6Yn5mSfng0hA6itGNjKXeUFT7W0RVRQ6zTXqnRTe6WATz2JPyugHdSy4Yi0o3Qv4aGGLjJujlf2EQdgwumqyDweB/bi8Q5PNVQ6OenfUAbaaIHgA5unENKM4ukf9TrYnkME4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=M9WGQumN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 15F8E203657D; Wed, 26 Mar 2025 10:44:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 15F8E203657D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743011054;
	bh=7ON7Lx5WziLX9EyB39yTlXH5hwR0+Sud+i4xgixsKG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M9WGQumNi47gap5ynxpBiSPoi9A7h59COPaUozisoG3pNa4ayhAqz+N47V5iFaPFo
	 jhZxBd7KpvZXyPcKivd+8FE1wkvQTCUtBAAH4qL/jZtK3JJ7Xud1Do44o91RaQWCc2
	 jtaWEF4StgNIuxFV2cGAPjuuyumn9cwZzW79iyRI=
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
Subject: Re: [PATCH 6.12 000/115] 6.12.21-rc2 review
Date: Wed, 26 Mar 2025 10:44:14 -0700
Message-Id: <1743011054-4428-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250326154546.724728617@linuxfoundation.org>
References: <20250326154546.724728617@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.12.21-rc2 on x86 and arm64 Azure VM.

Kernel binary size for x86 build:
text      data      bss      dec       hex      filename
27757173  17715502  6393856  51866531  3176ba3  vmlinux

Kernel binary size for arm64 build:
text      data      bss      dec       hex      filename
36395528  14996573  1052816  52444917  3203ef5  vmlinux


Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

