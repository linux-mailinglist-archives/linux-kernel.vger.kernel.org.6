Return-Path: <linux-kernel+bounces-387925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE989B5808
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D43F2284204
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B99E20C46B;
	Tue, 29 Oct 2024 23:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/p4UaAK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723D020ADE6;
	Tue, 29 Oct 2024 23:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245818; cv=none; b=YlU/VYjabilY9qAJyfR1B+WX8EIJeBsKDKI0Dcr5e1c751HMgJqkGeqHzv+VcB+lONYNn6QeJQdYD40oDcJNfgJRujGd8EP0cT2VuA6IvmjL+csl5Dq/HBJ2UNEdeX+B7vGIu26xkTkIOsakTqnrFTsEpi9wgyRg7M74IzXbHWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245818; c=relaxed/simple;
	bh=yCR2Z+Z6hYhzHCaXbkJsDBqya3WiyH2zWb5yh5pkiLE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BUxpPDmN698VjTctqOT1qoG3VccaRWv3QydyKvSStakTH8qvOdQNN41OOB2AiM9FMF0FkOgL8gaaXATZ4gc2fUc6T3CkXEhoY+dssGBxgZR9Hf2eyUZPSRqc8X4XRSbRmjXvU7LbXL3eBJH0WvUryfzNl3OX6lTr5UKuU0/gQwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/p4UaAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985DBC4CEE3;
	Tue, 29 Oct 2024 23:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730245818;
	bh=yCR2Z+Z6hYhzHCaXbkJsDBqya3WiyH2zWb5yh5pkiLE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s/p4UaAKqTWNo2gEJeBaEM5GCtAXiFo+ZyY/UTsK7/ON438Gr7RKlMYS9XjmLqWO6
	 oQ1ZozgcZJEaqWcMK2GUqM86FJvTsRRXwes+mAVE6oNnl5tREVoDus+4j0TwidUAgj
	 5MTGJHGo8AUYHjfpEfE92ibvk53ZFShHhwDDgCCLEMuZjUFrFAUH+RChmhfi+pbV9g
	 qTIGU9pS2cva6ZMbHny2eZ79YMuOLOrWtrMl7VM9Q8vCNJcJZckXvagh/RiTefiLzu
	 eRwSOJTugaF0WZk9i2ajU3KfFGlZ1D0NBV5sPKS0FEEmjWpyyN+mCV8+Rl/ebbzD6A
	 iz3RJQ63v8LCg==
Date: Tue, 29 Oct 2024 16:50:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, Geliang
 Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Gang Yan
 <yangang@kylinos.cn>, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH net-next 0/4] mptcp: various small improvements
Message-ID: <20241029165016.568f01bd@kernel.org>
In-Reply-To: <20241021-net-next-mptcp-misc-6-13-v1-0-1ef02746504a@kernel.org>
References: <20241021-net-next-mptcp-misc-6-13-v1-0-1ef02746504a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 17:14:02 +0200 Matthieu Baerts (NGI0) wrote:
> The following patches are not related to each other.
> 
> - Patch 1: Avoid sending advertisements on stale subflows, reducing
>   risks on loosing them.
> 
> - Patch 2: Annotate data-races around subflow->fully_established, using
>   READ/WRITE_ONCE().
> 
> - Patch 3: A small clean-up on the PM side, avoiding a bit of duplicated
>   code.
> 
> - Patch 4: Use "Middlebox interference" MP_TCPRST code in reaction to a
>   packet received without MPTCP options in the middle of a connection.

Could be a coincidence but looks like we got two flakes in mptcp-join
since yesterday (different sub-cases). What's more sad is that it looks
like our subcase parsing is broken, when I look at the subcase view
all sub-cases are marked as passing :( Could you take a look?

