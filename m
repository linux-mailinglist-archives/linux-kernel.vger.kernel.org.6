Return-Path: <linux-kernel+bounces-320958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6195971289
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCAB42826AB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBAC1B150A;
	Mon,  9 Sep 2024 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WpUK5T12"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973E5176246
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725871755; cv=none; b=YZdNd88RlChlewGWPYx5JA8dqj8dY/3O8XNr5pPOQIfU+ZwAiG5bmYl3RhmiFx38EaIkS/E7VKSVxq6/YR9YBTVZm+4u2i5IHSKCo/Z3u1dG+o4f6yp2Q68tiCHoEb8X5X11yJlRTkQxf1zDu01mdjet5fU7qh6Zx1A3TQcpmkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725871755; c=relaxed/simple;
	bh=BpFD1nqnfjm7c2hfMLb19BE77uJQhMSAbociWh8TeMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5ykpu9Yb33oCUxyzE/kHakNWzqKdefzh93ChoJXQUpiCkEyzCweHuJaLNkOFpAVWEN0ranml9tggiOpypiXz2LJnP+Fs4T5pMFToqlcwnVWAhUl9DcUGUID3sIWHAU4pCjjxyjM7UiwjjocugOU/VrQTHIRRyz6SzBUTgyJGLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=WpUK5T12; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4X2L9C6HmQz9sW5;
	Mon,  9 Sep 2024 10:49:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1725871743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AngHvSwbCW0+7rfPLzjnSExJBBtNLPD5KPT/tszkCtQ=;
	b=WpUK5T12v7bPD/nIczcpQZBACpbwWOUIQxMnRY8JODRbywjax0pUvcp2QB02GT9eJ/Cxfz
	WU2isLHojzke+6ZK3S/uH20vDxkzSuopvzOVoEg74XEQ24vuj0gcLNEKoevfr3odQY+wVu
	1lXIVaThtfBaf6ufzPzyezUSqIS9VcAauZnVHm5YZ6FzNSaJySXI9Be71LbMte9/kH1GuY
	25nLXxSZS/8p8FjiH0ySEUu0kIaETSohRV7GKaz/lMpzz4r2eOyJ49g7984oWoa12iJ0yC
	SXBHztSHFN+ZIuq9YrsuCZRMGDa6p3vmG89G9ucRWJpJDD1XlRJWTz+7rZpM1g==
Message-ID: <d880c32d-2bc4-4b53-a919-efa8df79109e@mailbox.org>
Date: Mon, 9 Sep 2024 10:49:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: 6.11/regression/bisected - after commit 1b04dcca4fb1, launching
 some RenPy games causes computer hang
To: Leo Li <sunpeng.li@amd.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Harry Wentland <harry.wentland@amd.com>, zaeem.mohamed@amd.com,
 pekka.paalanen@collabora.com, "Wheeler, Daniel" <daniel.wheeler@amd.com>,
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <CABXGCsNgx6gQCqBq-L2P15ydaN_66sM9CgGa9GQYNzQsaa6Dkg@mail.gmail.com>
 <CABXGCsNztS8MLteq5=fcddwuQ1TCzeOM8TdVtpJ3crK=sV5PTQ@mail.gmail.com>
 <CABXGCsMdxHJ-MLkS0pm51Sk8g0PTghsuZxmowvj5t44bVN4ndA@mail.gmail.com>
 <ffd2c40c-1c2e-4465-b26f-88d5e08a80d9@amd.com>
 <CABXGCsOoL5vD0+FRALFQFr3ZBpb2z5mpGKzAD5RHoW9_sb5yaQ@mail.gmail.com>
 <f68020a3-c413-482d-beb2-5432d98a1d3e@amd.com>
 <CABXGCsMSTsBFW=OirDszPFVOiNgyOBSh3qyzAw-Coi-McnicAQ@mail.gmail.com>
 <04d3755d-f295-46d7-b35d-008b888b39ae@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <04d3755d-f295-46d7-b35d-008b888b39ae@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: kcrirfedk8katjemr557ymd44g7p1e1e
X-MBO-RS-ID: 989341b4da68afa42db

On 2024-09-06 21:46, Leo Li wrote:
> 
> Second, can you try adding "amdgpu.dcdebugmask=0x40" to your kernel cmdline at
> boot, and see if you can still repro the hang?
> 
> This setting disables hw planes. If it resolves the hang, then it's quite
> interesting, because it suggests that gnome may be using direct-scanout via hw
> planes. We may need to align our gnome configuration in that case, since I don't
> see any additional hw planes being used on my setup.

GNOME's mutter doesn't make use of overlay planes yet.

(There's a WIP MR though: https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/2660)


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast

