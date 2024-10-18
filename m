Return-Path: <linux-kernel+bounces-372309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B13A9A46F7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 21:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ADB1283216
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F91204942;
	Fri, 18 Oct 2024 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfaV8r5r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B53516EB4C;
	Fri, 18 Oct 2024 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729279756; cv=none; b=Z10ZJGDoCySPEqDf+Im3dSZvDVkyddtVpFD5cZBoh/Ay0rc8vjbrT5PIqne+BvXhAnm6sRdZ266mqfUDPWWCGa8M9TMmdXQ8l5L4P28lj034Sm0nugGl66siqteqQcxlmreewmKH0EuK/reOZ9Pv/b0XGZr6LAppRsbIJQkhK1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729279756; c=relaxed/simple;
	bh=F9jc4H2Uu88wd7hxrwfCVyb5JZTtH/39g76NARRm75g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROjeKBJoZpX2BRVQmk15oXHVZojQd0b4la6eMF/8zl6dIZ5xVOS2KupaXlfDn5T4k4BjF2+dsgHQ4Sj9XXQHZ++BA6lPamZlYfyjr44WGqwpuSUNH6/mkyiynQhuQnNRfHgUQXlCZTN9Tr4XWkzXm/eYGznQF9kUOAcNgT0/jns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfaV8r5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA49C4CEC3;
	Fri, 18 Oct 2024 19:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729279755;
	bh=F9jc4H2Uu88wd7hxrwfCVyb5JZTtH/39g76NARRm75g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AfaV8r5rMXzHaM8ThnxSHYSipHrwZWR+bXSvnaByPdPXRi1Q0xBC44S3x0N7XZ4J7
	 B1Gp/PcR+uV9pX229pMlBgnEn8QQxuxp4XALptF671h8KS28PYu6CnmwDB/hE4S8Ou
	 l9iwFKcWdMB8ufSu/8V74J6QW8a+laX/OtiWJukkXwpoqpjc5CQiTl6yslNOXGStCu
	 dK6Ty46Br5dkenGS1hhDr3K9Zj6nJ4fjR2IO5vSizWeiTvJbCG6YCG7HXB6liINsi+
	 yXcsExXbyk+rvaHZCOvTg9R0NKU8ZNicU9Oo8Hi4b+n0Apbxw38GM3yUqtXMKCz4j5
	 LosI+72QZVTwg==
Date: Fri, 18 Oct 2024 20:29:10 +0100
From: Simon Horman <horms@kernel.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: michael.chan@broadcom.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	mchan@broadcom.com, jdmason@kudzu.us, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, mcarlson@broadcom.com,
	benli@broadcom.com, sbaddipa@broadcom.com, linas@austin.ibm.com,
	Ramkrishna.Vepa@neterion.com, raghavendra.koushik@neterion.com,
	wenxiong@us.ibm.com, jeff@garzik.org,
	vasundhara-v.volam@broadcom.com
Subject: Re: [PATCH] eth: Fix typo 'accelaration'. 'exprienced' and
 'rewritting'
Message-ID: <20241018192910.GB1697@kernel.org>
References: <90D42CB167CA0842+20241018021910.31359-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90D42CB167CA0842+20241018021910.31359-1-wangyuli@uniontech.com>

On Fri, Oct 18, 2024 at 10:19:10AM +0800, WangYuli wrote:
> There are some spelling mistakes of 'accelaration', 'exprienced' and
> 'rewritting' in comments which should be 'acceleration', 'experienced'
> and 'rewriting'.
> 
> Suggested-by: Simon Horman <horms@kernel.org>
> Link: https://lore.kernel.org/all/20241017162846.GA51712@kernel.org/
> Signed-off-by: WangYuli <wangyuli@uniontech.com>

Reviewed-by: Simon Horman <horms@kernel.org>


