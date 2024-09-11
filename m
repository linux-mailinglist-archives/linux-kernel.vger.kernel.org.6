Return-Path: <linux-kernel+bounces-324658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 336FA974F6A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12601F224DB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE414181B82;
	Wed, 11 Sep 2024 10:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdyboa+m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1A67DA83
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726049485; cv=none; b=qPyEgqFwjrJ6BM2rFHQknYDoWwZ1EGX7v079YRJkH+TtWd1dWKTEC8/dinI6mg/+z/dcA8ODA5uNcNPbjUrcmx9dAz0I2YsmgS4hlUM+4fUR1OTdbQ7zlbCqxGagR7yprUhGPGJ8x3XZEa4vyUL7NjtMde+w8fbPtXkq6iomf2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726049485; c=relaxed/simple;
	bh=YvMlm2ESwrZTXRL5FZVtN11iIJixl70i7lygrB5p/Dg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W7ecWxGYmwhzkZt64T1l6tw+y5dIRr9pDGJ9xqAxyexjttgKwqLeSnyqYKHqKu6Jbxdkkl1hh6ihPkM/546OCHYU4RwSHUv0TWdClVS9CVGI7OcTeI+ULvAH8KunJhtp5UTvgsztsKfotmk5KZk2je2DUGS6W/anL+9uqrUEVCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdyboa+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6C2C4CEC5;
	Wed, 11 Sep 2024 10:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726049484;
	bh=YvMlm2ESwrZTXRL5FZVtN11iIJixl70i7lygrB5p/Dg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=gdyboa+mByyyt7sm45nRTt9KN6uJUXofon0hlSsK51BFmlVXaF434+pK5e7fr1ZGw
	 hjzPbop/Y7S4sdrOWER+u7nCPkzfYs/aLUNbQMPLoYxGuA3yGiGgYshRUqLQ32SHm3
	 4f6nc8hJtxD140BPsQbt5aNLUYukYdTflgSnKfmsRkkBruDJq0RwAeKMcWQEfwZW3a
	 ZgcbS4mEESxLAoj3Hassmyd66dRgxwk7h893ZUHR/+v07E8gwMfJike2CkfZ/ARXFY
	 I/fV+11t4i+t26g8EwKBl26XCoyvHn3AlA5LXxkKi4KMzeE2VgbgB+cGJ1pmR87Z9I
	 DGc1GiJIjSRVA==
Message-ID: <975e18d5-3870-4503-a5c9-0740e859148d@kernel.org>
Date: Wed, 11 Sep 2024 18:11:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] f2fs: remove unused parameters
To: liuderong@oppo.com, jaegeuk@kernel.org
References: <1726022421-58677-1-git-send-email-liuderong@oppo.com>
 <1726022421-58677-2-git-send-email-liuderong@oppo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1726022421-58677-2-git-send-email-liuderong@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/11 10:40, liuderong@oppo.com wrote:
> From: liuderong <liuderong@oppo.com>
> 
> Remove unused parameter segno from f2fs_usable_segs_in_sec.
> 
> Signed-off-by: liuderong <liuderong@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

