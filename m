Return-Path: <linux-kernel+bounces-286267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8292B9518DE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DA2CB21062
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711541AE02D;
	Wed, 14 Aug 2024 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gvqir7bh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94B51A01C8;
	Wed, 14 Aug 2024 10:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631621; cv=none; b=dWnTaGAaBK3JC9jDNPd0rnpiAdn22VqA0myUhzmbqMBll/gg+bN7aUwSfmqOMx1LEbL2Cz6PWb4oBB3wWN4V6dmiVavVZ2OWmsN6351KXu4txnD/V/R+OPSInm42wKsvGo5VZ4+tREhL4j39OIYO62kGjs/Aas9KwTLkD8ObhEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631621; c=relaxed/simple;
	bh=dw1WTbCQKkArspGvbZm78zUYtI2+m3rV6lgHY+XP10o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9B3BIPQ8icuL6magI6cme4a1Tt9o2hyzVYx4LxH5JaUQYrtHeb1h8MOpWISXSo3S7YVj74h9whVjFTijBITfIInmdawIGCqFVuyii1VC4mj67QWpk70THHk3h9zRCpm3cqe9Z6K8BDj+4bBro0PjtDkvBsFNAVQfkYeeSZzafA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gvqir7bh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD3EC32786;
	Wed, 14 Aug 2024 10:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723631621;
	bh=dw1WTbCQKkArspGvbZm78zUYtI2+m3rV6lgHY+XP10o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gvqir7bhIN51vmmqcYiHMZb44Hy2Kkjqtt/F4DMCL10iOudC3WMBb8xMlFY2ZNf74
	 gWbKpqukX1OMxtb9BDI5xt41N3ZcoOOwmsx9yHJlidH+Qy2j/OuBXgvY/TFrMKzvW0
	 BnzWsyQXUmz4TR1gdkNr+pihnk1RobogaqLNj/DU=
Date: Wed, 14 Aug 2024 12:33:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Akshay Gupta <akshay.gupta@amd.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@roeck-us.net, arnd@arndb.de, naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH v3 8/8] misc: amd-sbi: Add document for AMD SB IOCTL
 description
Message-ID: <2024081412-snowless-judgingly-ce90@gregkh>
References: <20240814095954.2359863-1-akshay.gupta@amd.com>
 <20240814095954.2359863-9-akshay.gupta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814095954.2359863-9-akshay.gupta@amd.com>

On Wed, Aug 14, 2024 at 09:59:53AM +0000, Akshay Gupta wrote:
> +The following IOCTL is defined:
> +
> +``#define SB_BASE_IOCTL_NR      0xF9``
> +``#define SBRMI_IOCTL_CMD          _IOWR(SB_BASE_IOCTL_NR, 0, struct apml_message)``

You only have 1 ioctl, so why are you saying that you are reserving
0-1F?


> +Data structure::
> +	struct apml_message {
> +		/* message ids:
> +		 * Mailbox Messages:	0x0 ... 0x999
> +		 * APML_CPUID:		0x1000
> +		 * APML_MCA_MSR:	0x1001
> +		 * APML_REG:		0x1002
> +		 */
> +		__u32 cmd;
> +		/*
> +		 * 8 bit data for reg read,
> +		 * 32 bit data in case of mailbox,
> +		 * up to 64 bit in case of cpuid and mca msr
> +		 */
> +		union {
> +			__u64 cpu_msr_out;
> +			__u32 mb_out[2];
> +			__u8 reg_out[8];
> +		} data_out;
> +		/*
> +		 * [0]...[3] mailbox 32bit input
> +		 *	     cpuid & mca msr,
> +		 *	     rmi rd/wr: reg_offset
> +		 * [4][5] cpuid & mca msr: thread
> +		 * [4] rmi reg wr: value
> +		 * [6] cpuid: ext function & read eax/ebx or ecx/edx
> +		 *	[7:0] -> bits [7:4] -> ext function &
> +		 *	bit [0] read eax/ebx or ecx/edx
> +		 * [7] read/write functionality
> +		 */
> +		union {
> +			__u64 cpu_msr_in;
> +			__u32 mb_in[2];
> +			__u8 reg_in[8];
> +		} data_in;
> +		/*
> +		 * Status code is returned in case of CPUID/MCA access
> +		 * Error code is returned in case of soft mailbox
> +		 */
> +		__u32 fw_ret_code;
> +	} __attribute__((packed));

This does not need to be here, pull it directly from the .h file using
kernel doc formatting please.

> +The ioctl would return a non-zero on failure; user can read errno to see
> +what happened.

That's not how the ioctl syscall works :(

> The transaction returns 0 on success.
> +
> +User space C-APIs are made available by linking against the esmi_oob_library,
> +which is provided by the E-SMS project https://www.amd.com/en/developer/e-sms.html.
> +Link: https://github.com/amd/esmi_oob_library

What is this last line for?

thanks,

greg k-h

