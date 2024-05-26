Return-Path: <linux-kernel+bounces-189582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0858F8CF25F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 03:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C2A2B20E95
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 01:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946EFA5F;
	Sun, 26 May 2024 01:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjxfSiic"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF59387;
	Sun, 26 May 2024 01:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716686789; cv=none; b=CgzpcwugGc32EQi9U4oUGCPTd7rVhHEi0xetVU0cjBawKU9btiQcHUULOg4S2uxcGzxh8gUKEQGvNVuF1GSPMw8/GD8DxiRyPc7cZDClCDZkCjWMI7LUYI3J0Eoy7vH+qf7hTvb0nmZ+L64XxA6PvmFHQ6UxBEU73PKH92jqaWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716686789; c=relaxed/simple;
	bh=hliK7wtfdTHGdpCX/b8c2sgRKOvc0CvTg9bJ/aDLsWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgLuo2JRyNPY/KAJtf18b1TsG9XW/ikC1Px7uxQ6XRY3OzBlp/0u+HC2eiYTaDtoAfP8M88ybvNFWJAFrPlIT9EWup8UwASqLSpjqD4gBnw7ogK8z9mGotgN56vUspO6tFrvec8xilch+S1+sP7kgyHCR8mi5uZGlgtDUxtZrFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjxfSiic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0137CC2BD11;
	Sun, 26 May 2024 01:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716686789;
	bh=hliK7wtfdTHGdpCX/b8c2sgRKOvc0CvTg9bJ/aDLsWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NjxfSiickapoyY7GKSUZthmQ87dXNQZgqEWNvEzdt/zAoe808W7MTmVfYldr/2qOH
	 2CF3apqhm41ZbeI7cDckO4g2O1eokvacv1ZJCzhPpjMBA10v9/mfRWy0HT55VHlYgf
	 yJWN/TCIs1vuV6UcxXdQG4VZHvBgj0I5PkObTrKlK87+4anNbmCUSUvECv1KB4aGjv
	 xUHKw6mLF357XqPhOZIXtHwJeJDgSgp1SpDj/ew/i9/tCxXp4o40Sa1I8rzQbRph+S
	 L1ur/01mD5Hg4wyJAfQMxNkkqrF6/2sWRhb7UjgNhK9yIbIYDECTc6tc6zVhp38zfE
	 EhN/EHSlOW21A==
Date: Sun, 26 May 2024 01:26:26 +0000
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
Message-ID: <ZlKPwlF86Oe8OPK9@google.com>
References: <20240515055631.5775-1-ben@jubnut.com>
 <20240515055631.5775-6-ben@jubnut.com>
 <ZkscFnmHeWWma7Nb@google.com>
 <87jzjk1ibr.fsf@jubnut.com>
 <Zk_63rrDJFhN1Y1q@google.com>
 <87cypb12j9.fsf@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cypb12j9.fsf@jubnut.com>

On Fri, May 24, 2024 at 07:35:22PM +0100, Ben Walsh wrote:
> Tzung-Bi Shih <tzungbi@kernel.org> writes:
> 
> > From the context you provided, instead of matching "PNP0C09" in the driver,
> > it makes more sense to me (for Framework EC):
> >
> > * Mainly use DMI match.
> > * Add a quirk for looking up (acpi_get_devices()?) and binding
> >   (e.g. ACPI_COMPANION_SET()) the `adev` in cros_ec_lpc_probe().
> 
> Sorry, I don't think I provided enough context. There is already a
> platform device /sys/bus/platform/devices/PNP0C09:00 with a companion
> acpi device /sys/bus/acpi/devices/PNP0C09:00. I think it makes sense to
> bind the driver to the existing platform device.
> 
> I could add a new quirk which provides an alternative ACPI match table
> to be used instead of the default. In the default case the match_table
> will contain only "GOOG0004" as before. But in the Framework EC case the
> match table will be "PNP0C09".

I think it doesn't work as the current quirk is handling in
cros_ec_lpc_probe() which is after matching.

My original idea: would it be possible to get the `adev` in cros_ec_lpc_probe()
via any lookup API?  If yes, it could still use DMI match and get `adev` if
required.

