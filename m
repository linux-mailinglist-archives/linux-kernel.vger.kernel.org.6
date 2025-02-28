Return-Path: <linux-kernel+bounces-537860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5470EA491DC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B697189395F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66E81C5496;
	Fri, 28 Feb 2025 07:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="TkOEstEI"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D142A748F;
	Fri, 28 Feb 2025 07:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740726320; cv=none; b=uW1EugQ2DdeN3g7aaJWMIJeefFSHLGOf3Z7DRHj/t0Abz9WosLq94C1/QgahdoHtSLpWyS0O4tM49L0LZZyRHSBh3j1Gvn4EN4vLp3QKCiF9G7M+1xlmG2QwYaDLxdYp4hI3uNLNHgsY4dTKIo2v6ww+8lo8EDvNOByxQzZsQVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740726320; c=relaxed/simple;
	bh=bGa95YOPkKi8fj8E1CkS0c3ZJVvnqOpy6nKf8kuoB/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eLXt4ci8W7wggSsqk2pMlt2RC3RBB2rIRXMxxqMLg1Xr+o7XrMowI85G1SWhHSerdOlWOLGw7nkISgRofd/PGgbkAAd8Svc/Koc1c8TiwfW69Ryh6CRQqUPUchpzr6Hf3umyAUEl46IXnar6CUFzFKWafHGPU1+EhIRLAwu4/7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=TkOEstEI; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1740726314; x=1741331114; i=deller@gmx.de;
	bh=ENfaXkamSI2ybRPJwBq1VOHuIvly4CjY5OwL1Vv9PQc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TkOEstEIDgPC8vDcW9c5ac9ZmyRsKAvbVyLerHY9YETYsciltV9D/P4AGIW71wBj
	 iRfPw1dAtvynQqCfFUBcbWrPez7c49RFZC1jorXPCzfXZFdEzqve+jXZtCin8Sa82
	 +TeeFqkYlKUAK/7tL4fZAUux9WJ0NbQG5R2g2ebMp1ruVEnoZgl/k4yFpY/ApIhZK
	 njJV4tvKFUj91ZhNnG1uiCT2W3Kh7Q/CNsZlsFcJN5cc4LPr7gSeJYiNM8FFx+NRV
	 HLESHVgIXHPga1N4178TcpvdYiaou3Ar6SDzwExX3NcUaLG8nipFA4rUzd6dfQbfA
	 cI/C6sxsPJfwWg1LAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.173] ([109.250.63.121]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9Wuk-1ttQkQ398O-00CHf6; Fri, 28
 Feb 2025 08:05:14 +0100
Message-ID: <5fca72b9-fd7f-4e37-ae5f-1afcb0362c6d@gmx.de>
Date: Fri, 28 Feb 2025 08:05:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] parisc: PDT: Fix missing prototype warning
To: Yu-Chun Lin <eleanor15x@gmail.com>, James.Bottomley@HansenPartnership.com
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 jserv@ccns.ncku.edu.tw, visitorckw@gmail.com,
 kernel test robot <lkp@intel.com>
