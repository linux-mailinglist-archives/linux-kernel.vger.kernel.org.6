Return-Path: <linux-kernel+bounces-283040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2967994EC3B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5E00B21CA2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDE0178CE7;
	Mon, 12 Aug 2024 12:00:37 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FD2170A08
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464036; cv=none; b=fYBA7DrruD/bK9UG1v7Ko3WualqYc7+UTIwT+GzdKv3tauAGwSpaYf9gJCy+QLOzI1MkMUTs08fIll/npa+sPfSr+8mjraVA5MLoBI0CrJr7R2UVFyi4+TyAlbtn1D9En9gE2w1dKPzT0YQdsWqRrtDhZLhibvIeITpLI0DYQfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464036; c=relaxed/simple;
	bh=NWmzRnfV1qQl3sfE4Y69k06o+WCasZ3xjlNRbOl79WI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eAxZsNokTXrRImkmYfAXpgOj2OtZD1fDUcHGdvjLySgCfLZacLQ7Il8hc1FAi/5wP4UMe5U2y+16FN3ysloB/bvHiDmaKXW6/+x2zIAXcbGo2shnabGcFOQpejm3kvHjU0VES8bw4PdZVWMaOQMg7lhFejKKYavxC42N3zCMimU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WjCl34NBYz4wcs;
	Mon, 12 Aug 2024 22:00:31 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Andrew Morton <akpm@linux-foundation.org>, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <1cdaacb391cbd3e0240f0e0faf691202874e9422.1723109462.git.christophe.leroy@csgroup.eu>
References: <1cdaacb391cbd3e0240f0e0faf691202874e9422.1723109462.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/mm: Fix size of allocated PGDIR
Message-Id: <172346398143.772106.7025827300868207438.b4-ty@ellerman.id.au>
Date: Mon, 12 Aug 2024 21:59:41 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, 08 Aug 2024 11:32:47 +0200, Christophe Leroy wrote:
> Commit 6b0e82791bd0 ("powerpc/e500: switch to 64 bits PGD on 85xx
> (32 bits)") increased the size of PGD entries but failed to increase
> the PGD directory.
> 
> Use the size of pgd_t instead of the size of pointers to calculate
> the allocated size.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/mm: Fix size of allocated PGDIR
      https://git.kernel.org/powerpc/c/e7a9af8c93aa9f408f9972809b642faeec5287e1

cheers

