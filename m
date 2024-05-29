Return-Path: <linux-kernel+bounces-194223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B51FF8D389C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD511F24814
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71641CD00;
	Wed, 29 May 2024 14:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="ekgZviop"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F721BF3B;
	Wed, 29 May 2024 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991472; cv=none; b=OvMaH24aVqLkSX1Ly4iYGG9aXl0TATr07VRrO4kwB+79nxy8czsiPaKVzQELatN+Y8mhPZsdCIOxwiZCxfRIrx9+DFNs1njpatsVKRfemXuevUHoIxV66piyVQ0fms7r+Tl5HxCZBsSo5JcsRqJHoqQziY7n8YMkS5zYQ3Blt50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991472; c=relaxed/simple;
	bh=DdMCRc5EsV5UiaFx4HmAOXxcZCqa946sIQrcpkQtXpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mD9q1wBRHICTdHrm6jkLomCgEG1yA4EsT4wDYA+Vjq0s98T+54uq/9fgMlnxRPcVUt4Te5hG9SjEEI536yfsGmsElbRNQQN5M8W5N6PeKFqmQ6x9LQdUjl2AyCxl0vrD+OHbea6hu78eho+E/w1YFNYAeJ82q8axO4BYfa4wiS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=ekgZviop; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=jnTyBxsS5RtHgV77jQhikXeIzn8AQh5mj+B33JmR4+s=;
	t=1716991470; x=1717423470; b=ekgZviopk162nGrOsq+OK3xgTVve/fMXcIsXl96SUlhHWKz
	qIjkNmQvOHIa9EuXD+cHvwdxUV4kC8iQQ8mCDSJqeoAdWXWP1XN1mr/cY8pO+P72+Q/eweHQn3rIl
	O51itnlPqcLm2RBtFC/Lo+AnHel8kkAVFn3Fql2iv6sIjUFHtDOeIoRNyPcPPHPyWtX1W2OPqWXS3
	HUT6FHJMPYrTAGVZHfoNhRZnBxdZSiIX6bRzphyQ8dhlQY/+ATbYH1GYtaDeivis/dr+np3fftU92
	UfavS9fhNXZuFSFMUWx3ETkB/Fom6h92MJxUQOjzhWWOXPrgmZZsXfDZaZWty0Yw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sCJuk-0005C2-5J; Wed, 29 May 2024 16:04:26 +0200
Message-ID: <937e6c6b-7d98-4c9f-b3f7-47e1d6562963@leemhuis.info>
Date: Wed, 29 May 2024 16:04:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Intermittent inability to type in graphical Plymouth on UEFI VMs
 since kernel 6.9
To: Genes Lists <lists@sapience.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Adam Williamson <awilliam@redhat.com>, linux-kernel@vger.kernel.org
Cc: jforbes@redhat.com, rstrode@redhat.com
References: <75c17881-68e9-40e7-821c-5655d49d7c0f@redhat.com>
 <8fee69cc8fdd67fd265790c0fa287cb9566c2349.camel@sapience.com>
 <165f7cfd-41bc-4c37-b859-a418a3ccece7@leemhuis.info>
 <c5b3d3ec7701b51dd7b163261c84fb54c778b9bb.camel@sapience.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <c5b3d3ec7701b51dd7b163261c84fb54c778b9bb.camel@sapience.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1716991470;0fe3b531;
X-HE-SMSGID: 1sCJuk-0005C2-5J

On 29.05.24 15:35, Genes Lists wrote:
> On Wed, 2024-05-29 at 15:01 +0200, Linux regression tracking (Thorsten
> Leemhuis) wrote:
>>>
>>>     cpu i9-12900K  / Raptor Lake-P [Iris Xe Graphics]
>   Sorry, this should be:  13th Gen Intel(R) Core(TM) i7-1360P
>>>
>>
>> Does this happen every boot or only sometimes? Could you maybe upload
>> the full dmesg from a boot where things worked and one where only the
> For me it is every boot

Ahh, good to know. Would you be able to bisect the problem? That would
help tremendously!

https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html

> - the first few key strokes are accepted but no
> asterisks are displayed - and it works fine even though fewer asterisks
> are displayed than characters typed.

Strange.

> full dmesg attached.

Do you by chance also have a dmesg at hand for a boot where everything
worked normally?

Adam, do you maybe have dmesg output for the affected cases somewhere?

>> P.S.: let me add this to the regression tracking
>>
>> #regzbot report: /
>> #regzbot introduced: v6.8..v6.9
>> #regzbot summary: Intermittent inability to type in graphical
>> Plymouth
>> on UEFI VMs since kernel 6.9
> 
> Thank you.

np; but without a bisecting or at least locating the subsystem that is
causing this we might not get any further. :-/

Ciao, Thorsten

