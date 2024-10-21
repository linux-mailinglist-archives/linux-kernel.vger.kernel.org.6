Return-Path: <linux-kernel+bounces-374883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE719A7182
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB9941C22D88
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5E71F9403;
	Mon, 21 Oct 2024 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClhW/BCh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEA81F8EE0;
	Mon, 21 Oct 2024 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533410; cv=none; b=AXNPfx4WpGxrQvJNZPO09k2WBo0gkA31teGoeC0hfL8FcGEKu4T8K3qOwPr0zwoAMkB8jBfBwTX2LsjEh41ZSPmRJq2z9puwNoHeob0uFnHyxeJ+N20asTG0XByWEWW1yj+lZvVneaJJZTaYLSs2+kqpnT3cPsNppsK1pFeLk2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533410; c=relaxed/simple;
	bh=PoMYB0MBTluKGbrOcMZ2NG103OhIvWMsk4YgoHV9f70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGszTNrmjynGLvGj6m3L6PadO9l5pkdkw7VI9PWIFycEo+jOxqZZQavehdN5jt7pIzBDMYya+fbiyZ50yoQrU/g4ciLp3QQX5GzCr94WxIIS63o1cVZadOjZlP0GYOoO7HJYkbXu9x+XjVJx3FkD8+1Du5C2CqgToDmbqRlBVes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClhW/BCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC84C4CEE8;
	Mon, 21 Oct 2024 17:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729533410;
	bh=PoMYB0MBTluKGbrOcMZ2NG103OhIvWMsk4YgoHV9f70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ClhW/BCheoLjCVUeO5Hrv+Aur7HSWu9EYLAi7inVvuP8oVd/KvwFmNfKgmkkRbsaF
	 z+6ZybIESrdi+ullcxIg7R3Ftil8pZoSiu9/cSLe/FTQJIarUhfxivMrCrT8S99Z/J
	 5mekzkdWxZfWDkm/6aMcl3dgIHErSqYmu4nHDRdf8od7tgcfz/as4KsEKqUxJEsSJL
	 L9DREu6fgNlQe8ZnVAFg0/FJFaOo+5xvQhNM1akt9ybMNrIBPbBbo9MRuQrBUOBhf4
	 7zKSdyn9Y/NtaIXKF592EvoFZcy/q3zjZjh1uVGu4u+SnOHN7maGcwH871lDW6Fm6G
	 uaQ5FCMUKy0QQ==
Date: Mon, 21 Oct 2024 13:30:06 -0400
From: Sasha Levin <sashal@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: torvalds@linux-foundation.org, ksummit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <ZxaPnk-uC7-A-f_e@sashalap>
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <e27ab2c0-ddee-4fc2-a41e-70b4a7775127@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e27ab2c0-ddee-4fc2-a41e-70b4a7775127@acm.org>

On Mon, Oct 21, 2024 at 10:24:53AM -0700, Bart Van Assche wrote:
>On 10/21/24 9:07 AM, Sasha Levin wrote:
>>Current testing:
>>   - LKFT: https://qa-reports.linaro.org/lkft/sashal-linus-next/
>>   - KernelCI: https://t.ly/KEW7F
>
>Hi Sasha,
>
>Is blktests included in any of the above? If not, please consider 
>including it. During the past few years we have noticed that the
>test failures reported by this test suite are most of the time caused
>by kernel bugs. Sometimes issues in the tests are discovered but this
>is rare. See also https://github.com/osandov/blktests/.

Hey Bart,

I don't plan on doing any tests on my own, but rather have our existing
CI infra (kernelci, LKFT, etc) deal with the actual testing part of
things.

AFAIK KernelCI if working on adding blktests support!

Thanks!

-- 
Thanks,
Sasha

