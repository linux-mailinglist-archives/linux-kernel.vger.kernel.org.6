Return-Path: <linux-kernel+bounces-173353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 440688BFF3A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 749B91C20AB7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27B37D3FE;
	Wed,  8 May 2024 13:46:23 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFA11E51F;
	Wed,  8 May 2024 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175983; cv=none; b=oWeqE3bNiAGD+KvVrB7XqQ+HqWwu2rC6cl0Hzub9d8U+tRFszEBxg7xsdx+XmFaxc9EDU5W7KsJjoE6JtRcpxYkH+YY4R6FqMRX7N3rTMGojFNsW5Yz40e58H6SSXj2yVm96Ui6E2OrletegLmP4sx9QDa2657RgCQYBgG4zuKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175983; c=relaxed/simple;
	bh=kHPytl/WnecPTAFAs/1fEu2mwaIRPQ7ygJ9fBErgvy4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dkWF/bpWeR3HHvV1xfcLrjbhkRd3xJvFCorO2Xneh7OuVjU5bmaX/cw87ewi5FE5NzL3uSMUiFEuDaBQxkb6HnjcIps4ctmH2PCrT91mwx5o+Ng7jEBxeBjkcSDaN1NLfgfpLF8cGeW4JVz+DsRxAOx02R2IWEojOop0bvzKY3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VZGdS0z3Vz4wb0;
	Wed,  8 May 2024 23:46:20 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, Kunwu Chan <chentao@kylinos.cn>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240125083348.533883-1-chentao@kylinos.cn>
References: <20240125083348.533883-1-chentao@kylinos.cn>
Subject: Re: [PATCH v2] KVM: PPC: code cleanup for kvmppc_book3s_irqprio_deliver
Message-Id: <171517595457.167543.9885593763734582769.b4-ty@ellerman.id.au>
Date: Wed, 08 May 2024 23:45:54 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, 25 Jan 2024 16:33:48 +0800, Kunwu Chan wrote:
> This part was commented from commit 2f4cf5e42d13 ("Add book3s.c")
> in about 14 years before.
> If there are no plans to enable this part code in the future,
> we can remove this dead code.
> 
> 

Applied to powerpc/topic/ppc-kvm.

[1/1] KVM: PPC: code cleanup for kvmppc_book3s_irqprio_deliver
      https://git.kernel.org/powerpc/c/a9c08bcd3179a59998d6339505d0010b82cbcb93

cheers

