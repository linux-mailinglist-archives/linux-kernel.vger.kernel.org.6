Return-Path: <linux-kernel+bounces-440142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9014A9EB968
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8A432826EE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C93214207;
	Tue, 10 Dec 2024 18:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFHT+fK/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C393204696
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855708; cv=none; b=OMGeYhJLI1uV8WbdlhGcpjjzh6++1WCPfA6QIkFdbsF7W4Bqm7hM4sTRPHGRK8x2gRQZ0baLiOw0xodIgvMOUaoljk8Viz9+4BUV0OpgZYFjCcjZXUpznP3/0xdCpo27hHFWrBIW5woKqfNAaJfuHGsXgBkIlDDlofl8yvuLXIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855708; c=relaxed/simple;
	bh=9LharZa16OofMPaEDCesasz39XzH6ib3Z17ZeyyX9Ss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nevo69DBWvWXuEja9fp0QijTPByx6n3zxd1o91F31t/1E0t2cA5LHQlZWrZGpgK4JQWMM9BEg59SwmYmxR6ruA30Ghoryphm9UjTql4y85gBbNI0u3Lvlrt10V64H0YACLPrCOYPVpi9bLwIYlznUxMdkQnIhXWk7kBt4/3qdk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFHT+fK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8155BC4CEDD;
	Tue, 10 Dec 2024 18:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733855707;
	bh=9LharZa16OofMPaEDCesasz39XzH6ib3Z17ZeyyX9Ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UFHT+fK/gUHEkpSwS1en/4ti4hxrlxaWXQUW4sl7eGOTAHGQGOhv5Im4cW3yj4jfb
	 vBke+5IAJPx/hL2i6gckdXapdTbEL1UOBTxhvrQ/AUDijx1S/zLtbCScVtBgXN6EKw
	 /Q8dV++NGuBDNvkZp4D/2jTg0hFz4BrVqLDgO2xSk65DLihOC/Z9j8aXJqsp6PIJUU
	 gSr4u4KRTXKizD6L/n2CmoabBYdECVOUUiEzfSNW7Fsz/R0uPdVZHokZ21Al+b+46c
	 r5eykfOn1xrKeJ9L1bXWQRstFAsW3LL4y8ZVYsAV7HOz6o1kihchYM5R4nIMpfzqzq
	 xIJor//EvSwVw==
From: Will Deacon <will@kernel.org>
To: catalin.marinas@arm.com,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND] arm64: asm: Fix typo in pgtable.h
Date: Tue, 10 Dec 2024 18:34:48 +0000
Message-Id: <173383048640.3808253.4005904648913144834.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241203093323.7831-1-zhujun2@cmss.chinamobile.com>
References: <20241203093323.7831-1-zhujun2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 03 Dec 2024 01:33:23 -0800, Zhu Jun wrote:
> The word 'trasferring' is wrong, so fix it.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: asm: Fix typo in pgtable.h
      https://git.kernel.org/arm64/c/e281bd22998b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

