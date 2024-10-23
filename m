Return-Path: <linux-kernel+bounces-378728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727339AD472
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF2B7B22726
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5711CDFB9;
	Wed, 23 Oct 2024 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFl2bXzY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270D914658F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 19:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729710212; cv=none; b=VAJfyDVViE+XMYxeiKhSif9nC3jRIGKAJn0GV5BFNhv6j+eQAK88Osz5HWLfRkUhkxzB3xXaZVVZRvMec3GmHRUwWUJk2xVHkfqE9T0E37JFK8IP8LpGV/Xa0tEfQlStiT7pVU+KtZmB9i4IggsX9hjYzSVswR7vX0ftiHUySeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729710212; c=relaxed/simple;
	bh=CZH/84Ek9rzDjA6ub4IK/RwfA2npXsLdu4sF0W0en/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTHjxX4BIkNjkAhIM1uRWKNRu5DccrnqGrwhe0kUgfJyHHmUqcoV9WBvhqgKB68amxoQzLybdpZ8hAl92BGSew1rIhgKX9V6quNj7rekSA+97+d6UVP0td/z0n5xjfzfk7BcZIYWLNSgQprmOC2pc6AGQmQBHGnpLCnb05Wb96c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFl2bXzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91266C4CEC6;
	Wed, 23 Oct 2024 19:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729710211;
	bh=CZH/84Ek9rzDjA6ub4IK/RwfA2npXsLdu4sF0W0en/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rFl2bXzYpTQWbD2K4exnxJ6nQrrud0YrDgd/0jr507UQyCD1ZQsT31BAcsuCEkcDa
	 lF7VRJcQptPGlq85aGXprUmHvAmamkuOeYs4qp+aPj7osBpHfiTZC/ZIHclKCVInVP
	 5WDt4o1nSbUZyJ5RzDJqJCYD9Wf9A85/PY2IW9H9E8UOYg5AHJmbrMf+Y+AtUMn4Uz
	 ync2A6PqPb/ui1F2xVCPZ1ynLvUwoYSn/0MPLcoihn8csmPuZNDQhcUtg/c3gXfBel
	 p5Y4WdvMFfwGm/0MA55t4NCFfXRDwTsm4D863ezylSe+I8s/a51w84nfpmbghm1piY
	 wAxRLnqcan5cw==
Date: Wed, 23 Oct 2024 09:03:30 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <andrea.righi@linux.dev>
Cc: David Vernet <void@manifault.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-6.12-fixes] sched_ext: fix fmt__str variables in
 kfuncs
Message-ID: <ZxlIgnLAiXddfTmT@slm.duckdns.org>
References: <20241022074035.139897-1-andrea.righi@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241022074035.139897-1-andrea.righi@linux.dev>

On Tue, Oct 22, 2024 at 09:40:35AM +0200, Andrea Righi wrote:
> Commit 3e99aee7ce48 ("sched-ext: Use correct annotation for strings in
> kfuncs") renamed some parameters without updating the body of the
> functions, triggering build errors like this:
> 
> kernel/sched/ext.c:6881:45: error: ‘fmt’ undeclared (first use in this function)
> 6881 |       if (bstr_format(&scx_exit_bstr_buf, fmt, data, data__sz) >= 0)
>      |                                             ^~~
> 
> Fix by renaming also the varibles in the affected kfuncs.
> 
> Fixes: 3e99aee7ce48 ("sched-ext: Use correct annotation for strings in kfuncs")
> Signed-off-by: Andrea Righi <andrea.righi@linux.dev>

I removed this patch along with 3e99aee7ce48 ("sched-ext: Use correct
annotation for strings in kfuncs"). This breaks compatibility in a way which
is difficult to work around. If we want to do this, I think we should do it
by introducing new set of kfuncs and than phasing out the old ones. Also,
it's unclear what the practical benefits of the change are anyway.

Thanks.

-- 
tejun

