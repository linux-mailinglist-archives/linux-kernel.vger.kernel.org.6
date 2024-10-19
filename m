Return-Path: <linux-kernel+bounces-372578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B359A4AA7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 02:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2528F284DA2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 00:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E281922E8;
	Sat, 19 Oct 2024 00:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XJX9VvKL"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3171922CB
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 00:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729298065; cv=none; b=QNbKmtfm8f/SCBcIafuvyKlWPnkHuNzP4O/J78l5BXTwffzPAnJVnwVErj9wqbq7dcAwOdX3dqnntpV9NKznjYiqeXu6mj2QjeIOc7Kft0vIg++hpunDBCYVGy3g7yGitLDcesNxMLPletnMVhK4hmtNoyY3kk2ODG9wma0sg0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729298065; c=relaxed/simple;
	bh=kyq2Is5AVARH9C6wHc4yNYdRW2C8EsYHzw8IWrSprME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NHUGo8A52DCuyeJiLObA7FczR+i7vPW9nZTVD47kKDBo73YusezbCAjfrHtx8wSF+bjv8TuNqHckZ5CVeoI5XOgY7YJtYrPZ5jAF75RCJvpNTO7W1UuK35dSt0ENPRw3Hlk4VBzCNjRIcvHNucOuDVLcAldEKNmSxaDZFaDdhSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XJX9VvKL; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <294f7ba3-fd7a-4c3e-b4a2-580695b604d5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729298058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tGiEQEanKgGvIwPUrTuB73lAsnoo0I+tviMcPgBvqEM=;
	b=XJX9VvKLRFj+Xuu7PkLG3UNrO4ySIkGiEFmvK2brgda56YiYkQ72cWENQmqQ8ZnSXs2yjI
	URWTHY5C4y0hlbm1Y7YCY0hUOidBVbSz2McZxi9DF5v+8ExDNfyGg4kN9icU9bvAplZEor
	q8gO1bMwR2gaV1/4B12Q1vrH4viUJL0=
Date: Fri, 18 Oct 2024 17:34:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 6/6] selftests/bpf: remove
 test_tcp_check_syncookie
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 ebpf@linuxfoundation.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Lorenz Bauer <lmb@cloudflare.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20241016-syncookie-v1-0-3b7a0de12153@bootlin.com>
 <20241016-syncookie-v1-6-3b7a0de12153@bootlin.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241016-syncookie-v1-6-3b7a0de12153@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/16/24 11:35 AM, Alexis Lothoré (eBPF Foundation) wrote:
>   .../bpf/progs/test_tcp_check_syncookie_kern.c      | 167 ----------------
>   .../selftests/bpf/test_tcp_check_syncookie.sh      |  85 --------
>   .../selftests/bpf/test_tcp_check_syncookie_user.c  | 213 ---------------------
Nice.

Left some comments in the earlier patches. Overall looks good. Thanks.

pw-bot: cr


