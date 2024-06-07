Return-Path: <linux-kernel+bounces-205693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A6C8FFEFC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 955831F219B8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D333015D5C7;
	Fri,  7 Jun 2024 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNYdvai8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1218D15D5B3;
	Fri,  7 Jun 2024 09:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751573; cv=none; b=Pul4DXrWrxahuIvXsl/ovgPSJa0Cup4QczG03zJd/JcWkBFqFxq7r8YtmgraD7cEYaKRL/b2BzGbT5/08odJfw4NQfK12C+lfuvRyote4/9hTNav72N3m8vFnHj5CPkL2heKWOWaI7HDtgv3BK3QDlj//oUS7wntMwfGx35ApaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751573; c=relaxed/simple;
	bh=D1pcZZbRM2ZaLXMKLTuChv3xA89P+2Rujv5a4Bthmxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ft3VabHbuhwoxZD5nBw+R0XESEWF0XDGlQZRaVBTpnvWnZhQsVeLfe5oRypqviNTGsStV5HywikDgcjsvHIW0ysMkNpsVKF05QssAiLErKH+BQSxKVM7DRead+k8xkllbQhCpx0aK6Hku5iK93+QPUaWH20en8j2GctTDOqRpK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNYdvai8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA24C4AF0E;
	Fri,  7 Jun 2024 09:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717751572;
	bh=D1pcZZbRM2ZaLXMKLTuChv3xA89P+2Rujv5a4Bthmxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JNYdvai8G4egmNGuDUSstBebnnvCbcOmMZCgPCf2YrCMVPhg73fAEy/gRcAWqb20u
	 PZvOQ5tXAXWJk5eY14lw2+h+oIPfs/YynpAy8x5v/u4uIDXc86agB0KM/7fLlSZyvX
	 4JFVsyA2vYOaj6gfFaWk38IXwlBNGade4c+NGYbIUm/veSsJr6TPRpaIz6tY2+Ft12
	 ZuoK23kv5KcLVNAYEz/8aO+IEZySE5SDJRfhVW3A+izjVxbTgWk1eLb5YTxAGklAfB
	 qFsJMSgpsJxFI5wOEiaEFmR5DqMK7tUzh9pRoG/CLvpNABvBrAUf200W1OrMoV2KcB
	 QWAC/wRfU46HQ==
Date: Fri, 7 Jun 2024 11:12:48 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Ballance <andrewjballance@gmail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the hid tree
Message-ID: <tsidjatmspfgcyccgxnl3igznphdo5jxvdif7hwhlgglz4exo4@qa2fqxyrzb35>
References: <20240607074711.4390fbe4@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607074711.4390fbe4@canb.auug.org.au>

On Jun 07 2024, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   cfacaaf33cd7 ("hid: asus: asus_report_fixup: fix potential read out of bounds")
> 
> Fixes tag
> 
>   Fixes: 59d2f5b73921 ("HID: asus: fix more n-key report descriptors if n-key quirked")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: 59d2f5b7392e ("HID: asus: fix more n-key report descriptors if n-key quirked")

Oops, yeah, sorry for not spotting that before pushing.

I have force-pushed the for-next branch (and for-6.10/upstream-fixes
FWIW).

And thanks for that bot which allows to prevent this kind of errors to
go in mainline!

Cheers,
Benjamin

