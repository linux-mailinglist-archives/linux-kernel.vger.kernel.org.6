Return-Path: <linux-kernel+bounces-395271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE709BBB22
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F0C2810E9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0B91C3025;
	Mon,  4 Nov 2024 17:09:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4995762EB
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 17:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730740194; cv=none; b=XAYAjPiugHw6TgMqmtrdtcy1s85rv6crK1dMscqrGbqmD9tFTwgvKkGLmcu8pByDERlg7N1I4o8G1vcrTikzau3MgpQ7vb16aJjwZMf2+7bVAziCh7rGBvJamFXWdQkWO512f8kjOxI+89L8R2iVQUbG9YnyyevV7Sb9JZP4bwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730740194; c=relaxed/simple;
	bh=nA44HGw+YAyPk0lqEPZ1Nx0EjhV4bo+f1Mejm/3mbLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D69cLbl3UGMnmErAxGaJB8UQeLzGqt2n42tV2415+WBifbYyLIy9sotkG8bvD5GcDODcckJPHWGTuui76bYYIG+KoE7ZfIePFS2NyNi+Ja4EXI49NxFAtGs4puxfA6k7bWcpPjNPySFSO7GB3ux7mHI7vVfhCn7z6/Dao1m5z2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99354C4CECE;
	Mon,  4 Nov 2024 17:09:52 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Drop setting PTE_TYPE_PAGE in pte_mkcont()
Date: Mon,  4 Nov 2024 17:09:50 +0000
Message-Id: <173074012624.2444105.5179272721710586496.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241104041617.3804617-1-anshuman.khandual@arm.com>
References: <20241104041617.3804617-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 04 Nov 2024 09:46:17 +0530, Anshuman Khandual wrote:
> PTE_TYPE_PAGE bits were being set in pte_mkcont() because PTE_TABLE_BIT was
> being cleared in pte_mkhuge(). But after arch_make_huge_pte() modification,
> which dropped pte_mkhuge() completely, setting back PTE_TYPE_PAGE bits are
> no longer necessary. Hence this changes pte_mkcont() to just set PTE_CONT.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/mm: Drop setting PTE_TYPE_PAGE in pte_mkcont()
      https://git.kernel.org/arm64/c/ced841702ee7

-- 
Catalin


