Return-Path: <linux-kernel+bounces-303964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EEA9617B9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 21:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E26C1F24B94
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB991D279D;
	Tue, 27 Aug 2024 19:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWPhT5bm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2783C08A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 19:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785714; cv=none; b=k/wE+NEW0XIeNqO27CSQ7FjnTsThf/I/KkyQdb3CkMSqSTIyMdo2aNSAA6X1x9D9Y6Gf1EbhmGfEDBhQL+QFJBGnlVaXLPyh6jUvUMiIIHKDhKuin3cJyRlfF+Wk3TpH7WBiaqa8bOoHfnK/iwdwR4ifHX2QysY30J3EU2b3wYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785714; c=relaxed/simple;
	bh=MCwajK1SWDCk8zkVuQoXayRcIq68/osW50uYMsTi0mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inx8OF2u7cDi7B++3ySlAI+F7Vd6b9KdiuugXpQeGlGlrwqSopYVLFEA5kk+WHR+OJxowCH6g7euS1aQErp7uJefbK2nthVTzeBPWJeb9a+Ast4sWdUOtELSh8qqWXSbDz1yF6SiPElf6HyVsqHktg2cBrOk3zwqh9MRWAJ0vuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWPhT5bm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E359C32786;
	Tue, 27 Aug 2024 19:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724785713;
	bh=MCwajK1SWDCk8zkVuQoXayRcIq68/osW50uYMsTi0mA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NWPhT5bmFYLE8izys4zsECwJTWo1Z4A1QcWun1C6+Du4XbUMJ/ig7mKQtjo5p1QKP
	 vCeeT0roet1lCJ2t03aajk1RiLzUQgJOod7z2sRZfxl28nwS/F6QTueAKHrwSOI2kz
	 XuFGCOG0Ht05g9yw/aYJstj9HP8jQ2RNEfKRWSj2670xQmrO4rnm+wF7VmsBjOhCSv
	 CIftwZe5/oU6hmz+B4cQVyAkd55PVRip/YWaa8Pf2Xnotnee4CbO0Z9V7zYEaMzhQc
	 TBIXWaKoe2QwAv2FsAEwPtXPg61c6xdJj22UYXZ0PleZK8NXOq6du4yBVy5iRPpDnF
	 w75SwOMIE6ZPw==
Date: Tue, 27 Aug 2024 09:08:32 -1000
From: Tejun Heo <tj@kernel.org>
To: Xingyu Li <xli399@ucr.edu>
Cc: jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: BUG: general protection fault in check_lifetime
Message-ID: <Zs4kMHs-bbFnup6a@slm.duckdns.org>
References: <CALAgD-5hheRoik1vz49AxFSQ49uQ3eR0D=Mo=tWbrqKBkMD=WQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAgD-5hheRoik1vz49AxFSQ49uQ3eR0D=Mo=tWbrqKBkMD=WQ@mail.gmail.com>

Hello,

On Sat, Aug 24, 2024 at 09:31:03PM -0700, Xingyu Li wrote:
...
> RIP: 0010:check_lifetime+0x6ae/0x960

This is a work callback function in net/ipv4/devinet.c which triggered the
GPF. The workqueue part of backtrace is not really relevant as it's just
calling this function. Can you please report this to network folks instead?
Also, it'd be helpful if the above address is mapped to the source line too.

Thanks.

-- 
tejun

