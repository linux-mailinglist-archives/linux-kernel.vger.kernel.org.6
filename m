Return-Path: <linux-kernel+bounces-222612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 824CB91048A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB09D1C23090
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 12:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133C71ACE81;
	Thu, 20 Jun 2024 12:50:50 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ACB1AC767
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718887849; cv=none; b=aSgwaqnqobVOtA8fAi3QM1NUejBGx1mEghaENyntO8N55rxzMcco80tD2GAdWdw5izdLdrOQ3bRBAr18WUZr3nGAC1c3gVkl7+Yr/+bHFgeufYmHnOGUHvfXjVMNKpFXW+69VYcqlOi+tSKCCwHYp6hGVjqSPxzso/G/M5ASOHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718887849; c=relaxed/simple;
	bh=hd23P3AHr//PBfB5UtyTv08Hw4j/j8+cjgNQoagL2G4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HkZUpg044JLk1G+2Via9Bt0z6TzRV/0u3x4HKbW03SGlJWfOMb2ntF8JH5uEncgEOu9iAvNPZUqgU4GipHH3r7FmnaRmpF4rb/FCwi34DlfnYERmZ3gNNzdxqml8FrkrtKfoE++2jaofL/qG49afX/lAIkRo9hmZsR4kUmeXAoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4W4gMV0jP8z4wcg;
	Thu, 20 Jun 2024 22:50:46 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen.n.rao@linux.ibm.com, Gautam Menghani <gautam@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, aboorvad@linux.ibm.com
In-Reply-To: <20240514132457.292865-1-gautam@linux.ibm.com>
References: <20240514132457.292865-1-gautam@linux.ibm.com>
Subject: Re: [PATCH v2] arch/powerpc: Remove unused cede related functions
Message-Id: <171888775095.806750.18022878075319680310.b4-ty@ellerman.id.au>
Date: Thu, 20 Jun 2024 22:49:10 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, 14 May 2024 18:54:55 +0530, Gautam Menghani wrote:
> Remove extended_cede_processor() and its helpers as
> extended_cede_processor() has no callers since
> commit 48f6e7f6d948("powerpc/pseries: remove cede offline state for CPUs")
> 
> 

Applied to powerpc/next.

[1/1] arch/powerpc: Remove unused cede related functions
      https://git.kernel.org/powerpc/c/214f33fcf656bf1be3f9f03d58fda067cdf7eecc

cheers

