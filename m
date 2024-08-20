Return-Path: <linux-kernel+bounces-293903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F68F958658
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26C7F1F231CC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83C118EFEE;
	Tue, 20 Aug 2024 11:59:43 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A531818E02C;
	Tue, 20 Aug 2024 11:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155183; cv=none; b=LJgHvErOZSNiGFNrjvELDlsF42he51Fl2ErmUEPpPOS64Xtlsft/PF0pTCXP77dkV7rbZa4h4AaeZwC1YMTE7BOSJJZMh09WJcV+HChLPz9NIluRNw+NoompYE25xSERyrKUPdAll7boMlXw1aFvC53QBwKifbLcSj5pjE80X6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155183; c=relaxed/simple;
	bh=AZ0pSABjIpoBEalEF73L1k+W3ZHvD0m6HPUWROW2Bsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOwDebsxo/ex+pTq8wcGubZ/b5IixCzKWhtz0/QoKm5y4CdXfMHhVHTpAu5Y/RVKPislCFfiecWGuzE0AsbxZffuIdUbe4vGeJ6dvLByYpqHapkRtLoBDf8BjSReksMiaJG6EANMlAEXRlVawqRDlDbAPzXX0Y0+MzTYC8ly6jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sgNWJ-0005Ph-VN; Tue, 20 Aug 2024 13:59:27 +0200
Date: Tue, 20 Aug 2024 13:59:27 +0200
From: Florian Westphal <fw@strlen.de>
To: Xi Huang <xuiagnh@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv6: remove redundant check
Message-ID: <20240820115927.GA19599@breakpoint.cc>
References: <20240820115442.49366-1-xuiagnh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820115442.49366-1-xuiagnh@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Xi Huang <xuiagnh@gmail.com> wrote:
> err varibale will be set everytime,like -ENOBUFS and in if (err < 0),
>  when code gets into this path. This check will just slowdown
> the execution and that's all.

Compiler agrees, those conditionals get removed at compile time.

Reviewed-by: Florian Westphal <fw@strlen.de>

