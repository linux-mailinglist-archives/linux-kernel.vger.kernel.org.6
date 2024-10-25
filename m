Return-Path: <linux-kernel+bounces-382708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6264C9B1282
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 00:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3D18B2278B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B2D20BB5B;
	Fri, 25 Oct 2024 22:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMiLXYu5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB60217F30
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 22:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729894776; cv=none; b=oc4+Y3hRlQrK/krV3ilf+A1UViX1NFzuz/zDCE4NEViIzvv/qR7Rs7KK80ZzRqNdTiV8jXFXVNlYauuSLcTnsrlEnYyzh5bDRrH0uJa5BM+JxGRVKuAqxPel0xPchxA+TO3EQgSwXmRC/MuG6kuQuPvm7Un9P6ZE8M5y33UJ7aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729894776; c=relaxed/simple;
	bh=bkIyIOt709LEpIxSor2lQavjHgiCS4DA4jxp1iLyLN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7oeitYoxP36hakmFYcp05lT3wtmufszl07gkyhYZgrNhtAP5mzJgHRpc5G+Uq1kI6B2vldGUdKDLZL/MKJKwRSsI2CSIATMTztvCKFCNYZQvHIxlI0g95gzLPqTyyPBUNLXXpVK74SsotXvAw5iYT46+fYRfsNm9/GpWgdEwXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMiLXYu5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33984C4CEC3;
	Fri, 25 Oct 2024 22:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729894776;
	bh=bkIyIOt709LEpIxSor2lQavjHgiCS4DA4jxp1iLyLN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gMiLXYu5d7yjFtbuznywp/Sms5VwCmjVdLYvyOT6BkD/R5SCfv7F0XxfQcOoJlGHx
	 i7qL0sYsjA1EfClM0VMQ9fTYNnH8NvXhVxtvZJzaiqtH/qV0L/IOsrEMYfimdSlQ/P
	 jEqt4Q4Mm22rr+2oWLtluPQ+ca21E6GsOt7Gn8xKMhOsC7wpGKyS9RZ70O773M7OwI
	 vEwcB4ecsoxG8Yr6Kx+CisGJn21qsG64O9DtDbl0PyCWtm396T82HA3DZNbXoEvuu/
	 XM2E3BCdEoXB8Ip+Ua/6GJ6lfINXmNbKv/pLRXpMB8X/9QJyKX/mHpqahTwdQoinlC
	 nNp1hfgEWvMpA==
Date: Fri, 25 Oct 2024 12:19:35 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, sched-ext@meta.com
Subject: Re: [PATCH sched_ext/for-6.12-fixes] sched_ext: Make cast_mask()
 inline
Message-ID: <ZxwZd160pfdBYz2y@slm.duckdns.org>
References: <ZxwXgmKQ2B3OmIea@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxwXgmKQ2B3OmIea@slm.duckdns.org>

On Fri, Oct 25, 2024 at 12:11:14PM -1000, Tejun Heo wrote:
> cast_mask() doesn't do any actual work and is defined in a header file.
> Force it to be inline. When it is not inlined and the function is not used,
> it can cause verificaiton failures like the following:
> 
>   # tools/testing/selftests/sched_ext/runner -t minimal
>   ===== START =====
>   TEST: minimal
>   DESCRIPTION: Verify we can load a fully minimal scheduler
>   OUTPUT:
>   libbpf: prog 'cast_mask': missing BPF prog type, check ELF section name '.text'
>   libbpf: prog 'cast_mask': failed to load: -22
>   libbpf: failed to load object 'minimal'
>   libbpf: failed to load BPF skeleton 'minimal': -22
>   ERR: minimal.c:20
>   Failed to open and load skel
>   not ok 1 minimal #
>   =====  END  =====
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Fixes: a748db0c8c6a ("tools/sched_ext: Receive misc updates from SCX repo")

Applying to sched_ext/for-6.12-fixes.

Thanks.

-- 
tejun

