Return-Path: <linux-kernel+bounces-289938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C0C954D7E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 991B3B22874
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7796C1C230C;
	Fri, 16 Aug 2024 15:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bM28XNRN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF84A1C0DFE
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723821405; cv=none; b=LrSjUxSTLNIZDUpHCH+5jdihXPpvChFW65S1yKAveI6nm+mMwW9OgL1uVAaYQkSeCRIQ3pJCVgQt02dkKZ63LH64uZjUZbOT40tpbdmO9F3m6XsZ2GdFD/XyLpvUjMeF9Ai7KSguSZN1PnqdEo2RHA6MdGxZrDD/bYI/Hc3IoOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723821405; c=relaxed/simple;
	bh=c4V06q3FrLWm94Idywcyy5ZwUqpQ3qU5+i63NsPAaDk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSqsw4o3JCSN/ajCjopYuolZ+DCM6hAIiSAfb128ViDULan81q7MFzPzG+CH9lI1hIcj40gRLZ3U8ck89Nb3c+5ItmiBMxMzVhzGVLbAIkpiYxur5gddOe8+OMAbbmkCE+P88RFulpAwmoiufXMiv5RPc1LFizkK7FeZ+C5ZWMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bM28XNRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B39CC32782;
	Fri, 16 Aug 2024 15:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723821405;
	bh=c4V06q3FrLWm94Idywcyy5ZwUqpQ3qU5+i63NsPAaDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bM28XNRN28svM2g6ED4VKV9vVn53YSxqbXwQxMucgaTvZ1kjhuq1vCLp3DUAtxQih
	 hDFSJ2rv9VdOBLi71bYGCT5JYIhLE5nAHhtEIQWvCm1yfyBqfL8yPqXwigdVgeWjoi
	 RnycbYbJIUqfolafz0sHAelWqjZaLbke6YtzKxH6ABDBXRqbyZUq1+gMDsXzYM8Jx8
	 wL99EbeLCUPnknhQkMMIl0UNdxeJxV5OD0zCE03h/zsUYnsP0bS3tC9Qvha+y3GL5f
	 Q5q+fWmrIx1nK+tdQqikEhV3Ws1U1IeDSPJMCmvbVQcapYmJb7ppLHasL+PjPdra2v
	 ajCIHH5F/n+cA==
From: Will Deacon <will@kernel.org>
To: catalin.marinas@arm.com,
	broonie@kernel.org,
	mark.rutland@arm.com,
	Yue Haibing <yuehaibing@huawei.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] arm64/sve: Remove unused declaration read_smcr_features()
Date: Fri, 16 Aug 2024 16:16:03 +0100
Message-Id: <172380529549.1164361.4192187183006952773.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240810093944.2587809-1-yuehaibing@huawei.com>
References: <20240810093944.2587809-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 10 Aug 2024 17:39:44 +0800, Yue Haibing wrote:
> Commit 391208485c3a ("arm64/sve: Remove SMCR pseudo register from cpufeature code")
> removed the implementation but leave declaration.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/sve: Remove unused declaration read_smcr_features()
      https://git.kernel.org/arm64/c/93b81abc6ea9

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

