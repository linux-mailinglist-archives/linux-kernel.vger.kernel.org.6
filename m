Return-Path: <linux-kernel+bounces-260158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B1B93A3F5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A680A1C22D97
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54744156C6C;
	Tue, 23 Jul 2024 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7+1hLkv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4D2156F28
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 15:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721749623; cv=none; b=nIbtoOcZ2JDl9EcuVDEp8+kp5v5Asp+/vSxYNqHjDOcczz0zetAcP+L1PBDd7mi8U/KT03PN1tfrJVS6PW84RRbUvlqyTsSLJpSLOsDuQvq4ObPgHBqucS5feFKBvc9IKE8u2kLB7LFaWNFf7SnBfK1uE7VS1JPKx3xIPEZUGik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721749623; c=relaxed/simple;
	bh=XVBNrvlzN38b6OTLsGpzsbNJf+KvGDn63v/k2m5kp7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EgPSjkdeeDJnlQxbl2Pc5amjqivQpyCYc229oPhcOXy/+qiqK4GqMqJ8Q3sGoN03eIY05FjuOyvHlV1T7jaGKM6n61p9rDSyaDnUhVWA0XaMuzlzEpI05e+YnWe8GTT51J+f1FUd7t4rpQxzfrl/08to6MqYGWp+7kyuxsJBoP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7+1hLkv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1C0C4AF09;
	Tue, 23 Jul 2024 15:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721749623;
	bh=XVBNrvlzN38b6OTLsGpzsbNJf+KvGDn63v/k2m5kp7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s7+1hLkvOpSXUA4iLLMertqWBetI0Ub/zeIInAVbD2k/S5OccJzeFxpELgmMA1U6f
	 5w4hHFnPHiTgA7wcI/eVQvqRfy85DbJDZhHBcQsinQr4VEnE+TrsdLM1NFQT32J+mQ
	 fe7SfNmIvM2ykBOJsvNEapbFV28CXTP6crffgjS9svn8UjZBcDi7HrdcTDaendQgf0
	 i6jqpdy2xqVMHy2f1rr7bEgzghYSAY1bbKEiwKFOuAAcRuA3N/1yxoOTuSaLjc7eLP
	 VqmxivDCt25/CzxXZiPOhXv8Jae4ErSjvz2A7kY4Gj0FWUSANFNg0fAzqCCXpdnqPS
	 yhuyeU+MT+OuQ==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	Anshuman Khandual <anshuman.khandual@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	mark.rutland@arm.com,
	masahiroy@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/Kconfig: Remove redundant 'if HAVE_FUNCTION_GRAPH_TRACER'
Date: Tue, 23 Jul 2024 16:46:52 +0100
Message-Id: <172174464309.279082.5991422775140917653.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240716050915.2657694-1-anshuman.khandual@arm.com>
References: <20240716050915.2657694-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 16 Jul 2024 10:39:15 +0530, Anshuman Khandual wrote:
> Since the commit 819e50e25d0c ("arm64: Add ftrace support"),
> HAVE_FUNCTION_GRAPH_TRACER has always been enabled. Although a subsequent
> commit 364697032246 ("arm64: ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL")
> redundantly added check on HAVE_FUNCTION_GRAPH_TRACER, while enabling the
> config HAVE_FUNCTION_GRAPH_RETVAL. Let's just drop this redundant check.
> 
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] arm64/Kconfig: Remove redundant 'if HAVE_FUNCTION_GRAPH_TRACER'
      https://git.kernel.org/arm64/c/add6128fc7f0

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

