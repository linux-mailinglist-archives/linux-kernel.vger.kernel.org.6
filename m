Return-Path: <linux-kernel+bounces-430981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B44749E37C4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7937328291C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AE31AB507;
	Wed,  4 Dec 2024 10:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sysprog.at header.i=@sysprog.at header.b="Jk+7itxD"
Received: from esgaroth.petrovitsch.at (esgaroth.petrovitsch.at [78.47.184.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6981547CA
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.184.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308995; cv=none; b=sOpA24e1GhfB2pW08zi14lYWWpKUL1MH16F7U4Yx1123nj35gxKczPs53JGqfzAq5V4MF1ahjMuto84RzSEkrgi3T+IriXZXgqiV8a96NZrzR/61vFcX8uvTqleB+vTenE4Dqugh/AqMfDLgWJXmxFq+cQ9Z3deBZydN/d7ZCLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308995; c=relaxed/simple;
	bh=tLSiOvgxjxLzeqkqOEJ/76JCKQ4EXnqsXuDoj/zWvS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=rq3mRmnh81juWmzDKXOba5K9yxr645mwgEaA7s47PxweND+2vCQiFVdAWynb4vRdd5TqLY6ctzTgf11OXG+n7VYGiIkDSeTLm0VY7EAfVOBBV5DfvnL2XkQsobrx/0WHSES/eMCP8AfekINTQNvjnH92unQyLpxabQIJ42xv5q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sysprog.at; spf=pass smtp.mailfrom=sysprog.at; dkim=pass (1024-bit key) header.d=sysprog.at header.i=@sysprog.at header.b=Jk+7itxD; arc=none smtp.client-ip=78.47.184.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sysprog.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sysprog.at
Received: from [172.16.0.14] (84-115-223-47.cable.dynamic.surfer.at [84.115.223.47])
	(authenticated bits=0)
	by esgaroth.petrovitsch.at (8.18.1/8.18.1) with ESMTPSA id 4B4AhIxa2490979
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
	Wed, 4 Dec 2024 11:43:20 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 esgaroth.petrovitsch.at 4B4AhIxa2490979
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sysprog.at;
	s=default; t=1733309000;
	bh=VvneIJPZERiXJlWKIMDPUSoKcpKksGxjbbhMPfZoSoA=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=Jk+7itxDIStCXXNcPslKZUUD+HfJ4iF/mgaec+yNwCPPHW/1Za739bKGSHm9N8qp6
	 NDTHBCcgfVPQh9CkZkmS9DTkXEyR5DHPiGl2QXxIdG2/2acZNnSsnRHVYMWjePSxQ/
	 YbpvjqYLTT7pR+KJJ8cx/Z/amVk4Umj3Qkdz/0sk=
Message-ID: <3d7a96f4-b50d-41bc-8221-54be9ea1350e@sysprog.at>
Date: Wed, 4 Dec 2024 11:43:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: Wislist for Linux from the mold linker's POV
To: Rui Ueyama <rui314@gmail.com>
References: <CACKH++baPUaoQQhL0+qcc_DzX7kGcmAOizgfaCQ8gG=oBKDDYw@mail.gmail.com>
From: Bernd Petrovitsch <bernd@sysprog.at>
Content-Language: en-US
Cc: LKML <linux-kernel@vger.kernel.org>
BIMI-Selector: v=BIMI1; s=default
In-Reply-To: <CACKH++baPUaoQQhL0+qcc_DzX7kGcmAOizgfaCQ8gG=oBKDDYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DCC--Metrics: esgaroth.petrovitsch.priv.at 1102; Body=2 Fuz1=2 Fuz2=2
X-Virus-Scanned: clamav-milter 1.0.7 at smtp.tuxoid.at
X-Virus-Status: Clean
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from author's
	*       domain
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*      valid
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
	* -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
	*      [score: 0.0000]

Hi all!

On 28.11.24 03:52, Rui Ueyama wrote:
[...]
> After all, we just want a system-wide semaphore that is guaranteed to
> be released on process exit. But it seems like such a thing doesn't
> exist.

I use a socket for that purpose as they are closed with the end of
the process.

(SysV-)Semaphores cannot do that as they are separate entities with a
life independent of processes.

Kind regards,
	Bernd
-- 
mobile: +43 664 4416156               http://www.sysprog.at/
Embedded Linux Software Development, Consulting and Services

