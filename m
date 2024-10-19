Return-Path: <linux-kernel+bounces-372704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 943679A4C12
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 10:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3467C1F22B45
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 08:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20231DE88C;
	Sat, 19 Oct 2024 08:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFmrckly"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464431DE4CF
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 08:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729327275; cv=none; b=UdAI7QjlO+m81HF/4fv829j1RL44Sp94JJ6nqlxH3aQFGfuCOx0dSmuzR5cQ4bpMqv18UeuF03Ohl76M5qv2/Gr5ZtBh6SKLP/zuJfKHBhfagpggvMApxVwAvOROjc1QC+mmw9EStOL31+id17GL4K1/vvNrFbhBiKmwXHtaKRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729327275; c=relaxed/simple;
	bh=DAlPlTs+16MibKvjtVDLB7vwpJiecnFULsgDCkmeFHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhjEHQMuoFIWjGYqeqM6tJddl9Ow3kwCdQ2BUXrrHBDMjA2VoX5hzk4MivHgmeBNSvTNulnGFet76zc/0K+r6IdkHwpOsoljbADAqvab+nZGA4zxya0BdQQPCyQxbXxwwLS3Bi4ftZn7GBZIIo1Di7y4+mQXtKF9fjAT2JNf0hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFmrckly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB71BC4CECF;
	Sat, 19 Oct 2024 08:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729327275;
	bh=DAlPlTs+16MibKvjtVDLB7vwpJiecnFULsgDCkmeFHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HFmrcklyRncTXvFXM99oWzszEuyVFDE1BKlqiBhE5C5GpNQvcGmWxdMjAt8AvJwDs
	 HchdHngj7l4evdnRa25trmijqpD4uvQ1x+ajdVhim32FIdT2RVbOYBwCTumyDDbTMe
	 cvpiNlh/rAxX4At+ORWh/loSO/9KtyORQ/U58D1/XNChZUDeVPAfX+Esj2n7WbfSmb
	 oxZRxo2kXUpTeAOBZ/1yDGjJ4e9wwznUYPw2rTXdxxtS+lLENL1prJsso9NnrtfoQ3
	 C0+oHns1/5HBN/9tHIIjjkVxUs7RiCSSf4DT22Qn9CgS0/2YgU7L7cVd8Za1fU3GFK
	 HDOXNYK0BDDGg==
Date: Sat, 19 Oct 2024 09:41:11 +0100
From: Simon Horman <horms@kernel.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: akpm@linux-foundation.org, jesse.brandeburg@intel.com,
	colin.i.king@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/spelling.txt: Add typo "exprienced" and
 "rewritting"
Message-ID: <20241019084111.GO1697@kernel.org>
References: <C1FE2459CF066CA5+20241018024719.58325-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C1FE2459CF066CA5+20241018024719.58325-1-wangyuli@uniontech.com>

On Fri, Oct 18, 2024 at 10:47:19AM +0800, WangYuli wrote:
> Add typo "exprienced" and "rewritting".
> They were found and fixed in follow patches:
> 
> Link: https://lore.kernel.org/all/90D42CB167CA0842+20241018021910.31359-1-wangyuli@uniontech.com/
> Link: https://lore.kernel.org/all/45F06B5D4CA9F444+20241018023340.47617-1-wangyuli@uniontech.com/
> Suggested-by: Simon Horman <horms@kernel.org>
> Link: https://lore.kernel.org/all/20241017162846.GA51712@kernel.org/
> Signed-off-by: WangYuli <wangyuli@uniontech.com>

Reviewed-by: Simon Horman <horms@kernel.org>


