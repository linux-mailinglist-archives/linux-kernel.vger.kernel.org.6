Return-Path: <linux-kernel+bounces-290093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FF3954F4F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A36731F23330
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507C31BF30B;
	Fri, 16 Aug 2024 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l53Elb4x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F3A179A3;
	Fri, 16 Aug 2024 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723827089; cv=none; b=NGrF82BckCRwC4KvGq5XvW2TZv5q8o4tZ6QuHR1+XO7o3YZ+1hTpuHkv2Lu8HuCvwCcsemdjzOAdz0oJWGVXp9KoJIKFZweFeYn7miDPj2vxffcc6hAlDHWgowlYLY8BWcwC7IAKoXWrOuspVsagwcNyzOXvZciTi4hzzvRkYdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723827089; c=relaxed/simple;
	bh=h9wGdr8bSQV99HJYZ9yR9TGr7cPVcjfNE1R0NMCwxFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmdf7TRUiqnwermfjHeLPDj23OifwGN+sNai12qUy8ML++dvY/fXz/I6s8dnUN7PjEhQXUCSmyuclSFy26YaHW7PS6rkdIdw0f8WIRg2g3PkR8PXBfyRI5lgEmZBwNdYxidQjgTRxpryPOlmiPRwjuywOdhBzYpPoB0JEEau5ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l53Elb4x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6EDC4AF0B;
	Fri, 16 Aug 2024 16:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723827089;
	bh=h9wGdr8bSQV99HJYZ9yR9TGr7cPVcjfNE1R0NMCwxFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l53Elb4x0oxFDNSVmJnYAAmuUk8GNhK03kg2bTdbEzdS84I4aYfJH2bWCDUptH3mc
	 OnpRr6d7GxHpilYk3EUfXEdCyfp2B/EBtYlAurHF2qN6OWimF+o3NfyjJTnMlkWmw4
	 xnpy7Vob1rIcB7Y2aa9+7XhwDhlN5u5fm2DjfqSzbDzuMlMYL8aEP2QYlekdX2Pj1B
	 qxkKlueg63ElFefvop52EpfdTNNfGvLrts1NgQPPfyV2IRsErsJbe6Km9y9ybzFodk
	 6mUz5rm2bNZ7kDUyNAQ6RI7oOrPkv/md3hcjiqrrOZge8Sawa27yFmeWjvFeBEjsDt
	 nhCJrJ7ydvDqA==
Date: Fri, 16 Aug 2024 17:51:24 +0100
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, olga.zaborska@intel.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] igbvf: Remove two unused declarations
Message-ID: <20240816165124.GZ632411@kernel.org>
References: <20240816101638.882072-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816101638.882072-1-yuehaibing@huawei.com>

On Fri, Aug 16, 2024 at 06:16:38PM +0800, Yue Haibing wrote:
> There is no caller and implementations in tree.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


