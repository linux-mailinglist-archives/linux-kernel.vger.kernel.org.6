Return-Path: <linux-kernel+bounces-191670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F898D126F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 05:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 630B8283C76
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 03:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3371D551;
	Tue, 28 May 2024 03:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvHwy407"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2BA1C68E;
	Tue, 28 May 2024 03:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716865720; cv=none; b=FHwZwpCwFoCYzMeVVdMEabmep2mk9SQwXELrYZ5Mp2E/k6L8ClcHqyPTVlz3wPa1i41Rcnfz+te9UmVj0GGtcWxttylex7S9K4ICGjlXsjFXMsIoYME6hEPomOD09Zzw51HINEdtW7aLeq2ADq09oWoLPzTbKNaGMzjt15vSmW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716865720; c=relaxed/simple;
	bh=d7d5F6caD9/yJ3kRjdZS1IPLThXJka7WSNS5A4PF+fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpnnAxqKmWdoeux2PNYKnKsSuBqdq3wvf9WO1jTJjPVy8A0uiQMWp4IlO+hAeF38DiSt20xh3VHG50mVCnObW15DAc8Y7HgZMknQlJak441gsfbKkVJdhaFO5BJgTEgcUvH30lJTQe3R2QFzc9HmsKN7ar463UqoUMI3OSWB2Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvHwy407; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784D4C2BBFC;
	Tue, 28 May 2024 03:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716865719;
	bh=d7d5F6caD9/yJ3kRjdZS1IPLThXJka7WSNS5A4PF+fI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RvHwy407wYBqxzTnTcA53k/E8zgm1pDTTfjIQXaUzK3/TpImMrDDUZB3odnqXQyhC
	 6vPE23w45KBrQ7BtUzZMuThb1bl84dr2YscivnKnXTQsQ0ufMMW14rDEm9Tx3uh+uG
	 Kdy+HSAyRxk4vCvBNnr5NsOtQqD8eHQeXkA/i+WQIv2z/Cmr5KTX87daCqpAep3H69
	 18g3xUEkP/CgatryUq61t91zjQcjhHPVr4sGLQwYdGooaF8aaXXMk8dQe9yf2FCEFB
	 weRefEEoI9zmePnNV7pachBaw4yKpdfeawo9LDU1l0PaaeKZek1vNkkzwv/Zbk+JDK
	 ZGpzDkDUsEhfA==
Date: Tue, 28 May 2024 03:08:36 +0000
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
Message-ID: <ZlVKtL7GUHRWkFpf@google.com>
References: <20240515055631.5775-1-ben@jubnut.com>
 <20240515055631.5775-6-ben@jubnut.com>
 <ZkscFnmHeWWma7Nb@google.com>
 <87jzjk1ibr.fsf@jubnut.com>
 <Zk_63rrDJFhN1Y1q@google.com>
 <87cypb12j9.fsf@jubnut.com>
 <ZlKPwlF86Oe8OPK9@google.com>
 <877cff2kpb.fsf@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cff2kpb.fsf@jubnut.com>

On Mon, May 27, 2024 at 07:06:40PM +0100, Ben Walsh wrote:
> Tzung-Bi Shih <tzungbi@kernel.org> writes:
> 
> > On Fri, May 24, 2024 at 07:35:22PM +0100, Ben Walsh wrote:
> 
> >> I could add a new quirk which provides an alternative ACPI match table
> >> to be used instead of the default. In the default case the match_table
> >> will contain only "GOOG0004" as before. But in the Framework EC case the
> >> match table will be "PNP0C09".
> >
> > I think it doesn't work as the current quirk is handling in
> > cros_ec_lpc_probe() which is after matching.
> 
> I was thinking of a new quirk called CROS_EC_LPC_QUIRK_ACPI_MATCH, and
> putting it in cros_ec_lpc_init(), not cros_ec_lpc_probe(). Do we have to
> do all quirk handling in cros_ec_lpc_probe()?

No, but there is already code in cros_ec_lpc_probe() for handling quirks and
we would like to reuse them if we could.

Also a possible issue: MODULE_DEVICE_TABLE() wouldn't work if the table changes
during runtime.

> 
> > My original idea: would it be possible to get the `adev` in cros_ec_lpc_probe()
> > via any lookup API?  If yes, it could still use DMI match and get `adev` if
> > required.
> 
> That works; I've tested it.
> 
> In this scenario we're not using the existing PNP0C09 platform device,
> which means I can't look at
> /sys/bus/acpi/devices/PNP0C09\:00/physical_node/driver and see the
> driver. Is this OK?
> 
> (Note that ACPI_COMPANION_SET() doesn't fix this. You can use
> acpi_bind_one() but that seems more like internal plumbing).

As long as ACPI_COMPANION() in the driver can get the correct `adev`, I guess
it's fine.  Otherwise, put the `adev` to somewhere device specific (e.g.
struct cros_ec_lpc) should also work.

