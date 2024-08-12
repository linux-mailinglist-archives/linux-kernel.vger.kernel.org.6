Return-Path: <linux-kernel+bounces-283043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6605E94EC41
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85DCB1C20D08
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7A817839B;
	Mon, 12 Aug 2024 12:02:00 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CEF3715E
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464119; cv=none; b=lVj9ruiN/rYm6YDvtRWpRHMi5Rmh77MdazvxaorvzW3PtXuol2HzX+Rfxcw8KNV/GNJs1LaNM80uJmRc9tByyNNJcgZHRLB6unX2Bcnlfz88DK0VGYQ+jbyJF5ivhQtDPvJcU6OtbD8FAeb7hTo/zxOZSdflRTT/xtxjUdDdZIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464119; c=relaxed/simple;
	bh=mfmFcYgLEGLxMYEk3jcYSG7IzHHxetrEWR+B4AWhaxY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ACVCKg3RECLuPwvk9+N89OEHRToJLGtj9O41JRH4+Wnh2UjolDNFpDEiRo/Kb8BTUpR3NPOakr445AinAPUWLSU6pi3gNiDN8YviXapF4xDomrF8v8GgRCFccvzq+tNca4yfk4IylTXILf5EfTGcEzEMlIdGwHK3opYppk8oWv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WjCmg4pGcz4xCV;
	Mon, 12 Aug 2024 22:01:55 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: dennis@kernel.org, tj@kernel.org, cl@linux.com, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240807025604.2817577-1-ruanjinjie@huawei.com>
References: <20240807025604.2817577-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH -next v2] powerpc: Remove useless config comment in asm/percpu.h
Message-Id: <172346406507.772934.17084991880915030609.b4-ty@ellerman.id.au>
Date: Mon, 12 Aug 2024 22:01:05 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, 07 Aug 2024 10:56:04 +0800, Jinjie Ruan wrote:
> commit 0db880fc865f ("powerpc: Avoid nmi_enter/nmi_exit in real mode
> interrupt.") has a config comment typo, and the #if/#else/#endif section
> is small and doesn't nest additional #ifdefs so the comment is useless
> and should be removed completely.
> 
> 

Applied to powerpc/next.

[1/1] powerpc: Remove useless config comment in asm/percpu.h
      https://git.kernel.org/powerpc/c/fa740ca82277b476a49fee83c6fdb023656ef779

cheers

