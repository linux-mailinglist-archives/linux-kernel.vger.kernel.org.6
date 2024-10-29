Return-Path: <linux-kernel+bounces-386709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5808B9B4738
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A951F2411B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504CC205136;
	Tue, 29 Oct 2024 10:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Z5hCKpm6"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8726E205145
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198876; cv=none; b=QI/q/FSnogvHcYxnx79TgkNpR0s81x3IlPtwR1AHaukay3GTw/qO8TMEoW0Pu6u7Pj763zf/j+U1xT3sKfrL4cNYsPoZ6W+5HTBSH/SB9GI47fklloijo5tJeZuBFLbLBzA9svs3bHBMDm7eHzDycSmnj/aA3L+TXJQLvd2mFsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198876; c=relaxed/simple;
	bh=z4MmmruKHDgcFwBjhbNnPFNvUTYhOCWSBr6hgQkASJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SUvnPz64k50hn8zvMecMl9RJ5Qmq2sMxs9DaukmvwJnbAM8B/hxRTJcsXZfbF3DhzbXp0lOT7q6+o9gSAvBdpzrB6rPs9SFEyHMUf3Y9/3eRYa7PFvrEVnVnmi+8Wwty4V3XmJVL3+5RdEX472rnn/X58jQzbqeAAmCuQzfylVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Z5hCKpm6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730198866;
	bh=z4MmmruKHDgcFwBjhbNnPFNvUTYhOCWSBr6hgQkASJE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z5hCKpm64qYkRVt4QTVglpykqTb/92V4MqBTZWVJ8xXtTHSEA+Hxqfc4nIVgAUHkL
	 8I+Qti/Mzke1ZDQnS9JgnsglYu/+0jMZAs/r0QFgTUDn7kAOUSJoy5XaWpF2HgKaDj
	 ADEy+nFvNw5z+/383EAUHmtTw7vd9wiQGKiPFRKn58GQRNrRHjoBZ7pdR/1k5xLzVw
	 PWQx6itWPsLIpq+5YV5aObjk+swpJwV2/gFMXPZvj/Z2rfrtzauzhZ81KCk1Ed2akS
	 Rp0sw3ONVscDpyhF0Ytv7msRGgO6PgHPx7B6npYszPKblVBuoBFUjFamG5fRNxwTEj
	 VLnl3UM2sfeRw==
Received: from [192.168.50.250] (unknown [171.76.83.143])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1E3E817E12D6;
	Tue, 29 Oct 2024 11:47:43 +0100 (CET)
Message-ID: <7acf985b-044e-41ff-9d5b-621d165b689f@collabora.com>
Date: Tue, 29 Oct 2024 16:17:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND. PATCH 1/5] drm/ci: Upgrade requirements because of
 bothering by GitHub Dependabot
To: Helen Mae Koike Fornazier <helen.koike@collabora.com>,
 WangYuli <wangyuli@uniontech.com>
Cc: "maarten.lankhorst" <maarten.lankhorst@linux.intel.com>,
 mripard <mripard@kernel.org>, tzimmermann <tzimmermann@suse.de>,
 airlied <airlied@gmail.com>, simona <simona@ffwll.ch>,
 "david.heidelberg" <david.heidelberg@collabora.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 guanwentao <guanwentao@uniontech.com>, zhanjun <zhanjun@uniontech.com>
References: <11312D359DDCA3CF+20241017034004.113456-1-wangyuli@uniontech.com>
 <192d7da2f2a.1069aaa001047791.5583301334791429946@collabora.com>
Content-Language: en-US
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <192d7da2f2a.1069aaa001047791.5583301334791429946@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Helen,

On 29/10/24 16:07, Helen Mae Koike Fornazier wrote:
> 
> 
> 
> 
> ---- On Thu, 17 Oct 2024 00:39:48 -0300 WangYuli  wrote ---
> 
>   > GitHub Dependabot keeps bugging us about old, vulnerable Python packages.
>   >
>   > Until we figure out a way to make it calm, we're stuck updating our
>   > dependencies whenever it complains.
>   >
>   > I guess it's a good thing in the long run, though, right?
>   > Makes our CI a bit "more secure"...
>   >
>   > Signed-off-by: WangYuli wangyuli@uniontech.com>
>   > --
>   > 2.45.2
>   >
>   >
> 
> 
> Hi WangYuli,
> 
> Thanks for this.
> 
> tbh, I'm tempted in removing the python script that is in the repo, and keep it out-of-tree somewhere, since it is a tool that is only triggered manually in local environment.
> 
> I also want to hear Vignesh's thoughts about it.

We can remove xfails/update-xfails.py script since we do not use this in 
CI jobs. Once ci-collate [1] is ready and tested for drm-ci, we could 
use this tool directly.

[1] https://gitlab.freedesktop.org/gfx-ci/ci-collate/

Regards,
Vignesh

