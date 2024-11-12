Return-Path: <linux-kernel+bounces-405212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6A09C4E66
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 06:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6530FB221A1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 05:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26CA1C303A;
	Tue, 12 Nov 2024 05:46:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DFB17333A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 05:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731390418; cv=none; b=ZEXz4Ywd5TTmQ2I0F3xwj6Ny2G6PsU/V9n5OvsFsaH+UP5v884U+FrZWjbdZ8g9kc/82soxL/LCjAy1EOCtTUq7B6/2tRt1yN3rl2vuSaLw3HkLuXkVFES53lXR5IuNcv6f3CWAYErSWvwYrRoPqy4ruBJLiCcYj9heE4hXG5wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731390418; c=relaxed/simple;
	bh=6wqsNI8g+LsX42UXEZCTfPAiHJB+iW7Ve5OHLfDxusU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSJjmWQIUdGpoNFQs8aRNF0JwPYokyZWSHohKvY6yfje0DnQDEgqpCW8HYEhssrLNe9sNucd9h58hEkxWlxyppcjrmP9T3BcSfpGCoeHaZMFFdSubpvp+tuBOrTfUQ4zCE5eYe1P+lWOugzZlJk/hsdSuVmwAT8rpFgGYM7gR6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB21D1477;
	Mon, 11 Nov 2024 21:47:23 -0800 (PST)
Received: from bogus (unknown [10.57.89.22])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2FCD3F66E;
	Mon, 11 Nov 2024 21:46:42 -0800 (PST)
Date: Tue, 12 Nov 2024 05:46:23 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: Q: Kconfig: 'If unsure, say N'
Message-ID: <20241112054623.7zxte2nny7h4st3h@bogus>
References: <D5GVI1Q30BTS.1ZVQ4YC4OJYEL@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D5GVI1Q30BTS.1ZVQ4YC4OJYEL@cknow.org>

On Fri, Nov 08, 2024 at 03:39:30PM +0100, Diederik de Haas wrote:
> Hi,
>
> In quite a number of Kconfig help text entries I see this:
> "If unsure, say N."
>
> But that raises the question: How can I be sure?
>
> To me, this comes across as that the person who implemented the feature
> recommends *against* using it, unless you think you know better then the
> person who implemented it. Which is quite a high bar.
>

If you don't know about the feature and it is not having any user-interface
why do you want to enable it. You must understand the feature to enable it
and use it IMO.

> IIRC I did come across an entry which paraphrased said:
> "This module can be useful in situation Y, but you run a real risk of
> physically damaging your board when you use it.
> So normally you REALLY should not enable this, but if you still need it
> then the functionality is implemented in this module.
>
> If unsure, say N."
>
> Which is an excellent reason not to enable it ;-)
> Moreover, it specifies when you can/should go against the advise and
> tells you what the risk is if you do.
>
> But the vast majority just says "If unsure, say N."
>
> The problem is that I'd need a better justification to enable (as 'y' or
> 'm') a module then "Based on (the rest of) the Help text, this looks
> really useful".
>

You seem to contradict yourself here. If you have understood the help
text and think it is useful, it seems to me as an indication that you
are not unsure really. So you can enable it if you want TBH.

> Not to discuss these specifically, but just for illustration:
> ``drivers/firmware/arm_scmi/transports/Kconfig`` has this
> option: ``ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE``
> which IIUC enables an *optional* feature for an atomic transaction.
>

"If you want the SCMI SMC based transport to operate in atomic
mode, avoiding any kind of sleeping behaviour for selected
transactions on the TX path, answer Y.

Enabling atomic mode operations allows any SCMI driver using this
transport to optionally ask for atomic SCMI transactions and operate
in atomic context too, at the price of using a number of busy-waiting
primitives all over instead."

So you read the above text, understood and find it useful. You must be
not unsure of this feature then, so what does that text bother you.
It is just a caution to users who are just build and not looked at the
code, or have no idea about the feature or doesn't understand the help
text.

--
Regards,
Sudeep

