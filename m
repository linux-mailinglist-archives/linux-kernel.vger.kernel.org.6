Return-Path: <linux-kernel+bounces-523139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8D6A3D291
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 618B017C055
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF921E9B15;
	Thu, 20 Feb 2025 07:46:06 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DA31E9B2D;
	Thu, 20 Feb 2025 07:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740037565; cv=none; b=YGroIZ8VAPNczkM9RS8VMuf5V5/jwt+0umUj4Z45/6/UYf/wfwsQPqnQZnisVVPGP51E/YuduMNe7eX2pbkSVkhMty4YvK7UU8sxgBhqmc7fAvV6Uc/xr1GRMSgI+EQUY6gQsvWM2ypgY+tnG4FSi6yUBBtHs1sFjbQvvyWYktc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740037565; c=relaxed/simple;
	bh=24E38aGTaxxEzPyzWRerQJnY8HDDXmt8Rkt7nsVgV3w=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=s6KKaK4ZhGufiV5xrmKqYveeu9F0bd+pusGw3fQMGaw1f3wBq5mVtQh+8FNoDzxSl9f5GQsif09O2wY7Qme/ztoLqQRg7GqmAlbhShQJMSlfw86qIBhO03mUhgTbaO5lZT+KbHff1ZKfiGiFyWk4GAzh0CNPV1Z0kHQix1S2PFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-49-67b6ddb64ed6
Message-ID: <93792bf7-9507-474f-a8b0-ccd4d59742dc@sk.com>
Date: Thu, 20 Feb 2025 16:45:56 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, Jonathan Corbet <corbet@lwn.net>,
 damon@lists.linux.dev, kernel-team@meta.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/2] mm/damon: introduce DAMOS filter type for unmapped
 pages
To: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
References: <20250219220146.133650-1-sj@kernel.org>
Content-Language: ko
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <20250219220146.133650-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsXC9ZZnke62u9vSDVZ+17GYs34Nm8WTA+2M
	Fk/+/2a12HcRyF3YtoTF4vKuOWwW99b8Z7U4/PUNkwOHx6ZVnWwemz5NYvc4MeM3i8eLzTMZ
	PRb3TWb1OHexwuPzJrkA9igum5TUnMyy1CJ9uwSujG/vN7AUvOWumHW8jbGBcS1nFyMnh4SA
	icS398uYYey2h/dZQWxeAUuJ/X9fsoDYLAKqEvvPbGOEiAtKnJz5BCwuKiAvcf/WDHYQm1lg
	N6PExFZdEFtYIFjiwYRWpi5GDg4RAR+JluWJIGEhAWOJm5d3MkKUi0jM7mwDW8smoCZx5eUk
	JhCbE+iEHycXMEHUmEl0be2CqpeX2P52DlA9F9CZJ9gk3i3+ywZxs6TEwRU3WCYwCs5Cct4s
	JDtmIZk1C8msBYwsqxiFMvPKchMzc0z0MirzMiv0kvNzNzECI2VZ7Z/oHYyfLgQfYhTgYFTi
	4Z3Rui1diDWxrLgy9xCjBAezkghvW/2WdCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8Rt/KU4QE
	0hNLUrNTUwtSi2CyTBycUg2MrLlbSjQ0Ljjo7nFomXGYcyXPEeY5XvpHT37h3fTF1+P4jNDq
	MxdWJRQydl5tuMt2/fVaua8Jj9+WNxX8TszPOL6tPkJd4NryXPm469qC2n9crFxmrldeaxK1
	4MriT/0vzVjE5e585K8y2LN1BsPysjc1X1ZpJNrU/7uefvvBaxbThFL/PflOSizFGYmGWsxF
	xYkAJwXW+pACAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsXCNUNLT3fb3W3pBi97ZSzmrF/DZvHkQDuj
	xZP/v1kt9l0Ecg/PPclqsbBtCYvF5V1z2CzurfnPanH46xsmB06PTas62Tw2fZrE7nFixm8W
	jxebZzJ6LO6bzOpx7mKFx+IXH5g8Pm+SC+CI4rJJSc3JLEst0rdL4Mr49n4DS8Fb7opZx9sY
	GxjXcnYxcnJICJhItD28zwpi8wpYSuz/+5IFxGYRUJXYf2YbI0RcUOLkzCdgcVEBeYn7t2aw
	g9jMArsZJSa26oLYwgLBEg8mtDJ1MXJwiAj4SLQsTwQJCwkYS9y8vJMRolxEYnZnGzOIzSag
	JnHl5SQmEJsT6IQfJxcwQdSYSXRt7YKql5fY/nYO8wRGvllIrpiFZNQsJC2zkLQsYGRZxSiS
	mVeWm5iZY6pXnJ1RmZdZoZecn7uJERj2y2r/TNzB+OWy+yFGAQ5GJR7eB4+3pguxJpYVV+Ye
	YpTgYFYS4W2r35IuxJuSWFmVWpQfX1Sak1p8iFGag0VJnNcrPDVBSCA9sSQ1OzW1ILUIJsvE
	wSnVwCh5knHnPTeHmQcX7jmkIy72c5WO3MH9vvFaF/a2dzT+m/H/1JRM5kpHY403+b6/Mj5+
	sLiTWCJgWFk1xe5q6qdUf5n3PWat8y5eOvH10vZt2WniB+bl+G1U4/8izx3XfP97Utfus+H8
	aSVS3griWqybHYMuvXxYvUGJnWcT1620rWaxkqoS1UosxRmJhlrMRcWJAEgNI9N3AgAA
X-CFilter-Loop: Reflected

Hi SeongJae,

On 2/20/2025 7:01 AM, SeongJae Park wrote:
> User decides whether their memory will be mapped or unmapped.  It
> implies that the two types of memory can have different characteristics
> and management requirements.  Provide the DAMON-observaibility
> DAMOS-operation capability for the different types by introducing a new
> DAMOS filter type for unmapped pages.

I asked it before at https://github.com/damonitor/damo/issues/13 about
monitoring unused paddr area but I see this patch series is related to
applying DAMOS action.

Regarding that, do you think we can skip those unused memory area using
this filter before applying DAMOS action?

I'm not sure if the current DAMOS tries pageout/migrate action for those
unused area because they are detected as cold area although those will
be imediately skiped inside action scheme.

Thanks,
Honggyu

> 
> Changes from RFC
> (https://lore.kernel.org/20241127205624.86986-1-sj@kernel.org)
> - Rebase on latest mm-unstable
> - Wordsmith commit message
> - Add documentation
> 
> SeongJae Park (2):
>    mm/damon: implement a new DAMOS filter type for unmapped pages
>    Docs/mm/damon/design: document unmapped DAMOS filter type
> 
>   Documentation/mm/damon/design.rst | 2 ++
>   include/linux/damon.h             | 2 ++
>   mm/damon/paddr.c                  | 3 +++
>   mm/damon/sysfs-schemes.c          | 1 +
>   4 files changed, 8 insertions(+)
> 
> 
> base-commit: a2130e89cbd08ddb6f023b0b10eb87ebbc67add1


