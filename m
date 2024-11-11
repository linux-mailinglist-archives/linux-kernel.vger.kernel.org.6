Return-Path: <linux-kernel+bounces-404395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4ED9C4331
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 420D71F21E96
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2221A3BC3;
	Mon, 11 Nov 2024 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oq7DZoSo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A542AF1C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731344849; cv=none; b=dv86pnq7haF55RZwaLijGdbb4H0+vQTWukmAlTLn8Xa3h3UhqhtyIBa3yjDihVX5tKTo5W0Y2cOkI26Fm5M3uB0Cglty1iB5ecenMpLiODrvvs/gaddy/YVyDyjq02tue7PzDAOP8Qic0DWGAG1E8ttiRGmptQj+jR0klVhGSag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731344849; c=relaxed/simple;
	bh=W/aQj+pAHcpmE/eJCgmauLYUmPofPLI1BcTAQ+MBIHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmKN8bShsw1zlRWsA3tDwskbYVNPlzsJxiMUFrU7wkUzP73EdciA3sRyLK0AqFrvuJL/ARfxQFDpEHi94LY4Ui/FErYvfkygAsvGtLHz5W7mj0HqxnGboG7ZGAMD1Lm+LIXNysmJJPAEg7sdT4Hh68bufuhPNEeyCDw3NRPsQb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oq7DZoSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022CFC4CECF;
	Mon, 11 Nov 2024 17:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731344849;
	bh=W/aQj+pAHcpmE/eJCgmauLYUmPofPLI1BcTAQ+MBIHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oq7DZoSoE7dNGz6TqnAOuiIp9z/ZX4M8WzeGoMxk74tpwB3jAzyEpK0zxlN2qJuLr
	 jp7g6/snJXQbc+4BV6Fp0s9zaIvFvQFPM5ptY9P8NVkQxjqseyLRUKlEXVjfjiBinZ
	 fDKujvFUMLwS0gJWzZRgvd+J+IhOH2weZ63zq2xNR73YXmx021pigRITWg1zYBaLED
	 5iMadvZAqExfjJDFm7oTvcadEEeKR1ZBBsrYS1xxeKT64A3//jbaI7va4i6nytEtoa
	 XFu+OmsoS5saw0L19sZox8AC7XSkSZW2zUNvHTmNCR9+FrdmBaXVvup7CJJCZnJOKY
	 9mpUNLyiVZulA==
Date: Mon, 11 Nov 2024 07:07:27 -1000
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, sched-ext@meta.com,
	arighi@nvidia.com, multics69@gmail.com, me@mostlynerdless.de,
	ggherdovich@suse.com, dschatzberg@meta.com, yougmark94@gmail.com
Subject: Re: [PATCHSET sched_ext/for-6.13] sched_ext: Rename dispatch and
 consume kfuncs
Message-ID: <ZzI5z-1lREMbp1Sf@slm.duckdns.org>
References: <20241110200308.103681-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241110200308.103681-1-tj@kernel.org>

On Sun, Nov 10, 2024 at 10:02:50AM -1000, Tejun Heo wrote:
...
> Clean up the API with the following renames:
> 
> 1. scx_bpf_dispatch[_vtime]()		-> scx_bpf_dsq_insert[_vtime]()
> 2. scx_bpf_consume()			-> scx_bpf_dsq_move_to_local()
> 3. scx_bpf_dispatch[_vtime]_from_dsq*()	-> scx_bpf_dsq_move[_vtime]*()
> 
> This patchset is on top of sched_ext/for-6.13 72b85bf6a7f6 ("sched_ext:
> scx_bpf_dispatch_from_dsq_set_*() are allowed from unlocked context") and
> contains the following patches:
> 
>  0001-sched_ext-Rename-scx_bpf_dispatch-_vtime-to-scx_bpf_.patch
>  0002-sched_ext-Rename-scx_bpf_consume-to-scx_bpf_dsq_move.patch
>  0003-sched_ext-Rename-scx_bpf_dispatch-_vtime-_from_dsq-s.patch

Applied to sched_ext/for-6.13.

Thanks.

-- 
tejun

