Return-Path: <linux-kernel+bounces-254384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9DF9332A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD5C1F2368C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5706A19DF8C;
	Tue, 16 Jul 2024 20:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Qjt+wD3g"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5009F41C7F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 20:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721160342; cv=none; b=e/Yzvy1/bwitd66uT7G47SgsHjyheCf5NxsO3FIPKgYvDU9pDT59uBEHTsGnfylBItlx5pSIBxLwTVrcOYjiJNUY+hdZ7UkWy/jvflHpSf7tcpStJpRLusq3RxlErZLITRCZgcVrNwyq6gTyHC8vjdMMTqIg97F+K5K57bx5bCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721160342; c=relaxed/simple;
	bh=6c/U6i9C9qUTRmjPlMdW5T8LBDogRxmEOQNNMUbLuQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKkNKf5S572DEXkMgkFORPD5uCOmt6tZj8FQJ/7o2+rMp2JEhJH+DTppyg96TE7AisuCR+wUShPimiQczohsi/48hCkh6Wu6OIAueN/8dQ+Vs3X1rzdPwM/Z5NX84SK+AKCenQXFgo80Vp2o99UUQiSgKwyOZumrQ5R+tA2/1CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Qjt+wD3g; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1721160332;
	bh=6c/U6i9C9qUTRmjPlMdW5T8LBDogRxmEOQNNMUbLuQE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Qjt+wD3gW7GBDzgrZCjslJXNsa+FjWwCRWGZs2dpVVwnYmrRZQX1LqtzKsYV1h0OS
	 bgDYNvysiHH3TVv2bmdfU/1yWTrN0IM6RYY1/F5s6vfS51vOizjyywl9xJIkXiajsA
	 EM7MYiDlaBjITgVltaVGZJeVzqAyUVNH8iBE4CRaMW9OPXiVHjN6ZnwO0slII4ffhK
	 IB+jDlqcY/sgJKbto9g/rTzrQ/LBp+d6Hc+qduXNSrVV5WofqK40CV6eVKf9xlH6n/
	 w+I8MAgM1c0F+svo2mWbBdXgaEWv6cz14rdLikpl71N3kpr8yPxd/hvQgBxdDEXl8/
	 9mtEAeTB+cLWA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WNqn83hByz1CSc;
	Tue, 16 Jul 2024 16:05:32 -0400 (EDT)
Message-ID: <a71100aa-ffe4-477e-814a-1564e00cb067@efficios.com>
Date: Tue, 16 Jul 2024 16:05:26 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] ring-buffer: Updates for 6.11
To: Steven Rostedt <rostedt@goodmis.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Thorsten Blum <thorsten.blum@toblux.com>
References: <20240716155118.152dea35@rorschach.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20240716155118.152dea35@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-07-16 15:51, Steven Rostedt wrote:
> 
> 
> Linus,
> 
> tracing/ring-buffer: Have persistent buffer across reboots

Hi Steven,

Perhaps I'm missing something here, but we discussed previously that
you would document the fact that users of this feature are expected
to run the same kernel before/after reboot.

Looking at this PR, I fail to find that documentation, or in fact
any documentation at all. Is this something that was overlooked ?

Thanks,

Mathieu

> 
> This allows for the tracing instance ring buffer to stay persistent across
> reboots. The way this is done is by adding to the kernel command line:
> 
>    trace_instance=boot_map@0x285400000:12M
> 
> This will reserve 12 megabytes at the address 0x285400000, and then map
> the tracing instance "boot_map" ring buffer to that memory. This will
> appear as a normal instance in the tracefs system:
> 
>    /sys/kernel/tracing/instances/boot_map
> 
> A user could enable tracing in that instance, and on reboot or kernel
> crash, if the memory is not wiped by the firmware, it will recreate the
> trace in that instance. For example, if one was debugging a shutdown of a
> kernel reboot:
> 
>   # cd /sys/kernel/tracing
>   # echo function > instances/boot_map/current_tracer
>   # reboot
> [..]
>   # cd /sys/kernel/tracing
>   # tail instances/boot_map/trace
>         swapper/0-1       [000] d..1.   164.549800: restore_boot_irq_mode <-native_machine_shutdown
>         swapper/0-1       [000] d..1.   164.549801: native_restore_boot_irq_mode <-native_machine_shutdown
>         swapper/0-1       [000] d..1.   164.549802: disconnect_bsp_APIC <-native_machine_shutdown
>         swapper/0-1       [000] d..1.   164.549811: hpet_disable <-native_machine_shutdown
>         swapper/0-1       [000] d..1.   164.549812: iommu_shutdown_noop <-native_machine_restart
>         swapper/0-1       [000] d..1.   164.549813: native_machine_emergency_restart <-__do_sys_reboot
>         swapper/0-1       [000] d..1.   164.549813: tboot_shutdown <-native_machine_emergency_restart
>         swapper/0-1       [000] d..1.   164.549820: acpi_reboot <-native_machine_emergency_restart
>         swapper/0-1       [000] d..1.   164.549821: acpi_reset <-acpi_reboot
>         swapper/0-1       [000] d..1.   164.549822: acpi_os_write_port <-acpi_reboot
> 
> On reboot, the buffer is examined to make sure it is valid. The validation
> check even steps through every event to make sure the meta data of the
> event is correct. If any test fails, it will simply reset the buffer, and
> the buffer will be empty on boot.
> 
> 
> Please pull the latest ring-buffer-v6.11 tree, which can be found at:
> 
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
> ring-buffer-v6.11
> 
> Tag SHA1: d3d32acdae295a7eb0600aa878ff33f4fe52460d
> Head SHA1: b96c312551b241bc17226c5347c6d6b38a1efd3e
> 
> 
> Dan Carpenter (1):
>        tracing: Fix NULL vs IS_ERR() check in enable_instances()
> 
> Steven Rostedt (Google) (13):
>        ring-buffer: Allow mapped field to be set without mapping
>        ring-buffer: Add ring_buffer_alloc_range()
>        ring-buffer: Add ring_buffer_meta data
>        tracing: Implement creating an instance based on a given memory region
>        ring-buffer: Add output of ring buffer meta page
>        ring-buffer: Add test if range of boot buffer is valid
>        ring-buffer: Validate boot range memory events
>        tracing: Add option to use memmapped memory for trace boot instance
>        ring-buffer: Save text and data locations in mapped meta data
>        tracing/ring-buffer: Add last_boot_info file to boot instance
>        tracing: Handle old buffer mappings for event strings and functions
>        tracing: Update function tracing output for previous boot buffer
>        tracing: Add last boot delta offset for stack traces
> 
> Thorsten Blum (1):
>        ring-buffer: Use vma_pages() helper function
> 
> ----
>   Documentation/admin-guide/kernel-parameters.txt |   9 +
>   include/linux/ring_buffer.h                     |  20 +
>   kernel/trace/ring_buffer.c                      | 886 +++++++++++++++++++++---
>   kernel/trace/trace.c                            | 244 ++++++-
>   kernel/trace/trace.h                            |  10 +-
>   kernel/trace/trace_output.c                     |  12 +-
>   6 files changed, 1061 insertions(+), 120 deletions(-)
> ---------------------------

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


