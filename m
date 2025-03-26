Return-Path: <linux-kernel+bounces-576350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3859BA70E20
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 01:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7C91884D03
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 00:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78532E3373;
	Wed, 26 Mar 2025 00:18:06 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F1A376
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 00:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742948286; cv=none; b=XvbeDon9o9tgrd75Z0SHfbap4twFRZg+jDTDyn1YdIU2wrd+YvQiNUlZrMef+Blrp6U4+YVBMkH1HTjbJ6RTG0OqMzXcJ78uiTGKiMq6gIVbxaH/ilgNu6TDsnV/yRVqM8CfSR/G/MsEYlR+f6/y3gac2WVZoha7umTZow2aSes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742948286; c=relaxed/simple;
	bh=Uo+hfnF1D00BsefGa41HbxRwm4Uk/AF5b+tDM1sovDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzUF5x1xlrrMZzDqw/mEAaalroDD1xDUFEnE90CSs+PWfN71QU/RM5NTXqYbNkiswBuOiEikc5OsNfUy65UGqQlI8gr+M7ZBkuhK3W/8d704txInzbbpXxx+I153QDC8sZjKOl5gNyTMExBDhPMuXCbrdZtAmVMXfQ++YxyCeKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF32EC4CEE4;
	Wed, 26 Mar 2025 00:18:04 +0000 (UTC)
Date: Wed, 26 Mar 2025 00:18:02 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] arm64 updates 6.15-rc1
Message-ID: <Z-NHugcLdLqkEHFR@arm.com>
References: <20250325195322.3243734-1-catalin.marinas@arm.com>
 <CAADWXX-0hMgpyeQw_7Ko14hNMciqSnKJAROEWS5vwAdMKUt_zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADWXX-0hMgpyeQw_7Ko14hNMciqSnKJAROEWS5vwAdMKUt_zw@mail.gmail.com>

On Tue, Mar 25, 2025 at 01:12:45PM -0700, Linus Torvalds wrote:
> On Tue, Mar 25, 2025 at 12:53 PM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > Please pull the arm64 updates for 6.15-rc1 below.
> 
> This was in my spam folder. The reason is that your email
> configuration is wrong, and lacks the proper DKIM signature.
> 
> You have
> 
>     From: Catalin Marinas <catalin.marinas@arm.com>
> 
> but it doesn't actually have the DKIM signature from arm.com...
> 
> It looks like you sent it through the kernel.org smtp server using
> git-send-email, but it doesn't have the kernel.org DKIM either (but it
> may be that kernel.org only signs things that say "From:
> xyzzy@kernel.org").

Hmm, I thought that setting "Return-Path: cmarinas@kernel.org" would be
enough. This header left my machine but seems to have disappeared in the
lore archive. Not sure how much difference it would have made, IIUC
that's more for SPF than DKIM.

If the envelope sender doesn't work, I may have to switch to using
cmarinas@kernel.org, at least for pull requests. Arm has an SMTP server
that doesn't add the legal disclaimer but I've had similar problems with
it in the past (the expected sender was ...@foss.arm.com; maybe IT fixed
it in the meantime).

Anyway, thanks for letting me know. I'll dig further.

-- 
Catalin

