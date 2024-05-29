Return-Path: <linux-kernel+bounces-194625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECACC8D3F1B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 21:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B231F24C50
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 19:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0B71C233A;
	Wed, 29 May 2024 19:50:01 +0000 (UTC)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B591C0DCC;
	Wed, 29 May 2024 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717012201; cv=none; b=THmd9TUP/KHR9Ku6TsXQS+nUVJPFC9lNkHfzRP3I5cHJOL8y2cIrI74ffS3cQrsYXgGLPY97hGP1TBxM2bYrU3Ij/Br2I2R/XfL/phLDuc7fELaO4AR80effL1AhN0MIB4YWuEtfF+aBZmH7svjjpR63nPoMY/Fw02BHYusrETg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717012201; c=relaxed/simple;
	bh=R4kk8vdF172JQsu+zba+/XWB4MT4EEDQ6ks+oOGk/Tc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZycwOmIoZrepROrCSEIXxaKRLOmfsjSMpgSgM+SmjcachCX+hcPF0EKxFkxtp1rYi9YlV7TI6MyChE6d5vWAHtpDiYEkkAZjSkxm4LooIopf/VtXK97HQmLTfAmUc6FjgrCjmfg3/O4VF7pGr0ULUxAgjU6DxiiYyJXko/wjbHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4VqKjB6NXJz1qsPY;
	Wed, 29 May 2024 21:49:50 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4VqKjB5Cjhz1qqlS;
	Wed, 29 May 2024 21:49:50 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id Uh27It5nQX2G; Wed, 29 May 2024 21:49:49 +0200 (CEST)
X-Auth-Info: 0SwjUwDtw+nxunYaVMuVVnCmM5xNvnuk9yBSTzOmX3K5ggql+6ueXVIRbmsnRiUW
Received: from igel.home (aftr-82-135-83-252.dynamic.mnet-online.de [82.135.83.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Wed, 29 May 2024 21:49:49 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 917B12C121E; Wed, 29 May 2024 21:49:49 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
  devicetree@vger.kernel.org,  linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org,  Emil Renner Berthing <kernel@esmil.dk>,
  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>,  Paul Walmsley
 <paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>,  Albert
 Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v1 0/2] riscv: dts: starfive: Enable Bluetooth on JH7100
 boards
In-Reply-To: <f18a74a5-330e-402a-93ca-5552faf00e7e@sifive.com> (Samuel
	Holland's message of "Wed, 29 May 2024 14:30:31 -0500")
References: <20240508111604.887466-1-emil.renner.berthing@canonical.com>
	<87wmo2nmee.fsf@linux-m68k.org>
	<CAJM55Z-F6N6ua5LoqyMFogDtLp=FaRPoDv4osXFDMjR1b8r9nw@mail.gmail.com>
	<87zfsy102h.fsf@igel.home>
	<CAJM55Z8Ce1i==pSUj0z4T2y71g713-675mAYQP5qSN5Euz=rLQ@mail.gmail.com>
	<878qzsbona.fsf@igel.home>
	<f18a74a5-330e-402a-93ca-5552faf00e7e@sifive.com>
X-Yow: On SECOND thought, maybe I'll heat up some BAKED BEANS and
 watch REGIS PHILBIN..  It's GREAT to be ALIVE!!
Date: Wed, 29 May 2024 21:49:49 +0200
Message-ID: <87zfs89z4y.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mai 29 2024, Samuel Holland wrote:

> If the Bluetooth part has some dependency (pinconf, reset pin, clock, regulator,
> etc.), then such dependency must be declared specifically for the Bluetooth in
> the DT. Those seem to be correct, so maybe the issue is the maximum UART
> frequency, if the signal integrity is marginal. Have you tried reducing that?

How to do that?

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

