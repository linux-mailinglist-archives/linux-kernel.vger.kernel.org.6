Return-Path: <linux-kernel+bounces-359086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D510099873F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657771F22E4F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23B71C9EC0;
	Thu, 10 Oct 2024 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWjkvzYS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E0F1C9EB5
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565853; cv=none; b=ndbb3BZ9BniLrXWbvcInk1EKjbMyfY6S6qEt1Iwl1U/Mp3filj98D5/x0DW+HyAHYnAtGPNPP6QE+7K6rE6vis3/F6EKHK6BdynGmkL6HpnJCG483M7IADAFHezVSfE5Th2kCnXvodZzCK0Su94PlQONGkzqnJiY8AULovyYIuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565853; c=relaxed/simple;
	bh=nbxrHiu+Y+ZHb4sOl8GF9nrUEtiGwY5CR1WoKWijaWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpX2PjOw2cifxnMjncWgifOffVGF0xJtlma5Usv5j1eELldDlMmBOt7lKEyzEBQFA3ExHMNj/VXXd3NhC8WWBRf4eNdkERXX7am39Emg6epMRXioLmCYqkbjab+JzxilnQ3pI9u0C/naibtAamsyZj9FDmvefdgFsL7KnagRCoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWjkvzYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAFAC4CEC5;
	Thu, 10 Oct 2024 13:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728565852;
	bh=nbxrHiu+Y+ZHb4sOl8GF9nrUEtiGwY5CR1WoKWijaWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWjkvzYSv9VIRj38CIz/LsGP9PZP/ewE7ObjA5f5pZ4fzWbG6IPLONN/AM5s5zJQz
	 bPfMuS3Y7wjaZxqm5XsRiJEEwP6+9ZWEDbmRZ5LDMq76kq3j8jFNNS8WbrhySAgcrH
	 klzoVbGBgWilpSUWjCnAwzyHarNOc5R7R4VBSidindVixdeqLf7vI+3VY1iR/xTL6M
	 JFHBCTd9/tooJU2ddJ6tAfq/LV3s2ewlDQNT6HPNQSLqmSNZ5DjUamjkyUI2OXOY9k
	 5hwJCebuA4vMY9c2brg+8TEX1wvKGraNfV2FmcGwEIm3Ixyr1/j/GaEblb0b1XR+c0
	 HyHyRK+nqk9og==
Date: Thu, 10 Oct 2024 15:10:50 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 15/15] timers/Documentation: Cleanup delay/sleep
 documentation
Message-ID: <ZwfSWrowBQNIWpIE@localhost.localdomain>
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-flseep-v2-15-b0d3f33ccfe0@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240911-devel-anna-maria-b4-timers-flseep-v2-15-b0d3f33ccfe0@linutronix.de>

Le Wed, Sep 11, 2024 at 07:13:41AM +0200, Anna-Maria Behnsen a écrit :
> The documentation which tries to give advises how to properly inserting

advices*

> delays or sleeps is outdated. The file name is 'timers-howto.rst' which
> might be missleading as it is only about delay and sleep mechanisms and not

misleading*

> how to use timers.
> 
> Update the documentation by integrating the important parts from the
> related function descriptions and move it all into a self explaining file
> with the name "delay_sleep_functions.rst".
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  Documentation/timers/delay_sleep_functions.rst | 122 +++++++++++++++++++++++++
>  Documentation/timers/index.rst                 |   2 +-
>  Documentation/timers/timers-howto.rst          | 115 -----------------------
>  3 files changed, 123 insertions(+), 116 deletions(-)
> 
> diff --git a/Documentation/timers/delay_sleep_functions.rst b/Documentation/timers/delay_sleep_functions.rst
> new file mode 100644
> index 000000000000..05d7c3c8fbe8
> --- /dev/null
> +++ b/Documentation/timers/delay_sleep_functions.rst
> @@ -0,0 +1,122 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Delay and sleep mechanisms
> +==========================
> +
> +This document seeks to answer the common question: "What is the
> +RightWay (TM) to insert a delay?"
> +
> +This question is most often faced by driver writers who have to
> +deal with hardware delays and who may not be the most intimately
> +familiar with the inner workings of the Linux Kernel.
> +
> +The following table gives a rough overview about the existing function
> +'families' and their limitations. This overview table does not replace the
> +reading of the function description before usage!
> +
> +.. list-table::
> +   :widths: 20 20 20 20 20
> +   :header-rows: 2
> +
> +   * -
> +     - `*delay()`
> +     - `usleep_range*()`
> +     - `*sleep()`
> +     - `fsleep()`
> +   * -
> +     - busy-wait loop
> +     - hrtimers based
> +     - timer list timers based
> +     - combines the others
> +   * - Usage in atomic Context
> +     - yes
> +     - no
> +     - no
> +     - no
> +   * - precise on "short intervals"
> +     - yes
> +     - yes
> +     - depends
> +     - yes
> +   * - precise on "long intervals"
> +     - Do not use!
> +     - yes
> +     - max 12.5% slack
> +     - yes
> +   * - interruptible variant
> +     - no
> +     - yes
> +     - yes
> +     - no
> +
> +A generic advice for non atomic contexts could be:
> +
> +#. Use `fsleep()` whenever unsure (as it combines all the advantages of the
> +   others)
> +#. Use `*sleep()` whenever possible
> +#. Use `usleep_range*()` whenever accuracy of `*sleep()` is not sufficient
> +#. Use `*delay()` for very, very short delays
> +
> +Find some more detailed information about the function 'families' in the next
> +sections.
> +
> +`*delay()` family of functions
> +------------------------------
> +
> +These functions use the jiffy estimation of clock speed and will busy wait for
> +enough loop cycles to achieve the desired delay. udelay() is the basic
> +implementation and ndelay() as well as mdelay() are variants.
> +
> +These functions are mainly used to add a delay in atomic context. Please make
> +sure to ask yourself before adding a delay in atomic context: Is this really
> +required?
> +
> +.. kernel-doc:: include/asm-generic/delay.h
> +	:identifiers: udelay ndelay
> +
> +.. kernel-doc:: include/linux/delay.h
> +	:identifiers: mdelay
> +
> +
> +`usleep_range*()` and `*sleep()` family of functions
> +----------------------------------------------------
> +
> +These functions uses hrtimers or timer list timers to provide the requested

use*

> +sleeping duration. For a decision which function is the right one to use, take

I'm not a native speaker but perhaps "In order to decide which function..." is
better...

> +some basic information into account:
> +
> +#. hrtimers are more expensive as they are using an rb-tree (instead of hashing)
> +#. hrtimers are more expensive when the requested sleeping duration is the first
> +   timer which means real hardware has to be programmed
> +#. timer list timers always providing some sort of slack as they are jiffy

provide*

> +   based
> +
> +The generic advice is repeated here:
> +
> +#. Use `fsleep()` whenever unsure (as it combines all the advantages of the
> +   others)
> +#. Use `*sleep()` whenever possible
> +#. Use `usleep_range*()` whenever accuracy of `*sleep()` is not sufficient
> +
> +First check fsleep() function description and to learn more about accuracy,
> +please check msleep() function description.
> +
> +
> +`usleep_range*()`
> +~~~~~~~~~~~~~~~~~
> +
> +.. kernel-doc:: include/linux/delay.h
> +	:identifiers: usleep_range usleep_range_idle
> +
> +.. kernel-doc:: kernel/time/sleep_timeout.c
> +	:identifiers: usleep_range_state
> +
> +
> +`*sleep()`
> +~~~~~~~~~~
> +
> +.. kernel-doc:: kernel/time/sleep_timeout.c
> +       :identifiers: msleep msleep_interruptible
> +
> +.. kernel-doc:: include/linux/delay.h
> +	:identifiers: ssleep fsleep

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

