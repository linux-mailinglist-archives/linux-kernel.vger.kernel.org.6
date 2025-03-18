Return-Path: <linux-kernel+bounces-566085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A43A672E6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADEC07A928A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D8520B7F4;
	Tue, 18 Mar 2025 11:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvanpjKY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11FB20B7E2
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298209; cv=none; b=HbgaU5qt1o8eWorQGX2JAyMhJ4vQaXzc/hNEiTWfshKHeMxxNq2pxwCwGENk3kT0eMAwfJagv12fWOydZapY90rzuz2WUiCngE9wOIQ/KipDYR2M6xw0ojcvjFANpy74Ilccgk17bIrOcCiwhfCPJf1G0SYgn2sBj9WTMCPOujk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298209; c=relaxed/simple;
	bh=Vlsxlh1AOW/QiXTampQxQJe/BaKBoGTXudbRio4oViU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KroN6GA+qLQ4aD6PWGt/FrwlgNHdCXCBkFio9ThezoCTkGEeXA+KUyav3b7/Nr/EeAdub/OsGNCphRJZylCLRWQfJ3tr/E3ungYCXeAwSBYbNnUr+DiDSYdmMte1gN1Zmn/JMuZHk6UjM5s2r/l/aejReUM1B/mEe9zZz4VfYWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvanpjKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E17C4CEDD;
	Tue, 18 Mar 2025 11:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742298209;
	bh=Vlsxlh1AOW/QiXTampQxQJe/BaKBoGTXudbRio4oViU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LvanpjKYLeX/AGVBpSR82hErBd5QXy8bzpNon4qzZ9e1PL1Ov61ah66m194iTnKe0
	 tt7Ug8izLxjHxMt0e5D3S8AN4p+3nniVafLKVX7T80TtLc+nV4v84EgIaj/3Ftklaj
	 t3o2Zwj3fe5szCpmEIcXTwCTMfQ5NBgt8uiYlUHTC8atyWfEHGcoViw77eGUnFeXvX
	 6m2i5uUYY3xeE9OQRlO4r6Smr0zyolJsCYjoHNNjaI6jrBAa4B3dPaS/N0RbZBfPhT
	 8DMLReM/yMnsjebI2Fa58W3P+tfBSd6T+gmldXPnrAb8VDjTMMhpgnXmjJsSqfMuxb
	 MPlc9sX80YY6w==
Date: Tue, 18 Mar 2025 11:43:24 +0000
From: Will Deacon <will@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	maz@kernel.org, rananta@google.com
Subject: Re: [GIT PULL] arm64 fixes for -rc7
Message-ID: <20250318114323.GA13641@willie-the-truck>
References: <20250314160458.GA9438@willie-the-truck>
 <CAHk-=wgiX0q0WCL+SFwVCYtG7JR3=2Rshse-5J3AO2Y4AgT7Jw@mail.gmail.com>
 <20250317160034.GA12267@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317160034.GA12267@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Mar 17, 2025 at 04:00:35PM +0000, Will Deacon wrote:
> I'll have a crack at reworking things to take a 'const char *' instead,
> but it won't be for 6.14 as it'll be reasonably invasive.

Bah, that doesn't work at all because we need a string literal for the
asm and I can't spot any constraints that allow you to pass in a string.

So a different flavour of surgery is required...

Will

