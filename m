Return-Path: <linux-kernel+bounces-188229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0398CDF79
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 04:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0BCD1F2175E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 02:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5784022616;
	Fri, 24 May 2024 02:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2wQhyob"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E43BE48;
	Fri, 24 May 2024 02:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716517602; cv=none; b=LQhQc3/66YYNuC0hPw/tdDKdpSzjfbWg80mtHuIYqpP0M4qDKsVhbSAEz8yKSadxPvK2lm3cqCrjsOHG8vagjF7HJl7jXp35Hgajuwc4pw5NL+fGzaIsWSjtJ/G0mVPsn/qhNGpOrTmH3W82/Xuq1JaHDQqQ71tYG6//f962Ro4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716517602; c=relaxed/simple;
	bh=V68S0YfqASuSJwOd0Y6I2O+LhStMZE72uKYdl/eTTAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7ZNDnAMDQ4pg8q29t9YojW9HceNoG2MjyL8OZxHs5DgJGpBM440OHMV9MDh3pPFAHWQjlr5YQ8KxhRHEYryTWJYOVEYBgr0TWGFAue+Eq9GVoD1uth4Ei2Zj1JuLw2vV/lu6DDgGCmbHq0NFbI5oOe2RAyFzUQZdnARvVLJIFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2wQhyob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88466C2BD10;
	Fri, 24 May 2024 02:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716517601;
	bh=V68S0YfqASuSJwOd0Y6I2O+LhStMZE72uKYdl/eTTAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O2wQhyobFdhTB6x8N5tFKWgIblU+F5RC2QzfD4VQbqQg88wes4uVngfm6jmbfP6Sc
	 X+tbywIGkqmTnhR2IxEINuesOfiPN0THXoWycvaNz2kHj22I1WeyEHx4/1FsYo6wdI
	 1q75N/ZrziY0NyQPIzgS2c0ku2cRrS6AGhb2xI5PzRjlObaPgJzP86TG6MARu/2cZ3
	 atP86hJ79HhcmIzYe21t5HcWPT6yJa/P6VKbABYOtk5vkg+UmwiVyJFh72M6aCjcCn
	 YRajmZHoCNdaLDn38BNB8y0DrnmIHPGCq3eza2x2hPmeKz4dKIekY+KzHACR75WApS
	 fNQKAvWAK4LXA==
Date: Fri, 24 May 2024 02:26:38 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Ben Walsh <ben@jubnut.com>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	"Dustin L. Howett" <dustin@howett.net>,
	Kieran Levin <ktl@frame.work>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Mario Limonciello <mario.limonciello@amd.com>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] platform/chrome: cros_ec_lpc: Correct ACPI name for
 Framework Laptop
Message-ID: <Zk_63rrDJFhN1Y1q@google.com>
References: <20240515055631.5775-1-ben@jubnut.com>
 <20240515055631.5775-6-ben@jubnut.com>
 <ZkscFnmHeWWma7Nb@google.com>
 <87jzjk1ibr.fsf@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzjk1ibr.fsf@jubnut.com>

On Thu, May 23, 2024 at 07:42:00PM +0100, Ben Walsh wrote:
> Tzung-Bi Shih <tzungbi@kernel.org> writes:
> 
> > On Wed, May 15, 2024 at 06:56:30AM +0100, Ben Walsh wrote:
> >> Framework Laptops' ACPI exposes the EC as name "PNP0C09". Use this to
> >> find the device. This makes it easy to find the AML mutex via the
> >> ACPI_COMPANION device.
> >>
> >> The name "PNP0C09" is part of the ACPI standard, not Chrome-specific,
> >> so only recognise the device if the DMI data is recognised too.
> >
> > I don't quite understand the statement.  Why it needs DMI data?
> 
> There are lots of computers with EC chips with ACPI name "PNP0C09"
> because it's part of the ACPI standard (for example I have an Intel NUC
> with one of these). Most of them don't support the cros_ec protocol, so
> the cros_ec driver should ignore these chips. The Framework EC is
> unusual in that it's called "PNP0C09" and supports the cros_ec protocol.
> 
> Before these patches, the cros_ec code just ignored PNP0C09 because it
> wasn't in the match table. The cros_ec_lpc_init logic looked like:
> 
>   * dmi_match => ok
>   * acpi_name == "GOOG0004" => ok
>   * otherwise fail.
> 
> After the patch, cros_ec_lpc_init still has this behaviour. We have
> "PNP0C09" in the match table so the driver gets hooked up correctly
> with the right "ACPI_COMPANION" device, but we don't allow the match
> to proceed unless we have the DMI data indicating it's a Framework EC.

From the context you provided, instead of matching "PNP0C09" in the driver,
it makes more sense to me (for Framework EC):

* Mainly use DMI match.
* Add a quirk for looking up (acpi_get_devices()?) and binding
  (e.g. ACPI_COMPANION_SET()) the `adev` in cros_ec_lpc_probe().

