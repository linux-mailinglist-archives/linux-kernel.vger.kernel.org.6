Return-Path: <linux-kernel+bounces-554881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4F8A5A2FF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD4B3B0621
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D882376E2;
	Mon, 10 Mar 2025 18:33:03 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D829235BF3
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 18:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631583; cv=none; b=PUsaUs15aEQElc634pnCAXCp+vCnPEydNV3V4XtSPEy5Mg253QW5S1nxzfuyZ2XOvl2FB6XZPXnf7GTVEkw7QyAkCYZ429rtBxZyZAM2nadAf1JerM9hd55vdWI4hAFDUL35hUnMDwo06q8+2SLzbL4ckqzJJc5KMhkxfyXAxUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631583; c=relaxed/simple;
	bh=t4Uv6uyVW3jYkWEtLWpqVJj5/ztgiHaitXl7ZTeh+a0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ccCud0kSAftaEhEpaXLowW11I5fRiVNOyguhE0JMq+4Sdh8WmDbtz7bCj1R9wNesrF3Zi8Uj1cKNnhG8unf/VbqSfIYSpW2WE6Ci2SePWckDFVLExO6tzys+cfYiEojNJYAWTRyMApDFi8Rcc+8IZlBWAXK9DgO13FsSWsfGtEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05A5C4CEE5;
	Mon, 10 Mar 2025 18:33:01 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	Joey Gouly <joey.gouly@arm.com>
Subject: Re: [PATCH 0/3] Minor improvements for PIE/POE helpers
Date: Mon, 10 Mar 2025 18:32:59 +0000
Message-Id: <174163157306.3207771.13653726246249700352.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250219164029.2309119-1-kevin.brodsky@arm.com>
References: <20250219164029.2309119-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 19 Feb 2025 16:40:26 +0000, Kevin Brodsky wrote:
> This is a collection of minor cleanups and improvements for the PIE/POE
> macros in asm/sysreg.h and asm/por.h. Besides the readability
> improvement, it will also come in handy for the kpkeys series [1] that
> performs more calculations on POR_EL1.
> 
> - Kevin
> 
> [...]

Applied to arm64 (for-next/pie-poe-cleanup), thanks!

[1/3] arm64/sysreg: Improve PIR/POR helpers
      https://git.kernel.org/arm64/c/f91a3a6088ea
[2/3] arm64/sysreg: Rename POE_RXW to POE_RWX
      https://git.kernel.org/arm64/c/83d78bbfd2a4
[3/3] arm64/sysreg: Move POR_EL0_INIT to asm/por.h
      https://git.kernel.org/arm64/c/650701e4ead6

-- 
Catalin


