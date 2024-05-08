Return-Path: <linux-kernel+bounces-173341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE9C8BFF1F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2846D1C212CC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A129126F19;
	Wed,  8 May 2024 13:42:02 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAA486244
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175721; cv=none; b=MWRFxdkqVI2xEP/eFjizJ8LqnrcTc1OozLEpckPBQG1zlX0lquKzA+jZ+ncNQOltfD7QB95r/jjlBT7E60Hl3sKvxX9sseVxdtZBMQQQj16eZLZ3eqxr2XUtofxtvsDIPcUZNcZHiJn42FJMyw13G1WFQWEafz4DPRUylIiFoow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175721; c=relaxed/simple;
	bh=WQGjo0KOQfzPqgPzYYoZJZp2ermeNX4r8eyPXu0S4aY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nrd0xMXvpArOtEASuaJr3zOBD8mtqSGJJtr0NAEY1tbq5Z2mDWqQ4dakS3bQhZd6/+A/clTRXBH8iI6TcMY6nR0P2uT/wf6Cu1ZPTq/kPjgUPiVoVi/tVh7R8Kbz9zRqkxmBn5Ve4EegLTa3748MOSs0sNRdURN+JfRprwJ8Ifk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VZGXQ45fLz4x4T;
	Wed,  8 May 2024 23:41:58 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, npiggin@gmail.com, linux@treblig.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240503002317.183500-1-linux@treblig.org>
References: <20240503002317.183500-1-linux@treblig.org>
Subject: Re: [PATCH] power: Remove arch specific module bug stuff
Message-Id: <171517558546.165093.744820732746093524.b4-ty@ellerman.id.au>
Date: Wed, 08 May 2024 23:39:45 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 03 May 2024 01:23:17 +0100, linux@treblig.org wrote:
> The last function to reference module_bug_list went in 2008's
>   commit b9754568ef17 ("powerpc: Remove dead module_find_bug code")
> but I don't think that was called since 2006's
>   commit 73c9ceab40b1 ("[POWERPC] Generic BUG for powerpc")
> 
> Now that the list has gone, I think we can also clean up the bug
> entries in mod_arch_specific.
> 
> [...]

Applied to powerpc/next.

[1/1] power: Remove arch specific module bug stuff
      https://git.kernel.org/powerpc/c/4071739249fd2e647e7058dbab0db4ddc0a0c427

cheers

