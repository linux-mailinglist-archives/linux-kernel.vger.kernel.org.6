Return-Path: <linux-kernel+bounces-384503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE089B2B00
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B196E2826E7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1435192D64;
	Mon, 28 Oct 2024 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="LiYG53oc"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FAB18FDA9;
	Mon, 28 Oct 2024 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730106535; cv=none; b=Ex5OQ2Tsz8XaIqugTz47ddp1tq7086Agenyz70iPD06zHT+mx7cxGZxoGfkJWrwtOl5cbKppomxtenEL6NmBNK73wTsNxWheSqUUv7TFvRlG87Mdqr6viftyBUqAkFNuv9kTjw0wYJ+CXFQPwUcos/di6Js1k/RYBVkuMdm+LhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730106535; c=relaxed/simple;
	bh=znNWDArYITD+C8GRoj1XxmSJ1sNsnBzofgxiyCp5wEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BoDR5MWyb/YKRu14ZTctrx2NaflcQ2PMbXsV72nCHlxCuRZDEq19c0mGShAJdbsdplifP3JMMmUnPVffaOXIxmdsV86BBHmd78gjJyuaK2x+UG5cvKbl5BNXXh4tCCFi+iMcuh9Bg3ZJtci1q3mnE9uUmkq6d/MTr/zpOMMxQaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=LiYG53oc; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=0fWLIibkXAooGEh+4Ue/KQyTQtfHAznEPn6tSd4Cdgc=; t=1730106533;
	x=1730538533; b=LiYG53ocXmo8vHruoBxvjWMqwO8IwBzu7cUbY55xHD+stahQQFvTMDdTXG+jv
	ZeRxahLwxwwsgsABJv4t8bIOyX53en0nYDq23vZYLpbJbaSlnqV0cQjCGubp/+f0DSwnfoL61wdR6
	EokT0xBIabHQmXfXW3/7ka4DLjtlDYsfy+2CCj2RfXNZ391qAZtRgaPsLiMtj326wZdiGky+PouFx
	UPPxMEGXinm12IhJBOh2nFTlnGQPnyajKfr/YNI+R/+zSpDEjimqQ96+XouM9x9r4suJlzMADrW3M
	CY5nzgrAhLOxWDG1RzCwvePhnxnk0VRzhROKmq2DGtjzIVTPug==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1t5Lk2-0002DU-D9; Mon, 28 Oct 2024 10:08:50 +0100
Message-ID: <42dfef93-eb8a-458b-b76b-b7de9077d0af@leemhuis.info>
Date: Mon, 28 Oct 2024 10:08:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] driver core: Fix userspace expectations of
 uevent_show() as a probe barrier
To: Dan Williams <dan.j.williams@intel.com>, gregkh@linuxfoundation.org
Cc: rafael.j.wysocki@intel.com, tj@kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
References: <172790598832.1168608.4519484276671503678.stgit@dwillia2-xfh.jf.intel.com>
 <67047c516045d_964fe294b1@dwillia2-xfh.jf.intel.com.notmuch>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <67047c516045d_964fe294b1@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1730106533;2ac0ac42;
X-HE-SMSGID: 1t5Lk2-0002DU-D9

On 08.10.24 02:26, Dan Williams wrote:
> Dan Williams wrote:
>> Changes since v1 [1]:
>> - Move the new "locked" infrastructure to private header files to make
>>   it clear it is not approved for general usage (Greg)
> 
> Greg, per the 0day report and further testing I am missing something
> subtle in using kernfs open files to pin device objects. So hold off on
> this for now until I can get that root caused. If someone else can spot
> what I missed feel free to chime in, but otherwise I will circle back.
> 
> If I don't get back to this before -rc6 I think the theoretical deadlock
> that would be re-introduced by a revert of 15fffc6a5624 would be
> preferable to this reported regression. I am not aware of any reports of
> that deadlock triggering in practice.
Was there any progress? If not: given that Linus prefers to have things
fixed by -rc6 I wonder if now would be a good time to get the revert on
track for a merge later this week.

Ciao, Thorsten

#regzbot poke

