Return-Path: <linux-kernel+bounces-213113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E998906BE7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72B5FB240AA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6333B143872;
	Thu, 13 Jun 2024 11:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="cdN5nyZG"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4031448EB;
	Thu, 13 Jun 2024 11:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279079; cv=none; b=pUmAHrFc93UC4OmgzpIHSkjx7t5kCAvp0uBVtcBcJfSCSIgsJiDZuuvSqurBuH2XbnNMjwd6/AvLXsSQo0viX1HuGxMuElUXLT4b10VrKNY1KvgJcpZrsLmm21oTW5u+YgWNX/c3FxENPuL1picMk3cqAYxvADxbbVqKPMblhmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279079; c=relaxed/simple;
	bh=2n+TNIHW7fyXz94EhLnmhhZsaSuYkTN3hTj+I+VmNYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jFMtIAwoVnQKrPEhzOXpAlL8X3TSTOL1/yHNSJ+GP73ntRGNF/KWuX9zPtXgAPkN9N+pGbyUrquXCPKf/efcA32AyYwx6gJEwODAQIXW+fPNMwjtq38tLyjVQVdTh98m3/sVu6nA6XKkkaMNM/TG0eaDoxcLWpQ/fdaJCV/WFbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=cdN5nyZG; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=yFzarZ08c6f35rJCPnIaJIVfFjDEHxsEXnJtD6p8xVQ=;
	t=1718279077; x=1718711077; b=cdN5nyZG392kRcHgUNiDXM7s6JQ1k1g5ubbz/p9NhbSMq8K
	8hAgXRQl1KGB7s5Ei+bzawwVZauM+QfxvQmc8Hqtcoik+LYNo8AYo94vRn3+1PE7RSoHt+FJ8fnr2
	n36QaH1HiPnKhsZouauSv5nR97ZZbRuPqg1lwowQCt1DBxePsY6NTrpn0d8bfKomHBMx2sQLdi/Rl
	FyBaSDwp/m2QkJBHFGL6cBea8TCoJKaoKnKCnresz9pjI8OC0KEXi7zuE8GkllCnFSUYV++4K8t2/
	qn9fVgrohvPxC1FF2ifq968vfeQmoGUsjuhOkNHt1LolPuN5U4BgdXvSe17YLoWg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sHisa-0002dB-Er; Thu, 13 Jun 2024 13:44:32 +0200
Message-ID: <48832f23-7593-4bc5-875b-83462a603949@leemhuis.info>
Date: Thu, 13 Jun 2024 13:44:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] 6.10-rc1: Fail to resurrect from suspend.
To: Pavel Machek <pavel@ucw.cz>, David Wang <00107082@163.com>,
 regressions@lists.linux.dev
Cc: sivanich@hpe.com, kevin.tian@intel.com, baolu.lu@linux.intel.co,
 jroedel@suse.de, linux-kernel@vger.kernel.org
References: <20240530114907.4836-1-00107082@163.com>
 <ZmrSVax+fzXNKyiq@duo.ucw.cz>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZmrSVax+fzXNKyiq@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1718279077;3b71a3fd;
X-HE-SMSGID: 1sHisa-0002dB-Er

On 13.06.24 13:04, Pavel Machek wrote:
>> My system fails to resurrect after `systemctl suspend` with 6.10-rc1,
>> when pressing power button, the machine "sounds" starting(fans roaring),
>> but my keyboard/mouse/monitor is not powered, and I have nothing to
>> do but powering cycle the system.
>>
>> I run a bisect session, and narrows it down to following commit:
>>
>> 	commit d74169ceb0d2e32438946a2f1f9fc8c803304bd6
>> 	Author: Dimitri Sivanich <sivanich@hpe.com>
>> 	Date:   Wed Apr 24 15:16:29 2024 +0800
>>
>> 	    iommu/vt-d: Allocate DMAR fault interrupts locally
>> 	    
> [...]
>> And I have confirmed that reverting this commit can fix my problem.
> 
> Bisected regression. Should we simply revert the patch?

No need to afaics, as this afaics is fixed by "iommu/amd: Fix panic
accessing amd_iommu_enable_faulting" which Joerg committed earlier today.

https://lore.kernel.org/all/ZljHE%2FR4KLzGU6vx@hpe.com/
https://lore.kernel.org/all/31f16e4e.afe2.18fc9d5dad0.Coremail.00107082@163.com/

Ciao, Thorsten

