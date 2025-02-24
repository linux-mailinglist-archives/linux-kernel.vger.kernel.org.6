Return-Path: <linux-kernel+bounces-529892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4980EA42C37
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41AD0164717
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA931AB531;
	Mon, 24 Feb 2025 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dayNw8ml"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BBD19408C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423665; cv=none; b=sU5yICeT78mL0Bny5gcZKI8llnFRn6PK4Kyg88xEgq+CsM4g7Wfrz5NgMIniXd+islc/NSexDthpXf1V84bQ6FKCP4FIFwzzjyQek0d9miLvbZrwrHsoxXx2gYYuCcir1IH2dMLVdf9iP405fAcZlnEZ8v8O95KH3LVVZ55RPu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423665; c=relaxed/simple;
	bh=KYHGd5vYOBgKU9K2YPws9febCJ7MQ/EegcdB6pmeADc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8PElsJ86vB/SIci2Opf8obsIasNkMEvpmBwvy4WDjJYZ2b6ETqX1QJKXXfxbdFn3QqI9Yu3o8/ouLjrKx3j1Ud2aTRmPI7a6PPOPJcMHolvbL9Jupx1V08NN1f33KsPVunSpEOuBHLztlaOd3DP7uij9gsxq8tCLxYq6KbysCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dayNw8ml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01694C4CED6;
	Mon, 24 Feb 2025 19:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740423665;
	bh=KYHGd5vYOBgKU9K2YPws9febCJ7MQ/EegcdB6pmeADc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dayNw8mlNTeU42S9Ynn1j4oEI2j6simIB4RK6qBE/pv6TAoFgmM3nUM+u6xGVy69A
	 ogJg1Ki7kcUfmFDy2Kckl+KJtaLoq5gCD00G5KiEaBui2EqSOt0V7BFc3Jnx5/DhbT
	 Wnur1mmGYaSXpa9Kb0uqj/tE/LlOPq0uIfC44pVrmoWxEWhNXgak8e9b2WW2tdjMxt
	 CTO0O9yQ0uTznymyTch3O9XuRti1OEfr0jUsk2VMKD/NER9aXjne3g2gBpbnsMsEQj
	 G6ioPVFEniPHOyFtO//00Fq/Uj5rb2K/Q9oxBrgRtpSWMxCDIFtarf8bPEELw9X82q
	 5NvbVrirCS7vw==
Date: Mon, 24 Feb 2025 11:01:02 -0800
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org,
	jmill@asu.edu
Subject: Re: [PATCH v4 08/10] x86: BHI stubs
Message-ID: <202502241100.9B62173958@keescook>
References: <20250224123703.843199044@infradead.org>
 <20250224124200.717378681@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224124200.717378681@infradead.org>

On Mon, Feb 24, 2025 at 01:37:11PM +0100, Peter Zijlstra wrote:
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Did this commit log go missing?

-- 
Kees Cook

