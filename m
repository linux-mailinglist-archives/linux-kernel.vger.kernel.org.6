Return-Path: <linux-kernel+bounces-254414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F115F9332F3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5DBA281B53
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274221A00F7;
	Tue, 16 Jul 2024 20:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="xkZMA7hQ"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8860E249F5
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 20:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721161689; cv=none; b=EOA7/AShEID3hSfh80U2F7eT8J+rGBrRswfYAhSNoC8B1eCL838RugmZnosiER+u4Tw+ST8njrrcbqvE7/9hzkJBS9UkY9FOoiiflaiOVlZC4g8EzkDj4pZoEUy3vAOTF8bV1yKnbKlYvsZ60GvgCdcCudzcU3ar8aeteZRf8Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721161689; c=relaxed/simple;
	bh=bpB7fj7Gs4zldMRA8QvuyyQjqXWg+fNHWjVJwiGU4PY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r9+PQq4DrjoxbtiQ9jtJ1XekB7tbIUP4cauRfLDJ7UXcuhsnjiDQFCZYuPDCz5So5SG42VHtZ6bqK21OezdCFeMbLF7SsJJHussvBUAeWZKviPP4rHirtHddruPtvrVL9pLXdEznuxnURkhx49r3TfaQnj8uRQB4gPZrvoOZBJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=xkZMA7hQ; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1721161686;
	bh=bpB7fj7Gs4zldMRA8QvuyyQjqXWg+fNHWjVJwiGU4PY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=xkZMA7hQTlLjiDnHOdUwkbWdEh4l3vaBpYFTyQTTvEo1ui/Pv9SblAxx6sRrQkxEg
	 VV6tyVgW/jbkw5FBNY21F8NH5myzt+XORSjdWtJwBxSrBDeh2Ar6I4UYlef9zzhQhW
	 x1IykKvaY1D5y3ucLimSePaEaI9tl6Advk/zMoGIbflzg/yEvWFxIvPYrZA+h2rlzu
	 eTKab1kBZfEguXF+VLSaiwABx2JPkGjR9z9ULhV/vu+uyOlfhi1Wm3haCJtZ9BAuWn
	 pc4Hqp7lQ2M6z0wApS4YHlhHbca3Ge4SFSA/hgv+jniMmgI7hU73GcDVN51fEjS9bx
	 sA0DhQ7wv1+9g==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WNrHB2dZxz19wf;
	Tue, 16 Jul 2024 16:28:06 -0400 (EDT)
Message-ID: <886acd97-e837-4bff-a8e2-26638525cab5@efficios.com>
Date: Tue, 16 Jul 2024 16:28:06 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] ring-buffer: Updates for 6.11
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Thorsten Blum <thorsten.blum@toblux.com>
References: <20240716155118.152dea35@rorschach.local.home>
 <a71100aa-ffe4-477e-814a-1564e00cb067@efficios.com>
 <20240716161105.0aa6bfe1@rorschach.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20240716161105.0aa6bfe1@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-07-16 16:11, Steven Rostedt wrote:
> On Tue, 16 Jul 2024 16:05:26 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> On 2024-07-16 15:51, Steven Rostedt wrote:
>>>
>>>
>>> Linus,
>>>
>>> tracing/ring-buffer: Have persistent buffer across reboots
>>
>> Hi Steven,
>>
>> Perhaps I'm missing something here, but we discussed previously that
>> you would document the fact that users of this feature are expected
>> to run the same kernel before/after reboot.
>>
>> Looking at this PR, I fail to find that documentation, or in fact
>> any documentation at all. Is this something that was overlooked ?
> 
> Hmm, was that for this code, or the one that used the reserved_mem
> change, which isn't in this pull request, as it depends on the code
> that is going through the mm tree.
> 
> Technically it can work with different kernels (I have even done that).
> But yeah, it isn't guaranteed to work in such cases. But that is just a
> documentation update.

If the documentation just ends up being in a different PR, I have no
objection.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


