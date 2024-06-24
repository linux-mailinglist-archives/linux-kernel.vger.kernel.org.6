Return-Path: <linux-kernel+bounces-227763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502A591564E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3172874DD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604221A08CA;
	Mon, 24 Jun 2024 18:12:26 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9AD1A08BD
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719252746; cv=none; b=TthDDo9ZmY0s8lKPwNjFOvuMiwyiOaO25dSj54QdtCHakZjNuN9uSpOUqwMJtH2TEDwvVg6N9VNZZ+NYIJsc5ppnBSKkfRLXwTjnWFdiU6TAKsZhAv8tJMG6hhI+Thf1CtjNwjezbIbua8BhV++CYwTgzTjT339O88SF5v+To4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719252746; c=relaxed/simple;
	bh=HUsPDu1pns3cC9nlHD07Fw7yIJrXN8oMMhE+h33aRIA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtbKnj0oZJWOE/ax1ExewqyQ6UpzxtmJ96VhBwrfMKhhpgIbcQoyLY1F+txIiuRellCMtTcAp8LSCe0M5nhw14t6HjxbvuEQJkHdM/JqByI/VUClpdxsR2hvaumFBj6CFzEX27gkOuyc1UANF826BNkXV+6eyEvsu4j1pAk65eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AEAC4AF0C;
	Mon, 24 Jun 2024 18:12:23 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Will Deacon <will@kernel.org>,
	mark.rutland@arm.com,
	ryan.roberts@arm.com,
	maz@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64/mm: Stop using ESR_ELx_FSC_TYPE during fault
Date: Mon, 24 Jun 2024 19:12:21 +0100
Message-Id: <171925273632.3100383.7372147341915040294.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240618034703.3622510-1-anshuman.khandual@arm.com>
References: <20240618034703.3622510-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 18 Jun 2024 09:17:03 +0530, Anshuman Khandual wrote:
> Fault status codes at page table level 0, 1, 2 and 3 for access, permission
> and translation faults are architecturally organized in a way, that masking
> out ESR_ELx_FSC_TYPE, fetches Level 0 status code for the respective fault.
> 
> Helpers like esr_fsc_is_[translation|permission|access_flag]_fault() mask
> out ESR_ELx_FSC_TYPE before comparing against corresponding Level 0 status
> code as the kernel does not yet care about the page table level, where in
> the fault really occurred previously.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/mm: Stop using ESR_ELx_FSC_TYPE during fault
      https://git.kernel.org/arm64/c/573611145fcb

-- 
Catalin


