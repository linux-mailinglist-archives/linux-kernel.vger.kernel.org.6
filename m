Return-Path: <linux-kernel+bounces-272305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A149459EF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15BC81F25504
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D371C0DCE;
	Fri,  2 Aug 2024 08:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6cPlJKB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9702D1BF327
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 08:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722587503; cv=none; b=Zn+Sv/9r54/YcvhhxC+DOwXBe+h2gzjRruoRuEtKz2VT5g1rH0sFvCBSdfi8LDVlEev3pnOpbWIfSMozLT2gxyYI641RAXEAL1d8w8UouErpGKq5l3VSuk5gpGaB2VErPp9emrFI/qCV1H1XyevjgXhN9DPDZzGAExKspkva03w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722587503; c=relaxed/simple;
	bh=ATqdkeQXUqqjv4Hb5DHIWAQGElZkG2G8qJ9sP9ylcOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BnLPZvgLvbbxRQ6CgSOZnaM9Kztoby8tRAMbMSWAqmtKY0cX8L9yNi6rWQD+iatUjmMu9hAMxmLUPl5IqpNzNXkd3tX3JjdMSeqWMB1KLaj6bV7T/sduWhGbIl0C0wDv3ohIGRcPj/JPL79i/Iw0NbVGrtYyfF2hPGnEx1bMGy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6cPlJKB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAC4C32782;
	Fri,  2 Aug 2024 08:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722587503;
	bh=ATqdkeQXUqqjv4Hb5DHIWAQGElZkG2G8qJ9sP9ylcOw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j6cPlJKBVmi2TKsUogd1nvWUTsm3GNXG97hfwGDKB8WOxkrwpoNo0lsW1AOHn2J0J
	 P3PdDQ/fJN6L5qch4NnLWT6hWc/drsn/hmw4ybt39Tnvb8f1orHfbkTVO4kh7Nbcbj
	 2W9AeeT9YN1ULOgg6sDigmLidRDw4HYBSx2q0xtT9sc4JTOsTdAzX8k2BM2tf+WEvB
	 ON0dZruZCw90jVcxGbPUwILeaKrw4odTbL0uo/vfh61aSZg0D7BODOGjnqw3ukjoQ5
	 DNu+o0usq+VeH380cK2i5iniv7kEYN02xmeKwbEJrmT9gA2h1g5p1pT6KmRqkE9qzi
	 LRt6ajwBDbTiA==
Message-ID: <be8af273-0956-47a5-9a85-ce74a5504217@kernel.org>
Date: Fri, 2 Aug 2024 16:31:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: clean up val{>>,<<}F2FS_BLKSIZE_BITS
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com
References: <1722476031-22106-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1722476031-22106-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/1 9:33, Zhiguo Niu wrote:
> Use F2FS_BYTES_TO_BLK(bytes) and F2FS_BLK_TO_BYTES(blk) for cleanup
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

