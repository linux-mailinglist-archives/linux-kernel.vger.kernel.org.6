Return-Path: <linux-kernel+bounces-192688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 572218D20B9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 129102833C5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09308171650;
	Tue, 28 May 2024 15:47:36 +0000 (UTC)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FA710A2A;
	Tue, 28 May 2024 15:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716911255; cv=none; b=INy/i9NYM+Tu+6tr4HqpzlscNUAnfjSQYNFoLOPuBOz4p7e6g1HAFzwmJV38vfAFzjhyQNbDcpWimsIJmQszJDUc6Mdfam4JCeJxaWFdsqGKLyi0Vc3A2X9zLaBSlS5pJj4hMb99uX64/UylhmZmk9gk0DuNmmX2rvTbT1BexgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716911255; c=relaxed/simple;
	bh=vPa9rF0pS41uHkATsANPc1ylod/pfLeVpRJJC/BDrqs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d1ydhQIDlkJOpEVFwZQ8wtf58joloJAz0Gnimk08SDxS8XjrIDZFVSdlGdA0T69Jfd1V64mYwSk+csia5Qbw425H608S3uADP+S4XafD982PMIDsh57Pao0JxvgTIlRely68bASs+R//RxuOIL1ByTf4bh6k/G4MMuVThJ5/m6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4Vpc8Z2Tqjz1qsP0;
	Tue, 28 May 2024 17:37:34 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4Vpc8Z0lYHz1qqlY;
	Tue, 28 May 2024 17:37:34 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id Hg5p6M9piD87; Tue, 28 May 2024 17:37:33 +0200 (CEST)
X-Auth-Info: HpTRMRkMphHhCoLp09Dcf9TUvqKPwejy3RutzhJcbFthbpKdAzzewlMWKt91fpbJ
Received: from igel.home (aftr-82-135-83-75.dynamic.mnet-online.de [82.135.83.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Tue, 28 May 2024 17:37:33 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id E856D2C0F8D; Tue, 28 May 2024 17:37:32 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Conor Dooley <conor@kernel.org>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
  devicetree@vger.kernel.org,  linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org,  Emil Renner Berthing <kernel@esmil.dk>,
  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>,  Paul Walmsley
 <paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>,  Albert
 Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v1 0/2] riscv: dts: starfive: Enable Bluetooth on JH7100
 boards
In-Reply-To: <20240528-outpost-subduing-2e84f77427a4@spud> (Conor Dooley's
	message of "Tue, 28 May 2024 12:30:46 +0100")
References: <20240508111604.887466-1-emil.renner.berthing@canonical.com>
	<87wmo2nmee.fsf@linux-m68k.org>
	<CAJM55Z-F6N6ua5LoqyMFogDtLp=FaRPoDv4osXFDMjR1b8r9nw@mail.gmail.com>
	<87zfsy102h.fsf@igel.home>
	<20240528-outpost-subduing-2e84f77427a4@spud>
X-Yow: ..  I want to perform cranial activities with Tuesday Weld!!
Date: Tue, 28 May 2024 17:37:32 +0200
Message-ID: <87ttii54n7.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mai 28 2024, Conor Dooley wrote:

> Looking at things to apply post -rc1, are you still looking into this
> issue?

I don't know what to look for.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

