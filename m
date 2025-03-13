Return-Path: <linux-kernel+bounces-558682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE859A5E95E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 02:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12726169F7A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 01:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677B3179BD;
	Thu, 13 Mar 2025 01:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uG8stgWI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C467128399
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 01:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741828758; cv=none; b=JQOHR2IaulvA+9E/wXssLpFVnd/ai/d/gbizhB5LLZ0uWVEa2LGZFYs/5M5hTdkblD88+v7fu6AKZB1Ud0KEDNrO46V4CoghmOr6mkBcc3HX6V+xsONOooBlfpOC8ubhLW6yu66v/wGlvw/HeLf9+o76UkgWMafYl7djve3+trE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741828758; c=relaxed/simple;
	bh=VTXgiklq/UXDkZeGwoU5V8KaGpojlXqESK7KZcNIKzo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j8/9Oovf9mYfmpQrWRaIrBSCDjlqz44Llzd3X/MipTDppdVqKahSVmUOnN0Zbu8cZHfIws5Y1n02yau9ogQtBaEKHgQiX49LzqQXM0nmBhfq4ZqqjSSA+WnPy7OmZo+IOK8SmT3AQ2p9ZWSCYGljDiQzEu/abDnUNbdqx2q4fZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uG8stgWI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC96C4CEEB;
	Thu, 13 Mar 2025 01:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741828758;
	bh=VTXgiklq/UXDkZeGwoU5V8KaGpojlXqESK7KZcNIKzo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=uG8stgWIsOW1bRspuntE1tJoS0n4fmMFjJb2DE40UwirUvCRwO8G+AwGq18wPATUH
	 4wiWexMAvCZCuCGBcpHIPPh6bZYKkVpGi3fuScM681fhPpWWOTNYHHy0h3bHvOwJsQ
	 TwuqPU28E1BKiTyZv1EKeH48RrOk3b62zF8pERrmYwHAxzvnVmOvWMCmsF9ZCrlgTl
	 WU2pFyMGcyM02J4yBvREQaPZzt/MsTtreApKHAsoAIPd/hd8ift5NMaTa+S93/qdYa
	 mkVpBdFF5gnPBFJuZIiqJBJDP1sZRv73DhbHLJF1EOPhVwGxIKIWCERVRrm21rVGF7
	 Qt/iBxG2Z9wjA==
Message-ID: <11b8f5a8-f9d6-4d86-a313-b678b8e188e1@kernel.org>
Date: Thu, 13 Mar 2025 09:19:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: add carve_out sysfs node
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20250311182931.1043290-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250311182931.1043290-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 02:29, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> For several zoned storage devices, vendors will provide extra space
> which was used for device level GC than specs and F2FS can use this
> space for filesystem level GC. To do that, we can reserve the space
> using reserved_blocks. However, it is not enough, since this extra
> space should not be shown to users. So, with this new sysfs node,
> we can hide the space by substracting reserved_blocks from total
> bytes.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

