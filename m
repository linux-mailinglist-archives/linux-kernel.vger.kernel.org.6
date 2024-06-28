Return-Path: <linux-kernel+bounces-234111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB0391C259
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F00280D9C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE5C1C9EA5;
	Fri, 28 Jun 2024 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="001M5uWH"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A361C8FCE;
	Fri, 28 Jun 2024 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587721; cv=none; b=OhezIhmnHQghRVYIAY+O84LaNYW4GT2Au63oMa5+6D+v2BY7w//e9WlO/PTD++Q0AAEMN9E8+9jT1IbNFHoaC54mNXOBie7W+1HCV1pB0hHIAOYlzou/QZaq7Ktg8pIjCzVHDtRBtOTE2LFa84GEJq4vZpJlLWqgvQqv9K8uw00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587721; c=relaxed/simple;
	bh=yjFmRpgDAS3R6oGLA+UA1eypPW4Ck9gGInaHnul7eFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qy77slqsgHRtBn3QsH3qlMKqDQE5u6uCke3sGJ/+AlVTmsnu4t+QoERfpKrTJt3lq7fYiOi/5Svi6Vj0RBrjg71Oy432fl0IrmR8RcrhuUlmDbLywLNtWgiMj5owMNJmMc/De3YYcVcadcmxPKemWY0J+fvl9f+xv2HQudvENO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=001M5uWH; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=G2/bfVMPW6wWEoHKBdj/DTCoqOlBKV5ZXSF8CE6Ej8k=;
	t=1719587719; x=1720019719; b=001M5uWHvIQ4S2mEmRjW3hD3sqaiJjhLf/ziElg9hkyjGgT
	VEM+GBzIgMKtMjge5+V/x+zKdZCHn64bYxnlhH6b4Yi3XnPbwmphC7xKrwIR3vHy79WsS1/QKG1Hl
	yrMfTPGH6x2r8qiC/3W68h4pQJmTl4vCl1Ii2uw3lW2+OlLHLpuOgfenPgM3memrvzO0WRens0oRR
	+yI4FtbGP03Tx8TVJSTpSPr8HD1NqahazjGrwbK3yfc7CH73UB41jYvHYi+gf0RZ6K8TiXOGlwqwJ
	n81ItYGz4y88sAhqKOp50uERTdJaxfU1zuJ3rTVbQpmacq+isZ1mIFBTnzee4hJw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sNDJj-0002QN-Kf; Fri, 28 Jun 2024 17:15:15 +0200
Message-ID: <61f43bdd-7f73-4605-96e7-843483a53bca@leemhuis.info>
Date: Fri, 28 Jun 2024 17:15:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH 2/2] lib/sort: Optimize heapsort with double-pop variation
To: visitorckw@gmail.com, akpm@linux-foundation.org
Cc: jserv@ccns.ncku.edu.tw, linux-kernel@vger.kernel.org, lkml@sdf.org,
 alexdeucher@gmail.com,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Julian Sikorski <belegdol@gmail.com>
References: <20240113031352.2395118-3-visitorckw@gmail.com>
 <70674dc7-5586-4183-8953-8095567e73df@gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <70674dc7-5586-4183-8953-8095567e73df@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1719587719;94508700;
X-HE-SMSGID: 1sNDJj-0002QN-Kf

On 20.06.24 17:36, Julian Sikorski wrote:
> 
> it appears that this patch has caused suspend-to-idle regression:
> 
> https://gitlab.freedesktop.org/drm/amd/-/issues/3436
> 
> In brief, my laptop fails to suspend completely with the following error
> in the log:
> 
> Jun 18 12:42:20 kernel: amd_pmc AMDI0005:00: Last suspend didn't reach
> deepest state
> 
> Power consumption remains high enough that my battery has already
> unexpectedly drained twice before I noticed something was off.
> I am not entirely sure how changes to sorting function can influence
> suspend, but it is what it is. 6.9.5 as shipped by Fedora 40 exhibits
> the issue, 6.9.5 as shipped by Fedora with the patch reverted does not.

Andrew, could you maybe help out here or point us in the direction of
somewhat that might be able to help? I'm asking, as from a quick search
on lore it seems Kuan-Wei Chiu has not posted anything since nearly four
weeks and thus also did not reply to Julian's regression report.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

