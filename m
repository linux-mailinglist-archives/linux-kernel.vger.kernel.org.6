Return-Path: <linux-kernel+bounces-406886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 342669C659D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 01:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1F81F2415F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A5B21CFA9;
	Wed, 13 Nov 2024 00:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fKtNa5cu"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EDC21CF8A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 00:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731456010; cv=none; b=HzT32Z8cPLrDHQHtgksZ3kEbiZyEHSRaSncAzfhMZbrPRQD2ePYzmqs56mgKMql25xTexq1biMWqIKi/wcbAoPnlhRVRPp/S+2Zo3LvdBtofc/tFyyhovRUoqPd/ee8BBrlzGUX/z3+qyR2CUNBJHSYz4EfYE+l6ONfTxkcupJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731456010; c=relaxed/simple;
	bh=T9l4BhKEzVRKbKPCslHurC3VcOM7HxkzI+55rdfE1Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTsnhZCHcKPiWdEHlumOZ4ABUZlQmjiv5mQdy1PXk8WddophkahhxbU+YGkEo/KumUOJGcRLTOpB3VRkI/b/mX6txLk0Q7tlpAfkDEjABQnj9Gfw5AsfrCNJbAjOVMwtm4aLC1f7YcwoPAjFaWNJIbCeRKDH9kMvTMLvrPt2HY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fKtNa5cu; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y3/xiYa/xohR6fnb9i1BK9eaSk5Lo94vVozm1B5+coI=; b=fKtNa5cukPZ9IrOb52Fc/BAu7o
	eQSkezc4UHMELJtj9RSSVAjGbB2Jzn/EEQWetDJcPjJ6MbhxVST7G+qTPNFjfgRbI3AL6rDY9PgJv
	ywWRds+oOUeOIwEadp3+rZ92pUMnHxZyfKPteFeRsAyoX1DFrlLjkfPyRj4WanXsSSS9oiWAI73vC
	H/quKeSLSc2m9aLHyL/N9RkJAUfnyOlr7Kp6XAl0yzwr90lU7amLS86QDyeFGkBgty2CO7KEArKaW
	IcfaK+adJr4X+jyNx77uhS2p51hDga9RYW8fu6N4fS3mLTRL5PsTOwDPm6jRzAzYCOfOgOoYhdBo5
	YiLPfqBw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tB0nk-0000000EIN5-3gpW;
	Wed, 13 Nov 2024 00:00:04 +0000
Date: Wed, 13 Nov 2024 00:00:04 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Agathe Porte <agathe.porte@canonical.com>
Cc: linux-kernel@vger.kernel.org, Jeff Johnson <quic_jjohnson@quicinc.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 1/1] ufs: ufs_sb_private_info: remove unused
 s_{2,3}apb fields
Message-ID: <20241113000004.GE3387508@ZenIV>
References: <20241112122000.35610-1-agathe.porte@canonical.com>
 <20241112122000.35610-2-agathe.porte@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112122000.35610-2-agathe.porte@canonical.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Nov 12, 2024 at 01:18:25PM +0100, Agathe Porte wrote:
> These two fields are populated and stored as a "frequently used value"
> in ufs_fill_super, but are not used afterwards in the driver.
> 
> Moreover, one of the shifts triggers UBSAN: shift-out-of-bounds when
> apbshift is 12 because 12 * 3 = 36 and 1 << 36 does not fit in the 32
> bit integer used to store the value.
> 
> Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2087853
> Signed-off-by: Agathe Porte <agathe.porte@canonical.com>

Applied to viro/vfs.git#work.ufs

