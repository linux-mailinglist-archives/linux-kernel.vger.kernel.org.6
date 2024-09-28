Return-Path: <linux-kernel+bounces-342671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DB0989178
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 23:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A10AAB21979
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 21:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900B916EBE6;
	Sat, 28 Sep 2024 21:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWm5ag18"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC610136358;
	Sat, 28 Sep 2024 21:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727557785; cv=none; b=r06DWRhJ2TNrU7bSTzKGPxVR9inXlU2ZrDEP1HJwRRPYNQx6T60lMz2V2VfU3VTsE1qhjEqtZvitOra3p+aG792Ow8U8qDELPK3WEhvfTU35GvAMaqxKBk3wNnQSC8WofTk3Fowbc+2MRUuHjl2EU+WIq1lzUw0dp+TzrGhIt+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727557785; c=relaxed/simple;
	bh=pqlCp3wPKJ1LkJOv3gUm6naNNwM8W2AUBqIuL9WIWCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjQEz/l63vZ5jGIQCKf8Hf37B4SXemvzxxCU+j4tcv8ZE2j41Ugr0K+YhCopPdyua9Mxx3lN8OacqGPj2a2tVKEPKJgisgqSm5cS2amsGDoT2he9S2ebJJHXGFPnFHloyNQDX6nK+TyqNci8rct+AsmJ0xJ8SoBTNgDbgjAZT5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWm5ag18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61676C4CEC3;
	Sat, 28 Sep 2024 21:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727557784;
	bh=pqlCp3wPKJ1LkJOv3gUm6naNNwM8W2AUBqIuL9WIWCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FWm5ag18MS+QAvV5a2Y7W1lIw4jh4XERaUimTmRFMIwIyU7g0ccUgiS3kD6iKD88U
	 1WWgv/bLKdPcmT3VSlSmGgWuEn/s+6qnskWC7jJA0FuThNLLvM/NyDazuC2nIucHCY
	 aAk4mHWRrcC9Ceqmu8gtRL4IWk/+CPQCKSMu5CtHF5V9mxtIDOFBHfoOsZFQaxsmQ6
	 ULrYfJpqptPVqikPrNarIoINdxXrzkvllEuCmZHuptXy9ogRm+TdUYfbuJaBADukf0
	 91mCWifH/ylVaxDN2uajeCGR9Sbuhki3OnhzWcWZWnk2ou3PyDOiljou233EPmGlcj
	 6Gk/T/yGSOjMw==
Date: Sat, 28 Sep 2024 14:09:43 -0700
From: Kees Cook <kees@kernel.org>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Allen Pais <apais@linux.microsoft.com>,
	Brian Mak <makb@juniper.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Jeff Xu <jeffxu@chromium.org>,
	Roman Kisel <romank@linux.microsoft.com>,
	regressions@lists.linux.dev
Subject: Re: [GIT PULL] execve updates for v6.12-rc1
Message-ID: <202409281409.889F1C2@keescook>
References: <202409160138.7E27F1A55@keescook>
 <d122ece6-3606-49de-ae4d-8da88846bef2@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d122ece6-3606-49de-ae4d-8da88846bef2@oracle.com>

On Thu, Sep 26, 2024 at 08:29:01PM +0200, Vegard Nossum wrote:
> This last commit seems to introduce a regression for me, creating a
> completely unkillable process (but idle/0% CPU) that is stuck here:

I've sent a potential fix here:
https://lore.kernel.org/all/20240928210830.work.307-kees@kernel.org/

-- 
Kees Cook

