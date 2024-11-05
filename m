Return-Path: <linux-kernel+bounces-396518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAD29BCE44
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E6D9283666
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7941D63D7;
	Tue,  5 Nov 2024 13:51:42 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754361D45EA
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 13:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730814702; cv=none; b=cx/jIONiMrBqHgodGR6AwaQ3XBmBLg9ftccPyuB89gGJkW8UJUCW71dDi3Ht7mEDHgOQkijNIMsdCT5dkKcByvxMJBjTC9VtH6gAUlceMgwgH2Ok3kbwDsmr+Y4SQjnwgJPLbvcZQVOeHbUNyWiCy5Xx32ShVOiTVjewq4+m7OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730814702; c=relaxed/simple;
	bh=AwW0Shd8VG7jOvjlzGTXdZBeksNxmYEQ7FZEFGIL80U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NePgYry3vLhYUoLrPT8NR2KfmDsDHDt0RsNM5bZMz8mfnySdfwuCO+bFW5L4BEYoogoy6VSRg7Hj8X/rys7S9saRb0UstHzpOasWOp6z7ZreOxhm/kMFP8hhnYtfupUEjAihBIEPfIQ/Ff6VSpPViy66OLEjhKmfPF4XRgtjFFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D23C4CECF;
	Tue,  5 Nov 2024 13:51:39 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/ptdump: Test both PTE_TABLE_BIT and PTE_VALID for block mappings
Date: Tue,  5 Nov 2024 13:51:37 +0000
Message-Id: <173081469049.3480353.2637044997787719917.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241105044154.4064181-1-anshuman.khandual@arm.com>
References: <20241105044154.4064181-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 05 Nov 2024 10:11:54 +0530, Anshuman Khandual wrote:
> Test both PTE_TABLE_BIT and PTE_VALID for block mappings, similar to KVM S2
> ptdump. This ensures consistency in identifying block mappings, both in the
> S1 and the S2 page tables. Besides being kernel page tables, there will not
> be any unmapped (!PTE_VALID) block mappings.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/ptdump: Test both PTE_TABLE_BIT and PTE_VALID for block mappings
      https://git.kernel.org/arm64/c/dc9b74a76320

-- 
Catalin


