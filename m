Return-Path: <linux-kernel+bounces-539062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2E9A4A070
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445383B6075
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDBB25BAA0;
	Fri, 28 Feb 2025 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNzORbQj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C08192D7E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763884; cv=none; b=Hy1yTBtxS8ldWd7w73+4gur+D967Pz8mcpbTM2s32C7ka6xFc7JqrdGT+XjtEiVwJ4GNYFxIjj+5h+iHkxCpKNAr+lRVKw2idUPBVFPq/zAgab5uoaFnx5wG8B3nnT4Oth9Nzi3mcVQkONndYTKEMHyQMmymUoFJQ0cSDxWVY/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763884; c=relaxed/simple;
	bh=8iV3+jM8ljBDDZwaoN9UjXYFhZiRuOgLElyELMHpKj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVyT4g/rfYupVvQTwxu1imTBeb6QGJZH5BGB/zhh7rEDfTunbtoKuXcv9sTmHLPttCHqhtJ4ABqvIQV112jMuqCMmch3e5yNyiYukDjMtPBq3ehioen7Eb9Qcr4/d8YNrT0RUDJSSCPYBPCOPXPd21l0HTQL73iLirE2pze12ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNzORbQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41981C4CED6;
	Fri, 28 Feb 2025 17:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740763883;
	bh=8iV3+jM8ljBDDZwaoN9UjXYFhZiRuOgLElyELMHpKj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lNzORbQjrv5D1Bv2Qsn2GjoagWbSSmG+F7ZEV46hn94Tkt286VNV/rh/geYZ6BCBI
	 3TK4kBtHT/kpgNeu1PMmtSUG/1Erdq7NnKh2oKC2MfZzQB+IUiTpo8lHQwJs/IWYBO
	 65pYGlcWsg91N/72yw5qlqCHqfKqH+DaMCcn2hSqxOeJWrFaLJ6oT+s9evTLuY9SnD
	 CkIa4CWBRYKG79HrG+5IsK6zQe1dXp4bhko+J8I76gg2MHMcwDMl81bnTnxRxRVPgY
	 O8saoV6VkE5bJ5f89BjGjTHqoktheV4+SaTRpjQdIG33Z/wzqz4aA9Ew7AnvufEY1h
	 QYXZ3VExAWwtg==
Date: Fri, 28 Feb 2025 07:31:22 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Changwoo Min <changwoo@igalia.com>, void@manifault.com,
	kernel-dev@igalia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Add trace point to track sched_ext core
 events
Message-ID: <Z8Hy6qu8shpYOR83@slm.duckdns.org>
References: <20250228085944.19451-1-changwoo@igalia.com>
 <Z8GKCkWNVN_Pbcc0@gpd3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8GKCkWNVN_Pbcc0@gpd3>

On Fri, Feb 28, 2025 at 11:03:54AM +0100, Andrea Righi wrote:
> > +TRACE_EVENT(sched_ext_event,
> > +	    TP_PROTO(const char *name, __u64 delta),
> > +	    TP_ARGS(name, delta),
> > +
> > +	TP_STRUCT__entry(
> > +		__string(name, name)
> > +		__field(	__u64,		delta		)
> 
> I'm wondering if we should use a __s64 here (and %lld below). We don't have
> negative deltas right now, but in the future who knows...
> 
> Apart than that, everything else looks good to me.

And let's also print out the updated value.

Thanks.

-- 
tejun

