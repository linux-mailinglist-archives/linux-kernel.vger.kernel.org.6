Return-Path: <linux-kernel+bounces-558240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82510A5E351
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4FC6189A773
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C01253B73;
	Wed, 12 Mar 2025 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUathdsX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8601E8325
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741802346; cv=none; b=ncl2XmpX1OgyI89Qlq7AaVAeDhfk08Ev+xY4K/zI1u0YeZ7B+98fx6OVEsH2Dsic/r2rl+Rdewd86scnG4Z3b+sCQoo6wspCc0I06z61sTMKGJUBZYtGLAPPSyclk7QpVqpPJGaSetqgVrJ75x0c2j6+rDRG/kI2NB318wtAeHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741802346; c=relaxed/simple;
	bh=Nhe3kXCMhs0V3Qxlf+bZ9chva2LNccUSEVkWWtw5Y30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=js402Vm0uXmUIVb9wlNDo727H9YlTb3kNNpmCnWNTCKjeYRkhN8nY0sZu7UFdiuuBn+MbhtyPd96GvbqUNnAXX6Jj+E247B6TA7j47yJrX2zO1PdaU8BJ/rvAFIJPUOevYWjbhjcxgzcokfTvAiDeignxtXXOpwCMA9fJzz5aQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUathdsX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB43C4CEDD;
	Wed, 12 Mar 2025 17:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741802345;
	bh=Nhe3kXCMhs0V3Qxlf+bZ9chva2LNccUSEVkWWtw5Y30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qUathdsXbD3y3s+/El3DlxZd2umXGcSIQuUUFVPwWQkZeDMM2xC9GAaYfisXGLdd0
	 gUYTWBGdwIJsY5GsE/3zDDMY0pbB2/jNgRlIofCKmHGtv6YlYivI3Kw8XJjcn/a04A
	 9JzLGTz2H6XxXfQGsBkLhgnXjvb+273z0Wtw6sdUdzqync3rqVGrss9q1Nc5rbAToF
	 XmxpebJsnwpqGk3lboC1u3V9Iaxo9l7K2gmcE1rJQwFE+EPCHiJqfDWxKceDaPv/QI
	 KXex5Bw50MppsUZ9YC67kOIPa5vfC3vimKNE3c3mcA0RLSwXhJnKSahJ8I8qvbhc2I
	 t4MmvVhPTOtMA==
Date: Wed, 12 Mar 2025 11:59:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: james.smart@broadcom.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	james_p_freyensee@linux.intel.com, jthumshirn@suse.de,
	zhanjun@uniontech.com, niecheng1@uniontech.com,
	guanwentao@uniontech.com, chenlinxuan@uniontech.com
Subject: Re: [PATCH] nvmet-fc: Remove unused functions
Message-ID: <Z9HLZukL5iMPKHtD@kbusch-mbp>
References: <E2A54BF9E5C050B5+20250312050650.1793024-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E2A54BF9E5C050B5+20250312050650.1793024-1-wangyuli@uniontech.com>

On Wed, Mar 12, 2025 at 01:06:50PM +0800, WangYuli wrote:
> The functions nvmet_fc_iodnum() and nvmet_fc_fodnum() are currently
> unutilized.
> 
> Following commit c53432030d86 ("nvme-fabrics: Add target support for FC
> transport"), which introduced these two functions, they have not been
> used at all in practice.
> 
> Remove them to resolve the compiler warnings.

Thanks, applied to nvme-6.15.

