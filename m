Return-Path: <linux-kernel+bounces-537165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E0AA488CF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 478347A5727
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB89926E658;
	Thu, 27 Feb 2025 19:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Od+gIcsA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132C826E652
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 19:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740683539; cv=none; b=B6iDI/EelAkz/4Q1M9V0BPYRhkBCCFDRk4QzPY7ZXiD3NLEYQKQW5TXacPdpXbOiU7qrcl3KqZ656QANNNn6JXtKpeTvq1CM50d5iKUXeLsPX1tlnMJ5s9tD24yHkYcFViGz//1JIUCWjNjw+UkZOe9HuOw9zfVbrrx+3Pdc9Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740683539; c=relaxed/simple;
	bh=QfA4t+TnvHcJFsgllIETJAAm5PaYWOAJv/1avs53/vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4X7CFbd2xA+RQL47P/5I3c+Jqs4cxzqFwNxmVdwfRkjdvcny9L4D+GSiQxZFqASvklhuYuJJJEzGkU+/7Ag6oKgMS7JZQ+krRpUBFQ/Mv2DJK/rEDxYSFeuOnudVGwA9JVNtqTjH2O+rFgrQX9X1nriQ8V2QerpMQnLEzMf9O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Od+gIcsA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4FFC4CEDD;
	Thu, 27 Feb 2025 19:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740683537;
	bh=QfA4t+TnvHcJFsgllIETJAAm5PaYWOAJv/1avs53/vQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Od+gIcsAbJ0H1nOcpQ6ESquno0NZMfuV8zyzNPCpvZdNazt8GQPkFsQCgkZquN3Ew
	 gg/TRp5D5BLMx1My9kMmIf3PHS1nM14tINr0qZoOebWIUrHu+y9ww436VNR1HfsSdP
	 6r/s6ShV0tE71YPtV69HUqYNoE6Qy0U4D7280y73mVSbOAgUJqiJpxItjerdgdYq+p
	 N/0uGtJvN9J3skKd9xBxkvzFMTQeAI2vE4tt4mdMM5s9eQcDag54lJUrxBiNnf0s6P
	 mQi64WWmNUFqzwwQs0SNHeazT/jNwAHnaRR+ZFZgEKlz6rO6RlIPN4U+Q9nOyN1Ucy
	 GtBewlT+8waUA==
Date: Thu, 27 Feb 2025 20:12:07 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Subject: Re: [PATCH RFC v1 06/11] x86/fpu/mpx: Remove MPX xstate component
 support
Message-ID: <Z8C5B9PJUqkEDGH9@gmail.com>
References: <20250227184502.10288-1-chang.seok.bae@intel.com>
 <20250227184502.10288-7-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227184502.10288-7-chang.seok.bae@intel.com>


* Chang S. Bae <chang.seok.bae@intel.com> wrote:

> A new xstate component is set to occupy the position previously used by
> MPX in the non-compacted format, then creating a fundamental conflict
> between the two.
> 
> Currently, xfeature_noncompact_order[] includes MPX, but the introduction
> of the new feature would cause a direct conflict there unless MPX is
> removed. Fortunately, MPX support has already been deprecated and
> effectively removed by commit:
> 
>     45fc24e89b7c ("x86/mpx: remove MPX from arch/x86")
> 
> Explicitly disable the deprecated feature to reserve a space for the new
> xstate.
> 
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> ---
> Several code references to this feature macro remain, primarily on the
> KVM side. While they are likely to become obsolete after this patch,
> their cleanup has been deferred at this review stage: This can be
> addressed in a follow-up patch or included as an optional part of APX
> enablement, I suppose.

So can this patch be moved further up in the series (without breaking 
anything), to make it easier to review the impact of the APX changes?

Thanks,

	Ingo

