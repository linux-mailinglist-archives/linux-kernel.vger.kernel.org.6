Return-Path: <linux-kernel+bounces-358283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37986997C96
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 07:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 947E7B238BD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 05:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FCF19EEC0;
	Thu, 10 Oct 2024 05:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="PniWuR6S"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331F42B9D2;
	Thu, 10 Oct 2024 05:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728539004; cv=none; b=O+340NS9cDVW/y7KYrZHm7CN5dxEXkNyMaLgKpN2XPPTu8sRTGMo8BMCsIUEgF2sw5W2U6rLblACUCUrZo4dn6v12bMAYWzIWlcXV7ACCkqeazzQjE3Ol4WZcvpzevGw0ca4f2XCAD0bfpiifpYwHj1mOv5rrNXb9f+xOLeJr50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728539004; c=relaxed/simple;
	bh=4cmlHmL1RfckZ1r9HT1RJDkP96vjRSxI23jRpNUZygA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZqwiDNhRFwhuQ9BFS7nHJxZOMVUVKwE/qOwUso+TSqUn2sbLC/pDv1f9i82fiEZtYaclvUvEPFZRmC40Nom+MkxKC6pDoy1VyGTFLrWl7tE7EPLkRkzVjUjeg0GEiYbl/OthZQIMUHNxjKbzgTmcyCIO3sfAev+YcmUwRUMT4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=PniWuR6S; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1728538989;
	bh=4cmlHmL1RfckZ1r9HT1RJDkP96vjRSxI23jRpNUZygA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PniWuR6SdZRQHy1ZUOfYp0Wm3YQXEpZTLwuQPFjUPCXWyEXVASoyZ9m+rvChIN/Ve
	 bjqIS3xYlJabnMmNwdpZWR91C6JG9P5dkpjzL+cKnpeS+SDTeAzec/tVF2wiMrPUTJ
	 7wfyBiOMoUXTmBM5+z5Zm5+6XsFtz02UJjwF/518=
Date: Thu, 10 Oct 2024 07:43:08 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Dustin Howett <dustin@howett.net>, linux-doc@vger.kernel.org, 
	Alex Deucher <alexander.deucher@amd.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
	Matt Hartley <matt.hartley@gmail.com>, Kieran Levin <ktl@framework.net>, 
	Hans de Goede <hdegoede@redhat.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v6 2/4] drm/amd/display: Add support for minimum
 backlight quirk
Message-ID: <bf61e7f2-9324-495d-af68-4b38ec211eee@t-8ch.de>
References: <20240824-amdgpu-min-backlight-quirk-v6-0-1ed776a17fb3@weissschuh.net>
 <20240824-amdgpu-min-backlight-quirk-v6-2-1ed776a17fb3@weissschuh.net>
 <1396eead-b584-4b36-b9b2-18ef783cfdbf@amd.com>
 <9dfc1548-7e11-44c3-ba7d-4e5ff7965a66@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9dfc1548-7e11-44c3-ba7d-4e5ff7965a66@amd.com>

On 2024-09-16 15:43:35-0400, Harry Wentland wrote:
> On 2024-08-26 12:57, Mario Limonciello wrote:
> > On 8/24/2024 13:33, Thomas Weißschuh wrote:
> >> Not all platforms provide the full range of PWM backlight capabilities
> >> supported by the hardware through ATIF.
> >> Use the generic drm panel minimum backlight quirk infrastructure to
> >> override the capabilities where necessary.
> >>
> >> Testing the backlight quirk together with the "panel_power_savings"
> >> sysfs file has not shown any negative impact.
> >> One quirk seems to be that 0% at panel_power_savings=0 seems to be
> >> slightly darker than at panel_power_savings=4.
> > 
> > Thanks; This is the kind of thing I was worried about.
> > 
> > Harry, Leo,
> > 
> > Is that expected?  I wonder if we need to internally turn off panel
> > power savings in display code when brightness falls a threshold (12
> > IIRC was the real "minimum" advertised in the table?).
> 
> How much darker? Is it bothersome?

Was this questions for meant for me?
To me personally it's absolutely not bothersome.
I probably wouldn't have noticed it if not explicitly looking for it.

> I wonder the FW and driver have different min backlight values now.
> 
> Leo, any thoughts?

Friendly ping.

