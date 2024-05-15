Return-Path: <linux-kernel+bounces-179978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D30248C685C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D0A0B23037
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A236913F43D;
	Wed, 15 May 2024 14:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThykNrT9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F8713F012;
	Wed, 15 May 2024 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715782457; cv=none; b=eOpzt2h//xqG7PUmafAsroOPjs2h6zgsYtmY16HG3z4JZPf1gOZsuNzIcSPYPUjey4v7yGRVnrpJlaXTLW+5cqUtil244L+kkAos09OliJBKfN93OmIwDy3wIuoHyGcn0+MMzoWhVd4nLniI3j6Wfy2bHceLSslA0g9mbfTLLGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715782457; c=relaxed/simple;
	bh=hYvG4BZJM2sDn6KG6DSiEfpwVN3PBWYFV5jfWq39tzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZ8BfY/yHBDUlJx4VjenmEcSOHeu5I07XJGH+Ohzu13ao7Pudi8gMNknG8fkajbDkA3eK8pzSXjsS2JyVzo1/wAMB6nEY/w106F8trcipabUu9z3Wb2LdVFlU3JzR5dKM5vfKft8qJy2uy4sWOgr7X3tfretBwyFkdjSTds8uog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThykNrT9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1699CC32789;
	Wed, 15 May 2024 14:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715782456;
	bh=hYvG4BZJM2sDn6KG6DSiEfpwVN3PBWYFV5jfWq39tzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ThykNrT9n8ZKE1OD3zLWQYd0g89YBsgOsU4Gt4H1MEKadRGtgYS8yfBkMU5BmVHby
	 NT0sxv+ILI9YZ33ETKcp9Jhq1Iu+jX4eVyU3K7snWorp3SbNibDpe8MZ5DE3wQFxsS
	 jRVx9j5hx7Z6q41BFah9ZQWoVo3SF6QwcBRFRTcoAQPPrUSG9UxiICSwtq+0Dn5e7N
	 yCDBdByBr2NfvpP7ANSbjJXhTfA0xvgFnplal556S/N7x3supqIJffgZ7ZYn1A5PU3
	 iKnlIGVnj+r+9wpRdfLpXODMGyeBDqly2ES8QKJ5K70S0smN3YBjDA3OWu95EYnLPN
	 o4gPjDd3MQ2QQ==
Date: Wed, 15 May 2024 16:14:14 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>, ying.huang@intel.com,
	feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [timers/migration]  61f7fdf8fd:
 netperf.Throughput_Mbps 2.7% improvement
Message-ID: <ZkTDNsKXs0VCHiaf@localhost.localdomain>
References: <202405151553.6423572f-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202405151553.6423572f-oliver.sang@intel.com>

Le Wed, May 15, 2024 at 04:06:50PM +0800, kernel test robot a écrit :
> 
> 
> Hello,
> 
> kernel test robot noticed a 2.7% improvement of netperf.Throughput_Mbps on:
> 
> 
> commit: 61f7fdf8fd00ce33d30ca3fae8d643c0850ce945 ("timers/migration: Fix ignored event due to missing CPU update")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Nice, so this means the previously reported regression with netperf due to the
new timer migration code is gone, right?

For reference: https://lore.kernel.org/all/202403011511.24defbbd-oliver.sang@intel.com/

Thanks.

