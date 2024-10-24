Return-Path: <linux-kernel+bounces-379394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD039ADE15
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFFB82828FE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 07:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39B318B488;
	Thu, 24 Oct 2024 07:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="XW+zhzq5"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2BF15573D;
	Thu, 24 Oct 2024 07:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729755914; cv=none; b=rIN107A7T81L2QRac4RScfXCqKuStDxPqeUL8dAC6FHnjIYnzVFgoUiPG6nRHpm29NAz05RuQC/AEPodRd2fJcuEmJK4KO5xygbXU2HBbqWTUFK0aW69KRKw2gfx8iXWIMxhpGT+aVLR5lmfJp7DJ8V0ixICOyQ4xDlXOCQ9YVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729755914; c=relaxed/simple;
	bh=QqjRQ9Z7EFjHhrZxhpnQHdFmOfdAcs3Qn3WVkNTGs7g=;
	h=Message-ID:Date:MIME-Version:From:Subject:Cc:To:Content-Type; b=HmvE05nNoQYPCN8zJ2t9Zaj4C2By86LUm4zwm9PVtamREbl4prgl6xsnL9qPuE4lOlr3xxpPyI/U7DdES8qP9WHl49Va+2gc0hWRLkioIDq/4Dy27ACbbEILx63Am/eUyBSiTIuY2KhiQfjNEpWGYEhRJF2AqsML4+W9QFh0qh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=XW+zhzq5; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:To:Cc:
	Subject:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=x7zQv6WLWCBckv+xucBTETL7MnDWTDn514ggvPhcUaw=; t=1729755911; x=1730187911;
	 b=XW+zhzq5DkmeCt+mO1c+f1F0ZrsC+VUdDjZ0+dsr6sDAx3LnZQmiuMLd8Z5oFHbVHbIuiy+vWJ
	fgkeeZlcFFyJsYbFkeeeixOdVg3gwRVhT0RxcnnEV3XGXFvcInCFSqkgiNteVMmqnfcx4hUFW48FU
	EQFYRnH7Sf3wCtsnjHmLs2bGVzRRd0+9jIadD1VnDP9Sfrh0gtXnBy583mI25x5TaKxUMzZdaoZ8p
	fB40uvf1Ijtq0VL7YA3u6cL94QZYS8uaNoM87wCf36t6mrEzxUxJJ5ItLggL989B2ABVm8VV73cBc
	DTRTOluKq4ymwmRzRKUatk2ax4a/QRFcCNYWg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1t3sWq-00086o-F3; Thu, 24 Oct 2024 09:45:08 +0200
Message-ID: <2050f0d4-57b0-481d-bab8-05e8d48fed0c@leemhuis.info>
Date: Thu, 24 Oct 2024 09:45:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: darktable performance regression on AMD systems caused by "mm: align
 larger anonymous mappings on THP boundaries"
Content-Language: en-US, de-DE
Cc: Matthias <matthias@bodenbinder.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
 Yang Shi <yang@os.amperecomputing.com>
To: Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1729755911;b8aa0f46;
X-HE-SMSGID: 1t3sWq-00086o-F3

Hi, Thorsten here, the Linux kernel's regression tracker.

Rik, I noticed a report about a regression in bugzilla.kernel.org that
appears to be caused by the following change of yours:

efa7df3e3bb5da ("mm: align larger anonymous mappings on THP boundaries")
[v6.7]

It might be one of those "some things got faster, a few things became
slower" situations. Not sure. Felt odd that the reporter was able to
reproduce it on two AMD systems, but not on a Intel system. Maybe there
is a bug somewhere else that was exposed by this.

So in the end it felt worth forwarding by mail to me. Not tracking this
yet, first waiting for feedback.

To quote from https://bugzilla.kernel.org/show_bug.cgi?id=219366 :

> Matthias 2024-10-09 05:37:51 UTC
> 
> I am using a darktable benchmark and I am finding that RAW-to-JPG
> conversion is about 15-25 % slower with kernels 6.7-6.10. The last
> fast kernel series is 6.6. I also tested kernel series 6.5 and it is
> as fast as 6.6
> 
> I know this sounds weird. What has darktable to do with the kernel?
> But the numbers are true. And the darktable devs tell me that this
> is a kernel regression. The darktable github issue is: https://
> github.com/darktable-org/darktable/issues/17397  You can find more
> details there.
> 
> What do I do to measure the performance?
> 
> I am executing darktable on the command line. opencl is disabled so
> that all activities are only on the CPU:
> 
> darktable-cli bench.SRW /tmp/test.jpg --core --disable-opencl -d
> perf -d opencl --configdir /tmp
> 
> ( bench.SRW and the sidecar file can be found here: https://
> drive.google.com/drive/folders/1cfV2b893JuobVwGiZXcaNv5-yszH6j-N )
> 
> This will show some debug output. The line to look for is
> 
> 4,2765 [dev_process_export] pixel pipeline processing took 3,811
> secs (81,883 CPU)
> 
> This gives an exact number how much time darktable needed to convert
> the image. The time darktable needs has a clear dependency on the
> kernel version. It is fast with kernel 6.6. and older and slow with
> kernel 6.7 and newer. Something must have happened from 6.6 to 6.7
> which slows down darktable.
> 
> The darktable debug output shows that basically only one module is
> responsible for the slow down: 'atrous'
> 
> with kernel 6.6.47:
> 
> 4,0548 [dev_pixelpipe] took 0,635 secs (14,597 CPU) [export]
> processed 'atrous' on CPU, blended on CPU ... 4,2765
> [dev_process_export] pixel pipeline processing took 3,811 secs
> (81,883 CPU)
> 
> with kernel 6.10.6:
> 
> 4,9645 [dev_pixelpipe] took 1,489 secs (33,736 CPU) [export]
> processed 'atrous' on CPU, blended on CPU ... 5,2151
> [dev_process_export] pixel pipeline processing took 4,773 secs
> (102,452 CPU)
> 
> 
> This is also being discussed here: https://discuss.pixls.us/t/
> darktable-performance-regression-with-kernel-6-7-and-newer/45945/1 
> And other users confirm the performance degradation.

[...]

> This seems to affect AMD only. I reproduced this performance
> degradation on two different Ryzen Desktop PCs (Ryzen 5 and Ryzen
> 9). But I can not reproduce it on my Intel PC (Lenovo X1 Carbon,
> core i5).

[...]

> By the way, there is also a thread in the darktable forum on this topic:
> https://discuss.pixls.us/t/darktable-performance-regression-with-kernel-6-7-and-newer/45945
>  
> Some users reproduced it there as well.

See the ticket for more details. The reporter is CCed. openZFS is in
use, but the problem was reproduced on vanilla kernels.

Ciao, Thorsten

