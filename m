Return-Path: <linux-kernel+bounces-568695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9446A69972
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191111897DFE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5EB21576C;
	Wed, 19 Mar 2025 19:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r7er10St"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65E82147FE
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412705; cv=none; b=l7sDXp83CAFMsTvPnDApbhab+sLuBgmslpc7N2U7PZfIb9RVAER7a6WWsQXSJlF+HGetih2cOio5W13i133rFEWfmL4UGsMagR87EC75F4r7pflM9OBQ0DLmjMy2HVjQTvTPEc6z5LQQ7etQN/vplL3EbXgPwjKczgx+yLHnrTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412705; c=relaxed/simple;
	bh=DvHYlc/0aDDkiX64CLMDQEmgMM36oqN1QfQnDHqEev8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+KTxUgRw4lsFKz/V5m7PKsU0FBkFlsnYH9jVA45DXrsWWFmT48oMijef426e+0CaP8obL9nQPLQXCXFBKwl0HRzh/TCo2bCT52IGEOgkW6LpT/3+Yd/Kwlul9bDG3I4g6l2iZDvYj1w8VRdehKLtyIkKjuJquy7bpooYvTB7Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r7er10St; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 19 Mar 2025 12:31:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742412691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bJmD4JThpWIDrNyj3D98K25ipZfZbcbZS/MAziEBkAI=;
	b=r7er10St4B2nq9xW3QqA7S+QCwT7p/McoYiG4uK80ar/+oIw0AePrzgZ20M3bGz266O4Ex
	xocg1R6CiRf+xsUghV2VOJnvX2UWSwCgF48/gxcQTbsbWFnlbY6nvNqr99MdWkhKfkleH7
	hB2DSc8CwwKwu16Xt2p9uiBqXljcENo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jingxiang Zeng <linuszeng@tencent.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, kasong@tencent.com
Subject: Re: [RFC 1/5] Kconfig: add SWAP_CHARGE_V1_MODE config
Message-ID: <q2x4drxpjbxcxgns6bjp446ynsxgl32ckcljqcol7posds4nit@3n3tjq35anvb>
References: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
 <20250319064148.774406-2-jingxiangzeng.cas@gmail.com>
 <edbqzi3hqfvkr36pawvjkrogjmjzxnhs5fcbye4oacyxye2s4h@vwq4ic7xzjoc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edbqzi3hqfvkr36pawvjkrogjmjzxnhs5fcbye4oacyxye2s4h@vwq4ic7xzjoc>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 19, 2025 at 12:29:11PM -0700, Shakeel Butt wrote:
> On Wed, Mar 19, 2025 at 02:41:44PM +0800, Jingxiang Zeng wrote:
> > From: Zeng Jingxiang <linuszeng@tencent.com>
> > 
> > Added SWAP_CHARGE_V1_MODE config, which is disabled by default.
> > When enabled in cgroupv2 mode, the memory accounting method of
> > swap will be restored to cgroupv1 mode.
> > 
> > Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
> > ---
> >  include/linux/memcontrol.h |  6 ++++++
> >  init/Kconfig               | 16 ++++++++++++++++
> >  2 files changed, 22 insertions(+)
> > 
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 53364526d877..dcb087ee6e8d 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -62,6 +62,12 @@ struct mem_cgroup_reclaim_cookie {
> >  
> >  #ifdef CONFIG_MEMCG
> >  
> > +/* Whether enable memory+swap account in cgroupv2 */
> > +static inline bool do_memsw_account_on_dfl(void)
> > +{
> > +	return IS_ENABLED(CONFIG_MEMSW_ACCOUNT_ON_DFL);
> > +}
> > +
> 
> Please move the above to memcontrol-v1.h file.
> 

And under CONFIG_MEMCG_V1 similar to do_memsw_account().

