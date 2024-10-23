Return-Path: <linux-kernel+bounces-377920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A62219AC88E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D51161C22594
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBE91AB6DC;
	Wed, 23 Oct 2024 11:05:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DE71AB53A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 11:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729681552; cv=none; b=LD4bOjHRpjiSvG03DKTCRaghHXPMXreaUxwGLZGL98q9tSdlPrPtUKh9qm7VFEZYNAqZwK7PiKhNJgePr1DWbek3qJnye7+M/b30vWZTS51tyAo1QJ94GNX0nHCx95oGXFbPkCvs9Ywz9DLcdJ+DV1higbhQy5ihV16RCRbHWqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729681552; c=relaxed/simple;
	bh=w64s/5bDrz2/hP+lYBGflyLsRmQM2n2tnsZ0h+y8gfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IV2s0vFkR6aYhVeZA1wxrxljrhqRcWDJomQldNv7FlKpH3ZMb06pe96Vfw39zn+foVvrWNFePYDxRObcUh8seh1yx+xKCvxJ6qcGfaiV098oxMJrtSGXRnCkQ5vwfautCHsl7HGRr1qOaboLGOAN6UYquk4j3HXTNpz554QxErg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15A0C4CEC6;
	Wed, 23 Oct 2024 11:05:50 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Drop _PROT_SECT_DEFAULT
Date: Wed, 23 Oct 2024 12:05:48 +0100
Message-Id: <172968153451.1430969.7795115918835596356.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241021063713.750870-1-anshuman.khandual@arm.com>
References: <20241021063713.750870-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 21 Oct 2024 12:07:13 +0530, Anshuman Khandual wrote:
> 'commit db95ea787bd1 ("arm64: mm: Wire up TCR.DS bit to PTE shareability
> fields")' dropped the last reference to symbol _PROT_SECT_DEFAULT, while
> transitioning from PMD_SECT_S to PMD_MAYBE_SHARED for PROT_SECT_DEFAULT.
> Hence let's just drop that symbol which is now unused.

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/mm: Drop _PROT_SECT_DEFAULT
      https://git.kernel.org/arm64/c/0448a96e243d

-- 
Catalin


