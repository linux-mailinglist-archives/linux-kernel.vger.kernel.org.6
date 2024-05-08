Return-Path: <linux-kernel+bounces-173333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5448BFF08
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C811F27071
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5FB7EEE4;
	Wed,  8 May 2024 13:41:57 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB741E51F
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 13:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175716; cv=none; b=e6CBjYZunN7nv32dw+Y+BVgNV3gtiW7WiSNA7OK/eJ50YgDRU8zFY4tvrqAcBtzWdEjTjNxP3xB/Z4O7lUL0a63q3s3riMOO3fZlohGfIj3oKBVflfTfIAeaEX9HwDo5dq+288c2mhsThrMWSXKeaMf3vJQMAIz23hkc7+7I4gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175716; c=relaxed/simple;
	bh=fF7Tz5qZhbHZMYHU/GExgVLfos1DrPidC5n3EDqWO3o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sSaj15hpefV5Omn8fZb5po/n+fx3dhQPz/1Lh0ztYBZlTHRu6D6UXmoJR4UgVxPbFq41nfEOXvJIf4UJC+y0vgqGy9gIEPE0XaYAnQxsmyoy7rOS2h/TDtQQ9Y3yLTLfxWjfzshUKw5F8D4E8dzjZ5NonAnAWjbZw/2UOA4OaHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VZGXB5s5mz4x33;
	Wed,  8 May 2024 23:41:46 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, Kunwu Chan <chentao@kylinos.cn>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240126025030.577795-1-chentao@kylinos.cn>
References: <20240126025030.577795-1-chentao@kylinos.cn>
Subject: Re: [PATCH] powerpc/pseries/pci: Code cleanup
Message-Id: <171517558556.165093.1888093707103171409.b4-ty@ellerman.id.au>
Date: Wed, 08 May 2024 23:39:45 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 10:50:30 +0800, Kunwu Chan wrote:
> This part was commented in about 19 years before.
> If there are no plans to enable this part code in the future,
> we can remove this dead code.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/pseries/pci: Code cleanup
      https://git.kernel.org/powerpc/c/2d8ebee0aac3a45d81de4f44255c8021d5a3401e

cheers

