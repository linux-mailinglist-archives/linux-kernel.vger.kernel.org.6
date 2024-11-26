Return-Path: <linux-kernel+bounces-421765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D5A9D8FB2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 02:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373891692E7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 01:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E751BBA33;
	Tue, 26 Nov 2024 01:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maowtm.org header.i=m@maowtm.org header.b="aSazYhMC"
Received: from sender2-of-o57.zoho.eu (sender2-of-o57.zoho.eu [136.143.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735C9B661
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 01:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.171.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732583410; cv=pass; b=FXRwdqzxw6WiiKsxKueUy6BApd98374y573I2mFWjJBxX3b13Z5YlOr6wx9aGmYNUWTcj5tGFXW5lbcgI564VX5aIn9ZWoQif3DG8uGonbkwqFkP8mlVsD8tlC+AUz96iFqSYLUos/87HaBiHo2WuaS9QntBiDQW/+9vhvMZnGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732583410; c=relaxed/simple;
	bh=rjWN5BokA2uAW+jzsW2J8EojPRKUcC0W7JvK4HY/qSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rHl7bw1x2cViu5nfy8M45CCNPom1tuPq7e4gEZW/2F9d+AFk6lQVfBVQ8ZGMmfgBzf9Opxg2WxGKEjcs5W/i/XZWbEN1mlAjQxIg8Y3obdOqX5sNSSkGhONna/5V6/D+DjY61ghTWd1KuXm2tBhVTMsqrUL+vatjv9vzXHcsDSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (1024-bit key) header.d=maowtm.org header.i=m@maowtm.org header.b=aSazYhMC; arc=pass smtp.client-ip=136.143.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
ARC-Seal: i=1; a=rsa-sha256; t=1732583359; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ZtIaacVC7lViS/nw9R/vZi9zhbywthXV0BWGZZzhYxdFLXsXuYSkmD5VxSLzvv3YSRdg3roFbMolBOE0Gmc1IB1x+H+ud8hbYS1uQW4qO+SehXxjjuthGHdhFcD7Nzs6hwPZPPOH1tN+MkaKfKlSOcA/NGGYhelCyUTrOLDyJxY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1732583359; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=e17lOy5bhdVeetCvTuAEK1H1DtIsWOnHW9HQZzrg8NE=; 
	b=alF4tK3lEq4c5I+0JOGwHqIq/2gUkjhadsc30qn+H0wBUl0DbzZuS3bpzN3RwTBN0HgjXRZ5cnMFz8QaDh54CNfrHGeyX6hYGwPG7QtJ3NumzXWseDXuTRLvD0oobEKtht5xOILJBFcXaVcNxUHAhvJ/4csWU9eHp2p83l9/3qc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=maowtm.org;
	spf=pass  smtp.mailfrom=m@maowtm.org;
	dmarc=pass header.from=<m@maowtm.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732583359;
	s=zoho; d=maowtm.org; i=m@maowtm.org;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=e17lOy5bhdVeetCvTuAEK1H1DtIsWOnHW9HQZzrg8NE=;
	b=aSazYhMCFOUr4hW74ureT27Jr9TcGs0GPdnLF+Aom5Ow/4G4JS8WXqexba9vIR2g
	Twesd6nJvNHar9Y2dj5SMF1gCFoDexgbp4Nuzeg41SDsO0bFJGFKKX1c9bRtH4CnEgO
	SGbxyDbNRxoU0HU8ElvXKZe4ODX2/8tdRpEHb4sI=
Received: by mx.zoho.eu with SMTPS id 1732583356211178.28251634433764;
	Tue, 26 Nov 2024 02:09:16 +0100 (CET)
Message-ID: <4d5abd25-57c1-4233-a34a-3167a114dcc8@maowtm.org>
Date: Tue, 26 Nov 2024 01:09:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: Fix off-by-one error in __access_ok
To: Mikel Rychliski <mikel@mikelr.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
References: <20241109210313.440495-1-mikel@mikelr.com>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20241109210313.440495-1-mikel@mikelr.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi,

I hit an issue with using gdb (and eventually more) on a system with 9p 
as rootfs which I eventually root-caused to this, so I'm just posting 
here for reference / another testing datapoint, since I couldn't find 
any other mentions of this error elsewhere and this is in the latest 
stable kernel (6.12 / 6.12.1). Apologies in advance that I might not be 
offering much else useful, but I can confirm that applying this patch 
fixes it.

I'm running a development VM where the rootfs is a 9p mount, and from 
6.12 I get this if I try to debug anything with gdb:

[    6.258525][   T88] netfs: Couldn't get user pages (rc=-14)
[    6.259414][   T88] netfs: Zero-sized read [R=1ff3]
/bin/sh: error while loading shared libraries: 
/lib/x86_64-linux-gnu/libc.so.6: cannot read file data: Input/output error
During startup program exited with code 127.

After some further testing I realized that basically *everything* was 
broken (e.g. /bin/sh) if I disable ASLR (via 
/proc/sys/kernel/randomize_va_space), with the same messages printed. 
The user-space is a Debian distribution.

Basically I think the user-space initialisation tries to call read with 
(for example) buf=0x7fffffffdfc8 and count=832, so it spans the last two 
valid user-space pages, and the access_ok in gup_fast_fallback 
eventually fails (because somewhere above it rounds to whole pages).

I think this doesn't happen with a "normal" ext4 root (otherwise I would 
be surprised if nobody else has reported it yet) - it might just have 
been surfaced by recent v9fs changes.

