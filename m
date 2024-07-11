Return-Path: <linux-kernel+bounces-249447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0045B92EBD6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0817285D31
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D859816C6B1;
	Thu, 11 Jul 2024 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GM8Ox8jV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262CA16A940
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720712415; cv=none; b=aYVgpHcpyaiHWVK2JygXTS1E/4/Z+Pat8gDpYEYfx6htYG1p9DPwvns/qI4o3/vWf+sPVuBco5ajZreLTmLnvYPgsSiIBc+nF7KozaCOr2LMV8cQSkJMWmv/u+lxI0fl92jOYOkE7wiajAYvrPm6vL/4zqjP8soOX65rGDm4Pec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720712415; c=relaxed/simple;
	bh=jT0s6MmCeb5WyN6dOvVggju22xt8YDaqZM9oROogAA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKAWMWB7lNeMZoLqLw445Q+vcqZBW1QpgBnhfQEILxD74NojGzwkCRiIfomon9blqyAkHmt5qAMee6a6Mmydt2cdZrifVB79E6jqupFO+zp8i359Dc8DIuTRDiR8UZs7BpQKMGlmrOL0rUiBzpPckOdwAF1+8o5bhghW51Z2ZEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GM8Ox8jV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B899C116B1;
	Thu, 11 Jul 2024 15:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720712415;
	bh=jT0s6MmCeb5WyN6dOvVggju22xt8YDaqZM9oROogAA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GM8Ox8jVs1KA87DQnHV+9ytcOYlMOXKYkAXoPgDHgtnFDImb5p8tPRKA+uMCBjyso
	 L951rtNaWs24S8lUdrQ6+/9RN9ux8VXWAgvBoYpYCQ+LofllNQUipJTLWrUsGV8vMt
	 s/WPbXVYaTNy7n5Di2I859vOP1EIDwvZSsZWQ4Wex6gQhP3EsHGARWpb+/t+3rCXiB
	 ZfiXcUvn+3BRsQRjFouiLlkSxHxgIVylYiXkVfpsFH3u8ro5UEsw2Jdb9qlvbYt45F
	 THDpuIGlYMwCQ1I5uN4hGUSh8JGNKuHrpHZ8KF1uX9xyTqjYY/g3BRJKffvf0J21BP
	 yAD7Xr1RN3xJg==
Date: Thu, 11 Jul 2024 16:40:11 +0100
From: Lee Jones <lee@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] mfd: timberdale: attach device properties to
 tsc2007 board info
Message-ID: <20240711154011.GM501857@google.com>
References: <ZoWg89A8C4gylTGX@google.com>
 <172071237016.1875446.17338144128047838915.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <172071237016.1875446.17338144128047838915.b4-ty@kernel.org>

On Thu, 11 Jul 2024, Lee Jones wrote:

> On Wed, 03 Jul 2024 12:05:23 -0700, Dmitry Torokhov wrote:
> > Switch over to using software nodes/properties to describe the
> > touchscreen instead of using the legacy platform data. This will
> > allow to drop support for the platform data from tsc2007 driver
> > and rely solely on the generic driver properties.
> > 
> > Note: "model" is not part of defined device propertioes and is not
> > used by the tsc2007 driver, so it can be safely dropped.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] mfd: timberdale: attach device properties to tsc2007 board info
>       commit: c298391abf6505c4040632b310a14f6bd9b7afff

Remember to run spell-check on commit messages.

If fixed the issues and applied, thanks.

-- 
Lee Jones [李琼斯]

