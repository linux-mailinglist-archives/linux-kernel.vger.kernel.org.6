Return-Path: <linux-kernel+bounces-561980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 124E0A619B5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 561FB3AB337
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AF620485B;
	Fri, 14 Mar 2025 18:43:44 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E57D1E5B9E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 18:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741977824; cv=none; b=LQdLgZ3/ZmzkCKbuHNfxS83GXXjryJszBoose6sSCLKY/AXR5rPfbbseLFRwl9WTpS6utjsbKHo0NtfCl1+ZaJ0B7eMaMxypZXXfVrerSyC5fsyVFeiiScrpvhVbIFPy+xVeAPT0FvMlpTmD5jZ+PeprFnew6k65yHFRYQit/d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741977824; c=relaxed/simple;
	bh=T3EVTlpNB2JPFMzFXviIqp4ddkZcFhIdzfHM2lxNZEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pAsiaMw/GuKGHDcI+ivT0COuD8EAIZgNXIAA5ZWB4krSSlhrmYppo6MLPAFZ+fhBtW2UaQWfsK/yVoX/w1oJZA/KgLjLL35N7nXBHKahUI3+0/4WkmQeWPzrdBBC6/QfaxhKjkQPx+vlcRMTPkg6HjeboRlsg0pv5+VlDXcc800=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BE5C4CEE3;
	Fri, 14 Mar 2025 18:43:42 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	robh@kernel.org,
	broonie@kernel.org,
	maz@kernel.org,
	James Clark <james.clark@linaro.org>
Cc: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	James Morse <james.morse@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/4] arm64/sysreg: Sort sysreg by encoding
Date: Fri, 14 Mar 2025 18:43:39 +0000
Message-Id: <174197777060.737113.10729866203138129273.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250115162600.2153226-1-james.clark@linaro.org>
References: <20250115162600.2153226-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 15 Jan 2025 16:25:54 +0000, James Clark wrote:
> A few small fixes and then sort and ensure sysreg remains sorted due to
> the discussion here [1].
> 
> Applies to next-20250115 for the review but I can repost after rc1.
> 
> Changes since v1:
> 
> [...]

Applied to arm64 (for-next/sysreg), thanks!

I'm not convinced about sorting, it makes backporting hard. Most likely
it would also conflict with other patches already queued. So I only
applied the first two patches.

[1/4] arm64/sysreg: Fix unbalanced closing block
      https://git.kernel.org/arm64/c/00cb1e01cd29
[2/4] arm64/sysreg: Enforce whole word match for open/close tokens
      https://git.kernel.org/arm64/c/2fdbf2ff3884

-- 
Catalin


