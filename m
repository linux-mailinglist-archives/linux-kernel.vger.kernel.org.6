Return-Path: <linux-kernel+bounces-299848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0208595DAC2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 04:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B30E5283DCC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 02:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6092CCAA;
	Sat, 24 Aug 2024 02:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPGa8VVh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488F02BAE5
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 02:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724468188; cv=none; b=UaoDNjvs9FU4caE5T+rxECOF/3WDY8x75qX2lIiGeDJRbKfXWhdMB6VfWVOg6chj8Do/IXiXwq7IBQ9SRfKSAilNCism6sKuOqK/lDmY/PsvB353FaKbpNS12DeNgEEPZFFxUoKNlnG4z75X3P67SK1uKVmYflQCsiBJAcqexhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724468188; c=relaxed/simple;
	bh=M2j/fYsl29HM4WMerQOU8nBvqgMMHWUH6ZwSl9RcNUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAaGVJYdMehbHURsM2vgJcLWlrao0jVLejjMzc5w0MDkGmA97b6nUgBXbArNbpzBYyzYwkKtHTyUwXNWBpQlBWQhS7yS2DXtOtnLBf1m21MD19DAxwZKGS9aYupVzMaW8Gh6jIANYkauy/2EUzMvip6HNA0rC0lVpR7zxxBXD2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPGa8VVh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46F2C32786;
	Sat, 24 Aug 2024 02:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724468187;
	bh=M2j/fYsl29HM4WMerQOU8nBvqgMMHWUH6ZwSl9RcNUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cPGa8VVhztd8d9/cPEGFLpubymC6Xo3AIhbdYY7HyQG1A+93fkFSWxvlhLhDu6CG0
	 SJ1STMM21P27Yq4cct2g30CHIq48tE8lDeG4YSWPn1SBUT3vgoU/f4PvpuCCYOE9Ho
	 MFJJI7vsf9KIcCqwGG68r/B32luLXbnq+7kXxmlIBeLtdJFP3zs7iSn83V0TeHFzub
	 6F0Bnp93WRF5Bg7ECx6W91Rpb843SFAthmD6FbjKFq/rnJM6XzrRakk73AWhcoDe1N
	 8PkDh6szVJ6rF045bB4VgPo6e37218ESBeVayzylbEwTV0Yvi/ypMQEDg3GwcRFUwf
	 Y0o/4TpAoNkbA==
Date: Fri, 23 Aug 2024 16:56:26 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [GIT PULL] workqueue: Fixes for v6.11-rc4
Message-ID: <ZslL2pNb9u_iqOEM@slm.duckdns.org>
References: <ZskwWy-gDniofgyx@slm.duckdns.org>
 <CAHk-=wgjnYfS7pqZ5Mj01H3Y3HC1F40ZWsk0kvh7QMTZ57qqRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgjnYfS7pqZ5Mj01H3Y3HC1F40ZWsk0kvh7QMTZ57qqRA@mail.gmail.com>

On Sat, Aug 24, 2024 at 10:44:30AM +0800, Linus Torvalds wrote:
> On Sat, 24 Aug 2024 at 08:59, Tejun Heo <tj@kernel.org> wrote:
> >
> > workqueue: Fixes for v6.11-rc4
> >
> > Nothing too interesting. One patch to remove spurious warning and others to
> > address static checker warnings.
> 
> Was there some reason you sent this twice?  Did you perhaps mean to
> send a different pull request rather than repeat an earlier one?

I was confused. I recently changed my outgoing mail settings (so that they
go through korg and pass DMARC) which made the "from: me" gmail search not
work anymore, so I got confused whether I sent it or not and ended up
resending it. Sorry about that.

Thanks.

-- 
tejun

