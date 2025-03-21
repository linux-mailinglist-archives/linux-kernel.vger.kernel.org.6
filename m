Return-Path: <linux-kernel+bounces-570813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E31A6B4C5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A11B189B5A7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF061EE008;
	Fri, 21 Mar 2025 07:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9k0lDLL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867EB1EDA09
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742541361; cv=none; b=Q2YUc1LGhPcobMUKK3pNJQlHyoK5x235wnobkpXBzIWw6oI5Ns9XLnFVcFk2QlSixRCPkAByQsxPwOUngDnKi+VpYr6X2EeI8kD7HaxVCOPbhNu31xCE6XlTa8xI/4cRhLTfnfF/Fgsc7xDZrZSo/FvJzJrvRKhQyrSXJv/zsRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742541361; c=relaxed/simple;
	bh=jaw1u88XcRaKwHM5/qlfEC//0aNDpCsiJfMdhJ2Zey4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSG62R64JVnHC43rANjkTfvlO0TOirmLhBEh/bngFKNYzmNalVBsNpkPx/Z94Ti2xcPVXnQqxDlijrdS2pi0IAho5kHxLs6TpnIOwseFf4UBPtAHNWsWljXPu1RXtCyHs4lpRcrPH9HwK0Wvub5LgpQufdBDz2Es+6NX6qVF5as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9k0lDLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2135C4CEE9;
	Fri, 21 Mar 2025 07:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742541361;
	bh=jaw1u88XcRaKwHM5/qlfEC//0aNDpCsiJfMdhJ2Zey4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l9k0lDLLA59jaJfLTlvfUFx7ASpWrxFo2XuvisypvxEEBSXLZjd0fwLLFskBpPCdx
	 x+64SG7lFHBAvWF8meHcNiklBVkd3G+wzqufDmO/MT0/CXK3LUgyBTp6otGGA/KdXt
	 bQ+0vfyvvZ9m5ZQEv5hAUm7Hm8d/zJzEQUHLmv1g0QloZZwPOjThGeM2slWdPaALcD
	 zYDPNjHGQAlEj5xHeC0dHEG7sQIauOPdLGVnn+4lCJL5Ffdy7dqMbjBCqDL+NE9x7f
	 qoFN/iQw7tf2NnWx0nl1OssgCkNFShwCpZ6NC5lfBhKrmKyrPoLaNXk4gCsFDbajSy
	 SM6DH8XAOY6aQ==
Date: Fri, 21 Mar 2025 00:15:59 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH] x86/speculation: Remove the extra ifdef around
 CALL_NOSPEC
Message-ID: <cujhiug3ojp2z7hh66kipue5wcugbrcogo7yofse7sfxphgqfg@6iqg3rghixfi>
References: <20250320-call-nospec-extra-ifdef-v1-1-d9b084d24820@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250320-call-nospec-extra-ifdef-v1-1-d9b084d24820@linux.intel.com>

On Thu, Mar 20, 2025 at 11:13:15AM -0700, Pawan Gupta wrote:
> Commit 010c4a461c1d ("x86/speculation: Simplify and make CALL_NOSPEC
> consistent") added an ifdef CONFIG_MITIGATION_RETPOLINE around the
> CALL_NOSPEC definition. This is not required as this code is already under
> a larger ifdef.
> 
> Remove the extra ifdef, no functional change.
> 
> vmlinux size remains same before and after this change.
> 
> CONFIG_MITIGATION_RETPOLINE=y:
>     text	   data	    bss	    dec		hex	filename
> 25434752	7342290	2301212	35078254	217406e	vmlinux.before
> 25434752	7342290	2301212	35078254	217406e	vmlinux.after
> 
>  # CONFIG_MITIGATION_RETPOLINE is not set:
>     text	   data	    bss	    dec		hex	filename
> 22943094	6214994	1550152	30708240	1d49210	vmlinux.before
> 22943094	6214994	1550152	30708240	1d49210	vmlinux.after
> 
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh

