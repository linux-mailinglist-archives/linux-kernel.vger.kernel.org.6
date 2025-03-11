Return-Path: <linux-kernel+bounces-556246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A035DA5C31B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0B2C166BB1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE012255E37;
	Tue, 11 Mar 2025 13:57:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1B51D5ADC;
	Tue, 11 Mar 2025 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741701431; cv=none; b=fEvSPxf3ZQYyjgubVLQTK6rI/NnyFHL/Rj4Ysv2M0lAqQMtXQuqyHL7ICotPBm8fN+GH1jjxB4wrCrpbQJ5UYSZXxotWHS/pDET3dBchFFEZQ6ig4O+VOx2uk1dGk2nD8dWdQhWzdjWqfz3llX4GmI2KH0IJrIIg/Q4wFvCDgBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741701431; c=relaxed/simple;
	bh=WJ7skOWoJeFHR7rNvq3i+XJAdc435edWr7FTfPWVkF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbAxm7ZddHTDRb4uE0RQlmoh617aqrM+7hN5IYC80Dy3n/09po26OwHY5Kfqh9y27GPz42LHAipvjSWQEeda/2+XLc4tatidUoQZpdpq3SA2aQ/2b1srbn4xtG2eH/jf1qAyJhC4iPoO2Kh6tPXr/OSTR/oZj0XwyNkKJcjA9WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E97F01515;
	Tue, 11 Mar 2025 06:57:19 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F20B3F694;
	Tue, 11 Mar 2025 06:57:08 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:57:04 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: coresight@lists.linaro.org, yeoreum.yun@arm.com,
	Mike Leach <mike.leach@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>, Leo Yan <leo.yan@linux.dev>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coresight: docs: Remove target sink from examples
Message-ID: <20250311135704.GK9682@e132581.arm.com>
References: <20241210144933.295798-1-james.clark@linaro.org>
 <20250311102200.GJ9682@e132581.arm.com>
 <898f1265-522f-44aa-a7da-879870b18807@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <898f1265-522f-44aa-a7da-879870b18807@linaro.org>

On Tue, Mar 11, 2025 at 10:51:39AM +0000, James Clark wrote:

[...]

> > > +Sink selection
> > > +~~~~~~~~~~~~~~
> > > +
> > > +An appropriate sink will be selected automatically for use with Perf, but since
> > > +there will typically be more than one sink, the name of the sink to use may be
> > > +specified as a special config option prefixed with '@'.
> > > +
> > > +The available sinks are listed in sysFS under
> > >   ($SYSFS)/bus/event_source/devices/cs_etm/sinks/::
> > > 
> > >          root@localhost:/sys/bus/event_source/devices/cs_etm/sinks# ls
> > >          tmc_etf0  tmc_etr0  tpiu0
> > 
> > Just a minor comment.  To reflect the latest hardware, it is good to
> > mention the TRBE case, users should not and cannot specify TRBE as the
> 
> Is that strictly true? From looking at the code I think you could pick one
> TRBE sink as long as you are only tracing from a single ETM. Although yeah
> it would be pointless.

My testing result shows perf reports error when specifying trbe as sink:

  # perf record -e cs_etm/@trbe0/ -- ls
  failed to mmap with 12 (Cannot allocate memory)

But I can make success for the command:

  # perf record -C 0 -e cs_etm/@trbe0/ -- ls
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.062 MB perf.data ]

This makes sense to me that if a perf session tries to enable trace for
multiple CPUs but only a CPU sink is supported, the driver should
report error to remind users the command does not work.

> > sink name.  The driver will give priority for TRBE by default unless
> > users specify other sink types.
> > 
> 
> IMO mentioning TRBE would be overly wordy and not really add anything.
> Removing the sink from all the base examples is exactly to make TRBE work
> without going into detail about why. And the advanced section doesn't
> mention TRBE because manually picking it is never right.

The section "Sink selection" applies _only_ to traditional sinks, not
to TRBE.  I am not sure if we should clarify a bit for this.  I don't
have strong opinion on it, as it is a trade-off between providing
necessary info and avoiding overstatement.

So this patch is fine for me:

Reviewed-by: Leo Yan <leo.yan@arm.com>

