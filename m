Return-Path: <linux-kernel+bounces-283042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF2A94EC40
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 672E01F2269A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF6927457;
	Mon, 12 Aug 2024 12:01:59 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2883C1366
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464118; cv=none; b=kNt/ranN/z6y62/diWGbLBwnDXEJfnd/SCoOOOWzrIMp/ZCMxVwXCoU/dKkKzrS3Gt7YMMOuRbt389y17jdsg34KECJeDaoiMOCeFg+zHb7HExqM/ysAARf1WqgFsfG3r/kjU3X0um7GCAb5vlneNxMIqC4slUvYCZAL5WRq0Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464118; c=relaxed/simple;
	bh=XPjbO4QlWL5etbcplCXxwAutKPGLTbNrVMmS+fzuzm4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eB0X14S1UhZhAQOJF9IRG4csqg1nvkZykCmE5Vy/IUZxnZAodrnpkViXlxlhld0nyZj6AL14zJraJvB5oJSrrV/no2QEBwKirmMQj4xU8y7qNd8dajet1DvfpDeQc48UQ6DFnYhWzJ/Z7KW2jdeR4qMFen2A2So6m3hwslOJfvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WjCmf6t4jz4wcF;
	Mon, 12 Aug 2024 22:01:54 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240731191312.1710417-9-robh@kernel.org>
References: <20240731191312.1710417-9-robh@kernel.org>
Subject: Re: [PATCH] powerpc: Use of_property_present()
Message-Id: <172346406496.772934.9733735582676595864.b4-ty@ellerman.id.au>
Date: Mon, 12 Aug 2024 22:01:04 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 13:12:47 -0600, Rob Herring (Arm) wrote:
> Use of_property_present() to test for property presence rather than
> of_get_property(). This is part of a larger effort to remove callers
> of of_get_property() and similar functions. of_get_property() leaks
> the DT property data pointer which is a problem for dynamically
> allocated nodes which may be freed.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Use of_property_present()
      https://git.kernel.org/powerpc/c/8a93960abed960b9f6097b6471b7fb34120ffc6a

cheers

