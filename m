Return-Path: <linux-kernel+bounces-547604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AC5A50B88
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91F51894549
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8232925335D;
	Wed,  5 Mar 2025 19:33:09 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDF519C55E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203189; cv=none; b=VIk2AS3FdtHdKIMZz44M5015LhPIhGIrUpza9AUn24vGNZ38If4FPGn0LSrDPGw+XbOMxp/tOJJxJAuvQZ/0vqKaqzEqKv+q+WT3tUKRhxv26Dv883b81ziyeL6FueomNXQQn5/1eiIRV17DAEEi8jVtI7l0vFMX3naeC5h0S94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203189; c=relaxed/simple;
	bh=10/Tw8JbtIHWDUtTlFSapHYtQyGq1lSaNW4TWNrwX14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r8w7NSdyl9MXwTW3xbv8tRbnBzCceJW3b8Re/rGqxmyddT06sgc+IsP9XVenRa39a5/AvJ2EcleOr/YTrm2c+ORwwFsHtVe/OH++W5M3vHNZtFTHkcINTXjKBydHfOVIA7uKvaHdzlGJ6M4BUTj8JXvgwhbB8KfXh92hZiSisEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BEC3C4CED1;
	Wed,  5 Mar 2025 19:33:07 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Will Deacon <will@kernel.org>,
	ryan.roberts@arm.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] arm64/hugetlb: Consistently use pud_sect_supported()
Date: Wed,  5 Mar 2025 19:33:05 +0000
Message-Id: <174120317313.1423488.11091478258805705032.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220050534.799645-1-anshuman.khandual@arm.com>
References: <20250220050534.799645-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 20 Feb 2025 10:35:34 +0530, Anshuman Khandual wrote:
> Let's be consistent in using pud_sect_supported() for PUD_SIZE sized pages.
> Hence change hugetlb_mask_last_page() and arch_make_huge_pte() as required.
> Also re-arranged the switch statement for a common warning message.
> 
> 

Applied to arm64 (for-next/pgtable-cleanups), thanks!

[1/1] arm64/hugetlb: Consistently use pud_sect_supported()
      https://git.kernel.org/arm64/c/34e8e63a6dc1

-- 
Catalin


