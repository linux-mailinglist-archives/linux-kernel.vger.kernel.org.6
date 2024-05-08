Return-Path: <linux-kernel+bounces-173334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EB28BFF0A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011431C21FDB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3493E81ABB;
	Wed,  8 May 2024 13:41:57 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050E8768FC
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 13:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175716; cv=none; b=oYeOog3AdgV7sHcn6RncMhEjeddNgC8NyipyJMd+ak18u/a4Px6o3k5hbIIVxIot7Ye6JXHiJRwCTdgv55DQgBZsPov2Oz0pidOQK8Mc3KIKY54xVnMEdpugKv/vYaqLycy1n/k6MGJq5Tl/53eTHpHRX961EO1vLjmdXkYHoOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175716; c=relaxed/simple;
	bh=Txx4Yud5UEU0OVCIwwHmcf9KT7+PYgR0XhbF6Lp8vG0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pIV9ggIqacx/Bi/SHLG3KA90RKhmBNVMLrbR+OJQO3AMJrbwvFICB/PM6yRUtvhMsWKnSInODff9YXNkLMvpGEaeqSeE9Dw1j3L74gSH7CrozzZBDbQELkAzQ5J7psdwxz2ZnO+yZ5J78KhQ8ggODyVgdrGMGkswBVlp1iI0sgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VZGXK12D8z4x3q;
	Wed,  8 May 2024 23:41:53 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: arnd@arndb.de, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, Kunwu Chan <chentao@kylinos.cn>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240125082637.532826-1-chentao@kylinos.cn>
References: <20240125082637.532826-1-chentao@kylinos.cn>
Subject: Re: [PATCH v2] powerpc/iommu: Code cleanup for cell/iommu.c
Message-Id: <171517558555.165093.13672934998542887170.b4-ty@ellerman.id.au>
Date: Wed, 08 May 2024 23:39:45 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, 25 Jan 2024 16:26:37 +0800, Kunwu Chan wrote:
> This part was commented from commit 165785e5c0be ("[POWERPC] Cell
> iommu support") in about 17 years before.
> 
> If there are no plans to enable this part code in the future,
> we can remove this dead code.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/iommu: Code cleanup for cell/iommu.c
      https://git.kernel.org/powerpc/c/f3560a2ba5cbbb6c62c14dbdc1e33cb3565199d0

cheers