References: <20250208174304.2627078-1-eleanor15x@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20250208174304.2627078-1-eleanor15x@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E0AhFQsLQ53R1JNUWyzibdyTR65cfPU/VIJyrphg5EqDdIFSTNu
 JP+J3f4pKXXoJHNCLSsio975S47eIv7yRDNWUrrR8gH0L29bKlHJt4+NVhQ/WXggY6w3lPA
 8RGc/QOFXiMUmdHmp4yKZwafOeqWr1y99Fn6DSTvwafoScwp6SUJDvPDuY6sumY16pLoWML
 X3Pr2q5Y1mOOhg1fBEmLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vjnR1tcXoPU=;rw60KGteRkljfm0psQ3XUsu8Yqy
 ld6+prApGitv1fKDVpRP63IiYr54P/e2l1D9e4eOKlxnqUGFzGwqnbAJ0ky2Z9cPdYT6/cjnG
 p6UnINMA9FawRz/cl1d8YbOSoqKqpKsmYp0iIaoQB1fV5oVy7TfADvNYxDTAzDgFFVv1WBGnq
 M3GJHzGJAxSFvbjoIbddDV465jnUJHmsTPmlZcoyHCBNSJcKCzEl3MSb74ZuWRUHuXln7GXkS
 G2VfbzhVQ+yDFXp79I6un8p1QdqE7r14kz1NItZkgfOR3Nj5uKk22iOokDiV0x2BghOXtH7oj
 iqOe/+tez1ALTeN/lZC6Rc/CGWlXCLwDPirInWXUKpKARucXeVTlFL4QBrikCNm72h/kqe7fU
 KvL1vLf/jGB0an0egEfCMA0Wjj41IfICPfP1dfBIEjlvtPESvcqqZBn9kQM0qMhINCiH5AE6O
 y34V+2kApprgWpAJkje3jM26RBEIu4trLoa2qQ3ZiBdSwFkxqKbQFPJNRuwpQRqlYBZunHwup
 PlVeFvgZ21yUEAKsYbec0YkBeVNZr2QxEgt+UetBILLDX5PwW4qi12q/yzp5jsGf/+HhpquKn
 jb8cgP+P3Rm3ohclNn7EGMF+cYB5E5PIk8h9IqPrqcVVTbKsJVrew8FzeP0zvGYZ+neq38bLm
 vjhmkS3C2gvE8GibKoxhcRZv68Vx1cQ+F3gnoPAGopQEC2ik5PovGvyeoLJys3Nr6iIJ1PHB9
 MFq1o0uS+gfYhfdqVMPaH+NkRj/eb4ZlmRBCbtLFMOWv5yLpnYtBb+3DPQgB6DA9pJQL1fYMT
 Sx07XRc98dlxtlcPXpoFk2kzqGC0V9Eec2/D9gn2EA1Fku1PgSNByKH3WfXouSz+QH5PtJM15
 aKw3JRsEtyJGWVlNJNPi/sVtQez9v6DQPWnCtUgwVlos9UmlXf9cASq5nqf6/1riF4dCt5yjd
 R73UVg3zd2/SAGaC0oyIGB0Ut4QWc9K8Q/461bBuoFAhHjxRolOq0fx0i1jl4sGCpzC0CczkY
 IVAtSIaxL3rGP0Dzbm7uCdlsPDSYSab7CD3d5RHN2I1QJy9ZALxTnEf9Hhn+pwhDxgzq+rYcl
 rDKf1vMhlVcO/+4ZcMYYTvljQAcK8rQ1XPxjv9NRJni6j4YWwERqn1Pgv5wx6ZhGnwRZGahc1
 T5GdWt5q4sfz7HJYwTfgX/Q+D8hz+61/oC7xgvNPCi+GgWKgYY6MtFvEAMkLPxvwdEXK8z0gF
 fBPHlvJFq6mYTTPFVX2ii3AjFDU3zk3JXoSGgBPCnOBhlYr4qnkltdCPuucglMMPQy2ylAfKf
 P0/xzgEZXV82wTxEWuR1zeZjM+7IGCa3hS58bZ/J+AjAPSxrnkL+fK5qbeAiuMkqT/DcMqMY7
 a3u8OFf1C9f4o3LkaKHvWsQPuI3AQXn8rftHymZss+3VPqZV5OaQs2NmJ7VPEDuMgElahX0fE
 29/Ydow==

On 2/8/25 18:43, Yu-Chun Lin wrote:
> As reported by the kernel test robot, the following error occurs:
>
> arch/parisc/kernel/pdt.c:65:6: warning: no previous prototype for 'arch_=
report_meminfo' [-Wmissing-prototypes]
>        65 | void arch_report_meminfo(struct seq_file *m)
>           |      ^~~~~~~~~~~~~~~~~~~
>
> arch_report_meminfo() is declared in include/linux/proc_fs.h and only
> defined when CONFIG_PROC_FS is enabled. Wrap its definition in #ifdef
> CONFIG_PROC_FS to fix the -Wmissing-prototypes warning.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202502082315.IPaHaTyM-lkp@=
intel.com/
> Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>

applied.

Thanks!
Helge

